package adminanalytics

import (
	"context"
	"testing"
	"time"

	"github.com/google/go-cmp/cmp"

	"github.com/sourcegraph/log/logtest"

	"github.com/sourcegraph/sourcegraph/internal/database"
	"github.com/sourcegraph/sourcegraph/internal/database/dbtest"
)

type EventLogRow struct {
	Name        string
	UserId      int
	AnonymousId string
	Time        time.Time
}

func init() {
	cacheDisabledInTest = true
}

func createEventLogs(db database.DB, rows []EventLogRow) error {
	for _, args := range rows {
		_, err := db.ExecContext(context.Background(), `
      INSERT INTO event_logs
        (name, argument, url, user_id, anonymous_user_id, source, version, timestamp)
      VALUES
        ($1, '{}', '', $2, $3, 'WEB', 'version', $4)
    `, args.Name, args.UserId, args.AnonymousId, args.Time.Format(time.RFC3339))

		if err != nil {
			return err
		}
	}

	return nil
}

func TestUserActivityLastMonth(t *testing.T) {
	logger := logtest.Scoped(t)
	ctx := context.Background()
	db := database.NewDB(logger, dbtest.NewDB(logger, t))
	now := bod(time.Now())

	err := createEventLogs(db, []EventLogRow{
		{"SearchNotebookCreated", 1, "1", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 1, "2", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 2, "3", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 0, "4", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 0, "5", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 0, "5", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 0, "6", now.AddDate(0, -2, 0)},
		{"SearchNotebookCreated", 0, "7", now.AddDate(0, 0, 1)},
		{"SearchNotebookCreated", 0, "backend", now.AddDate(0, 0, -5)},
		{"ViewSignIn", 3, "8", now.AddDate(0, 0, -5)},
	})

	if err != nil {
		t.Fatal(err)
	}

	store := Users{
		DateRange: "LAST_MONTH",
		Grouping:  "DAILY",
		DB:        db,
		Cache:     false,
	}

	fetcher, err := store.Activity()
	if err != nil {
		t.Fatal(err)
	}

	results, err := fetcher.Nodes(ctx)
	if err != nil {
		t.Fatal(err)
	}

	if len(results) < 28 {
		t.Fatalf("only %d nodes returned", len(results))
	}

	nodes := []*AnalyticsNode{
		{
			Data: AnalyticsNodeData{
				Date:            now.AddDate(0, 0, -5),
				Count:           6,
				UniqueUsers:     4,
				RegisteredUsers: 2,
			},
		},
	}

	for _, node := range nodes {
		var found *AnalyticsNode

		for _, result := range results {
			if bod(node.Data.Date).Equal(bod(result.Data.Date)) {
				found = result
			}
		}

		if diff := cmp.Diff(node, found); diff != "" {
			t.Fatal(diff)
		}
	}

	summaryResult, err := fetcher.Summary(ctx)
	if err != nil {
		t.Fatal(err)
	}

	summary := &AnalyticsSummary{
		Data: AnalyticsSummaryData{
			TotalCount:           6,
			TotalUniqueUsers:     4,
			TotalRegisteredUsers: 2,
		},
	}

	if diff := cmp.Diff(summary, summaryResult); diff != "" {
		t.Fatal(diff)
	}
}

