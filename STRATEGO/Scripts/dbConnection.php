<?php
$host='localhost';
$db = 'it175128';
require_once "db_upass.php";

$user=$DB_USER;
$pass=$DB_PASS;


if(gethostname()=='users.iee.ihu.gr') {
	$conn = new mysqli($host, $user, $pass, $db,null,'/home/student/it/2017/it175128/mysql/run/mysql.sock');
} else {
        $conn = new mysqli($host, $user, $pass, $db);
}

if ($conn->connect_errno) {
    echo "Failed to connect to MySQL: (" . 
    $conn->connect_errno . ") " . $conn->connect_error;
}?>
