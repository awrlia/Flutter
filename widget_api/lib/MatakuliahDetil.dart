import 'package:flutter/material.dart';

class MatakuliahDetail extends StatefulWidget {
  final String? KodeMatakuliah;
  final String? NamaMatakuliah;
  final String? SKS;
  final void Function(String?, String?, String?)?
      tambahDataMatakuliah; // Tambahkan ini

  const MatakuliahDetail({
    Key? key,
    this.KodeMatakuliah,
    this.NamaMatakuliah,
    this.SKS,
    this.tambahDataMatakuliah, // Tambahkan ini
  }) : super(key: key);

  @override
  _MatakuliahDetailState createState() => _MatakuliahDetailState();
}

class _MatakuliahDetailState extends State<MatakuliahDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Mata Kuliah',
          style: TextStyle(
            color: Colors.white,
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
            _buildDetailRow("Kode Mata Kuliah", widget.KodeMatakuliah),
            _buildDetailRow("Nama Mata Kuliah", widget.NamaMatakuliah),
            _buildDetailRow("S K S", widget.SKS),
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
