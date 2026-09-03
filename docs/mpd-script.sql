CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE lists (
    list_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL,
    CONSTRAINT fk_lists_user 
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE wishes (
    wish_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    comment TEXT,
    price DECIMAL(10, 2),
    website_url TEXT,
    picture_url TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reserved_at TIMESTAMP NULL,
    user_id INT NULL,
    list_id INT NOT NULL,
    CONSTRAINT fk_wishes_user 
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_wishes_list 
        FOREIGN KEY (list_id) REFERENCES lists(list_id) ON DELETE CASCADE
);

CREATE TABLE share_links (
    share_link_id SERIAL PRIMARY KEY,
    token VARCHAR(64) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    list_id INT NOT NULL UNIQUE,
    CONSTRAINT fk_share_links_list 
        FOREIGN KEY (list_id) REFERENCES lists(list_id) ON DELETE CASCADE
);

CREATE TABLE followed_lists (
    user_id INT NOT NULL,
    list_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, list_id),
    CONSTRAINT fk_followed_user 
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_followed_list 
        FOREIGN KEY (list_id) REFERENCES lists(list_id) ON DELETE CASCADE
);