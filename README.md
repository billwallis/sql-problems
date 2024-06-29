<div align="center">

[![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)](https://www.python.org/downloads/release/python-3110/)
[![Poetry](https://img.shields.io/endpoint?url=https://python-poetry.org/badge/v0.json)](https://python-poetry.org/)
[![GitHub last commit](https://img.shields.io/github/last-commit/Bilbottom/sql-problems)](https://shields.io/badges/git-hub-last-commit)

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/Bilbottom/sql-problems/main.svg)](https://results.pre-commit.ci/latest/github/Bilbottom/sql-problems/main)

</div>

---

# SQL Problems

Solutions to SQL problems.

I've only bothered solving the hardest (free) problems, and I'll add some notes on what I thought of the platform below.

> [!WARNING]
>
> This repository will contain spoilers for the problems. If you want to solve them yourself, do not look at the solutions.

> [!NOTE]
>
> Some notes on terms/phrases I use here:
>
> - "_Recommended solution_" means a solution provided by the platform itself.
> - "_Community solution_" means a solution provided by the community.

## Pre-requisites

This project uses Poetry to manage the Python dependencies and Docker to spin up the databases.

To install these, follow the instructions on their websites:

- https://python-poetry.org/docs/#installation
- https://www.python.org/downloads/
- https://docs.docker.com/get-docker/

## Quick start

After installing the pre-requisites and cloning this repo, just run Docker's `compose` command.

```bash
poetry install --sync  # --with dev
docker compose --profile build up --detach
docker compose down --volumes  # When you're finished
```

This will take a little while to run since there's a fair bit of data to chunk through. To build all services, skip the `--profile build` flag; to customise which services to build, adjust the `docker-compose.yaml` file.

You can connect to the databases using any of your favourite SQL clients.

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
- The recommended solution for the [updated-status](src/data-lemur/updated-status.sql) problem wraps all the business logic into a case statement. This is bad practice given that the solution could have used a lookup table<sup>\*</sup>, which is what SQL is all about!
- I frankly disagree with the approach for one solution ([median-search-freq](src/data-lemur/median-search-freq.sql)).

<sup>\*</sup>The DataLemur platform wasn't accepting several variant of the `VALUES` clause even though it was valid SQL. This feels like a bug in the platform.

I'm not sure about the premium hard questions, but based on the free ones, the problems are only moderately difficult -- I have to solve harder problems on a daily basis as an analytics engineer, so I don't think these are great preparation for a senior technical role.

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

Similar to DataLemur, the problem statements have sample data and expected results.

Similar to DataLemur, the platform is easy to use, has a fast response time, and the solutions tab has some good alternative community solutions -- but an added bonus is that Analyst Builder has a video explanation, too!

The PostgreSQL version that Analyst Builder uses is 16.1, two versions ahead of DataLemur.

Correct solutions have a nice animation when you submit them 😄

For the most part, the recommended solutions are good.

### Cons ❌

The "hard" problems are _waaay_ easier than the DataLemur ones; they're more like "medium" DataLemur ones.

Hopefully the "very hard" problems are actually hard, but I can't say for sure.

These questions are good for someone who's just starting out with SQL, but not for someone who's been working with SQL for a while.

---

## LeetCode

> [!NOTE]
>
> The problems are available at:
>
> - https://leetcode.com/problemset/database/?difficulty=HARD
>
> The platform uses MySQL (8.0.36) only.
>
> There are only 3 free hard problems.

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

The [member-type-upgrade.sql](src/sql-short-reads/member-type-upgrade.sql) question is a good one, I like when a question has a bit of Maths in it.

### Cons ❌

The [livesql.oracle.com](https://livesql.oracle.com/) site requires you to sign up to use it, which is a bit annoying -- in particular because it asks for more personal information than I'd like to give (phone number, company name, etc.).

Also, Oracle 🤮

To reiterate, Oracle 🤮

The recommended solutions seem overcomplicated in a few cases and, like Analyst Builder, the "hard" questions are mostly not that hard.

I disagree with the solution to [consecutive-top-product-category-performances.sql](src/sql-short-reads/consecutive-top-product-category-performances.sql).
