
import 'package:action_broadcast/action_broadcast.dart';
import 'package:flutter/material.dart';
import 'package:mobile_engineer/constants/app_colors.dart';
import 'package:mobile_engineer/constants/helper.dart';
import 'package:mobile_engineer/data/sharedpreferences.dart';
import 'package:mobile_engineer/model/employee_detail.dart';
import 'package:mobile_engineer/widget/AppBar.dart';
import 'package:mobile_engineer/widget/CustomTextField.dart';
class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key,}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController yearsController = TextEditingController();

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
                        formField('Full Name *', fullNameController),
                        formField('Phone Number *', phoneNumberController),
                        formField('Email *', emailController),
                        formField('Position *', positionController),
                        formField('Salary *', salaryController),


                      RadioListTile(
                          title: Text("Active"),
                          value: "active",
                          groupValue: "active",
                          onChanged: (active){
                            setState(() {
                            });
                          },
                        ),
                        formField('Working Years *', yearsController),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            if(fullNameController.text.trim().isNotEmpty &&
                            emailController.text.trim().isNotEmpty &&
                            phoneNumberController.text.trim().isNotEmpty &&
                            positionController.text.trim().isNotEmpty &&
                            salaryController.text.trim().isNotEmpty &&
                            yearsController.text.trim().isNotEmpty
                            ){
                              if(Utils.isValidEmail(emailController.text)){
                                SharedPref sharedPref = SharedPref();
                                int id =await sharedPref.listDataCount(Utils.sharedPrefrencesEmployeeKey);
                                sharedPref.saveEmployee(Utils.sharedPrefrencesEmployeeKey,
                                 Employee(
                                     id: id,
                                     fullName: fullNameController.text,
                                     phoneNumber: phoneNumberController.text,
                                     email: emailController.text,
                                     postion: positionController.text,
                                     salary: double.parse(salaryController.text),
                                     years: int.parse(yearsController.text),
                                     isActive: true,
                                     
                                 ));
                                Navigator.pop(context);
                                sendBroadcast(Utils.actionEmployees);
                              }
                              else{
                                Utils.showToastMessage(Utils.msgEnterValidEmail);
                              }
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