func TestUserFrequencyLastMonth(t *testing.T) {
	logger := logtest.Scoped(t)
	ctx := context.Background()
	db := database.NewDB(logger, dbtest.NewDB(logger, t))
	now := bod(time.Now())

	err := createEventLogs(db, []EventLogRow{
		{"SearchNotebookCreated", 1, "1", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 1, "2", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 1, "2", now.AddDate(0, 0, -4)},
		{"SearchNotebookCreated", 1, "2", now.AddDate(0, 0, -3)},
		{"SearchNotebookCreated", 2, "3", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 2, "3", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 0, "4", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 0, "5", now.AddDate(0, 0, -5)},
		{"SearchNotebookCreated", 0, "5", now.AddDate(0, 0, -4)},
		{"SearchNotebookCreated", 0, "6", now.AddDate(0, -2, 0)},
		{"SearchNotebookCreated", 0, "7", now.AddDate(0, 0, 1)},
		{"SearchNotebookCreated", 0, "backend", now.AddDate(0, 0, -5)},
		{"ViewSignIn", 3, "8", now.AddDate(0, 0, -5)},
	})

	if err != nil {
		t.Fatal(err)
	}

	store := Users{
		DateRange: "LAST_MONTH",
		Grouping:  "DAILY",
		DB:        db,
		Cache:     false,
	}

	results, err := store.Frequencies(ctx)
	if err != nil {
		t.Fatal(err)
	}

	nodes := []*UsersFrequencyNode{
		{
			Data: UsersFrequencyNodeData{
				DaysUsed:   1,
				Frequency:  4,
				Percentage: 100,
			},
		},
		{
			Data: UsersFrequencyNodeData{
				DaysUsed:   2,
				Frequency:  2,
				Percentage: 50,
			},
		},
		{
			Data: UsersFrequencyNodeData{
				DaysUsed:   3,
				Frequency:  1,
				Percentage: 25,
			},
		},
	}

	for _, node := range nodes {
		var found *UsersFrequencyNode

		for _, result := range results {
			if node.Data.DaysUsed == result.Data.DaysUsed {
				found = result
			}
		}

		if diff := cmp.Diff(node, found); diff != "" {
			t.Fatal(diff)
		}
	}
}

func TestMonthlyActiveUsersLast3Month(t *testing.T) {
	logger := logtest.Scoped(t)
	ctx := context.Background()
	db := database.NewDB(logger, dbtest.NewDB(logger, t))
	now := bod(time.Now())

	err := createEventLogs(db, []EventLogRow{
		{"SearchNotebookCreated", 1, "1", now},
		{"SearchNotebookCreated", 1, "1", now},
		{"SearchNotebookCreated", 1, "1", now.AddDate(0, -1, 0)},
		{"SearchNotebookCreated", 1, "1", now.AddDate(0, -1, 0)},
		{"SearchNotebookCreated", 1, "1", now.AddDate(0, -2, 0)},
		{"SearchNotebookCreated", 2, "3", now},
		{"SearchNotebookCreated", 2, "3", now.AddDate(0, -1, 0)},
		{"SearchNotebookCreated", 0, "4", now.AddDate(0, -2, 0)},
		{"SearchNotebookCreated", 0, "5", now.AddDate(0, -2, 0)},
		{"SearchNotebookCreated", 0, "5", now.AddDate(0, -2, 0)},
		{"SearchNotebookCreated", 0, "6", now.AddDate(0, -3, 0)},
		{"SearchNotebookCreated", 0, "7", now.AddDate(0, 0, 1)},
		{"SearchNotebookCreated", 0, "backend", now},
		{"ViewSignIn", 3, "8", now},
	})

	if err != nil {
		t.Fatal(err)
	}

	store := Users{
		DateRange: "LAST_MONTH",
		Grouping:  "DAILY",
		DB:        db,
		Cache:     false,
	}

	results, err := store.MonthlyActiveUsers(ctx)
	if err != nil {
		t.Fatal(err)
	}

	nodes := []*MonthlyActiveUsersRow{
		{
			Data: MonthlyActiveUsersRowData{
				Date:  now.AddDate(0, -2, 0).Format("2006-01"),
				Count: 3,
			},
		},
		{
			Data: MonthlyActiveUsersRowData{
				Date:  now.AddDate(0, -1, 0).Format("2006-01"),
				Count: 2,
			},
		},
		{
			Data: MonthlyActiveUsersRowData{
				Date:  now.Format("2006-01"),
				Count: 2,
			},
		},
	}

	for _, node := range nodes {
		var found *MonthlyActiveUsersRow

		for _, result := range results {
			if node.Data.Date == result.Data.Date {
				found = result
			}
		}

		if diff := cmp.Diff(node, found); diff != "" {
			t.Fatal(diff)
		}
	}
}
