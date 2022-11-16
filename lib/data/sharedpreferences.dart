
import 'dart:convert';
import 'package:mobile_engineer/model/employee_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<List<Employee>> readEmployee(String key) async {
    List<Employee> _model=[];
    final prefs = await SharedPreferences.getInstance();
    List<String> stringList = prefs.getStringList(key)??[] ;
    for (var element in stringList) {
      _model.add(Employee.fromJson(json.decode(element)));
    }
    return _model;
  }


  saveEmployee(String key,Employee _employee) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stringList = prefs.getStringList(key)??[];
    stringList.add(json.encode(_employee));
    prefs.setStringList(key, stringList);
  }


  saveListEmployee(String key,List<Employee> _employee) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stringList = [];
    _employee.forEach((element) {
      stringList.add(json.encode(element));
    });
    print(stringList);
    prefs.setStringList(key, stringList);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    print('Deleting '+key+' shared preferences....');
  }

  Future<int> listDataCount(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stringList = prefs.getStringList(key)??[];
    return stringList.length+1;
  }


}