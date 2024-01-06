import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DosenDetil.dart';

class DosenForm extends StatefulWidget {
  final void Function(String?, String?, String?)?
      tambahDataDosen; // Tambahkan ini

  const DosenForm({Key? key, this.tambahDataDosen}) : super(key: key);

  @override
  _DosenFormState createState() => _DosenFormState();
}

class _DosenFormState extends State<DosenForm> {
  final _NamaDosenTextboxController = TextEditingController();
  final _NidnTextboxController = TextEditingController();
  final _AlamatTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Data Dosen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextboxNidn(),
              SizedBox(height: 16),
              _buildTextboxNamaDosen(),
              SizedBox(height: 16),
              _buildTextboxAlamat(),
              SizedBox(height: 24),
              _buildTombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextboxNidn() {
    return TextField(
      decoration: InputDecoration(
        labelText: "N I D N",
        border: OutlineInputBorder(),
      ),
      controller: _NidnTextboxController,
    );
  }

  Widget _buildTextboxNamaDosen() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Nama Dosen",
        border: OutlineInputBorder(),
      ),
      controller: _NamaDosenTextboxController,
    );
  }

  Widget _buildTextboxAlamat() {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
        labelText: "Alamat",
        border: OutlineInputBorder(),
      ),
      controller: _AlamatTextboxController,
    );
  }

  Widget _buildTombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        _kirimDataDosen();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DosenDetail(
            Nidn: _NidnTextboxController.text,
            NamaDosen: _NamaDosenTextboxController.text,
            Alamat: _AlamatTextboxController.text,
          ),
        ));
      },
      child: const Text('Simpan',
          style: TextStyle(color: Color.fromARGB(255, 17, 17, 18))),
    );
  }

  void _kirimDataDosen() async {
    String nidn = _NidnTextboxController.text;
    String namaDosen = _NamaDosenTextboxController.text;
    String alamat = _AlamatTextboxController.text;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:80/PHP/dosen.php'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(
            {'nidn': nidn, 'nama_dosen': namaDosen, 'alamat': alamat}),
      );

      if (response.statusCode == 200) {
        widget.tambahDataDosen?.call(nidn, namaDosen, alamat);
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
