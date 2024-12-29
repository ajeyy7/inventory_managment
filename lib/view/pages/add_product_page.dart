import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_managment/model/hive_model.dart';
import 'package:inventory_managment/view/pages/components/common_button.dart';
import 'package:inventory_managment/view/pages/components/my_textfiled.dart';
import 'package:inventory_managment/view_model/inventory_vm.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<String> getImagePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getImagePath();
      final imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imagePath = '$directory/$imageName';

      final image = File(pickedFile.path);
      image.copySync(imagePath);

      setState(() {
        _selectedImage = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<InventoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyTextField(
                name: 'Product ID',
                hintText: 'Enter Product ID',
                controller: _idController,
              ),
              MyTextField(
                name: 'Product Name',
                hintText: 'Enter Product Name',
                controller: _nameController,
              ),
              MyTextField(
                name: 'Description',
                hintText: 'Enter Description',
                controller: _descriptionController,
              ),
              MyTextField(
                name: 'Stock Count',
                hintText: 'Enter Stock Count',
                controller: _stockController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _selectedImage == null
                  ? CommonButton(
                      color: Colors.black,
                      widget: Text(
                        'Pick Image',
                        style: TextStyle(color: Colors.white),
                      ),
                      width: 320,
                      onTap: _pickImage)
                  : Image.file(
                      _selectedImage!,
                      height: 100,
                      width: 100,
                    ),
              const SizedBox(height: 20),
              CommonButton(
                  color: Colors.black,
                  widget: Text(
                    'Save Product',
                    style: TextStyle(color: Colors.white),
                  ),
                  width: 320,
                  onTap: ()  {
                    if (_selectedImage != null) {
                      final product = Product(
                        deviceId: viewModel.deviceId,
                        productId: _idController.text,
                        name: _nameController.text,
                        description: _descriptionController.text,
                        supervisorName: 'John Doe',
                        inventoryDate: DateTime.now(),
                        currentStock: int.parse(_stockController.text),
                        productPhoto: _selectedImage!.path,
                      );
                       viewModel.addProduct(product);
                       
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
