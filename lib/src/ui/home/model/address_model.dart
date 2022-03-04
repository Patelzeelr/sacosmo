class DeliveryAddressModel {
  String title;
  String firstName;
  String lastName;
  String mobileNo;
  String alternateMobileNo;
  String scoirty;
  String street;
  String landMark;
  String city;
  String aera;
  String pinCode;
  String addressType;

  DeliveryAddressModel(
    this.title,
    this.addressType,
    this.aera,
    this.alternateMobileNo,
    this.city,
    this.firstName,
    this.landMark,
    this.lastName,
    this.mobileNo,
    this.pinCode,
    this.street,
    this.scoirty,
  );
}
