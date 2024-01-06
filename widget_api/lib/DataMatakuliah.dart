import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'MatakuliahDetil.dart';
import 'MatakuliahForm.dart';

class MatakuliahData {
  final String? KodeMatakuliah;
  final String? NamaMataKuliah;
  final String? SKS;

  MatakuliahData({this.KodeMatakuliah, this.NamaMataKuliah, this.SKS});
}

class DataMatakuliah extends StatefulWidget {
  const DataMatakuliah({Key? key}) : super(key: key);

  @override
  _MatakuliahState createState() => _MatakuliahState();
}

class _MatakuliahState extends State<DataMatakuliah>
    with AutomaticKeepAliveClientMixin {
  List<MatakuliahData> daftarMatakuliah = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    fetchMatkulData();
  }

  Future<void> fetchMatkulData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:80/PHP/matakuliah.php'),
      );

      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        List<MatakuliahData> matkulList = list
            .map((model) => MatakuliahData(
                  KodeMatakuliah: model['kode_matkul'],
                  NamaMataKuliah: model['nama_matkul'],
                  SKS: model['sks'],
                ))
            .toList();

        setState(() {
          daftarMatakuliah = matkulList;
        });
      } else {
        // Handle error jika HTTP request tidak berhasil
        print('Gagal mendapatkan data matakuliah');
      }
    } catch (error) {
      // Handle error jika terjadi kesalahan pada HTTP request
      print('Terjadi kesalahan: $error');
    }
  }

  void tambahDataMatkul(String? kode_matkul, String? namaMatkul, String? sks) {
    setState(() {
      daftarMatakuliah.add(
        MatakuliahData(
            KodeMatakuliah: kode_matkul, NamaMataKuliah: namaMatkul, SKS: sks),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Mata Kuliah',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MatakuliahForm(
                    tambahDataMatakuliah: tambahDataMatkul,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: daftarMatakuliah.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(daftarMatakuliah[index].KodeMatakuliah ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(daftarMatakuliah[index].NamaMataKuliah ?? ''),
                  Text(daftarMatakuliah[index].SKS ?? ''),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MatakuliahDetail(
                      KodeMatakuliah: daftarMatakuliah[index].KodeMatakuliah,
                      NamaMatakuliah: daftarMatakuliah[index].NamaMataKuliah,
                      SKS: daftarMatakuliah[index].SKS,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
