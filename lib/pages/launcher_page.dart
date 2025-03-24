import 'package:ec_com_admin_01/auth/authservice.dart';
import 'package:ec_com_admin_01/pages/dashboard_page.dart';
import 'package:ec_com_admin_01/pages/login_page.dart';
import 'package:flutter/material.dart';

class LauncherPage extends StatelessWidget {
  static const String routeName ='/';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, (){
      if (AuthService.currentUser != null){
        Navigator.pushReplacementNamed(context, DashBoardPage.routeName);
      }else {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(

        ),
      ),
    );
  }
}
