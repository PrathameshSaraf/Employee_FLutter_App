
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mobile_engineer/model/employee_detail.dart';

class DatabaseServices {
  final _db = FirebaseFirestore.instance;

  Future<String> addEmployee(String id, String fullName,
      String email,String phoneNumber,double salary,
       BuildContext context,DateTime Date,String Imageurl, String EmployeeType) async {

    final now = DateTime.now();
    final difference = now.difference(Date);
     int year=(difference.inDays/ 365).floor();
     print(year);
     print(year.runtimeType);
    final categoryData = Employee(
        id: id, fullName: fullName, phoneNumber: phoneNumber, email: email, salary: salary, years:year,imageurl: Imageurl);
    try{
      DocumentReference ref = await _db
          .collection("Employee")
          .add(categoryData.toMap())
          .catchError((e) {
        print(e);
      });
      await _db.collection("Employee").doc(ref.id).update({"id": ref.id});
      print(ref.id);
      return ref.id;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unable to update data $e")));
      return "";
    }
  }


  Future<List<Employee>> getEmployeeData() async {
    List<Employee> dataList = [];
    QuerySnapshot snapshots =
    await _db.collection("Employee").get().catchError((e) {
      print("Error :- $e");
    });
    for (QueryDocumentSnapshot snap in snapshots.docs) {
      dataList.add(Employee(
        years: snap["years"],
        imageurl: snap["image"],
        fullName: snap["full_name"],
        phoneNumber: snap['phone_number'],
        id: snap['id'],
        salary: snap['salary'],
        email: snap['email'],
        isActive: snap['isActive'],
        showButtons: snap['showButtons'],
      ));
    }

    return dataList;
  }

  Future<void> updatePhotoImage(String image, String id) {
    return _db.collection("Employee").doc(id).update({
      "image": image,
    }).then((value) => print("Done"));
  }
}


class Storageservice{
  final db = DatabaseServices();
  final firebase_storage.FirebaseStorage storage = firebase_storage
      .FirebaseStorage.instance;
  firebase_storage.Reference? ref;
  Future<void> uploadImage(File file,String id,BuildContext context) async {
    String fileName = file!.path.split('/').last;
    Uint8List imageData = await XFile(file.path).readAsBytes();
    final uploadTask =
    storage.ref('Employee/$fileName' + ".jpg").putData(imageData);
    print("hello");
    uploadTask.snapshotEvents.listen((event) async {
      switch (event.state) {
        case TaskState.running:
        // final progress = 100.0 * (event.bytesTransferred / event.totalBytes);
          break;
        case TaskState.paused:
          break;
        case TaskState.canceled:
          break;
        case TaskState.error:
          break;
        case TaskState.success:
          String downloadUrl =
          await storage.ref('Employee/$fileName' + ".jpg").getDownloadURL();
          db.updatePhotoImage(downloadUrl, id).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Photo Save")));
          });
          break;
      }});
  }

  }
