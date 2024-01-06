import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'DosenDetil.dart';
import 'DosenForm.dart';

class DosenData {
  final String? nidn;
  final String? namaDosen;
  final String? alamat;

  DosenData({this.nidn, this.namaDosen, this.alamat});
}

class DataDosen extends StatefulWidget {
  const DataDosen({Key? key}) : super(key: key);

  @override
  _DataDosenState createState() => _DataDosenState();
}

class _DataDosenState extends State<DataDosen>
    with AutomaticKeepAliveClientMixin {
  List<DosenData> daftarDosen = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    fetchDosenData();
  }

  Future<void> fetchDosenData() async {
    final response = await http.get(
      Uri.parse('http://localhost:80/PHP/dosen.php'),
    );

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      List<DosenData> dosenList = list
          .map((model) => DosenData(
                nidn: model['nidn'],
                namaDosen: model['nama_dosen'],
                alamat: model['alamat'],
              ))
          .toList();

      setState(() {
        daftarDosen = dosenList;
      });
    }
  }

  void tambahDataDosen(String? nidn, String? namaDosen, String? alamat) {
    setState(() {
      daftarDosen.add(
        DosenData(nidn: nidn, namaDosen: namaDosen, alamat: alamat),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Dosen',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DosenForm(
                    tambahDataDosen: tambahDataDosen,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: daftarDosen.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(daftarDosen[index].nidn ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(daftarDosen[index].namaDosen ?? ''),
                  Text(daftarDosen[index].alamat ?? ''),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DosenDetail(
                      Nidn: daftarDosen[index].nidn,
                      NamaDosen: daftarDosen[index].namaDosen,
                      Alamat: daftarDosen[index].alamat,
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
