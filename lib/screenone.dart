import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:list_students/screen_three.dart';
import 'package:list_students/studentclass.dart';
import 'screen_four.dart';
import 'screentwo.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  Icon myIcon = const Icon(Icons.search);
  Widget myField = const Text('Students List');
  String searchInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: myField,
        centerTitle: true,
        elevation: 10,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (myIcon.icon == Icons.search) {
                    myIcon = const Icon(Icons.clear);
                    myField = TextField(
                      onChanged: (value) {
                        searchInput = value;
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: 'Search here',
                      ),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18),
                    );
                  } else {
                    setState(() {
                      searchInput = '';
                    });
                    myIcon = const Icon(Icons.search);
                    myField = const Text('Students list');
                  }
                });
              },
              icon: myIcon),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<StudentList>('studentList').listenable(),
          builder: (context, Box<StudentList> box, widget) {
            List keys = box.keys.toList();
            if (keys.isEmpty) {
              return const Center(
                child: Text('List is Empty'),
              );
            }
            List<StudentList> data = box.values
                .where((element) => element.name!
                    .toLowerCase()
                    .contains(searchInput.toLowerCase()))
                .toList();
            if (data.isEmpty) {
              return const Center(
                child: Text('Sorry, no results found :('),
              );
            }
            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemBuilder: (contxt, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (conte) => ScreenThree(
                                    name: data[index].name,
                                    age: data[index].age,
                                    batch: data[index].batch,
                                    domain: data[index].domain,
                                    imageUrl: data[index].imageUrl),
                              ),
                            );
                          },
                          leading: data[index].imageUrl != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(
                                      File(data[index].imageUrl.toString())),
                                )
                              : const CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Image(
                                      image: AssetImage('images/image1.png')),
                                ),
                          title: Text(data[index].name.toString()),
                          subtitle: Text(data[index].age.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ScreenFour(
                                                  index: index,
                                                  obj: data,
                                                )));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Warning!'),
                                        content: const Text(
                                            'Do you really want to remove?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              data[index].delete();
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: data.length),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Student'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const ScreenTwo()));
        },
      ),
    );
  }
}
