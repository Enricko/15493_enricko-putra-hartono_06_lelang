import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Admin/Home.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/ApiHistoryLelang.dart';
  
class HistoryLelang extends StatefulWidget {
  const HistoryLelang({super.key, required this.idLelang});
  final int idLelang;

  @override
  State<HistoryLelang> createState() => _HistoryLelangState();
}

class _HistoryLelangState extends State<HistoryLelang> {

  Future<ApiHistoryLelang>? lelang;
  String? level;
  String? idhistory;
  String? token;

  Future<void> historyCheck()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      level = pref.getString('level');
      token = pref.getString('token');
      idhistory = pref.getString('id');
    });
    if(token == null || token == ""){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => adminMain(page:2)));
      EasyLoading.showError("Please login First",dismissOnTap: true);
      return;
    }
    lelang = Api.detailHistoryLelang(widget.idLelang);
  }

  @override
  void initState() {
    historyCheck();
    super.initState();
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
              'Table History Lelang #${widget.idLelang}',
              style: TextStyle(
                fontSize: 24
              ),
            ),
          ),
          SingleChildScrollView(
            child: FutureBuilder(
              future: lelang,
              builder: (context,AsyncSnapshot<ApiHistoryLelang> snapshot){
                if(snapshot.hasData){
                  if (snapshot.data!.data!.length == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Barang Tidak Laku'),
                        ],
                      ),
                    );
                  }
                  return TableHistory(snapshot.data!.data!,context);
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

  PaginatedDataTable TableHistory(List<Data> list, BuildContext context) {
    return PaginatedDataTable(
            arrowHeadColor: Colors.white,
            dataRowHeight: 100,
            header: Text("Table History Lelang #${widget.idLelang}"),
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
            source: MyData(DataList: list, context: context),
          );
  }
}
class MyData extends DataTableSource {
  MyData({required this.context,required this.DataList});
  final BuildContext context;
  final List<Data> DataList;
  final currencyFormatter = NumberFormat('#,000', 'ID');
  @override
  DataRow? getRow(int index) {
    if(index >= DataList.length){
      return null;
    }
    final history = DataList[index];
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
          Text("${history.user!.name!}"),
        ],
      )),
      DataCell(Text("${history.user!.telp!}")),
      DataCell(Text("${history.user!.email!}")),
      DataCell(Text("${currencyFormatter.format(int.parse(history.penawaranHarga!))}")),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DataList.length;

  @override
  int get selectedRowCount => 0;
}