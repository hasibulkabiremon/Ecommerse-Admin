import 'package:ec_com_admin_01/models/user_model.dart';

const String ratingModel = 'rating_model';
const String ratingModelRatingId = 'rating_id';
const String ratingModelUser = 'user';
const String ratingModelProductId = 'product_id';
const String ratingModelRating = 'rating';

class RatingModel {
  String rid;
  UserModel user;
  String productId;
  num rating;

  RatingModel({
    required this.rid,
    required this.user,
    required this.productId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ratingModelRatingId: rid,
      ratingModelUser: user.toMap(),
      ratingModelProductId: productId,
      ratingModelRating: rating,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic>map) =>
      RatingModel(rid: map[ratingModelRatingId],
        user: UserModel.fromMap(map[ratingModelUser]),
        productId: map[ratingModelProductId],
        rating: map[ratingModelRating],
      );
}
