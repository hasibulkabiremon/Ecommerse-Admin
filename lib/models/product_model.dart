import 'package:ec_com_admin_01/models/catagory_model.dart';

const String collectionProduct = 'products';
const String productFieldId = 'productId';
const String productFieldName = 'productName';
const String productFieldCategory = 'category';
const String productFieldShortDescriotion = 'shortDescription';
const String productFieldLongDescriotion = 'LongDescription';
const String productFieldSalePrice = 'salePrice';
const String productFieldStock = 'stock';
const String productFieldAvgRating = 'avgRating';
const String productFieldDiscount = 'discount';
const String productFieldThumdnail = 'thumbnail';
const String productFieldImage = 'images';
const String productFieldAvailable = 'available';
const String productFieldFeatured = 'featured';

class ProductModel {
  String? productId;
  String? productName;
  CategoryModel category;
  String? shortDescription;
  String? longDescription;
  num salePrice;
  num stock;
  num avgRating;
  num productDiscount;
  String thumbnailImageUrl;
  List<String> additionalImage;
  bool available;
  bool featured;

  ProductModel(
      {this.productId,
      required this.productName,
      required this.category,
      this.shortDescription,
      this.longDescription,
      required this.salePrice,
      this.avgRating = 0.0,
      required this.stock,
      this.productDiscount = 0,
      required this.thumbnailImageUrl,
      required this.additionalImage,
      this.available = true,
      this.featured = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      productFieldId: productId,
      productFieldName: productName,
      productFieldCategory: category.toMap(),
      productFieldShortDescriotion: shortDescription,
      productFieldLongDescriotion: longDescription,
      productFieldDiscount: productDiscount,
      productFieldSalePrice: salePrice,
      productFieldStock: stock,
      productFieldAvgRating :avgRating,
      productFieldThumdnail: thumbnailImageUrl,
      productFieldImage: additionalImage,
      productFieldAvailable: available,
      productFieldFeatured: featured,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
        productId: map[productFieldId],
        productName: map[productFieldName],
        category: CategoryModel.fromMap(map[productFieldCategory]),
        shortDescription: map[productFieldShortDescriotion],
        longDescription: map[productFieldLongDescriotion],
        salePrice: map[productFieldSalePrice],
        stock: map[productFieldStock],
        avgRating: map[productFieldAvgRating],
        productDiscount: map[productFieldDiscount],
        thumbnailImageUrl: map[productFieldThumdnail],
        additionalImage: map[productFieldImage] == null ? ['','',''] : (map[productFieldImage] as List).map((e) => e as String).toList(),
        available: map[productFieldAvailable],
        featured: map[productFieldFeatured],
      );
}
