import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_managment/view/pages/add_product_page.dart';
import 'package:inventory_managment/view/pages/components/common_button.dart';
import 'package:inventory_managment/view/pages/components/my_textfiled.dart';
import 'package:inventory_managment/view/pages/components/product_card.dart';
import 'package:inventory_managment/view/pages/components/qr_page.dart';
import 'package:inventory_managment/view_model/inventory_vm.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<InventoryViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_rounded),
        title: Text(
          'Inventory Management',
          style: TextStyle(fontSize: 19),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProductPage()));
              },
              icon: Icon(Icons.add)),
          Icon(Icons.more_vert_outlined),
        ],
      ),
      body: FutureBuilder(
        future: viewModel.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Consumer<InventoryViewModel>(
              builder: (context, viewModel, child) {
            if (viewModel.products.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No products available'),
                  const SizedBox(height: 30),
                  CommonButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddProductPage()));
                      },
                      color: Colors.black,
                      widget: Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                      width: 200)
                ],
              ));
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  MyTextField(
                    onChanged: (value) {
                      viewModel.filterProducts(value);
                    },
                    hintText: 'Search Products',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          final scannedCode = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QRCodeScannerPage()),
                          );
                          if (scannedCode != null) {
                            viewModel.filterProducts(scannedCode);
                          }
                        },
                        icon: Icon(Icons.qr_code_2_outlined)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.products.length,
                      itemBuilder: (context, index) {
                        final product = viewModel.products[index];
                        final DateFormat formatter = DateFormat('dd-MM-yyyy');
                        final formattedDate =
                            formatter.format(product.inventoryDate!);
                        return ProductCard(
                          updateStock: () async {
                            final newStock = await showDialog<int>(
                              context: context,
                              builder: (context) {
                                final controller = TextEditingController();
                                return AlertDialog(
                                  title: Text('Update Stock'),
                                  content: SizedBox(
                                    height: 100,
                                    child: MyTextField(
                                      hintText: 'Enter new stock count',
                                      controller: controller,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  actions: [
                                    CommonButton(
                                      color: Colors.black,
                                      widget: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      width: 100,
                                      onTap: () => Navigator.pop(context),
                                    ),
                                    CommonButton(
                                      color: Colors.black,
                                      widget: Text(
                                        'Update',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      width: 100,
                                      onTap: () {
                                        final stock =
                                            int.tryParse(controller.text);
                                        Navigator.pop(context, stock);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            if (newStock != null) {
                              viewModel.updateStock(
                                  product.productId!, newStock);
                            }
                          },
                          companyName: 'sdsdsd',
                          designation: 'Stock Manager',
                          deviceId: viewModel.deviceId,
                          firstInventoryDate: formattedDate,
                          stock: product.currentStock.toString(),
                          userId: 'Ajay77',
                          username: 'Ajay',
                          imageUrl: product.productPhoto ?? '',
                          name: product.name ?? '',
                          description: product.description ?? '',
                          supervisorName: product.supervisorName ?? '',
                          productId: product.productId ?? '',
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
