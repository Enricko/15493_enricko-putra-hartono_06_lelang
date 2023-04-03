import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart' if(kIsWeb) 'package:image_picker_for_web/image_picker_for_web.dart';

class FormInsertLelang extends StatefulWidget {
  const FormInsertLelang({super.key});

  @override
  State<FormInsertLelang> createState() => _FormInsertLelangState();
}

class _FormInsertLelangState extends State<FormInsertLelang> {
  bool isVisibility = true;
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Petugas',
    },
    {
      'value': 'Administrasi',
    },
  ];
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
                'Buka Lelang',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 25),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Container(
                      child: GestureDetector(
                        onTap: null,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          padding: EdgeInsets.all(6),
                          strokeWidth: 2,
                          color: Colors.white,
                          child: ClipRRect(
                            child: Image.asset('image/tambahan/image_placeholder.png',width: 200,height: 200, fit: BoxFit.cover)
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 5),
                      child: Text(
                        "Select Image Barang Lelang",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ),
                    Text(
                      "#Only Android/Ios/Website only",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  // controller: controllerName,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Nama Barang",
                    labelText: "Nama Barang",
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
                  keyboardType: TextInputType.number,
                  // controller: controllerName,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Harga Awal",
                    labelText: "Harga Awal",
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
                  // keyboardType: TextInputType.number,
                  keyboardType: TextInputType.datetime,
                  // controller: controllerName,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Lama Lelang",
                    labelText: "Lama Lelang",
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
                  keyboardType: TextInputType.text,
                  // controller: controllerName,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: "Deskripsi Barang",
                    labelText: "Deskripsi Barang",
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
                  onPressed: () => null,
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