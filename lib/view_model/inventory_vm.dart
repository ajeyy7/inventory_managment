import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:inventory_managment/model/hive_model.dart';

class InventoryViewModel extends ChangeNotifier {
  late Box<Product> _productBox;
  String _deviceId = '';
  final bool _isInitialized = false;

  String get deviceId => _deviceId;

  List<Product> get products =>
      _isInitialized ? _productBox.values.toList() : [];

  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    _productBox = await Hive.openBox<Product>('products');
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _productBox.add(product);
    notifyListeners();
  }

  Product? searchProduct(String productId) {
    try {
      return _productBox.values
          .firstWhere((product) => product.productId == productId);
    } catch (e) {
      return null;
    }
  }
}
