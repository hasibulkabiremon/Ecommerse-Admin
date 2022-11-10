import 'package:cached_network_image/cached_network_image.dart';
import 'package:ec_com_admin_01/models/catagory_model.dart';
import 'package:ec_com_admin_01/pages/product_details_page.dart';
import 'package:ec_com_admin_01/provider/product_provider.dart';
import 'package:ec_com_admin_01/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';

class ViewProductPage extends StatefulWidget {
  static const String routeName = '/view_product';

  const ViewProductPage({Key? key}) : super(key: key);

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  late ProductProvider productProvider;
  CategoryModel? categoryModel;

  @override
  void didChangeDependencies() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.getAllProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: const Text('Products'),
        gradient: gradient(),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Consumer<ProductProvider>(
                builder: (context, provider, child) => DropdownButtonFormField(
                  hint: const Text('Select Category'),
                  value: categoryModel,
                  isExpanded: true,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                  items: provider
                      .getCategoryListForFiltering()
                      .map((catModel) => DropdownMenuItem(
                          value: catModel, child: Text(catModel.categoryName)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      categoryModel = value;
                    });
                    provider.getAllProductsByCategory(categoryModel!);
                  },
                ),
              ),
              provider.productList.isEmpty
                  ? Expanded(
                      child: const Center(
                        child: Text('No Product Found'),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                      itemCount: provider.productList.length,
                      itemBuilder: (context, index) {
                        final product = provider.productList[index];
                        return ListTile(
                          onTap: () => Navigator.pushNamed(
                              context, ProductDetailsPage.routeName,
                              arguments: product),
                          leading: CachedNetworkImage(
                            width: 75,
                            imageUrl: product.thumbnailImageUrl,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          subtitle: Text(product.category.categoryName),
                          trailing: Text('Sock:${product.stock}'),
                          title: Text(product.productName!),
                        );
                      },
                    ))
            ],
          );
        },
      ),
    );
  }
}
