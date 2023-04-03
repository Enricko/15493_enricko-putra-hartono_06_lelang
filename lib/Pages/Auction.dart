import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:intl/intl.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // My Current Action
          currentBid(context),
          SizedBox(
            height: 15,
          ),
          listLelang(context),
          // My Current Action
        ],
      ),
    );
  }
  Widget currentBid(BuildContext context){
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
                    "Barang yang kamu tawar saat ini",
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
                        MaterialPageRoute(builder: (context) => ViewAll(page: 'Tawaran saat ini'))
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
                    for(var i = 1; i <= 18; i++) 
                    GestureDetector(
                      onTap: () => 
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailLelang())
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
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-nIVi5tIOdZXyrCWcc5M76F6QlfLR_VrEIQ&usqp=CAU",
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
                                  capitalizeAllSentence("expensive painting"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Rp.${currencyFormatter.format(10293092103)}",
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
 
  Widget listLelang(BuildContext context){
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
                    "List Semua Lelang",
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
                        MaterialPageRoute(builder: (context) => ViewAll(page: 'List Lelang'))
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
                    for(var i = 1; i <= 18; i++) 
                    GestureDetector(
                      onTap: () => 
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailLelang())
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
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-nIVi5tIOdZXyrCWcc5M76F6QlfLR_VrEIQ&usqp=CAU",
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
                                  capitalizeAllSentence("expensive painting"),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Rp.${currencyFormatter.format(10293092103)}",
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