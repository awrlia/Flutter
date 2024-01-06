import 'package:flutter/material.dart';
import 'DataMatakuliah.dart';
import 'DataMahasiswa.dart';
import 'DataDosen.dart';
import 'DataRuangan.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DataMahasiswa(),
    DataDosen(),
    DataMatakuliah(),
    DataRuangan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Universitas Logistik dan Bisnis Internasional',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.yellow,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 189, 149, 245),
            icon: Icon(Icons.person),
            label: 'Mahasiswa',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 189, 149, 245),
            icon: Icon(Icons.person_2),
            label: 'Dosen',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 189, 149, 245),
            icon: Icon(Icons.book),
            label: 'Mata Kuliah',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 189, 149, 245),
            icon: Icon(Icons.home),
            label: 'Ruangan',
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BottomNav(),
  ));
}
