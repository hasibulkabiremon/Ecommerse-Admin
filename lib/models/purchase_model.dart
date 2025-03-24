import 'date_model.dart';

const String collectionPurchase = 'purchase';
const String purchaseFieldPurchaseId = 'purchase_id';
const String purchaseFieldProductId = 'product_id';
const String purchaseFieldQuantity = 'quantity';
const String purchaseFieldPrice = 'price';
const String purchaseFieldDateModel = 'date_model';

class PurchaseModel {
  String? purchaseId;
  String? productId;
  num purchaseQuantity;
  num purchasePrice;
  DateModel dateModel;

  PurchaseModel({
    this.purchaseId,
    this.productId,
    required this.purchaseQuantity,
    required this.purchasePrice,
    required this.dateModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      purchaseFieldPurchaseId: purchaseId,
      purchaseFieldProductId: productId,
      purchaseFieldQuantity: purchaseQuantity,
      purchaseFieldPrice: purchasePrice,
      purchaseFieldDateModel: dateModel.toMap(),
    };
  }

  factory PurchaseModel.fromMap(Map<String, dynamic> map) => PurchaseModel(
        purchaseId: map[purchaseFieldPurchaseId],
        productId: map[purchaseFieldProductId],
        purchaseQuantity: map[purchaseFieldQuantity],
        purchasePrice: map[purchaseFieldPrice],
        dateModel: DateModel.fromMap(map[purchaseFieldDateModel]),
      );
}
