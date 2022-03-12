
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'studentclass.g.dart';

@HiveType(typeId: 0)
class StudentList extends HiveObject{
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? age;

  @HiveField(2)
  final String? batch;

  @HiveField(3)
  final String? domain;

  @HiveField(4)
  final String? imageUrl;

  StudentList(
      {
      @required this.name,
      @required this.age,
      @required this.batch,
      @required this.domain,
      @required this.imageUrl
      });

}
