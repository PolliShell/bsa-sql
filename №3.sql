SELECT
    u.id AS "ID",
    u.username AS "Username",
    ARRAY_AGG(f.movie_id) AS "Favorite movie IDs"
FROM
    users u
        LEFT JOIN
    favorites f ON u.id = f.user_id
GROUP BY
    u.id, u.username
ORDER BY
    u.id;