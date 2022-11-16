import 'dart:convert';

import 'package:flutter/cupertino.dart';
Employee employeeNameFromJson(String str) => Employee.fromJson(json.decode(str));
String employeeNameToJson(Employee data) => json.encode(data.toJson());
class Employee with ChangeNotifier{
  int id;
  String fullName;
  String phoneNumber;
  String email;
  String postion;
  double salary;
 int years;
  bool isActive;
  bool showButtons;
  Employee({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.postion,
    required this.salary,
   required this.years,
    this.isActive=false,
    this.showButtons =false
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    fullName: json["full_name"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    postion: json["postion"],
    salary: json["salary"],
    years:json["years"],
    showButtons:json["showButtons"] ?? false
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "phone_number": phoneNumber,
    "email": email,
    "postion": postion,
    "salary": salary,
    "years":years,
    "isActive":isActive,
    "showButtons":showButtons
  };

   bool countyears(){
    if(years>=5)
      return true;
    else
      return false;
  }
}