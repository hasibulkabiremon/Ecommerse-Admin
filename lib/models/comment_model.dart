import 'package:ec_com_admin_01/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String commentModel = 'comment';
const String commentModelId = 'id';
const String commentModelUser = 'user';
const String commentModelPoductId = 'product_id';
const String commentModelComment = 'comment';
const String commentModelApproved = 'approved';

class CommentModel {
  String cid;
  UserModel user;
  String proid;
  String comment;
  bool approved = false;

  CommentModel({
    required this.cid,
    required this.user,
    required this.proid,
    required this.comment,
    required this.approved,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      commentModelId: cid,
      commentModelUser: user.toMap(),
      commentModelPoductId: proid,
      commentModelComment: comment,
      commentModelApproved: approved,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic>map) =>
      CommentModel(
        cid: map[commentModelId],
        user: UserModel.fromMap(map[commentModelUser]),
        proid: map[commentModelPoductId],
        comment: map[commentModelComment],
        approved: map[commentModelApproved],
      );
}
