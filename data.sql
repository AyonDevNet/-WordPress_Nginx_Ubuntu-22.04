CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY '********';
GRANT ALL PRIVILEGES ON wordpress * TO 'wpuser';
FLUSH PRIVILEGES;
EXIT;
