const String collectionCategory = 'category';
const String categoryFieldId = 'id';
const String categoryFieldName = 'name';
const String categoryFieldProductCount = 'product_count';

class CategoryModel {
  String? categoryId;
  String categoryName;
  num productCount;

  CategoryModel({
    this.categoryId,
    required this.categoryName,
    this.productCount = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      categoryFieldId: categoryId,
      categoryFieldName: categoryName,
      categoryFieldProductCount: productCount,
    };
  }

  factory CategoryModel.fromMap(Map<String,dynamic>map)=>CategoryModel(
    categoryId: map[categoryFieldId],
    categoryName: map[categoryFieldName],
    productCount: map[categoryFieldProductCount],
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId;

  @override
  int get hashCode => categoryId.hashCode;
}
