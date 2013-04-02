<html>
<body>
<a href="recordQuestion.php">Record new question</a><br/><br/>
<?php
	require_once("mysql.php");
	$result = MySQL::query( 'SELECT id, file FROM questions;');
	foreach( $result as $row ) {
		echo '<a href="playQuestion.php?id='.$row['id'].'">Question #'.$row['id'].'</a><br/>';
	}
?>
</body>
</html>