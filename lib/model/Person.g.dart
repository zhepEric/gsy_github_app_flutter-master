// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    age: json['age'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'age': instance.age,
      'name': instance.name,
    };
