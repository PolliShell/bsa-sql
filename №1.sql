SELECT
    p.id,
    p.first_name,
    p.last_name,
    SUM(m.budget) AS total_movies_budget
FROM
    persons p
        JOIN
    characters c ON p.id = c.actor_id
        JOIN
    movies m ON c.movie_id = m.id
GROUP BY
    p.id,
    p.first_name,
    p.last_name;
