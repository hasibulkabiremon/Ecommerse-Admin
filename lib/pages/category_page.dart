import 'package:ec_com_admin_01/provider/product_provider.dart';
import 'package:ec_com_admin_01/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';

import '../utils/helper_function.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category';

  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSingleInputDialog(
            context: context,
            title: 'Category',
            positiveButtonText: 'ADD',
            onSubmit: (value) {
              Provider.of<ProductProvider>(context, listen: false).addNewCategory(value);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: NewGradientAppBar(
        title: const Text('Categories'),
        gradient: gradient(),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.categoryList.length,
          itemBuilder: (context, index) {
            final catModel = provider.categoryList[index];
            return ListTile(
              title: Text(catModel.categoryName),
              trailing: Text('Total: ${catModel.productCount}'),
            );
          },
        ),
      ),
    );
  }
}
