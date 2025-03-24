import 'package:ec_com_admin_01/provider/order_provider.dart';
import 'package:ec_com_admin_01/utils/constants.dart';
import 'package:ec_com_admin_01/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_details_Page.dart';

class OrderListPage extends StatelessWidget {
  static const String routeName ='/order_page';
  const OrderListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: Colors.white70,
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.orderList.length,
            itemBuilder: (context, index) {
              final order = provider.orderList[index];
              return ListTile(
                tileColor: id == null ? null : id == order.orderId ? Colors.grey.withOpacity(0.4): null,

                onTap: () => Navigator.pushNamed(context, OrderDetailsPage.routeName, arguments:  order.orderId),
                title: Text(getFormattedDate(order.orderDate.timestamp.toDate(), pattern: 'dd/MM/yyyy HH:mm:ss')),
                subtitle: Text(order.orderStatus),
                trailing: Text('$currencySymbol${order.grandTotal}'),
              );
          },);
        },
      ),
    );
  }
}
