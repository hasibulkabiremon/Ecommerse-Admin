import 'package:cached_network_image/cached_network_image.dart';
import 'package:ec_com_admin_01/models/product_model.dart';
import 'package:ec_com_admin_01/pages/product_repurchase_page.dart';
import 'package:ec_com_admin_01/utils/constants.dart';
import 'package:ec_com_admin_01/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';

import '../customwidget/image_holder_view.dart';
import '../provider/product_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName = '/product_details';

  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel productModel;
  late ProductProvider productProvider;

  @override
  void didChangeDependencies() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text(productModel.productName!),
        gradient: gradient(),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 200,
            imageUrl: productModel.thumbnailImageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(
            height: 100,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageHolderView(
                    onImagePressed: (url) {
                      _showImageDialoge(0);
                    },
                    url: productModel.additionalImage[0],
                    child: IconButton(
                      onPressed: () {
                        _addImage(0);
                      },
                      icon: Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                  ImageHolderView(
                      onImagePressed: (url) {
                        _showImageDialoge(1);
                      },
                      url: productModel.additionalImage[1],
                      child: IconButton(
                        onPressed: () {
                          _addImage(1);
                        },
                        icon: Icon(
                          Icons.add,
                        ),
                      )),
                  ImageHolderView(
                      onImagePressed: (url) {
                        _showImageDialoge(2);
                      },
                      url: productModel.additionalImage[2],
                      child: IconButton(
                        onPressed: () {
                          _addImage(2);
                        },
                        icon: Icon(
                          Icons.add,
                        ),
                      )),
                ],
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(
                  context, ProductRepurchasePage.routeName,
                  arguments: productModel),
              child: const Text('Re-Purchase'),
            ),
            OutlinedButton(
                onPressed: _showPurchaseList,
                child: const Text('Purchase History'))
          ]),
          ListTile(
            title: Text(productModel.productName!),
            subtitle: Text(productModel.category.categoryName),
          ),
          ListTile(
            title: Text('Sale Price: $currencySymbol${productModel.salePrice}'),
            subtitle: Text('Stock : ${productModel.stock}'),
          ),
          SwitchListTile(
            value: productModel.available,
            onChanged: (value) {
              setState(() {
                productModel.available = !productModel.available;
              });
              productProvider.updateProductField(productModel.productId!,
                  productFieldAvailable, productModel.available);
            },
            title: Text('Available'),
          ),
          SwitchListTile(
            value: productModel.featured,
            onChanged: (value) {
              setState(() {
                productModel.featured = !productModel.featured;
              });
              productProvider.updateProductField(productModel.productId!,
                  productFieldFeatured, productModel.featured);
            },
            title: Text('Featured'),
          ),
        ],
      ),
    );
  }

  void _showPurchaseList() {
    showModalBottomSheet(
        constraints: BoxConstraints(maxHeight: 300),
        context: context,
        builder: (context) {
          final purchaseList =
              productProvider.getPurchaseById(productModel.productId!).toList();
          return Container(
            margin: const EdgeInsets.all(20),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: purchaseList.length,
              itemBuilder: (context, index) {
                final purchaseModel = purchaseList[index];
                return ListTile(
                  title: Text(getFormattedDate(
                      purchaseModel.dateModel.timestamp.toDate())),
                  subtitle:
                      Text('$currencySymbol${purchaseModel.purchasePrice}'),
                  trailing: Text('Qty : ${purchaseModel.purchaseQuantity}'),
                );
              },
            ),
          );
        });
  }

  void _addImage(int index) async {
    final selectedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (selectedFile != null) {
      EasyLoading.show(status: 'Please wait');
      try {
        final downloadUrl =
            await productProvider.uploadImage(selectedFile.path);
        final previousList = productModel.additionalImage;
        previousList[index] = downloadUrl;
        await productProvider.updateProductField(
            productModel.productId!, productFieldImage, previousList);
        setState(() {
          productModel.additionalImage[index] = downloadUrl;
        });
        EasyLoading.dismiss();
        if (mounted) showMsg(context, 'Upload Successfully');
      } catch (error) {
        EasyLoading.dismiss();
        if (mounted) showMsg(context, 'Upload Failed');
        rethrow;
      }
    }
  }

  void _showImageDialoge(int index) {
    final url = productModel.additionalImage[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: CachedNetworkImage(
          height: MediaQuery.of(context).size.height / 2,
          imageUrl: url,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
          IconButton(
            onPressed: () async {
              Navigator.pop(context);
              EasyLoading.show(status: 'Deleting....');
              try {
                await productProvider.deleteImage(url);
                setState(() {
                  productModel.additionalImage[index] = '';
                });
                await productProvider.updateProductField(
                  productModel.productId!,
                  productFieldImage,
                  productModel.additionalImage,
                );
              } catch (error) {}
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
