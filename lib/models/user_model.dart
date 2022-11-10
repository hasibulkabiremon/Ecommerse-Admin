import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ec_com_admin_01/models/address_model.dart';

const String userField = 'user';
const String userFieldUserId = 'user_id';
const String userFieldDisplayName = 'display_name';
const String userFieldAddress = 'address_model';
const String userFieldCreationTime = 'creation_time';
const String userFieldImage = 'image';
const String userFieldGender = 'gender';
const String userFieldAge = 'age';
const String userFieldPhone = 'phone';
const String userFieldEmail = 'email';

class UserModel {
  String? userId;
  String? displayName;
  AddressModel? addressModel;
  Timestamp? userCreationTime;
  String? userImageUrl;
  String? gender;
  num? age;
  String? phone;
  String email;

  UserModel(
      {this.userId,
      this.displayName,
      this.addressModel,
      this.userCreationTime,
      this.userImageUrl,
      this.gender,
      this.age,
      this.phone,
      required this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      userFieldUserId: userId,
      userFieldDisplayName: displayName,
      userFieldAddress: addressModel?.toMap(),
      userFieldCreationTime: userCreationTime,
      userFieldImage: userImageUrl,
      userFieldGender: gender,
      userFieldAge: age,
      userFieldPhone: phone,
      userFieldEmail: email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        userId: map[userFieldUserId],
        displayName: map[userFieldDisplayName],
        addressModel: AddressModel.fromMap(map[userFieldAddress]),
        userCreationTime: map[userFieldCreationTime],
        userImageUrl: map[userFieldImage],
        gender: map[userFieldImage],
        phone: map[userFieldPhone],
        email: map[userFieldEmail],
      );
}
