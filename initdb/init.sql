SET client_encoding = 'UTF8';

CREATE SCHEMA IF NOT EXISTS public;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS public."users" (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS public."posts" (
    post_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)
        REFERENCES users (id)
        ON DELETE CASCADE
);

-- users テーブルにサンプルデータを挿入
INSERT INTO users (username, email, password) VALUES
('user1', 'user1@example.com', 'password1'),
('user2', 'user2@example.com', 'password2');

-- posts テーブルにサンプルデータを挿入
-- ユーザーIDを取得するために、先ほど挿入したユーザーデータからIDを取得する
INSERT INTO posts (user_id, title, body) VALUES
((SELECT id FROM users WHERE username = 'user1'), 'Post Title 1', 'Post body content for user 1 post 1'),
((SELECT id FROM users WHERE username = 'user1'), 'Post Title 2', 'Post body content for user 1 post 2'),
((SELECT id FROM users WHERE username = 'user1'), 'Post Title 3', 'Post body content for user 1 post 3'),
((SELECT id FROM users WHERE username = 'user1'), 'Post Title 4', 'Post body content for user 1 post 4'),
((SELECT id FROM users WHERE username = 'user1'), 'Post Title 5', 'Post body content for user 1 post 5'),
((SELECT id FROM users WHERE username = 'user2'), 'Post Title 6', 'Post body content for user 2 post 1'),
((SELECT id FROM users WHERE username = 'user2'), 'Post Title 7', 'Post body content for user 2 post 2'),
((SELECT id FROM users WHERE username = 'user2'), 'Post Title 8', 'Post body content for user 2 post 3'),
((SELECT id FROM users WHERE username = 'user2'), 'Post Title 9', 'Post body content for user 2 post 4'),
((SELECT id FROM users WHERE username = 'user2'), 'Post Title 10', 'Post body content for user 2 post 5');
