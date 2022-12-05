<?php
include_once "includes/test.inc.php";

$str = "lol2";
$integ = 10;
$date = null;

$sql = "INSERT INTO test (date, str, integ) VALUES (?,?,?)";
$stmt = $pdo -> prepare($sql);
// $stmt -> bindValue(1, $date, PDO::PARAM_NULL);
$stmt -> execute([$date, $str, $integ]);

?>