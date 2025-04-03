<div align="center">

[![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)](https://www.python.org/downloads/release/python-3110/)
[![uv](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/uv/main/assets/badge/v0.json)](https://github.com/astral-sh/uv)
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

## Pre-requisites

This project uses [UV](https://docs.astral.sh/uv/) to manage the Python dependencies and [Docker](https://www.docker.com/) to spin up the databases.

To install these, follow the instructions on their websites:

- https://docs.astral.sh/uv/getting-started/installation/
- https://www.python.org/downloads/
- https://docs.docker.com/get-docker/

## Quick start

After installing the pre-requisites and cloning this repo, just run Docker's `compose` command.

```bash
uv sync --all-groups
docker compose --profile build up --detach
docker compose down --volumes  # When you're finished
```

This will take a little while to run since there's a fair bit of data to chunk through. To build all services, skip the `--profile build` flag; to customise which services to build, adjust the `docker-compose.yaml` file.

You can connect to the databases using any of your favourite SQL clients.

## Reviews

Reviews of the platforms can be found at:

- [src/reviews.md](src/reviews.md)

These are just my opinions, and you may have a different experience.

The platforms I've reviewed so far are listed below by their relative difficulty (for me).

### 🟢 Easy

- [SQL Island](https://sql-island.informatik.uni-kl.de/) ([review](src/reviews.md#sql-island))
- [SQL Murder Mystery](https://mystery.knightlab.com/) ([review](src/reviews.md#sql-murder-mystery))
- [SQLNoir](https://www.sqlnoir.com/) ([review](src/reviews.md#sqlnoir))
- [Analyst Builder](https://www.analystbuilder.com/) ([review](src/reviews.md#analyst-builder))
- [SQL Premier League](https://sqlpremierleague.com/challenges/) ([review](src/reviews.md#sql-premier-league))
- [SQL Short Reads](https://sqlshortreads.com/sql-practice-problems/) ([review](src/reviews.md#sql-short-reads))
- [StrataScratch](https://platform.stratascratch.com/coding) ([review](src/reviews.md#stratascratch))
- [Lost at SQL](https://lost-at-sql.therobinlord.com/) ([review](src/reviews.md#lost-at-sql))

### 🟠 Medium

- [Zachary Thomas SQL Questions](https://quip.com/2gwZArKuWk7W) ([review](src/reviews.md#zachary-thomas-sql-questions))
- [NamasteSQL](https://www.namastesql.com/coding-problems) ([review](src/reviews.md#namastesql))
- [DataLemur](https://datalemur.com/) ([review](src/reviews.md#datalemur))
- [SQL Squid Game (DataLemur Game)](https://datalemur.com/sql-game) ([review](src/reviews.md#sql-squid-game-datalemur-game))
- [LeetCode](https://leetcode.com/problemset/database/) ([review](src/reviews.md#leetcode))
- [HackerRank](https://www.hackerrank.com/domains/sql) ([review](src/reviews.md#hackerrank))
- [DataExpert.io](https://dataexpert.io/questions) ([review](src/reviews.md#dataexpertio))
- [Advent of SQL](https://adventofsql.com/) ([review](src/reviews.md#advent-of-sql))
- [Claire Carrol's Advanced SQL Challenges](https://github.com/clrcrl/advanced-sql) ([review](src/reviews.md#claire-carrols-advanced-sql-challenges))
- [8 Week SQL Challenge (Data with Danny)](https://8weeksqlchallenge.com/) ([review](src/reviews.md#8-week-sql-challenge-data-with-danny))

### 🔴 Hard

- [Noah's Rug (Hanukkah of Data)](https://hanukkah.bluebird.sh/5784/) ([review](src/reviews.md#noahs-rug-hanukkah-of-data))
- [AdvancedSQLPuzzles](https://advancedsqlpuzzles.com/) ([review](src/reviews.md#advancedsqlpuzzles))
- [Challenging SQL Problems](https://bilbottom.github.io/sql-learning-materials/challenging-sql-problems/challenging-sql-problems/) ([review](src/reviews.md#challenging-sql-problems))

### ⭕ Skipped

There were some problem sites that I chose to skip completely:

- [SQL Police Department](https://sqlpd.com/): This uses a point-and-click interface, you don't actually write the SQL yourself. Might be good for complete beginners. Has some free "cases" to solve.
- [SQL Practice](https://sqlpractice.io/practice-questions): There are no free hard questions.
- [Interview Master](https://www.interviewmaster.ai/home): Doesn't support password authentication and you can't access questions without an account. Feels like a rip-off of [SQL Practice](https://sqlpractice.io/practice-questions).

For clarity, I'm only reviewing problem sites and the following are (interactive) courses/tutorials, so I've also skipped these:

- [Khan Academy](https://www.khanacademy.org/search?page_search_query=sql)
- [SQLZoo](https://sqlzoo.net/wiki/SQL_Tutorial)
- [Codecademy](https://www.codecademy.com/catalog/language/sql)
- [SQLBolt](https://sqlbolt.com/)
- [Udacity](https://www.udacity.com/catalog?searchValue=sql)
- [DataCamp](https://www.datacamp.com/courses-all?q=sql)
- [Coursera](https://www.coursera.org/search?query=sql)
- [LearnSQL](https://learnsql.com/)
- [Mode](https://mode.com/sql-tutorial)
