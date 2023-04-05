import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Admin/Home.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/ApiLelang.dart';
  
class LelangIndex extends StatefulWidget {
  const LelangIndex({super.key});

  @override
  State<LelangIndex> createState() => _LelangIndexState();
}

class _LelangIndexState extends State<LelangIndex> {
  Future<ApiLelang>? lelang;
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => adminMain(page:2)));
      EasyLoading.showError("Please login First",dismissOnTap: true);
      return;
    }
    lelang = Api.lelang(token!, "status=dibuka");
  }

  @override
  void initState() {
    userCheck();
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
            child: FutureBuilder(
              future: lelang,
              builder: (context,AsyncSnapshot<ApiLelang> snapshot){
                if(snapshot.hasData){
                  if (snapshot.data!.count! == 0) {
                    return Center(
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Data Lelang Kosong'),
                        ],
                      ),
                    );
                  }
                  return TableLelang(snapshot.data!.data!,context);
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

  PaginatedDataTable TableLelang(List<Data> list, BuildContext context) {
    return PaginatedDataTable(
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
      source: MyData(DataList: list, context: context),
    );
  }
}
class MyData extends DataTableSource {
  MyData({required this.context,required this.DataList});
  final BuildContext context;
  final List<Data> DataList;
  
  final img_url = "http://lelang.enricko.com/barang_lelang/";
  
  final currencyFormatter = NumberFormat('#,000', 'ID');
  @override
  DataRow? getRow(int index) {
    if(index >= DataList.length){
      return null;
    }
    final lelang = DataList[index];
    return DataRow(cells: [
      DataCell(Text("${index + 1}")),
      DataCell(Image.network(
        '${img_url + lelang.barang!.imageBarang!}',
        height: 75,
        width: 100,
        fit: BoxFit.cover,
      )),
      DataCell(Text("${lelang.barang!.namaBarang!}")),
      DataCell(Text("${lelang.tglDibuka!}")),
      DataCell(Text("${lelang.tglDitutup!}")),
      DataCell(Text("${lelang.barang!.hargaAwal!}")),
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
          Text("${lelang.user!.name!}"),
          Text("Rp.${currencyFormatter.format(int.parse(lelang.barang!.hargaAkhir!))}"),
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
          Text("${lelang.idPetugas!}"),
        ],
      )),
      DataCell(
        TextButton(
          onPressed: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => adminMain(page:6,idLelang:int.parse(lelang.idLelang!)))
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
  int get rowCount => DataList.length;

  @override
  int get selectedRowCount => 0;
}