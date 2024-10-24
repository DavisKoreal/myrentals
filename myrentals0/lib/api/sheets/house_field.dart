class HouseFields{
  static const String id = 'id';
  static const String hasPaid = 'hasPaid';
  static const String houseAccount = 'houseAccount';
  static const String buildingName = 'buildingName';
  static const String rentPayable = 'rentPayable';
  static const String tenantName = 'tenantName';
  static const tenantContact = 'tenantContact';

  static List<String> getFields ()=> [id,hasPaid,houseAccount,buildingName,rentPayable,tenantName,tenantContact];
}