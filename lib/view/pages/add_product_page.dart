import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_managment/model/hive_model.dart';
import 'package:inventory_managment/view/pages/components/common_button.dart';
import 'package:inventory_managment/view/pages/components/my_textfiled.dart';
import 'package:inventory_managment/view_model/inventory_vm.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController superVisorName = TextEditingController();
  final ImagePicker picker = ImagePicker();

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
                controller: idController,
              ),
              MyTextField(
                name: 'Product Name',
                hintText: 'Enter Product Name',
                controller: nameController,
              ),
              MyTextField(
                name: 'Description',
                hintText: 'Enter Description',
                controller: descriptionController,
              ),
              MyTextField(
                name: 'supervisor Name',
                hintText: 'Enter supervisor Name',
                controller: superVisorName,
              ),
              MyTextField(
                name: 'Stock Count',
                hintText: 'Enter Stock Count',
                controller: stockController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              viewModel.selectedImage == null
                  ? CommonButton(
                      color: Colors.black,
                      widget: Text(
                        'Pick Image',
                        style: TextStyle(color: Colors.white),
                      ),
                      width: 320,
                      onTap: () {
                        viewModel.pickImage(picker);
                      })
                  : Image.file(
                      viewModel.selectedImage!,
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
                  onTap: () {
                    if (viewModel.selectedImage != null) {
                      final product = Product(
                        supervisorName: superVisorName.text.trim(),
                        productId: idController.text.trim(),
                        name: nameController.text.trim(),
                        description: descriptionController.text.trim(),
                        inventoryDate: DateTime.now(),
                        currentStock: int.parse(stockController.text),
                        productPhoto: viewModel.selectedImage!.path,
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
