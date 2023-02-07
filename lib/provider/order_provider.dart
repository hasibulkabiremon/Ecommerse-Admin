import 'package:ec_com_admin_01/db/db_helper.dart';
import 'package:ec_com_admin_01/models/order_constant_model.dart';
import 'package:ec_com_admin_01/models/order_model.dart';
import 'package:flutter/material.dart';

import '../auth/authservice.dart';
import '../models/order_item.dart';

class OrderProvider extends ChangeNotifier{
  OrderConstantModel orderConstantModel = OrderConstantModel();
  List<OrderModel> orderList = [];
  List<OrderItem> orderItemList = [];

  getAllOrders() {
    DbHelper.getAllOrdersByUser(AuthService.currentUser!.uid)
        .listen((snapshot) {
      orderList = List.generate(snapshot.docs.length,
              (index) => OrderModel.fromMap(snapshot.docs[index].data()));
      orderItemList =
          orderList.map((order) => OrderItem(orderModel: order)).toList();
      notifyListeners();
    });
  }



  getOrderConstants() {
    DbHelper.getOrderConstants().listen((snapshot) {
      if (snapshot.exists) {
        orderConstantModel = OrderConstantModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  

  Future<void> updateOrderConstants(OrderConstantModel model) {
    return DbHelper.updateOrderConstants(model);
  }
}