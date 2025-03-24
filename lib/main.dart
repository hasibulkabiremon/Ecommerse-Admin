import 'package:ec_com_admin_01/pages/add_product_page.dart';
import 'package:ec_com_admin_01/pages/category_page.dart';
import 'package:ec_com_admin_01/pages/dashboard_page.dart';
import 'package:ec_com_admin_01/pages/launcher_page.dart';
import 'package:ec_com_admin_01/pages/login_page.dart';
import 'package:ec_com_admin_01/pages/notification_page.dart';
import 'package:ec_com_admin_01/pages/order_details_Page.dart';
import 'package:ec_com_admin_01/pages/order_page.dart';
import 'package:ec_com_admin_01/pages/product_details_page.dart';
import 'package:ec_com_admin_01/pages/product_repurchase_page.dart';
import 'package:ec_com_admin_01/pages/report_page.dart';
import 'package:ec_com_admin_01/pages/setting_page.dart';
import 'package:ec_com_admin_01/pages/user_list_page.dart';
import 'package:ec_com_admin_01/pages/view_product_page.dart';
import 'package:ec_com_admin_01/provider/notification_provider.dart';
import 'package:ec_com_admin_01/provider/order_provider.dart';
import 'package:ec_com_admin_01/provider/product_provider.dart';
import 'package:ec_com_admin_01/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        primarySwatch: Colors.teal,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName:(_) =>const LauncherPage(),
        LoginPage.routeName:(_) =>const LoginPage(),
        DashBoardPage.routeName:(_) =>const DashBoardPage(),
        AddProductPage.routeName:(_) =>const AddProductPage(),
        ViewProductPage.routeName:(_) =>const ViewProductPage(),
        ProductDetailsPage.routeName:(_) =>const ProductDetailsPage(),
        CategoryPage.routeName:(_) =>const CategoryPage(),
        OrderListPage.routeName:(_) =>const OrderListPage(),
        OrderDetailsPage.routeName:(_) =>const OrderDetailsPage(),
        ReportPage.routeName:(_) =>const ReportPage(),
        SettingsPage.routeName:(_) =>const SettingsPage(),
        ProductRepurchasePage.routeName:(_) =>const ProductRepurchasePage(),
        UserListPage.routeName:(_) =>const UserListPage(),
        NotificationPage.routeName:(_) =>const NotificationPage(),
      },
    );
  }
}

