<?php
define('CLIENT_NAME', '1of1group');
define('APP_BASE_PATH', '/var/www/html/core/');
define('CLIENT_BASE_PATH', '/var/www/html/app/');
define('BASE_URL', 'http://localhost:9010/web/');
define('CLIENT_BASE_URL', 'http://localhost:9010/app/');

define('APP_DB', '1of1group');
define('APP_USERNAME', 'root');
define('APP_PASSWORD', 'IceHrmR00t');
define('APP_HOST', 'mysql');
define('APP_CON_STR', 'mysqli://' . APP_USERNAME . ':' . APP_PASSWORD . '@' . APP_HOST . '/' . APP_DB);

//file upload
define('FILE_TYPES', 'jpg,png,jpeg');
define('MAX_FILE_SIZE_KB', 10 * 1024);
