import 'package:hive/hive.dart';
part 'hive_model.g.dart';
@HiveType(typeId:0)
class Product extends HiveObject{
  @HiveField(0)
  final String? productId;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final DateTime? inventoryDate;
  @HiveField(4)
  final int? currentStock;
  @HiveField(5)
  final String? productPhoto;
  @HiveField(6)
  final String? supervisorName;
   Product( {
    required this.supervisorName,
    required this.productId,
    required this.name,
    required this.description,
    required this.inventoryDate,
    required this.currentStock,
    required this.productPhoto,
  });
}