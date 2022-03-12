import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:list_students/studentclass.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  XFile? _imageFile;

  String? name;
  String? age;
  String? batch;
  String? domain;

  Box studentListBox = Hive.box<StudentList>('studentList');

  chooseImage(ImageSource source) async {
    final pickedFile = await ImagePicker.platform.getImage(source: source);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      appBar: AppBar(title: Text('Student Details')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                _imageFile == null
                    ? const CircleAvatar(
                        radius: 125,
                        backgroundImage: AssetImage('images/image1.png'),
                        backgroundColor: Colors.transparent,
                      )
                    : Column(
                        children: [
                          ClipOval(
                              child: Image(
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(
                                      _imageFile!.path,
                                    ),
                                  ))),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ElevatedButton(
                          child: const Text('Pick Gallery'),
                          onPressed: () {
                            chooseImage(ImageSource.gallery);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ElevatedButton(
                          child: Text('Pick Camera'),
                          onPressed: () {
                            setState(() {
                              chooseImage(ImageSource.camera);
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* requiered field';
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Name of the student')),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* requiered field';
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      age = val;
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text('Age')),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* requiered field';
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      batch = val;
                    });
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), label: Text('Batch')),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '* requiered field';
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      domain = val;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text('Domain')),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    child: Text('Submit Details'), onPressed: submitFunction)
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitFunction() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      Hive.box<StudentList>('studentList').add(StudentList(
          name: name,
          age: age,
          batch: batch,
          domain: domain,
          imageUrl: _imageFile?.path));

      Navigator.of(context).pop();
    }
  }
}
