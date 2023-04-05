import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/ApiLelang.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Pages/DetailLelang.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/main.dart';

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

class ViewAll extends StatefulWidget {
  const ViewAll({super.key,required this.page,required this.title,this.id = '',this.token = ''});
  final int page;
  final String id;
  final String token;
  final String title;

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  final currencyFormatter = NumberFormat('#,000', 'ID');
  final img_url = "http://lelang.enricko.com/barang_lelang/";
  Future<ApiLelang>? lelang;

  @override
  void initState() {
    if(widget.title == "Lelang Terbaru"){
      lelang = Api.lelangPage("status=dibuka&time=new&page=${widget.page}");  
    }
    if(widget.title == "History Lelang"){
      lelang = Api.lelangPage("status=ditutup&time=new&page=${widget.page}");  
    }
    if(widget.title == "Lelang yang telah kamu menangi"){
      lelang = Api.lelangPage("status=ditutup&user_id=${widget.id}&page=${widget.page}");  
    }
    if(widget.title == "Lelang yang telah kamu ikuti"){
      lelang = Api.ikutLelang("page=${widget.page}",widget.token);  
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: lelang,
      builder: (context, AsyncSnapshot<ApiLelang> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.message! == "Data tidak ditemukan") {
            if(widget.title == "Lelang yang telah kamu menangi"){
              return Center(
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Kamu belum memenangi lelang mana pun'),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: Text('< Back'))
                  ],
                ),
              );
            }
            if(widget.title == "Lelang yang telah kamu ikuti"){
              return Center(
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Kamu belum memenangi lelang mana pun'),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: Text('< Back'))
                  ],
                ),
              );
            }
          }
          return ListLelang(snapshot.data!.data!, context, img_url,(snapshot.data!.count! / 30).ceil());
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

  Scaffold ListLelang(List<Data> lelang, BuildContext context, String img_url,int totalPage) {
    return Scaffold(
    appBar: AppBar(
      title: Text(capitalizeAllSentence(widget.title)),
    ),
    body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.title}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 89, 121, 138),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Text(
                      '1',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
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
            Responsive(
              children: [
                for(var i = 0; i < lelang.length; i++) 
                GestureDetector(
                  onTap: () => 
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailLelang(idLelang: int.parse(lelang[i].idLelang!),))
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
                                "${img_url + lelang[i].barang!.imageBarang!}",
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
                                capitalizeAllSentence("${lelang[i].barang!.namaBarang!}"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            lelang[i].barang!.hargaAkhir! == "" ?
                            Text(
                              "Rp.${currencyFormatter.format(int.parse(lelang[i].barang!.hargaAwal!))}",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ):
                            Text(
                              "Rp.${currencyFormatter.format(int.parse(lelang[i].barang!.hargaAkhir!))}",
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
            )
          ],
        ),
      ),
    ),
   bottomNavigationBar: Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.blueGrey
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => widget.page <= 1 ? null : 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAll(title: widget.title, page: widget.page - 1)))
                ,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: BoxDecoration(
                    color: widget.page <= 1 ? Color.fromARGB(255, 95, 95, 95) : Colors.grey,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text(
                    '<',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                      height: 35,
                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                child: ListView.builder(
                  itemCount: totalPage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context,int index){
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => widget.page == index + 1 ? null : 
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAll(title: widget.title, page: index + 1))),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            decoration: BoxDecoration(
                              color: widget.page == index+1 ? Color.fromARGB(255, 95, 95, 95) : Colors.grey,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Text(
                              '${index+1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => widget.page >= totalPage ? null :
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAll(title: widget.title, page: widget.page + 1)))
                ,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: BoxDecoration(
                    color: widget.page >= totalPage ? Color.fromARGB(255, 95, 95, 95) : Colors.grey,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
  }
}