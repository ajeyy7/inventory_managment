class Product {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String inventoryDate;
  final String supervisorName;
  int stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.inventoryDate,
    required this.supervisorName,
    required this.stock,
  });
}

class User {
  final String id;
  final String username;
  final String designation;
  final String companyName;
  final String deviceId;

  User({
    required this.id,
    required this.username,
    required this.designation,
    required this.companyName,
    required this.deviceId,
  });
}
