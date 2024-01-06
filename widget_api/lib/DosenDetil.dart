import 'package:flutter/material.dart';

class DosenDetail extends StatefulWidget {
  final String? Nidn;
  final String? NamaDosen;
  final String? Alamat;
  final void Function(String?, String?, String?)? tambahDataDosen; // Tambahkan ini

  const DosenDetail({
    Key? key,
    this.Nidn,
    this.NamaDosen,
    this.Alamat,
    this.tambahDataDosen, // Tambahkan ini
  }) : super(key: key);

  @override
  _DosenDetailState createState() => _DosenDetailState();
}

class _DosenDetailState extends State<DosenDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Dosen',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:Color.fromARGB(255, 189, 149, 245),
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
            _buildDetailRow("N I D N", widget.Nidn),
            _buildDetailRow("Nama Dosen", widget.NamaDosen),
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
              color:Color.fromARGB(255, 189, 149, 245),
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

