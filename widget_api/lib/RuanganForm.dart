import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'RuanganDetil.dart';

class RuanganForm extends StatefulWidget {
  final void Function(String?, String?, String?)?
      tambahDataRuangan; // Tambahkan ini

  const RuanganForm({Key? key, this.tambahDataRuangan}) : super(key: key);

  @override
  _RuanganFormState createState() => _RuanganFormState();
}

class _RuanganFormState extends State<RuanganForm> {
  final _NamaRuanganTextboxController = TextEditingController();
  final _KodeRuanganTextboxController = TextEditingController();
  final _KapasitasTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Data Ruangan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextboxKodeRuangan(),
              SizedBox(height: 16),
              _buildTextboxNamaRuangan(),
              SizedBox(height: 16),
              _buildTextboxKapasitas(),
              SizedBox(height: 24),
              _buildTombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextboxKodeRuangan() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Kode Ruangan",
        border: OutlineInputBorder(),
      ),
      controller: _KodeRuanganTextboxController,
    );
  }

  Widget _buildTextboxNamaRuangan() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Nama Ruangan",
        border: OutlineInputBorder(),
      ),
      controller: _NamaRuanganTextboxController,
    );
  }

  Widget _buildTextboxKapasitas() {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
        labelText: "Kapasitas",
        border: OutlineInputBorder(),
      ),
      controller: _KapasitasTextboxController,
    );
  }

  Widget _buildTombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        _kirimDataRuangan();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RuanganDetail(
            KodeRuangan: _KodeRuanganTextboxController.text,
            NamaRuangan: _NamaRuanganTextboxController.text,
            Kapasitas: _KapasitasTextboxController.text,
          ),
        ));
      },
      child: const Text('Simpan', style: TextStyle(color: Colors.black)),
    );
  }

  void _kirimDataRuangan() async {
    String KodeRuangan = _KodeRuanganTextboxController.text;
    String NamaMataKuliah = _NamaRuanganTextboxController.text;
    String Kapasitas = _KapasitasTextboxController.text;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:80/PHP/ruangan.php'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'kode_ruangan': KodeRuangan,
          'nama_ruangan': NamaMataKuliah,
          'kapasitas': Kapasitas
        }),
      );

      if (response.statusCode == 200) {
        widget.tambahDataRuangan?.call(KodeRuangan, NamaMataKuliah, Kapasitas);
      } else {
        // Handle error jika HTTP request tidak berhasil
        print('Gagal mengirim data ke server');
      }
    } catch (error) {
      // Handle error jika terjadi kesalahan pada HTTP request
      print('Terjadi kesalahan: $error');
    }
  }
}
