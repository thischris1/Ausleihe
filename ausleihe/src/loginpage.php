<html>
<head>
<title>Login</title>
</head>
<body>
<h1>Ipad Ausleihe</h1>
<a href="ausleihe_v2.php"><button>Ausleihen</button></a>
<a href="rfid_rueckgabe.php"><button>Zurückgeben</button></a>
<form action="logincheck.php" method="post">
  Enter your username and password to see history:<br>
  <input type="text" name="username" value="<?php echo "username"; ?>"/>
  <input type="password" name="password"/>
  <input type="submit" value="submit" />
  <br>
</form>
</body>
</html>
