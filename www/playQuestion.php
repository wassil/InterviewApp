<html>
<body>
<a href="."> Back</a><br/>
	<?php
		$id = $_GET['id'];
		require_once("mysql.php");
		$result = MySQL::query("SELECT file FROM questions WHERE id=:1",$id);
		$streamName = $result[0]['file'];
		$params = "serverURL=rtmp://127.0.0.1/Red5App&streamName=".$streamName;
	?>
	<object type="application/x-shockwave-flash" 
		data="flash/Player.swf?<?php echo $params;?>" 
		width="300" height="300">
		<param name="movie" value="flash/Player.swf?<?php echo $params;?>" />
		<param name="allowScriptAccess" value="always"/>
		<param name="allowFullScreen" value="true"/>
		<p></p>
	</object>
</body>
</html>