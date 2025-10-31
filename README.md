# SQL Basics Reference & Movie Database Project

A comprehensive reference repository for SQL fundamentals, combined with a sample Movie Database schema (no data) to practice and demonstrate SQL queries and database design principles.

---

## Repository Structure

```text
Lua-Matlab-Python-R-J2EE/sql-basics-reference/
├── DB_schema/
│   ├── moviesdb.dbml
│   ├── moviesdb.md
│   └── moviesdb.png
├── sql-basics-reference.sql
└── README.md
```
---

## SQL Basics Reference

The file `sql-basics-reference.sql` contains a complete guide to SQL fundamentals, covering:

- Basic data retrieval (`SELECT`, `WHERE`, `LIKE`, `DISTINCT`, `ORDER BY`, `LIMIT`)
- Aggregate functions (`COUNT`, `MIN`, `MAX`, `AVG`) and `GROUP BY`
- Conditional logic (`IF`, `CASE`)
- Date calculations and numeric operations
- Joins (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `CROSS JOIN`, multi-table joins)
- Practical examples, including financial analysis and industry-specific queries
- Best practices, performance tips, and SQL execution order

It is suitable as a reference for everyday SQL queries.

---

## Movies Database

This repository includes a sample Movies Database to practice SQL:

- Actors (`actors`): Stores actor information.
- Movies (`movies`): Stores movie details, industry, studio, and release year.
- Languages (`languages`): Stores movie languages.
- Financials (`financials`): Stores budgets, revenues, and units (ENUM: `Units`, `Thousands`, `Millions`, `Billions`).
- Movie-Actor (`movie_actor`): Junction table linking movies and actors (many-to-many relationship).

### Database Documentation

The schema is documented in Markdown and ER diagram format:

- [Movies Database Documentation (`moviesdb.md`)](DB_schema/moviesdb.md)
- [Database ER Diagram (`moviesdb.png`)](DB_schema/moviesdb.png)
- DBML source: `DB_schema/moviesdb.dbml`

This structure allows readers to understand table relationships, data types, ENUMs, and constraints without exposing actual data.

---

