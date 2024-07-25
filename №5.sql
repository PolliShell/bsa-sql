SELECT
    m.id AS "ID",
    m.title AS "Title",
    m.release_date AS "Release date",
    m.duration AS "Duration",
    m.description AS "Description",
    json_build_object(
            'file_name', f.file_name,
            'mime_type', f.mime_type,
            'key', f.key,
            'url', f.url
    ) AS "Poster",
    json_build_object(
            'ID', p.id,
            'First name', p.first_name,
            'Last name', p.last_name
    ) AS "Director"
FROM
    movies m
        JOIN
    countries c ON m.country_id = c.id
        LEFT JOIN
    files f ON m.poster_id = f.id
        JOIN
    persons p ON m.director_id = p.id
        JOIN
    movie_genres mg ON m.id = mg.movie_id
        JOIN
    genres g ON mg.genre_id = g.id
WHERE
        c.id = 1
  AND m.release_date >= '2022-01-01'
  AND m.duration > 135  -- 2 hours 15 minutes = 135 minutes
  AND g.name IN ('Action', 'Drama')
GROUP BY
    m.id, f.file_name, f.mime_type, f.key, f.url, p.id, p.first_name, p.last_name
ORDER BY
    m.id;