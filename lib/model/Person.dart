import 'package:json_annotation/json_annotation.dart';

part 'Person.g.dart';
@JsonSerializable()
class Person {

  int age;
  String name;


  Person({this.age,
    this.name});


  factory Person.fromJson(Map<String,dynamic> json) => _$PersonFromJson(json);


  Map<String,dynamic> toJson() =>_$PersonToJson(this);

}