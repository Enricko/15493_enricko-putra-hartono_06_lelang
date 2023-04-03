import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
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
                            SizedBox(
                              width: 1000,
                              height: 250,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                child: Container(
                                  child: const Text(
                                    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error, harum nesciunt ipsum debitis quas aliquid. Reprehenderit, quia. Quo neque error repudiandae fuga? Ipsa laudantium molestias eos ",
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
                      const Div(
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
                              margin: const EdgeInsets.only(bottom: 10),
                              child: const Text(
                                'History Lelang (Kamu Top #1)',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 350,
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
                                    child: SingleChildScrollView(
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
                                          for(var i = 1; i <= 50; i++) 
                                          TableRow(
                                            children: [
                                              TableCell(
                                                child: Container(
                                                  margin: const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    color: i == 1 ? Color.fromARGB(255, 201, 201, 65) : i == 2 ? Color.fromARGB(255, 125, 129, 127) : i == 3 ? Color.fromARGB(255, 122, 83, 68) : null,
                                                  ),
                                                  child: Text(
                                                    '$i',
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
                                                    color: i == 1 ? Color.fromARGB(255, 201, 201, 65) : i == 2 ? Color.fromARGB(255, 125, 129, 127) : i == 3 ? Color.fromARGB(255, 122, 83, 68) : null,
                                                  ),
                                                  margin: const EdgeInsets.all(3),
                                                  child: Text(
                                                    'Masyarakat',
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
                                                    color: i == 1 ? Color.fromARGB(255, 201, 201, 65) : i == 2 ? Color.fromARGB(255, 125, 129, 127) : i == 3 ? Color.fromARGB(255, 122, 83, 68) : null,
                                                  ),
                                                  margin: const EdgeInsets.all(3),
                                                  child: Text(
                                                    'Rp.${currencyFormatter.format(19209192038)}',
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
                      ),
                      // Div(
                      //   divison: const Division(
                      //     colXS: 12,
                      //     colS: 12,
                      //     colM: 12,
                      //     colL: 12
                      //   ),
                      //   child: Container(
                      //     margin: const EdgeInsets.symmetric(vertical: 25),
                      //     child: Column(
                      //       mainAxisSize: MainAxisSize.max,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         const Text(
                      //           "Tawar barang ini dengan harga mu!!",
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 22,
                      //             fontWeight: FontWeight.w400
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    bottomNavigationBar: Container(
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
                      color: Colors.black
                    ),
                    fillColor: Colors.white60,
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
                    "Rp.123.103.123.213",
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
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage(page:3)),
                  ),
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
    ),
  );
  }
}