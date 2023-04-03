import 'package:flutter/material.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Admin/Home.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Pages/ViewAll.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
                    'Erick'.toUpperCase(),
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
                                  '2',
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
                                  '1',
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
                            Text('email@gmail.com')
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.smartphone,color: Colors.white, size: 30,),
                            Text('0812731277321')
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
                        MaterialPageRoute(builder: (context) => ViewAll(page: 'Lelang yang telah kamu menangi'))
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
                        MaterialPageRoute(builder: (context) => ViewAll(page: 'Lelang yang telah kamu ikuti'))
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
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ViewAll(page: 'Tawaran saat ini'))
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(
                                'Barang yang kamu tawar saat ini',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 1,
                          right: 1,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '1',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}