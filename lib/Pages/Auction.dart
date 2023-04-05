import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:intl/intl.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/ApiLelang.dart';

import 'DetailLelang.dart';
import 'ViewAll.dart';

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

class AuctionPage extends StatefulWidget {
  const AuctionPage({super.key});

  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  final currencyFormatter = NumberFormat('#,000', 'ID');
  final img_url = "http://lelang.enricko.com/barang_lelang/";
  List<Data> newLelang = [];
  List<Data> historyLelang = [];

  @override
  void initState() {
    Api.lelangPage("status=dibuka&time=new").then((value){
      setState(() {
        newLelang = value.data!;
      });
    });
    Api.lelangPage("status=ditutup&time=new").then((value){
      setState(() {
        historyLelang = value.data!;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // My Current Action
          lelangTerbaru(context),
          SizedBox(
            height: 15,
          ),
          riwayatLelang(context),
          // My Current Action
        ],
      ),
    );
  }
  Widget lelangTerbaru(BuildContext context){
    return Container(
      margin: EdgeInsets.all(10),
      child: Responsive(
        children: [
          Container(
            margin: EdgeInsets.only(left: 25,top: 15),
            child: Responsive(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Div(
                  divison: Division(
                    colXS: 12,
                    colS: 12,
                    colM: 9,
                    colL: 9,
                    colXL: 9,
                  ),
                  child: const Text(
                    "Lelang Terbaru",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Div(
                  divison: Division(
                    colXS: 12,
                    colS: 12,
                    colM: 3,
                    colL: 3,
                    colXL: 3,
                  ),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewAll(title: 'Lelang Terbaru',page:1))
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
                        decoration: BoxDecoration(
                          color:Colors.blueAccent ,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 3,
            indent: 20,
            endIndent: 20, 
            color: Colors.black, 
            height: 20, 
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 450
            ),
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: Responsive(
                  children: [
                    for(var i = 0; i < newLelang.length; i++) 
                    GestureDetector(
                      onTap: () => 
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailLelang(idLelang: int.parse(newLelang[i].idLelang!),))
                        ),
                      child: Card(
                        color: Color.fromARGB(255, 95, 95, 95),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: SizedBox(
                            width: 150,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                    "${img_url + newLelang[i].barang!.imageBarang!}",
                                    width: 100,
                                    height: 100,
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
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  capitalizeAllSentence("${newLelang[i].barang!.namaBarang!}"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                newLelang[i].barang!.hargaAkhir! == "" ?
                                Text(
                                  "Rp.${currencyFormatter.format(int.parse(newLelang[i].barang!.hargaAwal!))}",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ):
                                Text(
                                  "Rp.${currencyFormatter.format(int.parse(newLelang[i].barang!.hargaAkhir!))}",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
 
  Widget riwayatLelang(BuildContext context){
    return Container(
      margin: EdgeInsets.all(10),
      child: Responsive(
        children: [
          Container(
            margin: EdgeInsets.only(left: 25,top: 15),
            child: Responsive(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Div(
                  divison: Division(
                    colXS: 12,
                    colS: 12,
                    colM: 9,
                    colL: 9,
                    colXL: 9,
                  ),
                  child: const Text(
                    "History Lelang",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Div(
                  divison: Division(
                    colXS: 12,
                    colS: 12,
                    colM: 3,
                    colL: 3,
                    colXL: 3,
                  ),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => 
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewAll(title: 'History Lelang',page:1))
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
                        decoration: BoxDecoration(
                          color:Colors.blueAccent ,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 3,
            indent: 20,
            endIndent: 20, 
            color: Colors.black, 
            height: 20, 
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 450
            ),
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: Responsive(
                  children: [
                    for(var i = 0; i < historyLelang.length; i++) 
                    GestureDetector(
                      onTap: () => 
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailLelang(idLelang: int.parse(historyLelang[i].idLelang!),))
                        ),
                      child: Card(
                        color: Color.fromARGB(255, 95, 95, 95),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: SizedBox(
                            width: 150,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                    "${img_url + historyLelang[i].barang!.imageBarang!}",
                                    width: 100,
                                    height: 100,
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
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  capitalizeAllSentence("${historyLelang[i].barang!.namaBarang!}"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                historyLelang[i].barang!.hargaAkhir! == "" ?
                                Text(
                                  "Rp.${currencyFormatter.format(int.parse(historyLelang[i].barang!.hargaAwal!))}",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ):
                                Text(
                                  "Rp.${currencyFormatter.format(int.parse(historyLelang[i].barang!.hargaAkhir!))}",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}