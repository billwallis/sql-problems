# Reviews

Reviews of the SQL problem platforms are below: these are just my opinions, and you may have a different experience.

> [!NOTE]
>
> Some notes on terms/phrases I use here:
>
> - "_Recommended solution_" means a solution provided by the platform itself.
> - "_Community solution_" means a solution provided by the community.

---

## SQL Island

> [!NOTE]
>
> The problem is available at:
>
> - https://sql-island.informatik.uni-kl.de/
>
> The platform uses SQLite.
>
> The site isn't a set of problems; it's a guided SQL tutorial, so I won't save my SQL.
>
> The site is free.

### Pros ✔️

It's a good introduction for SQL and builds up the concepts well.

Lots of the steps are tweaking an existing query, which it very similar to what "doing SQL for real" is like.

It teaches DML as well as `SELECT` statements.

### Cons ❌

I get an "unsecure site" warning when I first access it (Google Chrome).

The tutorial types its own SQL slowly.

Still teaches the non-ANSI join syntax 😭😭😭

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
>
> The site is free.

### Pros ✔️

Asking an open-ended question gets you thinking analytically and is different to solving the "usual" kinds of problems.

The platform is simple and easy to use, with clear instructions.

It includes an extremely thorough walkthrough, perfect for beginners.

### Cons ❌

Not really a "con", but it's clearly just for beginners (you don't need any advanced SQL).

---

## SQLNoir

> [!NOTE]
>
> The problems are available at:
>
> - https://www.sqlnoir.com/
>
> The platform uses SQLite.
>
> The site is a set of "who dunnit?" investigations.
>
> The site is free.

### Pros ✔️

Asking an open-ended question gets you thinking analytically and is different to solving the "usual" kinds of problems.

The platform is simple and easy to use.

It (currently) has 4 investigations which get progressively more difficult.

The site has some handy tabs, and good documentation for the data model (table schemas and an interactive diagram).

### Cons ❌

Not really a "con", but it's clearly just for beginners (you don't need any advanced SQL).

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
> There are only 3 free hard problems, and 0 free "very hard" problems.

### Pros ✔️

The platform looks and feels really nice!

The problem statements have sample data and expected results.

The platform is easy to use, has a fast response time, and the solutions tab has some good alternative community solutions -- but an added bonus is that Analyst Builder has a video explanation, too!

The PostgreSQL version that Analyst Builder uses is 16.1, two versions ahead of DataLemur.

Correct solutions have a nice animation when you submit them 😄

For the most part, the recommended solutions are good.

### Cons ❌

The "hard" problems are _very_ easy. Hopefully the "very hard" problems are actually hard, but I can't say for sure.

These questions are good for someone who's just starting out with SQL, but not for someone who's been working with SQL for a while.

---

## Learn SQL (SQL Practice)

> [!NOTE]
>
> The problems are available at:
>
> - https://www.sql-practice.com/
>
> The platform uses SQLite.
>
> The site is free.

### Pros ✔️

Super simple site! Straightforward and easy to use, with no plugs for a paid tier.

Each question has an expected output, and multiple solutions.

Very fast response times for the queries.

The SQL editor is surprisingly good/user-friendly.

Both databases have an ERD, and easy to view table schemas.

It's good answering several questions per dataset, as you get more familiarity with the data with each question.

Great for people newish to SQL.

### Cons ❌

The "hard" questions are pretty easy.

I personally don't like that the keywords automatically capitalise in the editor 🤔

---

## SQL Premier League

> [!NOTE]
>
> The problems are available at:
>
> - https://sqlpremierleague.com/challenges/
>
> The platform uses PostgreSQL only.
>
> There are _loads_ of problems, and a live query editor.
>
> I only attempted a few hard questions (while they were free), but they were too easy for me to want to do any more.
>
> The hard problems now all require a subscription.

### Pros ✔️

There are _loads_ of questions, across a few different sports -- great for anyone with an interest in sports!

Each question has a submission history, discussions tab, and hints.

