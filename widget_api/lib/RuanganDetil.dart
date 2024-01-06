import 'package:flutter/material.dart';

class RuanganDetail extends StatefulWidget {
  final String? KodeRuangan;
  final String? NamaRuangan;
  final String? Kapasitas;
  final void Function(String?, String?, String?)? tambahDataRuangan; // Tambahkan ini

  const RuanganDetail({
    Key? key,
    this.KodeRuangan,
    this.NamaRuangan,
    this.Kapasitas,
    this.tambahDataRuangan, // Tambahkan ini
  }) : super(key: key);

  @override
  _RuanganDetailState createState() => _RuanganDetailState();
}

class _RuanganDetailState extends State<RuanganDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Ruangan',
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
            _buildDetailRow("Kode Ruangan", widget.KodeRuangan),
            _buildDetailRow("Nama Ruangan", widget.NamaRuangan),
            _buildDetailRow("Kapasitas", widget.Kapasitas),
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

