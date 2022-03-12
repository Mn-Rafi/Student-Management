import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';
import 'package:hive/hive.dart';
import 'package:list_students/studentclass.dart';

class ScreenFour extends StatefulWidget {
  var box = Hive.box<StudentList>('studentList');

  final List<StudentList> obj;
  final int index;

  ScreenFour({Key? key, required this.obj, required this.index})
      : super(key: key);

  @override
  State<ScreenFour> createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? age;
  String? batch;
  String? domain;
  String? imagePath;

  int? newKey;
  int? accessKey;

  void details() {
    name = widget.obj[widget.index].name;
    age = widget.obj[widget.index].age;
    batch = widget.obj[widget.index].batch;
    domain = widget.obj[widget.index].domain;
    imagePath = widget.obj[widget.index].imageUrl;
    newKey = widget.obj[widget.index].key;
    List<StudentList> studenList = widget.box.values.toList();
    for (int i = 0; i < studenList.length; i++) {
      if (studenList[i].key == newKey) {
        accessKey = i;
        break;
      }
    }
  }

  chooseImage(ImageSource source) async {
    final pickedFile = await ImagePicker.platform.getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imagePath = (pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    details();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Details')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: Form(
            key: _formKey,   child: ListView(
              shrinkWrap: true,
              children
         : [
                imagePath != null
                    ? Column(
                        children: [
                          ClipOval(
                              child: Image(
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(imagePath!),
                                  ))),
                        ],
                      )
                    : ClipOval(
                        child: Image(image: AssetImage('images/image1.png'),)
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
                  initialValue: name,
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
                  initialValue: age,
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
                  initialValue: batch,
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
                  initialValue: domain,
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
                    child: Text('Submit Changes'), onPressed: submitFunction)
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
      Hive.box<StudentList>('studentList').putAt(
        accessKey!,
        StudentList(
            name: name,
            age: age,
            batch: batch,
            domain: domain,
            imageUrl: imagePath
            ),
      );

      Navigator.of(context).pop();
    }
  }
}
