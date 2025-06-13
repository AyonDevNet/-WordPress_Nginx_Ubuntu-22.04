CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY '********';
GRANT ALL PRIVILEGES ON wordpress * TO 'wpuser';
FLUSH PRIVILEGES;
EXIT;


/** Update DB settings: */
define( 'DB_NAME', 'wordpress_db' );
define( 'DB_USER', 'wpuser' );
define( 'DB_PASSWORD', 'StrongPassword123!' );
define( 'DB_HOST', 'localhost' );
/**Optional: generate salts here  https://api.wordpress.org/secret-key/1.1/salt/ */



