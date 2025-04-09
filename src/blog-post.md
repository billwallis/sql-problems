# A review of 20+ SQL problem sites

(Big post incoming)

I've spent the last few months working on (the hardest free) SQL problems from various sites, and wanted to share how I found them.

To keep things simple, I've very subjectively categorised the sites on relative difficulty (easy, medium, hard), as well as the "style" of problems:

- **"Independent problems"** - typical LeetCode-style questions, where you have a single question with an independent dataset
- **"Dataset problems"** - also sometimes described as "case studies", where you have a dataset and a series of questions to answer on it
- **"Investigations"** - where you have a dataset and a "who dunnit?" style problem to solve

There were some sites that I loved (⭐), some that were okay (👍), and some that I didn't like at all (💩). Similarly, some sites are totally free (🆓) and others have paid features (💰). I didn't try any sites that were completely paid.

Here's how the sites I tried fit into the matrix of difficulty, style, enjoyment, and cost:

|                          | **Easy**                                                                 | **Medium**                                                                             | **Hard**                                                                                                                             |
| ------------------------ | ------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Independent problems** | [Analyst Builder](https://www.analystbuilder.com/) ⭐💰                  | [Claire Carrol's Advanced SQL Challenges](https://github.com/clrcrl/advanced-sql) ⭐🆓 | [AdvancedSQLPuzzles](https://advancedsqlpuzzles.com/) ⭐🆓                                                                           |
|                          | [SQL Short Reads](https://sqlshortreads.com/sql-practice-problems/) 👍🆓 | [DataLemur](https://datalemur.com/) ⭐🆓                                               | [Interview Query](https://www.interviewquery.com/questions?tags=SQL) ⭐💰                                                            |
|                          | [StrataScratch](https://platform.stratascratch.com/coding) 👍💰          | [HackerRank](https://www.hackerrank.com/domains/sql) ⭐💰                              | [Challenging SQL Problems](https://bilbottom.github.io/sql-learning-materials/challenging-sql-problems/challenging-sql-problems/) 🆓 |
|                          | [Lost at SQL](https://lost-at-sql.therobinlord.com/) 💩🆓                | [SQL Squid Game (DataLemur Game)](https://datalemur.com/sql-game) 👍🆓                 |                                                                                                                                      |
|                          |                                                                          | [Advent of SQL](https://adventofsql.com/) 👍🆓                                         |                                                                                                                                      |
|                          |                                                                          | [LeetCode](https://leetcode.com/problemset/database/) 👍💰                             |                                                                                                                                      |
|                          |                                                                          | [DataExpert.io](https://dataexpert.io/questions) 👍💰                                  |                                                                                                                                      |
|                          |                                                                          | [Zachary Thomas SQL Questions](https://quip.com/2gwZArKuWk7W) 💩🆓                     |                                                                                                                                      |
|                          |                                                                          | [NamasteSQL](https://www.namastesql.com/coding-problems) 💩💰                          |                                                                                                                                      |
|                          |                                                                          |                                                                                        |                                                                                                                                      |
| **Dataset problems**     | [Learn SQL (SQL Practice)](https://www.sql-practice.com/) ⭐🆓           | [8 Week SQL Challenge (Data with Danny)](https://8weeksqlchallenge.com/) ⭐💰          |                                                                                                                                      |
|                          | [SQL Premier League](https://sqlpremierleague.com/challenges/) 👍💰      |                                                                                        |                                                                                                                                      |
|                          |                                                                          |                                                                                        |                                                                                                                                      |
| **Investigations**       | [SQLNoir](https://www.sqlnoir.com/) ⭐🆓                                 |                                                                                        | [Noah's Rug (Hanukkah of Data)](https://hanukkah.bluebird.sh/5784/) ⭐🆓                                                             |
|                          | [SQL Murder Mystery](https://mystery.knightlab.com/) 👍🆓                |                                                                                        |                                                                                                                                      |

If you're interested in why I categorised them this way, I've got a full review of each site in my GitHub repo where I saved my solutions:

- https://github.com/Bilbottom/sql-problems/blob/main/src/reviews.md

There were some sites that I didn't attempt at all:

- [w3resource](https://www.w3resource.com/sql-exercises/): This has an impressive number of free questions (2,605!), but none of them are hard. Good for beginners that want an "endless" list of questions to practice on.
- [CodeChef](https://www.codechef.com/learn): No free hard questions.
- [Code360](https://www.naukri.com/code360/problem-lists/top-100-sql-problems): Email registration was broken. The "hard" and "ninja" questions all look fairly easy.
- [SQL Police Department](https://sqlpd.com/): This uses a point-and-click interface, you don't actually write the SQL yourself. Might be good for complete beginners. Has some free "cases" to solve.
- [SQL Practice](https://sqlpractice.io/practice-questions): No free hard questions (yet). Feels heavily AI-generated, so concerned about the quality of the data/questions/platform.
- [Interview Master](https://www.interviewmaster.ai/home): Doesn't support password authentication and you can't access questions without an account. Feels like a rip-off of [SQL Practice](https://sqlpractice.io/practice-questions) with the same concerns.

### Which ones should you try?

Rather than a generic "study plan", it obviously depends on your current level, your role, and how you learn best.

### 👶 Total SQL noob

If you're _completely_ new to SQL, do what you'd usually do to learn something new. If that involves solving some problems, then I'd recommend:

- (Optional) Work through the [SQLBolt](https://sqlbolt.com/) interactive tutorials. You'll learn the syntax and which clauses to use for certain operations in a hands-on way
- Start with [Analyst Builder](https://www.analystbuilder.com/) to get familiar solving simple isolated SQL problems

If you're a software engineer, this should be enough to get you started. If you're in a data role (data engineer/analyst/scientist), then I'd also recommend:

- Work through the [SQLNoir](https://www.sqlnoir.com/) cases to practise thinking analytically

If you're the kind of person that likes to practise over and over, then also try:

- [Learn SQL (SQL Practice)](https://www.sql-practice.com/) for answering many questions about the same datasets
- [w3resource](https://www.w3resource.com/sql-exercises/) for the same thing (but don't feel compelled to do all 2,605 questions!)

### 🥋 You know some SQL, but you want to get better

#### ...and you're a software engineer

You probably want to focus on database design and performance (modelling, indexes, etc.). The only site I noticed which had anything close to this was [Interview Query](https://www.interviewquery.com/questions?tags=SQL):

- https://www.interviewquery.com/questions?tags=Database+Design

Aside from this, I've found the following site to be the best for explaining indexes (but note that it's not a problem site):

- https://use-the-index-luke.com/

#### ...and you're in a data role

You probably want to learn about:

- Windows functions
- Subqueries and CTEs
- "Non-standard" joins (e.g. not just joining on column equality)

Use whatever method you prefer to learn these concepts.

If you like independent question, then practise on:

- [DataLemur](https://datalemur.com/) (medium and hard problems)
- [HackerRank](https://www.hackerrank.com/domains/sql) (medium problems)

If you prefer answering several questions on the same dataset, then practise with:

- [8 Week SQL Challenge (Data with Danny)](https://8weeksqlchallenge.com/)

Note that, while the data and questions for the **8 Week SQL Challenge** are available for free, you need to pay for the solutions 🤷‍♂️

In either case, it's also worth attempting:

- [Claire Carrol's Advanced SQL Challenges](https://github.com/clrcrl/advanced-sql)

There are only two questions, but both require some out-of-the-box thinking.

### 🏆 You want to master `SELECT` statements

> **Important warning/clarification**
>
> If you're a software engineer, the same advice applies as above -- you likely won't need advanced `SELECT` statement in your job. OLTP queries are usually simple **by design**.
>
> If you're a data engineer, being "good at SQL" is more than just knowing how to write SELECT statements -- you'll also need to know data modelling (including performance considerations), and well as have non-SQL skills.

To master `SELECT` statements, you'll likely want to know:

- Correlated subqueries
- Recursive CTEs
- `GROUP BY` options (`ROLLUP`, `GROUPING SETS`, `CUBE`)
- Common query patterns (e.g. solving "gaps and islands" problems)
- How to apply complex logic with SQL
- How to use structured data types with SQL (e.g. JSON, structs/maps, lists/arrays)

Same as before: use whatever method you prefer to learn these concepts.

The sites that I found the best for practicing these were:

- [Interview Query](https://www.interviewquery.com/questions?tags=SQL) which, despite its bugs/issues, is the only site I considered upgrading to a paid plan for
- [Noah's Rug (Hanukkah of Data)](https://hanukkah.bluebird.sh/5784/) which is undoubtedly my favourite site for applying complex logic to very open-ended SQL problems
- [AdvancedSQLPuzzles](https://advancedsqlpuzzles.com/) whose "part 2" questions are largely focused on recursive CTEs

I'd also shamelessly recommend my own site:

- [Challenging SQL Problems](https://bilbottom.github.io/sql-learning-materials/challenging-sql-problems/challenging-sql-problems/) which has questions ranging a [whole range of advanced topics](https://bilbottom.github.io/sql-learning-materials/challenging-sql-problems/topics/)

**Interview Query** has a live SQL editor, but the other three don't so you'll need to set up your own SQL environment to work on these problems (but if you're ready to tackle these problems, you probably know how to do this).

---

Hopefully this helps folk tailor your SQL learning using the best resources available. The advice above is entirely subjective and your experience may differ.

Note that some reviews might be stale as the reviews apply to when I used the site.

For clarity, I'm only reviewing problem sites. The following are (interactive) courses/tutorials, so I've also skipped these:

<details>
<summary>Courses/tutorials that I skipped</summary>

- [Khan Academy](https://www.khanacademy.org/search?page_search_query=sql)
- [SQLZoo](https://sqlzoo.net/wiki/SQL_Tutorial)
- [Codecademy](https://www.codecademy.com/catalog/language/sql)
- [SQLBolt](https://sqlbolt.com/)
- [Udacity](https://www.udacity.com/catalog?searchValue=sql)
- [DataCamp](https://www.datacamp.com/courses-all?q=sql)
- [Coursera](https://www.coursera.org/search?query=sql)
- [LearnSQL](https://learnsql.com/)
- [Mode](https://mode.com/sql-tutorial)
- [W3Schools](https://www.w3schools.com/sql/)

</details>
