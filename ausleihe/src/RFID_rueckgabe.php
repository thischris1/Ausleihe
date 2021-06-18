<html>
<body>
<?php
$usercardtype = 2;
$RFID_input = "6815.123498761543";

$pdo = new PDO('mysql:host=localhost;dbname=ausleihe', 'root', '');
if (is_numeric($RFID_input)) {
  $device_device = "SELECT * FROM rfid_devices LEFT JOIN rfid_device_type ON rfid_devices.device_type = rfid_device_type.device_type_id WHERE rfid_devices.rfid_code = ".$RFID_input." AND ".$RFID_input." = rfid_devices.rfid_code";
  $device = $pdo->query($device_device)->fetch();

  #scan korrekt?
  if ($device['device_type'] != $usercardtype AND $device['device_type'] == True) {
    echo $device['name']." erkannt"."<br>";

    #Wird das Gerät ausgeliehen?
    $user_user = "SELECT * FROM user LEFT JOIN klassen ON user.klasse = klassen.id WHERE user.rfid_device_id = ".$device['device_id'];
    $user = $pdo->query($user_user)->fetch();
    if ($user) {
      echo "Benutzer: ".$user['vorname']." ".$user['name']."<br>"."Klasse: ".$user['klassen_name']."<br>";
      $update = $pdo->query("UPDATE user SET rfid_device_id = '0' WHERE rfid_device_id = ".$device['device_id']);
      $user = "SELECT * FROM user WHERE user.user_id = ".$user['user_id'];
      $user = $pdo->query($user)->fetch();
      if ($user['rfid_device_id'] == 0) {
        echo $device['name']." wurde erfolgreich zurückgegeben."."<br>";
        $rfid_event = $pdo->query("INSERT INTO rfid_event (id, event_type_id, user_id, device_id, status, time_stamp) VALUES (NULL, '1', ".$user['user_id'].", ".$device['device_id'].", '0', date('Y-m-d H:i:s'))");
      }
      else {echo "Zurückgeben fehlgeschlagen<br>Status von ".$user['vorname']." ".$user['name'].": True"."<br>";}
    }
    else {echo $device['name']." kann nicht zurückgegeben werden."."<br>";}
  }
  else {
    if ($device == false) {echo "Device ist nicht in der Datenbank registriert."."<br>";}
    if ($device['device_type'] == $usercardtype) {echo "Bitte scanne ein Device ein."."<br>";}
  }
}
else {echo "Device ist nicht in der Datenbank registriert.";}
?>
<br><br>
<a href="loginpage.php"><button>Startseite</button></a>
</body>
</html>
