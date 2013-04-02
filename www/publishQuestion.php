<?php
require_once("mysql.php");
$file = $_GET['file'];
MySQL::insertRow( 'questions', array( 'file' => $file ) );
$id = MySQL::insertId();


$url = 'http://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['PHP_SELF']);
if ((substr($url, -1) == '/') OR (substr($url, -1) == '\\') ) {
$url = substr ($url, 0, -1);
}
$url .= "/playQuestion.php?id=".$id;
header("Location: $url");
exit();
?>
