import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'MatakuliahDetil.dart';

class MatakuliahForm extends StatefulWidget {
  final void Function(String?, String?, String?)? tambahDataMatakuliah;

  const MatakuliahForm({Key? key, this.tambahDataMatakuliah}) : super(key: key);

  @override
  _MatakuliahFormState createState() => _MatakuliahFormState();
}

class _MatakuliahFormState extends State<MatakuliahForm> {
  final _KodeMatakuliahTextboxController = TextEditingController();
  final _NamaMataKuliahTextboxController = TextEditingController();
  final _SKSTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Data Mata Kuliah',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextboxKodeMatakuliah(),
              SizedBox(height: 16),
              _buildTextboxNamaMataKuliah(),
              SizedBox(height: 16),
              _buildTextboxSKS(),
              SizedBox(height: 24),
              _buildTombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextboxKodeMatakuliah() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Kode Mata Kuliah",
        border: OutlineInputBorder(),
      ),
      controller: _KodeMatakuliahTextboxController,
    );
  }

  Widget _buildTextboxNamaMataKuliah() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Nama Mata Kuliah",
        border: OutlineInputBorder(),
      ),
      controller: _NamaMataKuliahTextboxController,
    );
  }

  Widget _buildTextboxSKS() {
    return TextField(
      decoration: InputDecoration(
        labelText: "SKS",
        border: OutlineInputBorder(),
      ),
      controller: _SKSTextboxController,
    );
  }

  Widget _buildTombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        _kirimDataMatakuliah();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MatakuliahDetail(
            KodeMatakuliah: _KodeMatakuliahTextboxController.text,
            NamaMatakuliah: _NamaMataKuliahTextboxController.text,
            SKS: _SKSTextboxController.text,
          ),
        ));
      },
      child: const Text('Simpan', style: TextStyle(color: Colors.black)),
    );
  }

  void _kirimDataMatakuliah() async {
    String kodeMatakuliah = _KodeMatakuliahTextboxController.text;
    String namaMataKuliah = _NamaMataKuliahTextboxController.text;
    String sks = _SKSTextboxController.text;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:80/PHP/matakuliah.php'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'kode_matkul': kodeMatakuliah,
          'nama_matkul': namaMataKuliah,
          'sks': sks
        }),
      );

      if (response.statusCode == 200) {
        widget.tambahDataMatakuliah?.call(kodeMatakuliah, namaMataKuliah, sks);
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
