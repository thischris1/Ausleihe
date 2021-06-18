<html>
<head>
<title>History</title>
</head>
<body>
	<form action="logincheck.php" method="post">
			Search:<br>
		  <input type="text" name="username"/>
			<input type="submit" value="submit" />
	</form>
	<?php
		$pdo = new PDO('mysql:host=localhost;dbname=ausleihe', 'root', '');
		$rfid_event = "SELECT * FROM rfid_event LEFT JOIN user ON user.user_id = rfid_event.user_id";
		$user = "SELECT * FROM user LEFT JOIN rfid_devices ON rfid_devices.device_id = user.rfid_code LEFT JOIN klassen ON user.klasse = klassen.id";
		$user = $pdo->query($user)->fetch();
		echo "All entries: "."<br><br>";
		foreach ($pdo->query($rfid_event) as $row) {
			echo "Name: ".$row['vorname']." ".$row['name']."<br>";
			if ($row['klassen_name'] == 1) {echo "Rang: Lehrer";}
			else {
				echo "Klasse: ".$row['klassen_name']."<br>";
			}
			echo "User ID: ".$row['user_id']."<br><br>";
		}
?>
</body>
</html>
