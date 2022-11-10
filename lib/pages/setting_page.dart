import 'package:ec_com_admin_01/models/order_constant_model.dart';
import 'package:ec_com_admin_01/provider/order_provider.dart';
import 'package:ec_com_admin_01/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings_page';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _discountCOntroller = TextEditingController();
  final _vatController = TextEditingController();
  final _deliveryChargeController = TextEditingController();
  late OrderProvider orderProvider;

  @override
  void didChangeDependencies() {
    orderProvider = Provider.of<OrderProvider>(context);
    _discountCOntroller.text =
        orderProvider.orderConstantModel.discount.toString();
    _vatController.text = orderProvider.orderConstantModel.vat.toString();
    _deliveryChargeController.text =
        orderProvider.orderConstantModel.deliveryCharge.toString();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _discountCOntroller.dispose();
    _vatController.dispose();
    _deliveryChargeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text('Settings'),
        gradient: gradient(),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _discountCOntroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Discount %',
                    prefixIcon: Icon(Icons.discount),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _vatController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Vat %',
                    prefixIcon: Icon(Icons.discount),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _deliveryChargeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Delivery Charge',
                    prefixIcon: Icon(Icons.discount),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field must not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: _saveInfo,
                  child: const Text('Update'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveInfo() {
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: 'Updating...');
      final model = OrderConstantModel(
        deliveryCharge: num.parse(_deliveryChargeController.text),
        vat: num.parse(_vatController.text),
        discount: num.parse((_discountCOntroller.text))
      );
      orderProvider.updateOrderConstants(model).then((value) {
        EasyLoading.dismiss();
        showMsg(context, "Updated");
      }).catchError((error){
        EasyLoading.dismiss();
        showMsg(context, 'Failed to update');
      });
    }
  }
}
