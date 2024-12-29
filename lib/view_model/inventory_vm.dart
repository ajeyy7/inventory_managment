import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_managment/model/hive_model.dart';
import 'package:path_provider/path_provider.dart';

class InventoryViewModel extends ChangeNotifier {
  late Box<Product> _productBox;

  String _deviceId = '';
  File? selectedImage;

  // Internal lists for managing products
  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  String get deviceId => _deviceId;

  // Exposed list for UI
  List<Product> get products => _filteredProducts;

  // Initialize ViewModel
  Future<void> init() async {
    _productBox = await Hive.openBox<Product>('products');
    _products = _productBox.values.toList();
    _filteredProducts = List.from(_products);
    await _getDeviceId();
    notifyListeners();
  }

  // Filter products based on query
  void filterProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = List.from(_products);
    } else {
      _filteredProducts = _products
          .where((product) =>
              product.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    }
    notifyListeners();
  }

  // Retrieve device ID
  Future<void> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await deviceInfo.androidInfo;
      _deviceId = androidInfo.id!;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await deviceInfo.iosInfo;
      _deviceId = iosInfo.identifierForVendor!;
    }
  }

  // Add a new product
  Future<void> addProduct(Product product) async {
    await _productBox.add(product);
    _products.add(product); // Update internal list
    filterProducts(''); // Refresh filtered list
    notifyListeners();
  }

  // Get image path
  Future<String> getImagePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Pick an image
  Future<void> pickImage(ImagePicker picker) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getImagePath();
      final imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imagePath = '$directory/$imageName';

      final image = File(pickedFile.path);
      image.copySync(imagePath);

      selectedImage = File(imagePath);
      notifyListeners();
    }
  }

  // Clear selected image
  void clearSelectedImage() {
    selectedImage = null;
    notifyListeners();
  }

  // Update stock of a product
  Future<void> updateStock(String productId, int newStock) async {
    final index = _products.indexWhere((product) => product.productId == productId);
    if (index != -1) {
      final product = _products[index];
      final updatedProduct = Product(
        supervisorName: product.supervisorName,
        productId: product.productId,
        name: product.name,
        description: product.description,
        inventoryDate: product.inventoryDate,
        currentStock: newStock,
        productPhoto: product.productPhoto,
      );
      await _productBox.putAt(index, updatedProduct);

      // Update internal lists
      _products[index] = updatedProduct;
      filterProducts(''); // Refresh filtered list
    }
    notifyListeners();
  }
}