Each question has the required tables, and the first three rows from each table.

There's a "Report and Issue" button on the questions, which is handy for submitting bug reports.

There is a leaderboard and a nice user profile page.

### Cons ❌

The platform doesn't seem to support CTEs, even though they're valid PostgreSQL syntax.

The "hard" problems are very easy.

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
>
> The site is free.

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

## StrataScratch

> [!NOTE]
>
> The problems are available at:
>
> - https://platform.stratascratch.com/coding?difficulties=3&is_freemium=1
>
> The platform uses a mix of databases and languages, and has plenty of free "hard" problems.
>
> The site has some free questions.

### Pros ✔️

The platform feels _very_ similar to HackerRank, but with some areas that are better and others that are worse.

The platform is easy to use, has a fast response time, and the "Solutions from Users" tab has some good community solutions.

I really like that you can see other people's submissions!

### Cons ❌

There are no sample data and expected results.

The "hard" questions are not that hard 😭

These questions are good for someone who's just starting out with SQL, but not for someone who's been working with SQL for a while.

---

## Lost at SQL

> [!NOTE]
>
> The problems are available at:
>
> - https://lost-at-sql.therobinlord.com/
>
> The platform uses SQLite, and has 5 problems with a live SQL editor.
>
> It also has a "story mode", which I've not attempted.
>
> The site is free.

### Pros ✔️

It has a cute name and is a nice idea.

There are settings to configure the experience and a leaderboard.

### Cons ❌

I really want to like this site, but I **hate** it. A strong feeling, I know, but I think it's justified.

I wish more effort went into the questions: of the 5 questions, I'm sure that only 2 of them have a valid solution that is accepted by the site.

#### The GUI is too much

It's clear that a lot of work has gone into the site, but it's still not a good site:

- There are too many pages/button clicks between the landing page and the questions' SQL editor
- Every single time I go on a question it prompts me to do the tutorial
- The GUI is overcomplicated with some sections having nested scroll bars
- The GUI spacing is very poor, making too much space for decorative elements of the site
- Even in full-screen mode, I still feel like I don't have enough space -- especially for the result sets
- The auto-complete is not good, and the SQL font isn't monospaced
- I don't think syntax errors or how long it took to finish are good metrics to track for something that is meant to be a learning site

Rather than working on background images, tile decals, pictures of fish/crew/puddings, and so on, I would have much rather the effort went into making the GUI more user-friendly.

#### The questions have lots of issues

The only question I didn't have an issue with was ["maintain" by Chris Green](/src/lost-at-sql/03-maintain-by-chris-green.sql), which was extremely easy.

The other questions are reviewed below.

[**"Case" by Jess Peck**](/src/lost-at-sql/01-case-by-jess-peck.sql)

- The problem statement and solution do not align (full details in [the solution file](/src/lost-at-sql/01-case-by-jess-peck.sql)), making this a terrible question because there is no "correct" solution
- The table columns are described in metric units (meters, kilograms) but the fish details are described in imperial units (inches, pounds), adding additional confusion
  - Note that the reference to metric units seems to be an error, not a conversion to consider in the solution
- Other than these issues, the question is good, albeit very simple

[**"Identify" by David Westby**](/src/lost-at-sql/02-identify-by-david-westby.sql)

- The question is fairly good and somewhat reflective of a "real life" problem

Nitpicks:

- The solution requires the "full name" column to be `Full_Name`, with the capital `F` and `N`. This is a poor design choice

[**"Pudding" by Robin Lord**](/src/lost-at-sql/04-pudding-by-robin-lord.sql)

- I solved this "by accident" with an incorrect solution (it had a logical error), but any solution I try that I think could be correct is not accepted
- Good opportunity to use a recursive CTE and the `GROUP` window frame

Nitpicks:

