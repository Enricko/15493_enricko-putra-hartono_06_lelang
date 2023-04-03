import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
                      '12312',
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
                      '12312',
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
                      '12312',
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
                      '12312',
                    ),
                  ],
                )
               ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}