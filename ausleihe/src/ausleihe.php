<html>
<body>
<?php
#RFID inputs:
$usercard = 0;
$usercardtype = 2;
$RFID_input2 = "6406.586651137644";
$RFID_input1 = "6815.123498761543";
$n = 0;
if (is_numeric($RFID_input1) AND is_numeric($RFID_input2)) {
  $pdo = new PDO('mysql:host=localhost;dbname=ausleihe', 'root', '');
  $device_1SELECT = "SELECT * FROM rfid_devices LEFT JOIN rfid_device_type ON rfid_devices.device_type = rfid_device_type.device_type_id WHERE rfid_devices.rfid_code = ".$RFID_input1." AND ".$RFID_input1." = rfid_devices.rfid_code";
  $device_2SELECT = "SELECT * FROM rfid_devices LEFT JOIN rfid_device_type ON rfid_devices.device_type = rfid_device_type.device_type_id WHERE rfid_devices.rfid_code = ".$RFID_input2." AND ".$RFID_input2." = rfid_devices.rfid_code";
  $device_1 = $pdo->query($device_1SELECT)->fetch();
  $device_2 = $pdo->query($device_2SELECT)->fetch();

  #scan korrekt?
  if ($RFID_input1 != $device_1['rfid_code'] AND $RFID_input2 != $device_2['rfid_code']) {echo "Device 1 und Device 2 sind nicht in der Datenbank registriert."."<br>";}
  else {
    if ($RFID_input1 != $device_1['rfid_code']) {echo "Device 1 ist nicht in der Datenbank registriert."."<br>";}
    if ($RFID_input2 != $device_2['rfid_code']) {echo "Device 2 ist nicht in der Datenbank registriert."."<br>";}
    $n = 1;
  }
  if ($device_1['device_type'] == $device_2['device_type'] AND $n == 1) {echo "Bitte scanne eine Usercard und ein weiteres Gerät ein."."<br>";}
  if ((($device_1['device_type'] OR $device_2['device_type']) == $usercardtype) AND $device_1['device_type'] != $device_2['device_type']) {
    if ($device_1['device_type'] != $usercardtype) {
      $usercard = $device_2['device_id'];
      $device = $device_1['device_id'];
      $devicename = $device_1['name'];
    }
    else {
      $usercard = $device_1['device_id'];
      $device = $device_2['device_id'];
      $devicename = $device_2['name'];
    }

    #Code, wenn das Gerät und Usercard in der db ist:
    #Zeile vom User holen:
    if ($device_1 AND $device_2) {
      $user_user = "SELECT * FROM user LEFT JOIN rfid_devices ON rfid_devices.device_id = user.rfid_code LEFT JOIN klassen ON user.klasse = klassen.id WHERE user.rfid_code = ".$usercard;
      $user = $pdo->query($user_user)->fetch();
      echo "Eine Usercard und ".$devicename." erkannt."."<br>";
      echo "Benutzer: ".$user['vorname']." ".$user['name']."<br>"."Klasse: ".$user['klassen_name']."<br>";
      #Wird das gerät ausgeliehen oder leiht die Person gerade etwas aus?
      if ($user['rfid_device_id'] != 0) {echo "Du leihst bereits aus: ".$devicename."<br>";}
      $device_check = "SELECT * FROM user WHERE rfid_device_id = ".$device;
      $device_check = $pdo->query($device_check)->fetch();
      if ($device_check == True AND $device_check['rfid_code'] == $usercard) {echo "Man munkelt, dass du das eingescannte Gerät (".$devicename.") bereits ausleihst."."<br>";}
      elseif ($device_check) {echo "Das eingescannte Gerät (".$devicename.") wird bereits ausgeliehen.";}
      elseif($device_check == false AND $user['rfid_device_id'] == 0) {
        $update = $pdo->query("UPDATE user SET rfid_device_id = ".$device." WHERE rfid_code = ".$usercard);
        $rfid_event = $pdo->query("INSERT INTO rfid_event (id, event_type_id, user_id, device_id, status, time_stamp) VALUES (NULL, '1', ".$user['user_id'].", $device, '1', date('Y-m-d H:i:s'))");
        $user = $pdo->query($user_user)->fetch();
        if ($user['rfid_device_id'] == $device) {echo "Status von ".$user['vorname']." ".$user['name'].": True (ID: ".$user['rfid_device_id'].")<br>".$devicename." wurde erfolgreich ausgeliehen."."<br>";  }
        else {echo "Ausleihen fehlgeschlagen<br>Status von ".$user['vorname']." ".$user['name'].": False"."<br>";}
      }
    }
  }
}
else {
  if (is_numeric($RFID_input1) == false AND is_numeric($RFID_input2) == false) {echo "Device 1 und Device 2 sind nicht in der Datenbank registriert."."<br>";}
  else {
    if (is_numeric($RFID_input1) == false) {echo "Device 1 ist nicht in der Datenbank registriert."."<br>";}
    if (is_numeric($RFID_input2) == false) {echo "Device 2 ist nicht in der Datenbank registriert."."<br>";}
  }
}
?>
<br><br>
<a href="loginpage.php"><button>Startseite</button></a>
</body>
</html>
