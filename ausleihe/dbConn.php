 <?php
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
 $sql = "SELECT id,`klassen_name` FROM `klassen`";
// Create database


$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo "id: " . $row["id"]. " - Name: " . $row["klassen_name"]. "<br>";
  }
} else {
  echo "0 results";
}
echo "Connection da";


$conn->close();
?> 