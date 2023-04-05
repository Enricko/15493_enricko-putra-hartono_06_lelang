import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Admin/Home.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Admin/Pages/Home.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/ApiAllUser.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/main.dart';
  
class UserAdmin extends StatefulWidget {
  const UserAdmin({super.key});

  @override
  State<UserAdmin> createState() => _UserAdminState();
}
class Manusia {
  int id;
  String nama,email;

  Manusia(
    this.id,
    this.nama,
    this.email,
  );
}

class _UserAdminState extends State<UserAdmin> {
  // final DataTableSource _data = MyData();
  Future<ApiAllUser>? admin;
  String? level;
  String? idUser;
  String? token;

  Future<void> userCheck()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      level = pref.getString('level');
      token = pref.getString('token');
      idUser = pref.getString('id');
    });
    if(token == null || token == ""){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(page:2)));
      EasyLoading.showError("Please login First",dismissOnTap: true);
      return;
    }
    admin = Api.getAllUser(token!, "admin=true");
  }

  @override
  void initState() {
    userCheck();
    super.initState();
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
            margin: EdgeInsets.only(top: 15,bottom: 7),
            child: Text(
              'Table User Admin/Petugas',
              style: TextStyle(
                fontSize: 24
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => adminMain(page:3))
            ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
              decoration: BoxDecoration(
                color:Colors.blueAccent ,
                borderRadius: BorderRadius.circular(25)
              ),
              child: Text(
                "+ Tambah Data",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: FutureBuilder(
              future: admin,
              builder: (context,AsyncSnapshot<ApiAllUser> snapshot){
                if(snapshot.hasData){
                  if (snapshot.data!.count! == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Data Admin Kosong'),
                        ],
                      ),
                    );
                  }
                  return TableAdmin(snapshot.data!.data!);
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError)
                      return Center(child: Text('Error: ${snapshot.error}'));
                    else
                    return Center(
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('if you stuck here press back'),
                          ElevatedButton(onPressed: (){
                            Navigator.pop(context);
                          }, 
                          child: Text('< Back'))
                        ],
                      ),
                    );
                }
              },
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

  PaginatedDataTable TableAdmin(List<Data> list) {
    return PaginatedDataTable(
      arrowHeadColor: Colors.white,
      header: Text("Table User Admin/Petugas"),
      onRowsPerPageChanged: (perPage) {
        setState(() {
          perPageSelected = perPage!;
          // perPageSelectedOnChange = perPage;
        });
      },
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
      ],
      source: MyData(userData: list),
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
  
  final List<Data> userData;

  @override
  DataRow? getRow(int index) {
    if(index >= userData.length){
      return null;
    }
    final user = userData[index];
    return DataRow(cells: [
      DataCell(Text("${index + 1}")),
      DataCell(Text(user.id.toString())),
      DataCell(Text(user.name!)),
      DataCell(Text(user.email!)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => userData.length;

  @override
  int get selectedRowCount => 0;
}