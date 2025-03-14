# Reviews

Reviews of the SQL problem platforms are below: these are just my opinions, and you may have a different experience.

---

## Analyst Builder

> [!NOTE]
>
> The problems are available at:
>
> - https://www.analystbuilder.com/
>
> The platform uses a mix of databases and languages.
>
> There are only 3 free hard problems, and 0 free very hard problems.

### Pros ✔️

The platform looks and feels really nice!

The problem statements have sample data and expected results.

The platform is easy to use, has a fast response time, and the solutions tab has some good alternative community solutions -- but an added bonus is that Analyst Builder has a video explanation, too!

The PostgreSQL version that Analyst Builder uses is 16.1, two versions ahead of DataLemur.

Correct solutions have a nice animation when you submit them 😄

For the most part, the recommended solutions are good.

### Cons ❌

The "hard" problems are _waaay_ easier than the DataLemur ones; they're more like "medium" DataLemur ones.

Hopefully the "very hard" problems are actually hard, but I can't say for sure.

These questions are good for someone who's just starting out with SQL, but not for someone who's been working with SQL for a while.

---

## SQL Short Reads

> [!NOTE]
>
> The problems are available at:
>
> - https://sqlshortreads.com/sql-practice-problems/
>
> These questions are created by [Chris Perry](https://www.linkedin.com/in/chrismperry/).
>
> The site only includes the questions (and solutions), but doesn't provide a live query editor -- instead, it points you to [https://livesql.oracle.com/](https://livesql.oracle.com/) which uses Oracle 19c.

### Pros ✔️

The site is pretty slick and easy to navigate, with plenty of problems to work on.

I like that the intention is to provide the requirements like a "real-world" scenario rather than framed like a technical question.

The author is clearly a fan of `DENSE_RANK` 😄

The [member-type-upgrade.sql](/src/sql-short-reads/member-type-upgrade.sql) question is a good one, I like when a question has a bit of Maths in it.

### Cons ❌

The [livesql.oracle.com](https://livesql.oracle.com/) site requires you to sign up to use it, which is a bit annoying -- in particular because it asks for more personal information than I'd like to give (phone number, company name, etc.).

Also, Oracle 🤮

To reiterate, Oracle 🤮

The recommended solutions seem overcomplicated in a few cases and, like Analyst Builder, the "hard" questions are mostly not that hard.

I disagree with the solution to [consecutive-top-product-category-performances.sql](/src/sql-short-reads/consecutive-top-product-category-performances.sql).

---

## SQL Murder Mystery

> [!NOTE]
>
> The problem is available at:
>
> - https://mystery.knightlab.com/
>
> The platform uses SQLite.
>
> The site isn't a set of problems; the only question is "who dunnit?"!

### Pros ✔️

Asking an open-ended question gets you thinking analytically and is different to solving the "usual" kinds of problems.

The platform is simple and easy to use, with clear instructions.

It includes an extremely thorough walkthrough, perfect for beginners.

### Cons ❌

Not really a "con", but it's clearly just for beginners.

---

## DataLemur

> [!NOTE]
>
> The problems are available at:
>
> - https://datalemur.com/
>
> The platform uses PostgreSQL only (version 14.11 at the time of writing).
>
> There are only 8 free hard problems.

### Pros ✔️

The problems do get you to think and use some not-so-common logic, which is good!

The problem statements have sample data and expected results, which is great for testing your solutions -- feels a lot like LeetCode/TDD 😉

The platform is easy to use, has a fast response time, and the discussion tab has some good alternative community solutions.

The solutions tab sometimes provides alternative approaches too -- one even showed off a recursive CTE!

### Cons ❌

Some of the recommended solutions could be better:

- There are some database features that the solutions could use to make the queries more concise and readable.
- The recommended solution for the [updated-status](/src/data-lemur/updated-status.sql) problem wraps all the business logic into a case statement. This is bad practice given that the solution could have used a lookup table<sup>\*</sup>, which is what SQL is all about!
- I frankly disagree with the approach for one solution ([median-search-freq](/src/data-lemur/median-search-freq.sql)).

<sup>\*</sup>The DataLemur platform wasn't accepting several variant of the `VALUES` clause even though it was valid SQL. This feels like a bug in the platform.

I'm not sure about the premium hard questions, but based on the free ones, the problems are only moderately difficult -- I have to solve harder problems on a daily basis as an analytics engineer, so I don't think these are great preparation for a senior technical role.

---

## LeetCode

> [!NOTE]
>
> The problems are available at:
>
> - https://leetcode.com/problemset/database/?difficulty=HARD
>
> The platform uses a mix of databases and even Pandas.
>
> There are only 3 free hard problems.

### Pros ✔️

It's LeetCode -- the platform is decent 😜

Like the rest of LeetCode, the test cases are a decent feature: especially since your solution is run against multiple inputs and outputs, encouraging you to write a more general solution rather than one that just works for the given data.

The questions have a walkthrough to help you understand the problem and the expected output.

The community shares a good variety of answers.

### Cons ❌

If you know common query patterns, the "hard" questions are easy.

Small gripe, but I'm never happy when SQL problems want column names to be case-sensitive or have spaces in them, like `Cancellation Rate` (rather than `cancellation_rate`).

Same as DataLemur: these are good for checking that you know what you need to know for a mid-level engineer, but are not great preparation for a senior technical role.

---

## HackerRank

> [!NOTE]
>
> The problems are available at:
>
> - https://www.hackerrank.com/domains/sql
>
> The platform uses a mix of databases and languages.

### Pros ✔️

The platform is easy to use and has a fast response time.

The problem statements have sample data and expected results.

There is a discussions tab to discuss solutions with other "hackers".

There is a leaderboard and you can gain experience (nice gamification).

I really like that you can see other people's submissions!

### Cons ❌

The only DB options are DB2, MySQL, Oracle, and SQL Server 😭

There are only two "hard" SQL problem (using the "difficulty" filter, not the "skills" filter).

There aren't enough hard questions, so someone prepping for a senior role will run out of questions very quickly.

---

## DataExpert.io

> [!NOTE]
>
> The problems are available at:
>
> - https://dataexpert.io/questions
>
> The platform uses Trino only.
>
> The platform is still a WIP, so I'll save the pros and cons for later.

---

## Advent of SQL

> [!NOTE]
>
> The problems are available at:
>
> - https://adventofsql.com/
>
> Although the questions are based on PostgreSQL, I'll solve them with DuckDB since there is significant overlap between the two (and I prefer DuckDB for stuff like this).

### Pros ✔️

For the most part, they're phrased like "real life" problems.

Each problem had a sample to practise with.

The author was very receptive to feedback on the [corresponding sub-Reddit community](https://www.reddit.com/r/adventofsql/).

There was a good variety of topics and data types (JSON, geometry, etc).

### Cons ❌

The difficulty varies _wildly_, and some of the challenges were way too easy.

Since it was the first year, there were a fair few bugs (as expected) and the samples didn't always correctly reflect the "real" data.

Would have been awesome to have a leaderboard 😛

---

## AdvancedSQLPuzzles

> [!NOTE]
>
> The problems are available at:
>
> - https://advancedsqlpuzzles.com/
> - https://github.com/smpetersgithub/AdvancedSQLPuzzles/tree/main/Advanced%20SQL%20Puzzles
>
> The site is a [GitHub](https://github.com/) repo which only includes the questions (and solutions), but doesn't provide a live query editor.
>
> The problems are created by [Scott Peters](https://github.com/smpetersgithub).

### Pros ✔️

There are _loads_ of problems to work on, which is great!

The problems aren't just about writing a `SELECT` statement, but also tests DDL and DML knowledge, as well as Maths/stats knowledge.

There is a lot of repetition in the problems, which is good for reinforcing the patterns and techniques.

Many of these questions _are_ hard, and are good preparation for a senior technical role.

### Cons ❌

The DDL is restricted to SQL Server, so it's not as general as the other platforms.

There's a lot of overlap between the DDL and the solutions -- I guess this is for convenience, but it makes the solutions harder to read.

The problems are written in a PDF.

---

## Challenging SQL Problems

> [!TIP]
>
> This is my own set of SQL problems 😄

> [!NOTE]
>
> The problems are available at:
>
> - https://bilbottom.github.io/sql-learning-materials/challenging-sql-problems/challenging-sql-problems/
>
> The site only includes the questions (and solutions), but doesn't provide a live query editor.
>
> The problems' DDL is written in generic SQL to support multiple databases.
>
> I'm not going to add a pros and cons list: I've just included this for completeness.
