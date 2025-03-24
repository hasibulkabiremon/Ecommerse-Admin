import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<bool> isConnectedToInternet() async {
  var result = await (Connectivity().checkConnectivity());
  return result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile);
}

showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(msg)));

getFormattedDate(DateTime dt,{String pattern = 'dd/MM/yyyy'}) =>
    DateFormat(pattern).format(dt);

gradient() {
  return LinearGradient(colors: [Colors.blue, Colors.purple,Colors.teal]);
}

Duration getDifference(DateTime dt)  {
  return DateTime.now().difference(dt);
}

