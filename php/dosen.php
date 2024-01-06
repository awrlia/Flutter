<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

//koneksi ke database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "ulbi2024db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Koneksi Gagal: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] === "GET") {
    //Obter todos os produtos
    $sql = "SELECT * FROM mstdosen";
    $result = $conn->query($sql);
    $products = array();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $products[] = $row;
        }
    }

    echo json_encode($products);

} elseif ($_SERVER["REQUEST_METHOD"] === "POST") {
    $data = json_decode(file_get_contents("php://input"), true);

    $nidn = $data["nidn"];
    $nama_dosen = $data["nama_dosen"];
    $alamat = $data["alamat"];

    $sql = "INSERT INTO mstdosen (nidn, nama_dosen, alamat) VALUES ('$nidn', '$nama_dosen', '$alamat')";
    $conn->query($sql);
    echo json_encode(array("message" => "Isi Data Baru Berhasil."));
}

$conn->close();
?>