- The site only checks the `offender_count` values, not the `snr_manager_id` values, so you could accidentally get a passing solution (like I did!)
- The problem statement asks for the column `snr_manager_id` but the SQL snippet asks for `senior_manager_id`, which is inconsistent (the SQL snippet is incorrect)
- Please don't use `timestamp` or `date` as object names 😔
- The problem statement's definition of "pudding offender" is contradictory: "_people who most often took more than two puddings in a day where the second pudding was the last_". You can't "_[take] more than two puddings in a day_" where "_the second pudding was the last_" because if the second pudding was the last one, you can't take more than two!
- The problem request also doesn't make much sense: why only care about the second pudding? Some people take up to 5 puddings in a single day!

[**"Search" by Dom Woodman**](/src/lost-at-sql/05-search-by-dom-woodman.sql)

- I'm very sure this question is broken: no matter what I do, I can't get an accepted solution -- and [neither can other people](https://stackoverflow.com/a/77434195/8213085), it seems

Nitpicks:

- The definition of "keyword" is not clear. Is it a unique `query` value, or the unique words _inside_ the `query` value (e.g. the `query` values split by spaces)?
- The definitions of the difference are not clear. Do they need to be directional, or just absolute values?

---

## Zachary Thomas SQL Questions

> [!NOTE]
>
> The problems are available at:
>
> - https://quip.com/2gwZArKuWk7W
>
> The site only includes the questions and some _very_ limited mock data, but doesn't provide a live query editor.
>
> The solutions aim to be independent of any specific SQL dialect, and I've solved them with DuckDB.
>
> The site is free.

### Pros ✔️

The site is easy to use and has a nice table of contents on the side.

The author has included multiple solutions, where appropriate.

### Cons ❌

Where to begin...

Despite the intention to be independent of any specific SQL dialect, the solutions to the following questions are incorrect and/or have syntax errors:

- [other-practice-problems/01-histograms.sql](zachary-thomas-sql-questions/other-practice-problems/01-histograms.sql)
- [self-join-practice-problems/03-retained-users-per-month.sql](zachary-thomas-sql-questions/self-join-practice-problems/03-retained-users-per-month.sql) parts 2 and 3
- [self-join-practice-problems/04-cumulative-sums.sql](zachary-thomas-sql-questions/self-join-practice-problems/04-cumulative-sums.sql)

Several of the questions use poor and/or inconsistent object names -- for example, "table" is an awful table name, and "from", "to", and "timestamp" are poor column names.

The "window function" questions and some of the "self join" problems are _extremely_ easy, so not appropriate for a "best medium-hard SQL questions" collection!

Additionally, of the 6 "self join" questions, 3 are objectively better solved with window functions.

The site is easy to use, but the solutions come immediately after the (small!) problem statement, so it's easy to spoil a question unless you scroll slowly.

The mock data is extremely limited.

This **is not** a great set of "medium-hard" SQL questions; this is medium _at best_, and anyone who has worked with SQL for a while should fly through most of these.

---

## NamasteSQL

> [!NOTE]
>
> The problems are available at:
>
> - https://www.namastesql.com/coding-problems
>
> The platform uses a mix of databases and languages.
>
> There are only 3 free hard problems, and 0 free "extreme hard" problems.

### Pros ✔️

The platform mostly looks and feels nice.

The problem statements have expected results.

There are recommended solutions for each database, and some have a video explanation too!

### Cons ❌

There are some GUI bugs, odd GUI frame cropping, and a schema mismatch in the [user-session-activity.sql](/src/namastesql/user-session-activity.sql) question.

The questions get you to think outside the box a bit (if you've not solved problems like these before), but they're not that hard; hopefully the "extreme hard" problems are actually hard, but I can't say for sure.

These questions are good for someone who's just starting out with SQL, but not for someone who's been working with SQL for a while.

I'm not a fan of the recommended solutions for the questions I attempted (my _opinions_ below):

- Most CTEs aren't given good names (just `cte1`, `cte2`)
- Some solutions calculate columns that aren't event used, which is confusing
- Some calculations/logic is overcomplicated -- for example, `cast(EXTRACT(EPOCH FROM <timestamp>) / 60 as int)` in [user-session-activity.sql](/src/namastesql/user-session-activity.sql) can be replaced with the much simpler `extract(minute from <timestamp>))`
- The CTE's `GROUP BY` in [project-budget.sql](/src/namastesql/project-budget.sql) implies an incorrect grain: it should only group by the project ID, and handle title and budget columns some other way

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

## SQL Squid Game (DataLemur Game)

> [!NOTE]
>
> The game is available at:
>
> - https://datalemur.com/sql-game
>
> The platform uses PostgreSQL only (version 16.4 at the time of writing).
>
> There are 9 levels to the game.
>
> The site is free.

### Pros ✔️

It has a good theme: lots of people know Squid Game.

Each level has multiple SQL editors, so you can keep several separate SQL snippets and result sets while you're working on the solution.

Some of the questions are different enough to "normal" questions that you need to think carefully about how to solve them.

Each question has a nice schema diagram to accompany the problem statement.

This is a fairly good game to play for anyone that has a solid understanding of the SQL basics.

### Cons ❌

The UI is buggy:

- Result set values are "undefined" when there are multiple columns with same name in result set (which is bad practice, but common)
- The query boxes return a "query is not defined" error when going back onto old pages

Many of the questions have unclear requirements and either don't explicitly ask for what they want, or don't define certain metrics that are required for the question!

I don't always agree with the solutions -- particularly levels 7, 8, and 9:

- [sql-squid-game/level-07.sql](/src/data-lemur/sql-squid-game/level-07.sql)
- [sql-squid-game/level-08.sql](/src/data-lemur/sql-squid-game/level-08.sql)
- [sql-squid-game/level-09.sql](/src/data-lemur/sql-squid-game/level-09.sql)

There are _loads_ of typos/grammar mistakes, and a lot of the problem statement context just feels childish -- for example, level 7:

> Today's task: **INTERNAL AFFAIRS**! You know what they say - a guard out of bed is a guard who might end up... ahem REASSIGNED! And we've had quite a few mysterious reassignments lately, haven't we? Must be something in the water... Alex Jones may be on to something...
>
> But anyways, sticking to todays task...
>
> DO YOU KNOW WHAT HAPPENS TO GUARDS WHO BREAK PROTOCOL?! Neither do I which is why I need your next analysis on identifying mysterious guard movements and what they've been up to...

Referencing Alex Jones here, and Kamala Harris/Donald Trump/Luigi Mangione in the data, feels unnecessary. Why bring politics into this?

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
>
> The site has some free questions.

### Pros ✔️

The platform is easy to use and has a fast response time.

The problem statements have sample data and expected results, and have a good walkthrough of how the numbers are derived for clarity on what the logic is.

There is a discussions tab to discuss solutions with other "hackers".

There is a leaderboard and you can gain experience (nice gamification).

I really like that you can see other people's submissions!

### Cons ❌

The only DB options are DB2, MySQL, Oracle, and SQL Server 😭

There are only two "hard" SQL problems (using the "difficulty" filter, not the "skills" filter).

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
>
> The site is free.

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

## Claire Carrol's Advanced SQL Challenges

> [!NOTE]
>
> The problems are available at:
>
> - https://github.com/clrcrl/advanced-sql
>
> This is a public GitHub repo, which only includes the data and questions.
>
> There are 2 questions. Although the questions are (loosely) based on BigQuery, I'll solve them with DuckDB.
>
> The site is free.

### Pros ✔️

The problem statements are explained very well: it's clear what the requirements are.

The problems include expected outputs, making it very easy to verify solutions.

The second question, [apportioning payments](/src/claire-carrols-advanced-sql-challenges/apportioning-payments.sql), is particularly good -- it's a real-life problem that you don't often see in problem sites.

### Cons ❌

The first question, [subscription price changes](/src/claire-carrols-advanced-sql-challenges/subscription-price-changes.sql), was a lot easier than I was expecting.

---

## 8 Week SQL Challenge (Data with Danny)

> [!NOTE]
>
> The problems are available at:
>
> - https://8weeksqlchallenge.com/
>
> The platform has 8 "case studies", each with its own dataset and context.
>
> There is no live query editor, but each case study has a link to a [DB Fiddle](https://www.db-fiddle.com/) page with the (PostgreSQL) DDL.
>
> Although the questions are based on PostgreSQL, I'll solve them with DuckDB.
>
> The site is free, but you need to pay for the solutions.

### Pros ✔️

It's nice answering several questions per dataset, as you get more familiarity/confidence with the data with each question.

There is a good variety of data between the datasets and, for the most part, the data/questions are similar like "real life" data/questions.

There is a good variety in question difficulty and the questions often build on top of previous ones.

There aren't just `SELECT` questions: there are also DML questions and "business" tasks, like creating a presentation slide.

A couple of questions require some intermediate SQL.

This is good for anyone that has done the SQL basics, and wants to try something more comprehensive.

### Cons ❌

Gotta pay for solutions, and you can't check your answers 😔

A fair few questions are ambiguous and/or have unclear requirements.

Pretty much all case studies could do with some refinement (clarity, typos, etc).

Each case study could have had some more difficult questions that _really_ stretched people's skills.

---

## Interview Query

> [!NOTE]
>
> The problems are available at:
>
> - https://www.interviewquery.com/questions?tags=SQL
>
> The platform uses MySQL (8.0.35), PostgreSQL (14.3), and SQL Server (2019) for SQL.
>
> The site has plenty of free hard questions, but has a limit on how many questions you can answer.

### Pros ✔️

The platform looks nice, is easy to use, and has a fast response time.

The problem statements have multiple test cases to verify that the query works in multiple scenarios.

The site has plenty of free hard questions (at least, questions labelled "hard").

There is a comments section for discussions with other users, and the recommended solutions generally have a thorough explanation.

The site also has other kinds of questions -- like providing a dataset with some context, and asking you to think about what kind of metrics might be good to define for the dataset.

There is good gamification on the site (leaderboards, badges, daily streaks).

I haven't used them, but lots of the premium features look pretty good.

There are some genuinely difficult problems on this site, so this is (largely) a good site to prepare for senior roles.

### Cons ❌

You can only do 3 questions for free, and several elements are hidden behind a paywall (which is fair for a free platform).

A significant proportion of the (hard) questions need some refinement:

- A couple of questions have problem statements that don't align with the expected result sets ([notification-type-conversion](/src/interview-query/notification-type-conversion.sql) and [trial-test-analysis](/src/interview-query/trial-test-analysis.sql))
- Lots of problem statements are not clear enough, with either ambiguous logic or undefined metrics (or both!)
- Lots of problem statements ask for the solution columns to be in one order, but the expected result set has a different order
- Other miscellaneous nitpicks that I won't cover here (see the solution SQL files for details)

Nitpick, but I don't like that a lot of the expected result sets with aggregates have the aggregated values _before_ the columns that are being grouped by 😬

Lots of the "hard" questions are not that hard -- the authors seem to think that a solution that includes a window function automatically makes it a hard question 🙄

---

## Noah's Rug (Hanukkah of Data)

> [!NOTE]
>
> The problems are available at:
>
> - https://hanukkah.bluebird.sh/5784/
>
> The site only includes the data and questions, but doesn't provide a live query editor.
>
> The site is free.

### Pros ✔️

This is probably my favourite "SQL sleuth" problem set!

The data is appropriately complex -- only 4 tables, but some of the tables are fairly large (for exercises like this).

The data is provided in multiple formats (CSV, JSONL, SQLite).

After completing the questions with the "normal" dataset, you get to try a speed-run with a new dataset (same schema, different rows).

The problems are easy enough to understand, but open-ended enough that you have to do some thinking and experimenting of your own.

The art in the site is very nice.

I'm categorising this as "hard" because of how open-ended it is (even if the solutions don't require _that_ advanced SQL).

### Cons ❌

There are no provided solutions or hints.

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
>
> The site is free.

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
>
> The site is free.
