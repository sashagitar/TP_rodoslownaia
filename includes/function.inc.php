<?php
// бд

// Проверка на наличие чего-то в базе данных
// from - таблица
// where - столбец
// what - значение
function existDB(PDO $pdo, string $from, string $where, $what): bool{
    $where = $where.' =';
    $sql = "SELECT * FROM ".$from." WHERE ".$where." = '".$what."';";
    try{
        $stmt = $pdo -> prepare($sql); // запрос в базу (должна быь обязательно указанна таблица и where)
        $stmt -> execute([$what]); // запрос с конкретным значением
        if ($stmt) { // True - если получили ответ на запрос
            if ($stmt -> rowCount() == 0) // проверяем количество
            { 
                return false; 
            }
            else
            { 
                return true; 
            }
        }
    }
    catch( PDOException $e) {
        header("location: ../index.php?error=stmt&message=".$e ->getMessage());
        exit();
    }
}

// Возвращает количество строк запроса
// from - таблица
// where - столбец
// what - значение
function getDB_count(PDO $pdo,  string $from, string $where, $what): int{
    $sql = "SELECT COUNT(*) FROM ".$from." WHERE ".$where." = '".$what."';";
    try {

        $res = $pdo->query($sql);
        return $res->fetchColumn(); // запрос на простое извлечение по столбцам работает как $idUser = $row -> id
    }
    catch( PDOException $e) {
        header("location: ../index.php?error=stmt&message=".$e ->getMessage());
        exit();
    }
}

// Возвращает значение запроса готовый для fetch
// from - таблица
// where - столбец
// what - значение
function getDB(PDO $pdo,  string $from, string $where, $what): PDOStatement{
    $where = $where.' =';
    $sql = "SELECT * FROM ".$from." WHERE ".$where." = ?;";
    try {

        $stmt = $pdo -> prepare($sql);
        $stmt -> execute([$what]);
        return $stmt; // запрос на простое извлечение по столбцам работает как $idUser = $row -> id
    }
    catch( PDOException $e) {
        header("location: ../index.php?error=stmt&message=".$e ->getMessage());
        exit();
    }
}

// Возвращает хеш пароля по логину, если такой есть иначе null
function getPassHash(PDO $pdo, string $login){
    $sql = "SELECT * FROM users WHERE ? = ?;";
    try{

        $stmt = $pdo -> prepare($sql);
        $stmt->execute([$login]);
        $row = $stmt -> fetch();
        if ($row) return $row['pass'];
        else return null;
    }
    catch( PDOException $e) {
        header("location: ../index.php?error=stmt&message=".$e ->getMessage());
        exit();
    }
}

// Создаёт id нового дерева и возвращае его
function createTree(PDO $pdo): int{
    $sql = "INSERT INTO trees (id) VALUES (NULL);";
    try {

        $pdo->query($sql);
        $sql = "SELECT * FROM trees order by id desc";
    
        $row = $pdo->query($sql);
        return ($row->fetch())['id'];
    }
    catch( PDOException $e) {
        header("location: ../index.php?error=stmt&message=".$e ->getMessage());
        exit();
    }
}

// Создаёт лист дерева и возвращает его
// Надо обсудить формат dob и dod чтобы передавать дату
// name думаю лучше брать из SESSION как и остальную информацию о пользователе
// dob - дата рождения
// id_last_editor - кто последний изменял
// id_father - id отца
// id_mother - id матери
// id_previous - идентификатор того листа, который дал право изменять дерево
// id_sex - пол
// dod - дата смерти (если есть)
function createLeafs(PDO $pdo, string $name, string $dob, int $id_last_editor, int 	$id_father, int $id_mother, int $id_previous, int $id_sex, string $dod = null){
    try{
        $sql = "INSERT INTO tree_leafs (name, DOB, DOD, id_last_editor, id_father, id_mother, id_previous, id_tree, id_sex) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $pdo -> prepare($sql);
        $stmt->execute([$name, $dob, $dod, $id_last_editor, $id_father, $id_mother, $id_previous, $id_sex]);
    }
    catch( PDOException $e) {
        header("location: ../index.php?error=stmt&message=".$e ->getMessage());
        exit();
    }
}

// Создает брак))
// id_husband - id мужа
// id_wife - id жены
// date_marriage - дата регистрации брака
// date_divorce - дата развода (если есть)
function createMarriage(PDO $pdo, int $id_husband, int $id_wife, string $date_marriage, string $date_divorce = null){
    try{
        $sql = "INSERT INTO marriage (id_husband, id_wife, date_marriage, date_divorce) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $pdo -> prepare($sql);
        $stmt->execute([$id_husband, $id_wife, $date_marriage, $date_divorce]);
    }
    catch( PDOException $e) {
        header("location: ../index.php?error=stmt&message=".$e ->getMessage());
        exit();
    }
}


?>