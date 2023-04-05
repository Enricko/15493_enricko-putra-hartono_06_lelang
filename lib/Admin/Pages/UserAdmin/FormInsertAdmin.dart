import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Admin/Home.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/main.dart';

class FormInsertAdmin extends StatefulWidget {
  const FormInsertAdmin({super.key});

  @override
  State<FormInsertAdmin> createState() => _FormInsertAdminState();
}

class _FormInsertAdminState extends State<FormInsertAdmin> {
  bool isVisibility = true;
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Petugas',
    },
    {
      'value': 'Administrasi',
    },
  ];
  
  String? level;
  String? idUser;
  String? token;
  
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerLevel = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPasswordConfirm = TextEditingController();

  Future<void> userCheck()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      level = pref.getString('level');
      token = pref.getString('token');
      idUser = pref.getString('id');
    });
    if(token == null || token == ""){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(page:2)));
      EasyLoading.showError("Please login First",dismissOnTap: true);
      return;
    }
  }
  register(BuildContext context){
    var name = controllerName.text;
    var level = controllerLevel.text;
    var email = controllerEmail.text; 
    var password = controllerPassword.text; 
    var passwordConfirm = controllerPasswordConfirm.text; 
    if(name == '' || level == '' || email == '' || password == '' || passwordConfirm == '' || 
      name == null || level == null || email == null || password == null || passwordConfirm == null){
      EasyLoading.showError("Please insert all form input",dismissOnTap: true);
      return;
    }
    if (password != passwordConfirm) {
      EasyLoading.showError("Password confirm doesnt match",dismissOnTap: true);
      return;
    }
    var data = {
      "name" : name,
      "email" : email,
      "level" : level,
      "password": password,
      'password_confirmation' : passwordConfirm,
    };
    Api.registerAdmin(token!,data).then((value){
      if (value.message! != "Selamat datang") {
        EasyLoading.showError("Email telah terpakai",dismissOnTap: true);
        return;
      }
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => adminMain(page:2)));
      EasyLoading.showSuccess("Data Telah di tambahkan",dismissOnTap: true);
      return;
    });

  }

  @override
  void initState() {
    userCheck();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register Admin/Petugas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: controllerName,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Name",
                    labelText: "Name",
                    hintStyle: TextStyle(
                      color: Colors.black
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800
                    ),
                    fillColor: Colors.white60,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white54),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white70),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 7),
                  child: SelectFormField(
                    controller: controllerLevel,
                    type: SelectFormFieldType.dropdown,
                    items: _items,
                    style: TextStyle(
                      color: Colors.black
                    ),
                    decoration: InputDecoration(
                      hintText: "Level",
                      labelText: "Level",
                      hintStyle: TextStyle(
                        color: Colors.black
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800
                      ),
                      fillColor: Colors.white60,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.white54),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.white70),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    // onChanged: (val) => print(val),
                    // onSaved: (val) => print(val),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controllerEmail,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Email",
                    labelText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.black
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800
                    ),
                    fillColor: Colors.white60,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white54),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white70),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7),
                child: TextFormField(
                  obscureText: isVisibility,
                  controller: controllerPassword,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Password",
                    labelText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.black
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800
                    ),
                    fillColor: Colors.white60,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white54),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white70),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                      icon: isVisibility == true
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          isVisibility = !isVisibility;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7),
                child: TextFormField(
                  obscureText: true,
                  controller: controllerPasswordConfirm,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Password Confirm",
                    labelText: "Password Confirm",
                    hintStyle: TextStyle(
                      color: Colors.black
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800
                    ),
                    fillColor: Colors.white60,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white54),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.white70),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => register(context),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
                    decoration: BoxDecoration(
                      color:Colors.blueAccent ,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}