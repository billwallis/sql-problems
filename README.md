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

> [!NOTE]
>
> Some notes on terms/phrases I use here:
>
> - "_Recommended solution_" means a solution provided by the platform itself.
> - "_Community solution_" means a solution provided by the community.

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

- [Analyst Builder](https://www.analystbuilder.com/) ([review](src/reviews.md#analyst-builder))
- [SQL Short Reads](https://sqlshortreads.com/sql-practice-problems/) ([review](src/reviews.md#sql-short-reads))
- [SQL Murder Mystery](https://mystery.knightlab.com/) ([review](src/reviews.md#sql-murder-mystery))

### 🟠 Medium

- [DataLemur](https://datalemur.com/) ([review](src/reviews.md#datalemur))
- [LeetCode](https://leetcode.com/problemset/database/) ([review](src/reviews.md#leetcode))
- [DataExpert.io](https://dataexpert.io/questions) ([review](src/reviews.md#dataexpertio))
- [Advent of SQL](https://adventofsql.com/) ([review](src/reviews.md#advent-of-sql))

### 🔴 Hard

- [AdvancedSQLPuzzles](https://advancedsqlpuzzles.com/) ([review](src/reviews.md#advancedsqlpuzzles))
- [Challenging SQL Problems](https://bilbottom.github.io/sql-learning-materials/challenging-sql-problems/challenging-sql-problems/) ([review](src/reviews.md#challenging-sql-problems))
