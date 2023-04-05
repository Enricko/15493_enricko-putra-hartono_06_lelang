import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/ApiHistoryLelang.dart' as historyLelang;
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/ApiLelang.dart';

import '../main.dart';

String capitalizeAllSentence(String value) {
  var result = value[0].toUpperCase();
  bool caps = false;
  bool start = true;

  for (int i = 1; i < value.length; i++) {
    if(start == true){
        if (value[i - 1] == " " && value[i] != " "){
            result = result + value[i].toUpperCase();
            start = false;
        }else{
            result = result + value[i];
        }
    }else{
      if (value[i - 1] == " " && caps == true) {
        result = result + value[i].toUpperCase();
        caps = false;
      } else {
          if(caps && value[i] != " "){
              result = result + value[i].toUpperCase();
              caps = false;
          }else{
              result = result + value[i];
          }
      }

      if(value[i] == "."){
          caps = true;
      }
    }  
  }
  return result;
}

class DetailLelang extends StatefulWidget {
  const DetailLelang({super.key, required this.idLelang});
  final int idLelang;

  @override
  State<DetailLelang> createState() => _DetailLelangState();
}

class _DetailLelangState extends State<DetailLelang> {
  final currencyFormatter = NumberFormat('#,000', 'ID');
  final img_url = "http://lelang.enricko.com/barang_lelang/";

  TextEditingController controllerTawar = TextEditingController();

  Future<ApiLelang>? lelang;

