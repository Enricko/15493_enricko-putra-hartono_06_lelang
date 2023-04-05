import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/main.dart';

import '../../Api/ApiAllUser.dart';
  
class UserMasyarakat extends StatefulWidget {
  const UserMasyarakat({super.key});

  @override
  State<UserMasyarakat> createState() => _UserMasyarakatState();
}

class _UserMasyarakatState extends State<UserMasyarakat> {
  Future<ApiAllUser>? masyarakat;
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
    masyarakat = Api.getAllUser(token!, "level=masyarakat");
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
            margin: EdgeInsets.only(top: 15,bottom: 25),
            child: Text(
              'Table User Masyarakat',
              style: TextStyle(
                fontSize: 24
              ),
            ),
          ),
          SingleChildScrollView(
            child: FutureBuilder(
              future: masyarakat,
              builder: (context,AsyncSnapshot<ApiAllUser> snapshot){
                if(snapshot.hasData){
                  if (snapshot.data!.count! == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Data Masyarakat Kosong'),
                        ],
                      ),
                    );
                  }
                  return TableMasyarakat(snapshot.data!.data!);
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
        ],
      ),
    );
  }

  PaginatedDataTable TableMasyarakat(List<Data> list) {
    return PaginatedDataTable(
      arrowHeadColor: Colors.white,
      header: Text("Table User Masyarakat"),
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
        DataColumn(
          label: Text('Telp'),
        ),
      ],
      source: MyData(userData: list),
    );
  }
}
class MyData extends DataTableSource {
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