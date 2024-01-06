import 'package:flutter/material.dart';

class MahasiswaDetail extends StatefulWidget {
  final String? Npm;
  final String? NamaLengkap;
  final String? Alamat;
  final void Function(String?, String?, String?)?
      tambahDataMahasiswa; // Tambahkan ini

  const MahasiswaDetail({
    Key? key,
    this.Npm,
    this.NamaLengkap,
    this.Alamat,
    this.tambahDataMahasiswa, // Tambahkan ini
  }) : super(key: key);

  @override
  _MahasiswaDetailState createState() => _MahasiswaDetailState();
}

class _MahasiswaDetailState extends State<MahasiswaDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Mahasiswa',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 189, 149, 245),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Kembali ke halaman Bottom Navigation Bar
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("NPM", widget.Npm),
            _buildDetailRow("Nama Lengkap", widget.NamaLengkap),
            _buildDetailRow("Alamat", widget.Alamat),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 189, 149, 245),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value ?? 'Belum diisi',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
