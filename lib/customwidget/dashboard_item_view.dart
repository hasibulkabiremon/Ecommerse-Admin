import 'package:ec_com_admin_01/models/dashboard_model.dart';
import 'package:flutter/material.dart';

class DashBoardItemView extends StatelessWidget {
  final DashboardModel model;
  const DashBoardItemView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, model.routeName),
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(model.iconData, size: 50, color: Color.fromRGBO(
                  154, 1, 29, 1.0),),
              const SizedBox(height: 10,),
              Text(model.title, style: TextStyle(fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }
}
