import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:mobile_engineer/constants/app_colors.dart';
import 'package:mobile_engineer/model/employee_detail.dart';
import 'package:mobile_engineer/widget/AppBar.dart';
import 'package:mobile_engineer/widget/EmployeeCard.dart';

class EmployeeDetailScreen extends StatefulWidget {
  Employee employee;
   EmployeeDetailScreen({Key? key,required this.employee}) : super(key: key);

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final Map<String, List> _elements = {
    '': ['FEB', 'JAN'],
    '2019': ['DEC', 'FEB', 'JAN'],
    '2018': ['FEB', 'JAN'],
  };

  Widget _itemBuilder(BuildContext context, IndexPath index) {
    String monthText = _elements.values.toList()[index.section][index.index];
    return Container(
      width: double.infinity,
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.white,
       border: Border.all(
         width: 1.5,
         color: AppColors.lightGreyColor
       )
      ),
      child: Row(
        children: [
          Container(
            height: 90,
           width: 75,
            color: AppColors.lightGreyColor,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                Text(monthText,
                 style: TextStyle(

                   color: Colors.grey,
                 ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: const Text('BORROWED:      ₦50,000',
                     style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.w300
                     ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: AppColors.lightGreyColor,
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: const Text('RECEIVABLE:     ₦100,000',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

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
              isDetail: true,
            ),
            Expanded(
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
                      EmployeeCard(
                        employee: widget.employee,
                        isDetail: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'LOAN RECORD',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            letterSpacing: 0.5
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(child:
                      GroupListView(
                        sectionsCount: _elements.keys.toList().length,
                        countOfItemInSection: (int section) {
                          return _elements.values.toList()[section].length;
                        },
                        itemBuilder: _itemBuilder,
                        groupHeaderBuilder: (BuildContext context, int section) {
                          return section>0 ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Text(_elements.keys.toList()[section],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15
                                      ),),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                    Expanded(
                                      child: Container(
                                        height: 1.5,
                                        color:AppColors.lightGreyColor ,
                                      ),
                                    )
                                  ],
                                ),
                                 )):const SizedBox(
                          );
                        },
                        separatorBuilder: (context, index) => Container(),
                        sectionSeparatorBuilder: (context, section) => const SizedBox(),
                      ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
