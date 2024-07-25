CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       first_name VARCHAR(50) NOT NULL,
                       last_name VARCHAR(50) NOT NULL,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       avatar_id INTEGER REFERENCES files(id),
                       created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE files (
                       id SERIAL PRIMARY KEY,
                       file_name VARCHAR(255) NOT NULL,
                       mime_type VARCHAR(50) NOT NULL,
                       key VARCHAR(255) NOT NULL UNIQUE,
                       url VARCHAR(255) NOT NULL,
                       created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE countries (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE movies (
                        id SERIAL PRIMARY KEY,
                        title VARCHAR(255) NOT NULL,
                        description TEXT,
                        budget NUMERIC(15, 2),
                        release_date DATE,
                        duration INTEGER,
                        director_id INTEGER REFERENCES persons(id),
                        country_id INTEGER REFERENCES countries(id),
                        poster_id INTEGER REFERENCES files(id),
                        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE genres (
                        id SERIAL PRIMARY KEY,
                        name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE movie_genres (
                              movie_id INTEGER REFERENCES movies(id) ON DELETE CASCADE,
                              genre_id INTEGER REFERENCES genres(id) ON DELETE CASCADE,
                              PRIMARY KEY (movie_id, genre_id)
);

CREATE TABLE characters (
                            id SERIAL PRIMARY KEY,
                            name VARCHAR(255) NOT NULL,
                            description TEXT,
                            role VARCHAR(50) CHECK (role IN ('leading', 'supporting', 'background')),
                            movie_id INTEGER REFERENCES movies(id) ON DELETE CASCADE,
                            actor_id INTEGER REFERENCES persons(id),
                            created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                            updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE persons (
                         id SERIAL PRIMARY KEY,
                         first_name VARCHAR(50) NOT NULL,
                         last_name VARCHAR(50) NOT NULL,
                         biography TEXT,
                         date_of_birth DATE,
                         gender VARCHAR(10),
                         country_id INTEGER REFERENCES countries(id),
                         main_photo_id INTEGER REFERENCES files(id),
                         created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person_photos (
                               person_id INTEGER REFERENCES persons(id) ON DELETE CASCADE,
                               file_id INTEGER REFERENCES files(id) ON DELETE CASCADE,
                               PRIMARY KEY (person_id, file_id)
);

CREATE TABLE favorites (
                           user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
                           movie_id INTEGER REFERENCES movies(id) ON DELETE CASCADE,
                           PRIMARY KEY (user_id, movie_id),
                           created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                           updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO files (file_name, mime_type, key, url)
VALUES
    ('avatar1.png', 'image/png', 'avatars/avatar1.png', 'https://s3.amazonaws.com/yourbucket/avatars/avatar1.png'),
    ('avatar2.jpg', 'image/jpeg', 'avatars/avatar2.jpg', 'https://s3.amazonaws.com/yourbucket/avatars/avatar2.jpg'),
    ('poster1.png', 'image/png', 'posters/poster1.png', 'https://s3.amazonaws.com/yourbucket/posters/poster1.png');

INSERT INTO users (username, first_name, last_name, email, password, avatar_id)
VALUES
    ('johndoe', 'John', 'Doe', 'johndoe@example.com', 'hashedpassword1', 1),
    ('janedoe', 'Jane', 'Doe', 'janedoe@example.com', 'hashedpassword2', 2);

INSERT INTO countries (name)
VALUES
    ('United States'),
    ('Canada'),
    ('United Kingdom');

INSERT INTO persons (first_name, last_name, biography, date_of_birth, gender, country_id, main_photo_id)
VALUES
    ('Steven', 'Spielberg', 'An American film director, producer, and screenwriter.', '1946-12-18', 'male', 1, 1),
    ('Christopher', 'Nolan', 'A British-American film director, producer, and screenwriter.', '1970-07-30', 'male', 3, 2);

INSERT INTO genres (name)
VALUES
    ('Action'),
    ('Drama'),
    ('Comedy');

INSERT INTO movies (title, description, budget, release_date, duration, director_id, country_id, poster_id)
VALUES
    ('Inception', 'A mind-bending thriller where dream invasion is possible.', 160000000, '2024-07-16', 148, 2, 3, 3),
    ('Jurassic Park', 'Dinosaurs are brought back to life through cloning.', 63000000, '2023-06-11', 140, 1, 1, 1);

INSERT INTO movie_genres (movie_id, genre_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 3);

INSERT INTO characters (name, description, role, movie_id, actor_id)
VALUES
    ('Dom Cobb', 'A skilled thief and dream infiltrator.', 'leading', 1, NULL),
    ('Dr. Alan Grant', 'A paleontologist who is invited to Jurassic Park.', 'leading', 2, NULL);

INSERT INTO person_photos (person_id, file_id)
VALUES
    (1, 1),
    (2, 2);

INSERT INTO favorites (user_id, movie_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 1);
