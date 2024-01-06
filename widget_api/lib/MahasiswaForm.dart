import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'MahasiswaDetil.dart';

class MahasiswaForm extends StatefulWidget {
  final void Function(String?, String?, String?)? tambahDataMahasiswa;

  const MahasiswaForm({Key? key, this.tambahDataMahasiswa}) : super(key: key);

  @override
  _MahasiswaFormState createState() => _MahasiswaFormState();
}

class _MahasiswaFormState extends State<MahasiswaForm> {
  final _NamaLengkapTextboxController = TextEditingController();
  final _NpmTextboxController = TextEditingController();
  final _AlamatTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Data Mahasiswa',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextboxNpm(),
              SizedBox(height: 16),
              _buildTextboxNamaLengkap(),
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

  Widget _buildTextboxNpm() {
    return TextField(
      decoration: InputDecoration(
        labelText: "N P M",
        border: OutlineInputBorder(),
      ),
      controller: _NpmTextboxController,
    );
  }

  Widget _buildTextboxNamaLengkap() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Nama Lengkap",
        border: OutlineInputBorder(),
      ),
      controller: _NamaLengkapTextboxController,
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
        _kirimDataMahasiswa();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MahasiswaDetail(
            Npm: _NpmTextboxController.text,
            NamaLengkap: _NamaLengkapTextboxController.text,
            Alamat: _AlamatTextboxController.text,
          ),
        ));
      },
      child: const Text('Simpan', style: TextStyle(color: Colors.black)),
    );
  }

  void _kirimDataMahasiswa() async {
    String npm = _NpmTextboxController.text;
    String namaLengkap = _NamaLengkapTextboxController.text;
    String alamat = _AlamatTextboxController.text;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:80/PHP/mahasiswa.php'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(
            {'npm': npm, 'nama_lengkap': namaLengkap, 'alamat': alamat}),
      );

      if (response.statusCode == 200) {
        widget.tambahDataMahasiswa?.call(npm, namaLengkap, alamat);
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
