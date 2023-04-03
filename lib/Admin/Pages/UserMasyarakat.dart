import 'dart:math';

import 'package:flutter/material.dart';
  
class UserMasyarakat extends StatefulWidget {
  const UserMasyarakat({super.key});

  @override
  State<UserMasyarakat> createState() => _UserMasyarakatState();
}
class Manusia {
  int id,telp;
  String nama,email;

  Manusia(
      this.id,
      this.nama,
      this.email,
      this.telp,
      );
}

class _UserMasyarakatState extends State<UserMasyarakat> {
  // final DataTableSource _data = MyData();
  List<Manusia> DaftarSiswa=<Manusia>[
    Manusia(1,"Andi",'email@gamil.com',18),
    Manusia(2,"Budi",'email@gamil.com',24),
    Manusia(3,"Cita",'email@gamil.com',12),
    Manusia(4,"Dito",'email@gamil.com',15),
    Manusia(5,"Echo",'email@gamil.com',17),
    Manusia(6,"Frenki",'email@gamil.com',24),
    Manusia(1,"Andi",'email@gamil.com',18),
    Manusia(2,"Budi",'email@gamil.com',24),
    Manusia(3,"Cita",'email@gamil.com',12),
    Manusia(4,"Dito",'email@gamil.com',15),
    Manusia(1,"Andi",'email@gamil.com',18),
    Manusia(2,"Budi",'email@gamil.com',24),
    Manusia(3,"Cita",'email@gamil.com',12),
    Manusia(4,"Dito",'email@gamil.com',15),
    Manusia(5,"Echo",'email@gamil.com',17),
    Manusia(6,"Frenki",'email@gamil.com',24),
    Manusia(1,"Andi",'email@gamil.com',18),
    Manusia(2,"Budi",'email@gamil.com',24),
    Manusia(3,"Cita",'email@gamil.com',12),
    Manusia(4,"Dito",'email@gamil.com',15),
    Manusia(1,"Andi",'email@gamil.com',18),
    Manusia(2,"Budi",'email@gamil.com',24),
    Manusia(3,"Cita",'email@gamil.com',12),
    Manusia(4,"Dito",'email@gamil.com',15),
    Manusia(5,"Echo",'email@gamil.com',17),
    Manusia(6,"Frenki",'email@gamil.com',24),
    Manusia(1,"Andi",'email@gamil.com',18),
    Manusia(2,"Budi",'email@gamil.com',24),
    Manusia(3,"Cita",'email@gamil.com',12),
    Manusia(4,"Dito",'email@gamil.com',15),
    Manusia(1,"Andi",'email@gamil.com',18),
    Manusia(2,"Budi",'email@gamil.com',24),
    Manusia(3,"Cita",'email@gamil.com',12),
    Manusia(4,"Dito",'email@gamil.com',15),
    Manusia(5,"Echo",'email@gamil.com',17),
    Manusia(6,"Frenki",'email@gamil.com',24),
    Manusia(1,"Andi",'email@gamil.com',18),
    Manusia(2,"Budi",'email@gamil.com',24),
    Manusia(3,"Cita",'email@gamil.com',12),
    Manusia(4,"Dito",'email@gamil.com',15),
    Manusia(5,"Echo",'email@gamil.com',17),
    Manusia(6,"Frenki",'email@gamil.com',24),
    Manusia(1,"Andi",'email@gamil.com',18),
    Manusia(2,"Budi",'email@gamil.com',24),
    Manusia(3,"Cita",'email@gamil.com',12),
    Manusia(4,"Dito",'email@gamil.com',15),
    Manusia(5,"Echo",'email@gamil.com',17),
    Manusia(6,"Frenki",'email@gamil.com',24),
    Manusia(6,"Frenki",'email@gamil.com',24),
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
  // int perPageSelectedOnChange = 10;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15,bottom: 25),
            child: Text(
              'Table User Masyarakat',
              style: TextStyle(
                fontSize: 24
              ),
            ),
          ),
          SingleChildScrollView(
            child: PaginatedDataTable(
              arrowHeadColor: Colors.white,
              header: Text("Table User Masyarakat"),
              onRowsPerPageChanged: (perPage) {
                setState(() {
                  perPageSelected = perPage!;
                  // perPageSelectedOnChange = perPage;
                });
              },
              // onPageChanged: (int? n){
              //   setState(() {
              //     if (DaftarSiswa.length - n! < perPageSelected) {
              //       if (DaftarSiswa.length - n < 10) {
              //         perPageSelected = 10;
              //       }else if(DaftarSiswa.length - n < 20){
              //         perPageSelected = 20;
              //       }else if(DaftarSiswa.length - n < 50){
              //         perPageSelected = 50;
              //       }else if(DaftarSiswa.length - n < 100){
              //         perPageSelected = 100;
              //       }
              //     }else{
              //       perPageSelected = perPageSelectedOnChange;
              //     }
              //   });
              // },
              rowsPerPage: perPageSelected,
              columns: <DataColumn>[
                DataColumn(
                  label: Text('No'),
                ),
                DataColumn(
                  label: Text('ID'),
                ),
                DataColumn(
                  label: Text('Name'),
                ),
                DataColumn(
                  label: Text('Email'),
                ),
                DataColumn(
                  label: Text('Telp'),
                ),
              ],
              source: MyData(userData: DaftarSiswa),
            ),
          ),
          // SizedBox(
          //   width: double.infinity,
          //   child: Center(
          //     child: 
          //   ),
          // ),
        ],
      ),
    );
  }
}
class MyData extends DataTableSource {
  // final List<Map<String, dynamic>> _data = List.generate(
  //     123,
  //     (index) => {
  //           "id": index * 3,
  //           "name": "Enricko",
  //           "email": "Enricko@gmail.com",
  //           "price": Random().nextInt(10000)
  //         });
  MyData({required this.userData});
  final List<Manusia> userData;
  @override
  DataRow? getRow(int index) {
    if(index >= userData.length){
      return null;
    }
    final user = userData[index];
    return DataRow(cells: [
      DataCell(Text("${index + 1}")),
      DataCell(Text(user.id.toString())),
      DataCell(Text(user.nama)),
      DataCell(Text(user.email)),
      DataCell(Text(user.telp.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => userData.length;

  @override
  int get selectedRowCount => 0;
}