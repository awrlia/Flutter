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
    // Mendapatkan semua data matakuliah
    $sql = "SELECT * FROM mstruangan";
    $result = $conn->query($sql);
    $products = array();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $products[] = $row;
        }
    }

    echo json_encode($products);

} elseif ($_SERVER["REQUEST_METHOD"] === "POST") {
    // Mengambil data JSON dari body
    $data = json_decode(file_get_contents("php://input"), true);

    $kode_ruangan = $data["kode_ruangan"];
    $nama_ruangan = $data["nama_ruangan"];
    $kapasitas = $data["kapasitas"];

    // Memasukkan data ke dalam database
    $sql = "INSERT INTO mstruangan (kode_ruangan, nama_ruangan, kapasitas) VALUES ('$kode_ruangan', '$nama_ruangan', '$kapasitas')";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(array("message" => "Isi Data Baru Berhasil."));
    } else {
        echo json_encode(array("message" => "Gagal menyimpan data: " . $conn->error));
    }
}

$conn->close();
?>
