
import 'package:flutter/material.dart';
import 'package:mobile_engineer/constants/app_colors.dart';
import 'package:mobile_engineer/constants/helper.dart';
import 'package:mobile_engineer/data/DatabasedServie.dart';
import 'package:mobile_engineer/model/employee_detail.dart';
import 'package:mobile_engineer/widget/AppBar.dart';
import 'package:mobile_engineer/widget/EmployeeCard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Employee> employeesList = [];
  final db = DatabaseServices();
  bool _isloading=true;
  @override
  void initState() {
    // TODO: implement initState
    getProducts();

  }
  getProducts()async {
    final value=await db.getEmployeeData();
    employeesList=value;
    print(value);
    setState(() {

    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    if(employeesList.length>0){
      setState(() {
        _isloading=false;
      });
    }

    return _isloading?const Center(
      child: CircularProgressIndicator(),
    ):SafeArea(
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

                              },
                              deleteTap: () {


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


  }




