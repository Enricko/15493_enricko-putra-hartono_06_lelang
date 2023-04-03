import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Admin/Home.dart';
  
class HistoryLelang extends StatefulWidget {
  const HistoryLelang({super.key});

  @override
  State<HistoryLelang> createState() => _HistoryLelangState();
}
class Manusia {
  int telp,penawaran;
  String image,email;

  Manusia(
      this.image,
      this.telp,
      this.email,
      this.penawaran,
      );
}

class _HistoryLelangState extends State<HistoryLelang> {
  // final DataTableSource _data = MyData();
  List<Manusia> DaftarSiswa=<Manusia>[
    Manusia('image/lelang/palu.jpeg',10000,'enricko@gmail.com',1232132),
    Manusia('image/lelang/palu.jpeg',10000,'enricko@gmail.com',1232132),
    Manusia('image/lelang/palu.jpeg',10000,'enricko@gmail.com',1232132),
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
            margin: EdgeInsets.only(top: 15,bottom: 25),
            child: Text(
              'Table History Lelang #1',
              style: TextStyle(
                fontSize: 24
              ),
            ),
          ),
          SingleChildScrollView(
            child: PaginatedDataTable(
              arrowHeadColor: Colors.white,
              dataRowHeight: 100,
              header: Text("Table History Lelang #1"),
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
                  label: Text('Penawar'),
                ),
                DataColumn(
                  label: Text('Telp'),
                ),
                DataColumn(
                  label: Text('Email'),
                ),
                DataColumn(
                  label: Text('Penawaran Harga'),
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
      DataCell(Text("${user.telp}")),
      DataCell(Text("${user.email}")),
      DataCell(Text("${user.penawaran}")),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => userData.length;

  @override
  int get selectedRowCount => 0;
}