  @override
  void initState() {
    lelang = Api.lelangPage('id_lelang=${widget.idLelang}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: lelang,
      builder: (context,AsyncSnapshot<ApiLelang> snapshot){
        if(snapshot.hasData){
          return Detail(context,snapshot.data!.data!);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  Scaffold Detail(BuildContext context, List<Data> list) {
    return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(capitalizeAllSentence("${list[0].barang!.namaBarang!}")),
    ),
    body: SingleChildScrollView(
      child: Container(
        child: Responsive(
          children: [
            Div(
              divison: const Division(
                colL: 12
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: SizedBox(
                    width: 230,
                    height: 230,
                    child: Image.network(
                      '${img_url + list[0].barang!.imageBarang!}',
                      width: 230,
                      height: 230,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress){
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Image.asset(
                          "image/tambahan/image_placeholder.png",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Div(
              divison: const Division(colL: 12),
              child: Container(
                width: 1000,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 99, 98, 98),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                ),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Responsive(
                    children: [
                      Div(
                        divison: const Division(
                          colXS: 12,
                          colS: 12,
                          colM: 12,
                          colL: 6
                        ),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                capitalizeAllSentence('${list[0].barang!.namaBarang!}'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),          
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Harga Sekarang:',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 219, 219, 219)
                                ),
                              ),
                            ),
                            list[0].barang!.hargaAkhir! == '' ? 
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Rp.${currencyFormatter.format(int.parse(list[0].barang!.hargaAwal!))}",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  fontSize: 26,
                                ),
                              ),
                            ):
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Rp.${currencyFormatter.format(int.parse(list[0].barang!.hargaAkhir!))}",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Deskripsi :",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 250,minHeight: 50,maxWidth: 1000),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${list[0].barang!.deskripsi!}",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 245, 245, 245),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Div(
                        divison: Division(
                          colXS: 12,
                          colS: 12,
                          colM: 12,
                          colL: 0
                        ),
                        child: SizedBox(
                          height: 25,
                        ),
                      ),
                      TopTable(currencyFormatter: currencyFormatter,idLelang: widget.idLelang,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    bottomNavigationBar: list[0].status! == 'ditutup' ? DetailCloseBottom(id_lelang: int.parse(list[0].idLelang!)) : BottomNavDetail(controllerTawar: controllerTawar,currencyFormatter: currencyFormatter,idLelang: widget.idLelang,),
  );
  }
}


class TopTable extends StatefulWidget {
  const TopTable({
    super.key,
    required this.currencyFormatter,
    required this.idLelang,
  });
  final int idLelang; 
  final NumberFormat currencyFormatter;

  @override
  State<TopTable> createState() => _TopTableState();
}

class _TopTableState extends State<TopTable> {
  
  // Future<historyLelang.ApiHistoryLelang>? history;
  String? id;
  int? top;
  int? penawaranSaatIni;

  Future<historyLelang.ApiHistoryLelang>? history;

  Future<void> userCheck()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    setState(() {
      id = pref.getString('id');
    });
  }

  @override
  void initState() {
    userCheck();
    history = Api.historyLelang(false, widget.idLelang.toString(), "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:history,
      builder:(context, AsyncSnapshot<historyLelang.ApiHistoryLelang> snapshot) {
        if(snapshot.hasData){
          
          return TableSection(snapshot.data!.data!);
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  Div TableSection(List<historyLelang.Data> list) {
    var top;
    var penawaranSaatIni;
    for(var i = 0; i < list.length; i++){
      if(list[i].id! == id){
        top = i + 1;
        penawaranSaatIni = int.parse(list[i].penawaranHarga!);
        break;
      }
    }
    return Div(
    divison: const Division(
      colXS: 12,
      colS: 12,
      colM: 12,
      colL: 6
    ),
    child: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            top != null ? 
            "History Lelang Kamu Top (#${top})":
            'History Lelang',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
        SizedBox(
          height: 360,
          child: Column(
            children: [
              Table(
                columnWidths: {
                  0: const FixedColumnWidth(50.0),// fixed to 100 width
                  1: const FlexColumnWidth(),
                  2: const FlexColumnWidth(),//fixed to 100 width
                },
                border: TableBorder.all(
                  color: const Color.fromARGB(255, 143, 143, 143),
                  width: 3
                ),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          color: Colors.black54,
                          child: Text(
                            '#',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          color: Colors.black54,
                          child: Text(
                            'User',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          color: Colors.black54,
                          child: Text(
                            'Penawaran',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                ],
              ),
              SizedBox(
                height: 320,
                child: list.length == 0 ? 
                Container(
                  color: const Color.fromARGB(255, 143, 143, 143),
                  child: Center(
                    child: Text(
                      "Belum ada penawaran",
                      style: TextStyle(
                        fontSize: 26
                      ),
                    ),
                  ),
                ):
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Table(
                    columnWidths: {
                      0: const FixedColumnWidth(50.0),// fixed to 100 width
                      1: const FlexColumnWidth(),
                      2: const FlexColumnWidth(),//fixed to 100 width
                    },
                    border: TableBorder.all(
                      color: const Color.fromARGB(255, 143, 143, 143),
                      width: 3
                    ),
                    children: [
                      for(var i = 0; i < list.length; i++)
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: i + 1 == 1 ? Color.fromARGB(255, 201, 201, 65) : i + 1 == 2 ? Color.fromARGB(255, 125, 129, 127) : i + 1 == 3 ? Color.fromARGB(255, 122, 83, 68) : null,
                              ),
                              child: Text(
                                '${i+1}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: i + 1 == 1 ? Color.fromARGB(255, 201, 201, 65) : i + 1 == 2 ? Color.fromARGB(255, 125, 129, 127) : i + 1 == 3 ? Color.fromARGB(255, 122, 83, 68) : null,
                              ),
                              margin: const EdgeInsets.all(3),
                              child: Text(
                                '${list[i].user!.name!}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: i + 1 == 1 ? Color.fromARGB(255, 201, 201, 65) : i + 1 == 2 ? Color.fromARGB(255, 125, 129, 127) : i + 1 == 3 ? Color.fromARGB(255, 122, 83, 68) : null,
                              ),
                              margin: const EdgeInsets.all(3),
                              child: Text(
                                'Rp.${widget.currencyFormatter.format(int.parse(list[i].penawaranHarga!))}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
  }
}

class BottomNavDetail extends StatefulWidget {
  const BottomNavDetail({
    super.key,
    required this.controllerTawar,
    required this.idLelang, required this.currencyFormatter,
  });
  final int idLelang;
  final NumberFormat currencyFormatter;

  final TextEditingController controllerTawar;

  @override
  State<BottomNavDetail> createState() => _BottomNavDetailState();
}

class _BottomNavDetailState extends State<BottomNavDetail> {

  String? id;
  int? top;
  int? penawaranSaatIni;

  Future<historyLelang.ApiHistoryLelang>? history;

  TextEditingController controllerTawar = TextEditingController();

  Future<void> userCheck()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    setState(() {
      id = pref.getString('id');
    });
    history = Api.historyLelang(true, widget.idLelang.toString(), token!);
  //   history = Api.historyLelang(false, widget.idLelang.toString(), "");
  }

  Future<void> Tawar(BuildContext context) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    var tawar = int.parse((controllerTawar.text).replaceAll(RegExp("[a-zA-Z:\s. ()]"),''));

    if (token == null || token == "") {
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(page: 2,)));
      
      EasyLoading.showError("Harap login terlebih dahulu untuk menawar",dismissOnTap: true);
      return;
    }

    Api.tawar(tawar, widget.idLelang!.toString(), token!).then((value){
      EasyLoading.showSuccess("${value.message!}",dismissOnTap: true);
    });
  }

  

  @override
  void initState() {
    userCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return id == null ? 
    Container(
      padding: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => {
                Navigator.pop(context),
                Navigator.pushReplacement(context, 
                  MaterialPageRoute(builder: (context) => MyHomePage(page: 2)),
                ),
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  "Login Untuk Menawar",
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ):
    FutureBuilder(
      future:history,
      builder: (context,AsyncSnapshot<historyLelang.ApiHistoryLelang> snapshot){
        if (snapshot.hasData) {
          if(snapshot.data!.data!.length != 0){
            return BottomNav(context,snapshot.data!.data!);
          }
        }
        return BottomNavNoBid(context);
      },
    );
  }

  Container BottomNav(BuildContext context, List<historyLelang.Data> list) {
    return Container(
    padding: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
    child: Responsive(
      children: [
        Div(
          divison: const Division(
            colXS: 8,
            colS: 8,
            colM: 8,
            colL: 8
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 7,bottom: 5),
                child: Text(
                  "Tawar barang ini dengan harga mu!!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: controllerTawar,
                inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    CurrencyTextInputFormatter(
                      locale: 'ID',
                      decimalDigits: 0,
                      symbol: '(IDR) Rp. ',
                    ),
                ],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  hintText: "Tawar",
                  hintStyle: TextStyle(
                    color: Colors.white
                  ),
                  fillColor: Color.fromARGB(153, 148, 148, 148),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.white54),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 7,bottom: 5,top: 5),
                child: Text(
                  "Penawaran mu sekarang",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 7,bottom: 5),
                child: Text(
                  "Rp.${widget.currencyFormatter.format(int.parse(list[0].penawaranHarga!))}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300
                  ),
                ),
              ),
            ],
          ),
        ),
        Div(
          divison: const Division(
            colXS: 4,
            colS: 4,
            colM: 4,
            colL: 4
          ),
          child: SizedBox(
            height: 125,
            child: Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () =>
                Tawar(context),
                child: Text(
                  'Tawar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22  
                  ),
                ),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 83, 142, 219)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: Colors.teal, 
                              width: 2.0,
                          ),
                      ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
  }
  Container BottomNavNoBid(BuildContext context) {
    return Container(
    padding: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
    child: Responsive(
      children: [
        Div(
          divison: const Division(
            colXS: 8,
            colS: 8,
            colM: 8,
            colL: 8
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 7,bottom: 5),
                child: Text(
                  "Tawar barang ini dengan harga mu!!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: controllerTawar,
                inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    CurrencyTextInputFormatter(
                      locale: 'ID',
                      decimalDigits: 0,
                      symbol: '(IDR) Rp. ',
                    ),
                ],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  hintText: "Tawar",
                  hintStyle: TextStyle(
                    color: Colors.white
                  ),
                  fillColor: Color.fromARGB(153, 148, 148, 148),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.white54),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.white70),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 7,bottom: 5,top: 5),
                child: Text(
                  "Belum Ada Penawaran yg dilakukan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ],
          ),
        ),
        Div(
          divison: const Division(
            colXS: 4,
            colS: 4,
            colM: 4,
            colL: 4
          ),
          child: SizedBox(
            height: 125,
            child: Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () =>Tawar(context),
                child: Text(
                  'Tawar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22  
                  ),
                ),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 83, 142, 219)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: Colors.teal, 
                              width: 2.0,
                          ),
                      ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
  }
}

class DetailCloseBottom extends StatefulWidget {
  const DetailCloseBottom({
    super.key,required this.id_lelang,
  });
  final int id_lelang;

  @override
  State<DetailCloseBottom> createState() => _DetailCloseBottomState();
}

class _DetailCloseBottomState extends State<DetailCloseBottom> {
  final currencyFormatter = NumberFormat('#,000', 'ID');
  List<historyLelang.Data> history = [];
  Future<historyLelang.ApiHistoryLelang>? historyData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Api.detailHistoryLelang(widget.id_lelang).then((value){
      setState(() {
        history = value.data!;
        historyData = Api.detailHistoryLelang(widget.id_lelang);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: historyData,
      builder: (context, AsyncSnapshot<historyLelang.ApiHistoryLelang> snapshot){
        if(snapshot.hasData){
          return CloseBottom(context,snapshot.data!.data!);
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Somethink wrong ${snapshot.error}"),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Container CloseBottom(BuildContext context, List<historyLelang.Data> list) {
    if (list.length == 0) {
      return Container(
        padding: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
        child: Responsive(
          children: [
            Div(
              divison: Division(
                colXS: 12,
                colS: 12,
                colM: 12,
                colL: 12,
                colXL: 12,
              ), 
              child: Text(
                'Barang Lelang ini tidak laku',
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontSize: 20
                ),  
              ),
            ),
          ],
        ),
      );
    }
    return Container(
    padding: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
    child: Responsive(
      children: [
        Div(
          divison: Division(
            colXS: 12,
            colS: 12,
            colM: 12,
            colL: 12,
            colXL: 12,
          ),
          child: Container(
            child: Text(
              "Lelang telah di tutup dan dimenangkan oleh",
              textAlign:TextAlign.center,
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ),
        ),
        Div(
          divison: Division(
            colXS: 12,
            colS: 12,
            colM: 12,
            colL: 12,
            colXL: 12,
          ),
          child: Container(
            child: Text(
              "${list[0].user!.name!}",
              textAlign:TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
        Div(
          divison: Division(
            colXS: 12,
            colS: 12,
            colM: 12,
            colL: 12,
            colXL: 12,
          ),
          child: Container(
            child: Text(
              "dengan penawaran : Rp.${currencyFormatter.format(int.parse(list[0].penawaranHarga!))}",
              textAlign:TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ],
    ),
  );
  }
}

