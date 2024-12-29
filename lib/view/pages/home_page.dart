import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_managment/view/pages/add_product_page.dart';
import 'package:inventory_managment/view/pages/components/my_textfiled.dart';
import 'package:inventory_managment/view/pages/components/product_card.dart';
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MyTextField(
                  hintText: 'Search Products',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: Icon(Icons.qr_code_2_outlined)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.products.length,
                    itemBuilder: (context, index) {
                      final product = viewModel.products[index];
                      final DateFormat formatter = DateFormat('dd-MM-yyyy');
                      final formattedDate =
                          formatter.format(product.inventoryDate);
                      return ProductCard(
                        companyName: 'sdsdsd',
                        designation: 'ceo',
                        deviceId: product.deviceId??'',
                        firstInventoryDate: formattedDate,
                        stock: 'sd',
                        userId: 'userid',
                        username: 'name',
                        imageUrl: product.productPhoto,
                        name: product.name,
                        description: product.description,
                        supervisorName: product.supervisorName,
                        price: '200',
                        productId: 'fdgfdg',
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
