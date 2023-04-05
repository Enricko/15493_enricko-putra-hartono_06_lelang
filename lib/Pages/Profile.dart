import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Admin/Home.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/ApiUser.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Pages/ViewAll.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Shared_preference/Preference.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.token});
  final String token;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future<ApiUser>? DataUser;
  String? level;
  String? idUser;
  String? token;
  String? menangCount;
  String? lelangIkut;

  Future<void> userCheck()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      level = pref.getString('level');
      token = pref.getString('token');
      idUser = pref.getString('id');
    });
    if(widget.token == null || widget.token == ""){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(page:2)));
      EasyLoading.showError("Please login First",dismissOnTap: true);
      return;
    }
    DataUser = Api.getUser(widget.token);
    Api.lelangPage("status=ditutup&user_id=${idUser}").then((value){
      setState(() {
        menangCount = value.count!.toString();
      });
    });
    Api.ikutLelang("",token!).then((value){
      setState(() {
        lelangIkut = value.count!.toString();
      });
    });
  }

  Future<void> Logout(BuildContext context)async {
    Pref.logoutPref();
    EasyLoading.showSuccess("Logout Success",dismissOnTap: true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage(page:2)));
    return;
  }

  @override
  void initState() {
    super.initState();
    userCheck();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataUser,
      builder:(context, AsyncSnapshot<ApiUser> snapshot) {
        if(snapshot.hasData){
          return UserProfile(context,snapshot.data!.data!);
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
    );
  }

  Container UserProfile(BuildContext context, List<Data> user) {
    return Container(
    margin: EdgeInsets.symmetric(vertical: 50),
    alignment: Alignment.center,
    child: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 500,
        ),
        child: Card(
          elevation: 10, 
          shadowColor: Colors.black, 
          child: Container(
            margin: EdgeInsets.all(25),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'image/tambahan/download.jpeg',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Text(
                  '${user[0].name!}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  width: 275,
                  child: Card(
                    color: Color.fromARGB(255, 124, 124, 124),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Menang Lelang',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "${menangCount}",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 236, 229, 229),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 25,),
                          Column(
                            children: [
                              Text(
                                'Ikut Lelang',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                '${lelangIkut}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 236, 229, 229),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email,color: Colors.white,size: 30,),
                          Text('${user[0].email!}')
                        ],
                      ),
                      SizedBox(height: 5,),
                      user[0].telp == null ? Container() :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.smartphone,color: Colors.white, size: 30,),
                          Text('${user[0].telp}')
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewAll(title: 'Lelang yang telah kamu menangi',page:1,id: idUser!,))
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(
                        'Lihat Semua Lelang Yang di Menangi'
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ViewAll(title: 'Lelang yang telah kamu ikuti',page:1,id: idUser!,token: token!,))
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(
                        'Lihat Semua Lelang Yang di Ikuti'
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // MouseRegion(
                //   cursor: SystemMouseCursors.click,
                //   child: Stack(
                //     children: [
                //       Container(
                //         margin: EdgeInsets.all(10),
                //         child: GestureDetector(
                //           onTap: () => Navigator.push(context,
                //               MaterialPageRoute(builder: (context) => ViewAll(title: 'Tawaran saat ini'))
                //           ),
                //           child: Container(
                //             padding: EdgeInsets.all(10),
                //             decoration: BoxDecoration(
                //               color: Colors.green,
                //               borderRadius: BorderRadius.circular(10)
                //             ),
                //             child: Text(
                //               'Barang yang kamu tawar saat ini',
                //             ),
                //           ),
                //         ),
                //       ),
                //       Positioned(
                //         top: 1,
                //         right: 1,
                //         child: Container(
                //           width: 30,
                //           height: 30,
                //           decoration: BoxDecoration(
                //             color: Colors.red,
                //             borderRadius: BorderRadius.circular(50)
                //           ),
                //           alignment: Alignment.center,
                //           child: Text(
                //             '1',
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                level == 'masyarakat' ? Container() :
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => adminMain())
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(
                        'Go To Admin',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Logout(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(
                        'Logout',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  }
}