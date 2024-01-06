import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'MahasiswaDetil.dart';
import 'MahasiswaForm.dart';

class MahasiswaData {
  final String? npm;
  final String? namaLengkap;
  final String? alamat;

  MahasiswaData({this.npm, this.namaLengkap, this.alamat});
}

class DataMahasiswa extends StatefulWidget {
  const DataMahasiswa({Key? key}) : super(key: key);

  @override
  _DataMahasiswaState createState() => _DataMahasiswaState();
}

class _DataMahasiswaState extends State<DataMahasiswa>
    with AutomaticKeepAliveClientMixin {
  List<MahasiswaData> daftarMahasiswa = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    fetchMahasiswaData();
  }

  Future<void> fetchMahasiswaData() async {
    final response = await http.get(
      Uri.parse('http://localhost:80/PHP/mahasiswa.php'),
    );

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<MahasiswaData> mahasiswaList = list
          .map((model) => MahasiswaData(
                npm: model['npm'],
                namaLengkap: model['nama_lengkap'],
                alamat: model['alamat'],
              ))
          .toList();

      setState(() {
        daftarMahasiswa = mahasiswaList;
      });
    }
  }

  void tambahDataMahasiswa(String? npm, String? namaLengkap, String? alamat) {
    setState(() {
      daftarMahasiswa.add(
        MahasiswaData(npm: npm, namaLengkap: namaLengkap, alamat: alamat),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Mahasiswa',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MahasiswaForm(
                    tambahDataMahasiswa: tambahDataMahasiswa,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: daftarMahasiswa.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(daftarMahasiswa[index].npm ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(daftarMahasiswa[index].namaLengkap ?? ''),
                  Text(daftarMahasiswa[index].alamat ?? ''),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MahasiswaDetail(
                      Npm: daftarMahasiswa[index].npm,
                      NamaLengkap: daftarMahasiswa[index].namaLengkap,
                      Alamat: daftarMahasiswa[index].alamat,
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
