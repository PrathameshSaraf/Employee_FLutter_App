import 'package:flutter/material.dart';
import 'package:mobile_engineer/constants/app_colors.dart';


class CustomAppBar extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
   bool isDetail;

   CustomAppBar({Key? key,
    required this.scaffoldKey,this.isDetail =false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  if(!isDetail){
                    scaffoldKey.currentState!.openDrawer();
                  }
                  else{
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 65,
                  width: 65,
                  color: Colors.blue,
                  padding: EdgeInsets.zero,
                  child: Icon(
                    isDetail?Icons.arrow_back :Icons.menu,
                    size: 35,
                    color: AppColors.blackShadeColor,
                  ),
                ),
              ),
              Container(
                width: 1.5,
                height: 55,
                padding: const EdgeInsets.symmetric(vertical: 5),
                color: AppColors.greyColor,
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Employees',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 28.6,
                            height: 1.5),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 10),
                        child: const Text(
                          'emp',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              height: 1.3,
                              textBaseline: TextBaseline.alphabetic),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(
            height: 1.0,
            thickness: 1.0,
            color: AppColors.greyColor,
          )
        ],
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Empl',
                  style: TextStyle(
                      color: Colors.blue, fontSize: 25,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 15.6,
                      height: 1.5),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.black,
              )),

          ListTile(
            leading: Icon(Icons.add_box_outlined,color: AppColors.black,),
            title: Text(
              'CREATE EMPLOYEE',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  letterSpacing: 1.0),
            ),
            onTap: () {
              Navigator.of(context).pop();

              Navigator.pushNamed(context, '/create');
            },
          ),
          ListTile(
            leading: Icon(Icons.list,color: AppColors.black,),
            title: Text(
              'EMPLOYEES',
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  letterSpacing: 1.0),
            ),
            onTap: ()  {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(context, ('/main'), (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
