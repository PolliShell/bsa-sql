WITH movie_details AS (
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
                'Last name', p.last_name,
                'Photo', json_build_object(
                        'file_name', pf.file_name,
                        'mime_type', pf.mime_type,
                        'key', pf.key,
                        'url', pf.url
                         )
        ) AS "Director",
        json_agg(json_build_object(
                'ID', a.id,
                'First name', a.first_name,
                'Last name', a.last_name,
                'Photo', json_build_object(
                        'file_name', ap.file_name,
                        'mime_type', ap.mime_type,
                        'key', ap.key,
                        'url', ap.url
                         )
                 )) AS "Actors",
        json_agg(json_build_object(
                'ID', g.id,
                'Name', g.name
                 )) AS "Genres"
    FROM
        movies m
            LEFT JOIN files f ON m.poster_id = f.id
            JOIN persons p ON m.director_id = p.id
            LEFT JOIN files pf ON p.main_photo_id = pf.id
            LEFT JOIN movie_genres mg ON m.id = mg.movie_id
            JOIN genres g ON mg.genre_id = g.id
            LEFT JOIN characters c ON m.id = c.movie_id
            LEFT JOIN persons a ON c.actor_id = a.id
            LEFT JOIN files ap ON a.main_photo_id = ap.id
    WHERE
            m.id = 1
    GROUP BY
        m.id, f.file_name, f.mime_type, f.key, f.url,
        p.id, p.first_name, p.last_name,
        pf.file_name, pf.mime_type, pf.key, pf.url
)
SELECT * FROM movie_details;
