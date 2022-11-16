import 'package:action_broadcast/action_broadcast.dart';
import 'package:flutter/material.dart';
import 'package:mobile_engineer/constants/app_colors.dart';
import 'package:mobile_engineer/constants/helper.dart';
import 'package:mobile_engineer/data/sharedpreferences.dart';
import 'package:mobile_engineer/model/employee_detail.dart';
import 'package:mobile_engineer/widget/AppBar.dart';
import 'package:mobile_engineer/widget/EmployeeCard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with AutoCancelStreamMixin{
  List<Employee> employeesList = [];
  SharedPref sharedPref = SharedPref();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employeesList.clear();
    sharedPref.readEmployee(Utils.sharedPrefrencesEmployeeKey).then((value) {

      setState(() {
        employeesList.addAll(value);
      });
    });

  }

  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            CustomAppBar(
              scaffoldKey: _scaffoldKey,
            ),
            Expanded(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                      'EMPLOYEES',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          letterSpacing: 1.0),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ListView.builder(
                        itemCount: employeesList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Employee employee = employeesList[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: EmployeeCard(
                              employee: employee,
                              editTap: () {
                                Utils.showToastMessage(""
                                    "The feature is not available at the moment.");
                              },
                              cardTap: () {
                                employeesList.forEach((element) {
                                  element.showButtons = false;
                                });
                                employee.showButtons = true;
                                sharedPref.saveListEmployee(
                                    Utils.sharedPrefrencesEmployeeKey, employeesList);
                                setState(() {
                                  employee.showButtons = true;
                                });
                              },
                              deleteTap: () {
                                Utils.showTwoButtonAlertDialog(context: context,
                                    alertTitle: 'Delete Employee',
                                    alertMsg: "Are you sure you want to delete the employee ?",
                                    positiveText: 'Delete', negativeText: 'Cancel', yesTap: (){
                                      setState(() {
                                        employeesList.removeAt(index);
                                      });
                                      sharedPref.saveListEmployee(
                                          Utils.sharedPrefrencesEmployeeKey, employeesList);
                                    });

                              },
                            ),
                          );
                        })
                  ],
                ),
              ),
            ))
          ],
        ),
        drawer: NavDrawer(),
      ),
    );
  }

  @override
  Iterable<StreamSubscription> get registerSubscriptions sync* {
    yield registerReceiver(
        [Utils.actionEmployees
        ]).listen(
            (intent) async {
          // // print("Receiver: " + intent.action);
              employeesList.clear();
          sharedPref.readEmployee(Utils.sharedPrefrencesEmployeeKey).then((value) {
            setState(() {
              employeesList.addAll(value);
            });
          });
        }
    );
  }

}


