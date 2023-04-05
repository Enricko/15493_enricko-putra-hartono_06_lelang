import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Pages/Home.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Pages/Login.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Pages/Profile.dart';

import 'ComponentLib/Components.dart';
import 'Pages/Auction.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lelang',
      theme: ThemeData(
        canvasColor: Color.fromRGBO(65, 65, 65, 1.0),
        primarySwatch: Colors.blueGrey,
        textTheme: Theme.of(context).textTheme.apply(  //  Set default Text() color;  Use:  apply()
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        cardColor: Color.fromARGB(255, 85, 85, 85),
      ),
      builder: EasyLoading.init(),
      scrollBehavior: MyCustomScrollBehavior(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.page = 1});
  final int page;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> onTapRouteBar = [AuctionPage(),HomePage(),LoginPage()];

  int selectedIndex = 1;

  Future<void> userCheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    if(token != null || token != ""){
      Api.getUser(token!).then((value){
        setState(() {
          onTapRouteBar = [AuctionPage(),HomePage(),ProfilePage(token:token)];
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userCheck();
    selectedIndex = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tampilan Lelang'),
      ),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: onTapRouteBar[selectedIndex]
      ),
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: selectedIndex,
        items: const [
          TabItem(icon: Icons.account_balance, title: 'Auction'),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        onTap: (int i) => onItemTapped(i),
      ),
    );
  }
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}