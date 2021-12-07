class DeliveryAddressModel {
  String ?fullName;
  String ?Governorate;
  String ?A_Place_NearYou;
  String ?PhoneNumber;
  String ?city;
  String ?pinCode;
  String ?addressType;

  DeliveryAddressModel({
    this.addressType,
    this.fullName,
    this.Governorate,
    this.city,
    this.A_Place_NearYou,
    this.pinCode,
    this.PhoneNumber,
  });
}