## Database ER Diagram

```mermaid
erDiagram
    users {
        id SERIAL PK
        username VARCHAR(50) UNIQUE
        first_name VARCHAR(50)
        last_name VARCHAR(50)
        email VARCHAR(100) UNIQUE
        password VARCHAR(255)
        avatar_id INTEGER FK
        created_at TIMESTAMP
        updated_at TIMESTAMP
    }

    files {
        id SERIAL PK
        file_name VARCHAR(255)
        mime_type VARCHAR(50)
        key VARCHAR(255) UNIQUE
        url VARCHAR(255)
        created_at TIMESTAMP
        updated_at TIMESTAMP
    }

    countries {
        id SERIAL PK
        name VARCHAR(100) UNIQUE
    }

    movies {
        id SERIAL PK
        title VARCHAR(255)
        description TEXT
        budget NUMERIC(15, 2)
        release_date DATE
        duration INTEGER
        director_id INTEGER FK
        country_id INTEGER FK
        poster_id INTEGER FK
        created_at TIMESTAMP
        updated_at TIMESTAMP
    }

    genres {
        id SERIAL PK
        name VARCHAR(50) UNIQUE
    }

    movie_genres {
        movie_id INTEGER FK
        genre_id INTEGER FK
        PRIMARY KEY (movie_id, genre_id)
    }

    characters {
        id SERIAL PK
        name VARCHAR(255)
        description TEXT
        role VARCHAR(50)
        movie_id INTEGER FK
        actor_id INTEGER FK
        created_at TIMESTAMP
        updated_at TIMESTAMP
    }

    persons {
        id SERIAL PK
        first_name VARCHAR(50)
        last_name VARCHAR(50)
        biography TEXT
        date_of_birth DATE
        gender VARCHAR(10)
        country_id INTEGER FK
        main_photo_id INTEGER FK
        created_at TIMESTAMP
        updated_at TIMESTAMP
    }

    person_photos {
        person_id INTEGER FK
        file_id INTEGER FK
        PRIMARY KEY (person_id, file_id)
    }

    favorites {
        user_id INTEGER FK
        movie_id INTEGER FK
        PRIMARY KEY (user_id, movie_id)
        created_at TIMESTAMP
        updated_at TIMESTAMP
    }

    users ||--o{ files : has
    movies ||--o{ files : has
    movies ||--o{ persons : directed_by
    movies ||--o{ countries : set_in
    movies ||--o{ movie_genres : classified_as
    movie_genres ||--o{ genres : includes
    movies ||--o{ characters : features
    characters ||--o{ persons : acted_by
    persons ||--o{ files : has_photo
    persons ||--o{ person_photos : includes
    users ||--o{ favorites : has
    favorites ||--o{ movies : likes
