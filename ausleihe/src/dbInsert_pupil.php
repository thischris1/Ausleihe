<?php

function rand_chars($c, $l, $u = FALSE) {
if (!$u) for ($s = '', $i = 0, $z = strlen($c)-1; $i < $l; $x = rand(0,$z), $s .= $c{$x}, $i++);
else for ($i = 0, $z = strlen($c)-1, $s = $c{rand(0,$z)}, $i = 1; $i != $l; $x = rand(0,$z), $s .= $c{$x}, $s = ($s{$i} == $s{$i-1} ? substr($s,0,-1) : $s), $i=strlen($s));
return $s;
} 


$servername = "localhost";
$username = "Ausleihe";
$password = "password";
$database ="Ausleihe";
// Create connection
$conn = new mysqli($servername, $username, "",$database);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
else {
echo "Kein Fehler\n";
}

$schuelerMax = rand(20,35);
print $schuelerMax;
# get  classes
$classSql = "SELECT `id`,`klassen_name` FROM `klassen`";

$classresult = $conn->query($classSql);
while ($row = $classresult->fetch_assoc()) {
      $classId = $row["id"];
      print ($classId);
      print ("\n");
      for ($index = 0; $index < rand(10,$schuelerMax); $index++){
      	  $randomName = rand_chars("ABCDEFGHIJklmnopqrstuvwxyz", 8);
      	  $randomvorName = rand_chars("ABCDEFGHIJklmnopqrstuvwxyz", 8);        
      	  print ($index);
      	  print (" , ");
      	  print ($randomName);
      	  print (" , ");
      	  print ($randomvorName);
      	  print ("\n");
	  $insertSql = "INSERT INTO `user`( `vorname`, `name`, `klasse`) VALUES ('".$randomvorName."' , '".$randomName."' , ".$classId.")";
	  print ($insertSql);
	  if ($conn->query($insertSql) === TRUE) {
  	  echo "New record created successfully";
	  } else {
  	  echo "Error: " . $insertSql . "<br>" . $conn->error;
	  }


}

}