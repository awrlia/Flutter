import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'RuanganDetil.dart';
import 'RuanganForm.dart';

class RuanganData {
  final String? KodeRuangan;
  final String? NamaRuangan;
  final String? Kapasitas;

  RuanganData({this.KodeRuangan, this.NamaRuangan, this.Kapasitas});
}

class DataRuangan extends StatefulWidget {
  const DataRuangan({Key? key}) : super(key: key);

  @override
  _RuanganState createState() => _RuanganState();
}

class _RuanganState extends State<DataRuangan>
    with AutomaticKeepAliveClientMixin {
  List<RuanganData> daftarRuangan = [];

  @override
  bool get wantKeepAlive => true; // Membuat widget tetap "alive"

  @override
  void initState() {
    super.initState();
    fetchRuanganData();
  }

  Future<void> fetchRuanganData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:80/PHP/ruangan.php'),
      );

      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        List<RuanganData> ruanganList = list
            .map((model) => RuanganData(
                  KodeRuangan: model['kode_ruangan'],
                  NamaRuangan: model['nama_ruangan'],
                  Kapasitas: model['kapasitas'],
                ))
            .toList();

        setState(() {
          daftarRuangan = ruanganList;
        });
      } else {
        // Handle error jika HTTP request tidak berhasil
        print('Gagal mendapatkan data ruangan');
      }
    } catch (error) {
      // Handle error jika terjadi kesalahan pada HTTP request
      print('Terjadi kesalahan: $error');
    }
  }

  void tambahDataRuangan(
      String? kode_ruangan, String? nama_ruangan, String? kapasitas) {
    setState(() {
      daftarRuangan.add(
        RuanganData(
            KodeRuangan: kode_ruangan,
            NamaRuangan: nama_ruangan,
            Kapasitas: kapasitas),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Ruangan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RuanganForm(
                    tambahDataRuangan: tambahDataRuangan,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: daftarRuangan.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(daftarRuangan[index].KodeRuangan ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(daftarRuangan[index].NamaRuangan ?? ''),
                  Text(daftarRuangan[index].Kapasitas ?? ''),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RuanganDetail(
                      KodeRuangan: daftarRuangan[index].KodeRuangan,
                      NamaRuangan: daftarRuangan[index].NamaRuangan,
                      Kapasitas: daftarRuangan[index].Kapasitas,
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
