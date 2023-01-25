import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_engineer/constants/app_colors.dart';
import 'package:mobile_engineer/constants/helper.dart';
import 'package:mobile_engineer/data/DatabasedServie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_engineer/widget/AppBar.dart';
import 'package:mobile_engineer/widget/CustomTextField.dart';
class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key,}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final db = DatabaseServices();
  final st=Storageservice();
  final ImagePicker _picker = ImagePicker();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    TextEditingController salaryController = TextEditingController();
    DateTime _selectedDate=DateTime.now();
  File? image;

  pickImage(ImageSource source) async {
    _picker.pickImage(source: source, maxHeight: 480, maxWidth: 480).then((i) {
      final imageTemp = File(i!.path);
      setState(() {
        image = imageTemp;
      });
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Unable to get image")));
    });
  }
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1998),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print(_selectedDate);
  }
  String _selectedRadio="Active";
@override
  void initState() {
    // TODO: implement initState
  super.initState();
  _selectedRadio = "Active";
}

  setSelectedRadio(String val) {
    setState(() {
      _selectedRadio = val;
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.white,
        body: Column(
          children: [
             CustomAppBar(scaffoldKey: _scaffoldKey,),
            Expanded(
                child:  SingleChildScrollView(
                  physics:const BouncingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'CREATE EMPLOYEE PROFILE',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              letterSpacing: 1.0
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(color: Colors.red[200]),
                      child: image != null
                          ? Image.network(
                        image!.path,
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.fitHeight,
                      ) : Container(
                        decoration: BoxDecoration(color: Colors.white),
                        width: 200,
                        height: 200,
                        child: IconButton(
                          icon:Icon(Icons.camera_alt),

                          onPressed: (){
                             pickImage(ImageSource.gallery);
                           // Navigator.pop(context);
                          },
                          color: Colors.grey[800],
                        ),
                      ),),
                        formField('Full Name *', fullNameController),
                        formField('Phone Number *', phoneNumberController),
                        formField('Email *', emailController),

                        formField('Salary *', salaryController),

                        Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Employee type',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            RadioListTile(
                              value: "Active",
                              groupValue: _selectedRadio,
                              onChanged: (val) {
                                setSelectedRadio(val as String);
                              },
                              title: Text("Active"),
                            ),
                            RadioListTile(
                              value: "Disactive",
                              groupValue: _selectedRadio,
                              onChanged: (val) {
                                setSelectedRadio(val as String);
                              },
                              title: Text("Disactive"),
                            ),
                          ],
                    ),


                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  _selectedDate == null
                                      ? 'No Date Chosen!'
                                      : 'Picked Joining Date : ${DateFormat.yMd().format(
                                      _selectedDate)}',
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(primary: Colors.purple),
                                child: Text(
                                  'Choose Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: _presentDatePicker,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            if(fullNameController.text.trim().isNotEmpty &&
                            emailController.text.trim().isNotEmpty &&
                            phoneNumberController.text.trim().isNotEmpty &&
                            salaryController.text.trim().isNotEmpty &&
                                _selectedDate.toString().trim().isNotEmpty

                            ){
                              print(fullNameController.text);
                              print(emailController.text);
                              print( phoneNumberController.text);
                              print(salaryController.text);

                              print(salaryController.text);
                              print(_selectedDate.toString());
                              print(_selectedRadio);

                              db.addEmployee('', fullNameController.text, emailController.text, phoneNumberController.text,
                                  double.parse(salaryController.text), context, _selectedDate,'',_selectedRadio).then((value) =>
                               st.uploadImage(image!, value,context)
                              );
                            }
                            else{
                              print('....');
                              Utils.showToastMessage(Utils.msgrequiredField);
                            }
                          },
                          child: Container(
                            height: 65,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              border: Border.all(
                                color: AppColors.black
                              )
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'SAVE',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
        drawer: NavDrawer(),
      )
    );
  }
  Widget formField(String labelName,TextEditingController controller){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start
      ,
      children: [
         Text(labelName,
          style:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CreateProfileTextField(controller: controller),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
