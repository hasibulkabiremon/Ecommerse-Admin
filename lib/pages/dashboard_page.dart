import 'package:ec_com_admin_01/auth/authservice.dart';
import 'package:ec_com_admin_01/customwidget/dashboard_item_view.dart';
import 'package:ec_com_admin_01/models/dashboard_model.dart';
import 'package:ec_com_admin_01/pages/launcher_page.dart';
import 'package:ec_com_admin_01/provider/order_provider.dart';
import 'package:ec_com_admin_01/provider/product_provider.dart';
import 'package:ec_com_admin_01/provider/user_provider.dart';
import 'package:ec_com_admin_01/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/notification_provider.dart';

class DashBoardPage extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<ProductProvider>(context, listen: false).getAllPurchase();
    Provider.of<OrderProvider>(context, listen: false).getOrderConstants();
    Provider.of<OrderProvider>(context, listen: false).getOrders();
    Provider.of<UserProvider>(context, listen: false).getAllUsers();
    Provider.of<NotificationProvider>(context, listen: false).getAllNotifications();

    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoard'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout().then((value) =>
              Navigator.pushReplacementNamed(context, LauncherPage.routeName));
            },
            icon: const Icon(Icons.logout),
          )
        ],
        backgroundColor: Colors.white70,
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
          ),
          itemCount: dashboardModelList.length,
          itemBuilder: (context, index) => DashBoardItemView(model: dashboardModelList[index],),

      ),
    );
  }
}
