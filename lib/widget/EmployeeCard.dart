import 'package:flutter/material.dart';
import 'package:mobile_engineer/constants/app_colors.dart';

import 'package:mobile_engineer/model/employee_detail.dart';

class EmployeeCard extends StatefulWidget {
  Employee employee;

  bool isDetail;
  GestureTapCallback? deleteTap;
  GestureTapCallback? editTap;
  GestureTapCallback? cardTap;
  EmployeeCard(
      {Key? key,
      required this.employee,
      this.isDetail = false,
      this.deleteTap,
      this.editTap,
      this.cardTap})
      : super(key: key);

  @override
  _EmployeeCardState createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
print(widget.employee.imageurl);
    // print(widget.employee.years);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),

          ///spread radius
          blurRadius: 3, // blur radius
          offset: Offset(-1, 0), // changes position of shadow
          //first paramerter of offset is left-right
          //second parameter is top to down
        ),
      ]),
      padding: EdgeInsets.zero,
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if(!widget.isDetail){
                Navigator.pushNamed(context, '/detail',
                    arguments: widget.employee);
                setState(() {
                  widget.employee.showButtons = false;
                });
              }
            },
            child:Image(
              width: 100,
              height: 200,
              image: NetworkImage(
                  widget.employee.imageurl
              ),
            ),
          ),


    Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(!widget.isDetail){
                            Navigator.pushNamed(context, '/detail',
                                arguments: widget.employee,

                          );
                            setState(() {
                              widget.employee.showButtons = false;
                            });
                          }
                        },
                        child: Text(
                          widget.employee.fullName.toUpperCase(),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                              color: AppColors.blackShadeColor,
                              fontSize: 21,
                              fontWeight: FontWeight.w400),
                        ),

                      ),
                      GestureDetector(
                        onTap: widget.cardTap,
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 13,
                              ),
                                widget.employee.years>5?Icon(
                                Icons.flag ,
                                color: Colors.green,
                              size: 30.0,
                              ):Icon(
                                  Icons.flag ,
                                  color: Colors.red,
                                  size: 30.0,
                                  )  ,


                              Text(
                               widget.employee.salary.toString(),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.employee.phoneNumber,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.employee.email,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                    color: AppColors.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!widget.isDetail && widget.employee.showButtons)
                  Container(
                    height: 150,
                    alignment: Alignment.bottomRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Expanded(
                          child: SizedBox(),
                        ),

                        InkWell(
                          onTap: widget.editTap,
                          child: Container(
                              color: Colors.black38,
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/edit.png',
                                height: 25,
                                width: 25,
                              )),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        InkWell(
                          onTap: widget.deleteTap,
                          child: Container(
                              color: Colors.black38,
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(
                                'assets/delete.png',
                                height: 25,
                                width: 25,
                              )),
                        )
                      ],
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}

