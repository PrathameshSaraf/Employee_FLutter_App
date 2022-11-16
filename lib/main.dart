import 'package:flutter/material.dart';
import 'package:mobile_engineer/model/employee_detail.dart';
import 'package:mobile_engineer/screens/create_screen.dart';
import 'package:mobile_engineer/screens/details_screen.dart';
import 'package:mobile_engineer/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/create':
        return MaterialPageRoute(builder: (_) => const CreateScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/detail':
        return MaterialPageRoute(
            builder: (_) => EmployeeDetailScreen(employee: args as Employee));
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
