import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Admin/Pages/LaporanPrint.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/main.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  String? tokens;
  int countAllBarang = 0;
  int countSedangDijual = 0;
  int countTelahDijual = 0;
  int userMas = 0;
  Future<void> userCheck()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      tokens = pref.getString('token');
    });
    if(tokens == null || tokens == ""){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(page:2)));
      EasyLoading.showError("Please login First",dismissOnTap: true);
      return;
    }
    Api.getAllUser(tokens!,'?level=masyarakat').then((value){
      setState(() {
        userMas = value.count!;
      });
    });
  }
  
  @override
  void initState() {
    userCheck();
    Api.lelangPage('status=dibuka').then((value){
      setState(() {
        countSedangDijual = value.count!;
      });
    });
    Api.lelangPage('status=ditutup').then((value){
      setState(() {
        countTelahDijual = value.count!;
      });
    });
    Api.lelangPage('').then((value){
      setState(() {
        countAllBarang = value.count!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Responsive(
        children: [
          Div(
            divison: Division(
              colXS: 12,
              colS: 12,
              colM: 6,
              colL: 3,
              colXL: 3
            ),
            child: Card(
              child: Row(
                children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15,top: 15,left: 15,right: 25),
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent
                  ),
                  child: Icon(
                    Icons.widgets_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Barang',
	                    overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '$countAllBarang',
                    ),
                  ],
                )
               ],
              ),
            ),
          ),
          Div(
            divison: Division(
              colXS: 12,
              colS: 12,
              colM: 6,
              colL: 3,
              colXL: 3
            ),
            child: Card(
              child: Row(
                children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15,top: 15,left: 15,right: 25),
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.redAccent
                  ),
                  child: Icon(
                    Icons.sell,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sedang Dijual',
	                    overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '$countSedangDijual',
                    ),
                  ],
                )
               ],
              ),
            ),
          ),
          Div(
            divison: Division(
              colXS: 12,
              colS: 12,
              colM: 6,
              colL: 3,
              colXL: 3
            ),
            child: Card(
              child: Row(
                children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15,top: 15,left: 15,right: 25),
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent
                  ),
                  child: Icon(
                    Icons.attach_money_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Telah Terjual',
	                    overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '$countTelahDijual',
                    ),
                  ],
                )
               ],
              ),
            ),
          ),
          Div(
            divison: Division(
              colXS: 12,
              colS: 12,
              colM: 6,
              colL: 3,
              colXL: 3
            ),
            child: Card(
              child: Row(
                children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15,top: 15,left: 15,right: 25),
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.yellow
                  ),
                  child: Icon(
                    Icons.groups,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 100
                      ),
                      child: Text(
                        'User Masyarakat',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '$userMas',
                    ),
                  ],
                ),
               ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: ()=>
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LaporanPrint(token: tokens!))
                ),
                  // MaterialPageRoute(builder: (context) => LaporanPrint())),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Text(
                    'Laporan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}