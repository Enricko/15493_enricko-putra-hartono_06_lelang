import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Api/Api.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Pages/Home.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/Shared_preference/Preference.dart';
import 'package:tampilan_lelang_ukk_jan_29_2023/main.dart';

import '../Admin/Home.dart';
import '../Api/ApiLogin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  bool isVisibility = true;
  bool registerClicked = false;
  late bool onHoverLogin = true;

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerNoTelp = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPasswordConfirm = TextEditingController();

  Login(BuildContext context) {
    var email = controllerEmail.text; 
    var password = controllerPassword.text; 
    if(email == '' || password == '' || email == null || password == null){
      EasyLoading.showError("Please insert email & password",dismissOnTap: true);
      return;
    }
    var data = {
      "email" : email,
      "password" : password
    };
    Api.login(data).then((value){
      if(value.message! == "Email/Password anda salah silahkan coba lagi!"){
        EasyLoading.showError("Email/Password anda salah silahkan coba lagi!",dismissOnTap: true);
        return;
      }

      Pref.userPref(value.data!.id!.toString(), value.data!.name!, value.token!,value.data!.level!);
      EasyLoading.showSuccess("Welcome ${value.data!.name!}",dismissOnTap: true);
      if(value.data!.level! == "masyarakat"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => adminMain()));
      }
      return;
    });
  }

  register(BuildContext context){
    var name = controllerName.text;
    var noTelp = controllerNoTelp.text;
    var email = controllerEmail.text; 
    var password = controllerPassword.text; 
    var passwordConfirm = controllerPasswordConfirm.text; 
    if(name == '' || noTelp == '' || email == '' || password == '' || passwordConfirm == '' || 
      name == null || noTelp == null || email == null || password == null || passwordConfirm == null){
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
      "telp" : noTelp,
      "password": password,
      'password_confirmation' : passwordConfirm,
    };
    Api.register(data).then((value){
      if (value.message! != "Selamat datang") {
        EasyLoading.showError("Email/NoTelp telah terpakai",dismissOnTap: true);
        return;
      }
      Pref.userPref(value.data!.id!.toString(), value.data!.name!, value.token!,value.data!.level!);
      EasyLoading.showSuccess("Welcome ${value.data!.name!}",dismissOnTap: true);
      if(value.data!.level! == "masyarakat"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => adminMain()));
      }
      return;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 35,horizontal: 10),
      child: Center(
        child: SizedBox(
          width: 700,
          child: Card(
            color: Color.fromARGB(255, 124, 124, 124),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              child: registerClicked ? RegisterSection(context) : LoginSection(context),
            ),
          ),
        ),
      ),
    );
  }
  Widget LoginSection(BuildContext context) {
    return Responsive(
      children: [
        Div(
          divison: Division(
            colL: 12,
          ),
          child: Text(
            "LOGIN",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 42
            ),
          ),
        ),
        Div(
          divison: Division(
            colL: 12,
          ),
          child: SizedBox(
            height: 25,
          ),
        ),
        Div(
          divison: Division(
            colL: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical: 7),
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
        ),
        Div(
          divison: Division(
            colL: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical: 7),
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
                      // Memeberikan nilai pada variable isVisibility
                      // dengan nilai balikan dari nilai is inVisibility sebelumnya
                      isVisibility = !isVisibility;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        Div(
          divison: Division(colL: 12),
          child: SizedBox(
            height: 20,
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () => Login(context),
            child: Container(
              margin: EdgeInsets.only(top: 25,bottom: 10),
              padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
              decoration: BoxDecoration(
                color:Colors.blueAccent ,
                borderRadius: BorderRadius.circular(25)
              ),
              child: Text(
                "LOGIN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Don't have account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              TextButton(
                onPressed: () =>
                setState(() {
                  registerClicked = !registerClicked;
                }),
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget RegisterSection(BuildContext context) {
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    bool isVisibility = true;
    late bool onHoverLogin = true;
    return Responsive(
      children: [
        Div(
          divison: Division(
            colL: 12,
          ),
          child: Text(
            "Register",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 42
            ),
          ),
        ),
        Div(
          divison: Division(
            colL: 12,
          ),
          child: SizedBox(
            height: 25,
          ),
        ),
        Div(
          divison: Division(
            colL: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical: 7),
            child: TextFormField(
              controller: controllerName,
              keyboardType: TextInputType.name,
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
        ),
        Div(
          divison: Division(
            colL: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical: 7),
            child: TextFormField(
              controller: controllerNoTelp,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                hintText: "NoTelp",
                labelText: "NoTelp",
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
        ),
        Div(
          divison: Division(
            colL: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical: 7),
            child: TextFormField(
              controller: controllerEmail,
              keyboardType: TextInputType.emailAddress,
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
        ),
        Div(
          divison: Division(
            colL: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical: 7),
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
        ),
        Div(
          divison: Division(
            colL: 12,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) * 0.05,vertical: 7),
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
        ),
        Center(
          child: TextButton(
            onPressed: () => register(context),
            child: Container(
              margin: EdgeInsets.only(top: 25,bottom: 10),
              padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
              decoration: BoxDecoration(
                color:Colors.blueAccent ,
                borderRadius: BorderRadius.circular(25)
              ),
              child: Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Already have account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              TextButton(
                onPressed: () =>
                setState(() {
                  registerClicked = !registerClicked;
                }),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

