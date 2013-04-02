<html>
<body>
	<?php
		$streamName = "../videos/".time()."_".rand(100000,999999);
		$publishURL = urlencode("publishQuestion.php?file=".$streamName);
		$params = "serverURL=rtmp://127.0.0.1/Red5App&streamName=".$streamName."&publishURL=".$publishURL;
	?>
	<object type="application/x-shockwave-flash" 
		data="flash/Recorder.swf?<?php echo $params;?>" 
		width="300" height="300">
		<param name="movie" value="flash/Recorder.swf?<?php echo $params;?>" />
		<param name="allowScriptAccess" value="always"/>
		<param name="allowFullScreen" value="true"/>
		<p></p>
	</object>
</body>
</html>