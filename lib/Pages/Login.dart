import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../Admin/Home.dart';

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
              // controller: controllerEmail,
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
              // controller: controllerPassword,
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
            onPressed: () => null,
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
              TextButton(
                onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => adminMain())
                ),
                child: Text(
                  "AdminPage",
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
              // controller: controllerName,
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
              // controller: controllerNoTelp,
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
              // controller: controllerEmail,
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
              // controller: controllerEmail,
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
              // controller: controllerPasswordConfirm,
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
            onPressed: () => null,
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

