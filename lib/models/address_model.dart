const String addressField = 'address';
const String addressFieldLine1 = 'address_line1';
const String addressFieldLine2 = 'address_line2';
const String addressFieldCity = 'city';
const String addressFieldZipcode = 'zipcode';

class AddressModel {
  String addressLine1;
  String? addressLine2;
  String city;
  String zipcode;

  AddressModel({
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.zipcode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      addressFieldLine1: addressLine1,
      addressFieldLine2: addressLine2,
      addressFieldCity: city,
      addressFieldZipcode: zipcode,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) => AddressModel(
        addressLine1: map[addressFieldLine1],
        addressLine2: map[addressFieldLine2],
        city: map[addressFieldCity] ?? 'Not Found',
        zipcode: map[addressFieldZipcode],
      );
}
