import 'dart:io';
import 'package:flutter/material.dart';
import 'package:inventory_managment/view/pages/components/common_button.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final String name;
  final String description;
  final String supervisorName;
  final String firstInventoryDate;
  final String stock;
  final String imageUrl;
  final String userId;
  void Function() updateStock;
  final String username;
  final String designation;
  final String companyName;
  final String deviceId;

  ProductCard({
    super.key,
    required this.updateStock,
    required this.productId,
    required this.name,
    required this.description,
    required this.supervisorName,
    required this.firstInventoryDate,
    required this.stock,
    required this.imageUrl,
    required this.userId,
    required this.username,
    required this.designation,
    required this.companyName,
    required this.deviceId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product ID: $productId',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imageUrl.isNotEmpty
                      ? Image.file(
                          File(imageUrl),
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: Colors.grey,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Supervisor: $supervisorName',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'First Inventory Date: $firstInventoryDate',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Current Stock: $stock',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 8),
            Text(
              'User ID: $userId',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Text(
              'Username: $username',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Text(
              'Designation: $designation',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Text(
              'Company: $companyName',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Text(
              'Device ID: $deviceId',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            CommonButton(
                color: Colors.black,
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      'Update Stock',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                width: 200,
                onTap: updateStock),
          ],
        ),
      ),
    );
  }
}
