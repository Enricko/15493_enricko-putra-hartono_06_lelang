import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Admin/Home.dart';
  
class LelangIndex extends StatefulWidget {
  const LelangIndex({super.key});

  @override
  State<LelangIndex> createState() => _LelangIndexState();
}
class Manusia {
  DateTime buka,tutup;
  int harga_awal,id_user,id_petugas;
  String image,nama_barang;

  Manusia(
      this.image,
      this.nama_barang,
      this.buka,
      this.tutup,
      this.harga_awal,
      this.id_user,
      this.id_petugas,
      );
}

class _LelangIndexState extends State<LelangIndex> {
  // final DataTableSource _data = MyData();
  List<Manusia> DaftarSiswa=<Manusia>[
    Manusia('image/lelang/palu.jpeg','Item',DateTime.now(),DateTime.now(),10000,10,1),
    Manusia('image/lelang/palu.jpeg','Item',DateTime.now(),DateTime.now(),10000,10,1),
    Manusia('image/lelang/palu.jpeg','Item',DateTime.now(),DateTime.now(),10000,10,1),
  ];

  @override
  void initState() {
    super.initState();
  }

  refreshList() {
    setState(() {
      DaftarSiswa=DaftarSiswa;
    });
  }

  int perPageSelected = 10;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15,bottom: 10),
            child: Text(
              'Table Lelang Dibuka',
              style: TextStyle(
                fontSize: 24
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => adminMain(page:7))
            ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
              decoration: BoxDecoration(
                color:Colors.blueAccent ,
                borderRadius: BorderRadius.circular(25)
              ),
              child: Text(
                "+ Buka Lelang",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: PaginatedDataTable(
              arrowHeadColor: Colors.white,
              dataRowHeight: 100,
              header: Text("Table Lelang Dibuka"),
              onRowsPerPageChanged: (perPage) {
                setState(() {
                  perPageSelected = perPage!;
                });
              },
              rowsPerPage: perPageSelected,
              columns: <DataColumn>[
                DataColumn(
                  label: Text('No'),
                ),
                DataColumn(
                  label: Text('Image'),
                ),
                DataColumn(
                  label: Text('Nama Barang'),
                ),
                DataColumn(
                  label: Text('Tanggal Dibuka'),
                ),
                DataColumn(
                  label: Text('Tanggal Ditutup'),
                ),
                DataColumn(
                  label: Text('Harga Awal'),
                ),
                DataColumn(
                  label: Text('Harga Tertinggi'),
                ),
                DataColumn(
                  label: Text('Penanggung Jawab'),
                ),
                DataColumn(
                  label: Text('History Lelang'),
                ),
              ],
              source: MyData(userData: DaftarSiswa, context: context),
            ),
          ),
        ],
      ),
    );
  }
}
class MyData extends DataTableSource {
  MyData({required this.context,required this.userData});
  final BuildContext context;
  final List<Manusia> userData;
  @override
  DataRow? getRow(int index) {
    if(index >= userData.length){
      return null;
    }
    final user = userData[index];
    return DataRow(cells: [
      DataCell(Text("${index + 1}")),
      DataCell(Image.asset(
        '${user.image}',
        height: 75,
        width: 100,
        fit: BoxFit.cover,
      )),
      DataCell(Text("${user.nama_barang}")),
      DataCell(Text("${DateFormat("EEEE, yyyy-MM-dd HH:mm:ss").format(user.buka)}")),
      DataCell(Text("${DateFormat("EEEE, yyyy-MM-dd HH:mm:ss").format(user.buka)}")),
      DataCell(Text("${user.harga_awal}")),
      DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'image/tambahan/download.jpeg',
              height: 50,
              width: 50,
            ),
          ),
          Text("Imam"),
          Text("Rp.100.012"),
        ],
      )),
      DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'image/tambahan/download.jpeg',
              height: 75,
              width: 75,
            ),
          ),
          Text("Admin"),
        ],
      )),
      DataCell(
        TextButton(
          onPressed: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => adminMain(page:6))
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
            decoration: BoxDecoration(
              color:Colors.blueAccent ,
              borderRadius: BorderRadius.circular(25)
            ),
            child: Text(
              "History Lelang",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => userData.length;

  @override
  int get selectedRowCount => 0;
}