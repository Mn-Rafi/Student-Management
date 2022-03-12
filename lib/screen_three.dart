import 'dart:io';

import 'package:flutter/material.dart';
import 'package:list_students/screen_four.dart';
import 'package:list_students/screentwo.dart';

class ScreenThree extends StatelessWidget {
  final String? name;
  final String? age;
  final String? batch;
  final String? domain;
  final String? imageUrl;

  const ScreenThree({
    Key? key,
    required this.name,
    required this.age,
    required this.batch,
    required this.domain,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name.toString()),
      ),
      body: Center(
        child: ListView(shrinkWrap: true, children: [
          imageUrl != null
              ? 
              Column(
                children: [
                  ClipOval(

                      child: Image(
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                        image: FileImage(
                        File(
                          imageUrl.toString(),
                        ),)
                      ),
                    ),
                ],
              )
              : const CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  child: Image(image: AssetImage('images/image1.png')),
                ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:50.0),
            child: Column(
              children: [
                Text(
                  'Name : $name',
                  style: TextStyle(fontSize: 20, color: Colors.redAccent),
                ),
                Text(
                  'Age : $age',
                  style: TextStyle(fontSize: 20, color: Colors.redAccent),
                ),
                Text(
                  'Batch : $batch',
                  style: TextStyle(fontSize: 20, color: Colors.redAccent),
                ),
                Text(
                  'Domain : $domain',
                  style: TextStyle(fontSize: 20, color: Colors.redAccent),
                ),
                
              ],
            ),
          )
        ]),
      ),
    );
  }
}
