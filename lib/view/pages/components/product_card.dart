import 'dart:io';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final String name;
  final String description;
  final String supervisorName;
  final String firstInventoryDate;
  final String stock;
  final String imageUrl;
  final String userId;
  final String username;
  final String designation;
  final String companyName;
  final String deviceId;

  const ProductCard({
    super.key,
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
    required String price,
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
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
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
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(color: Colors.grey[700]),
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

            // Action Button to Update Stock
            ElevatedButton(
              onPressed: () {
                // Handle stock update action
                // For example, show a dialog to update stock or navigate to another screen
              },
              child: Text('Update Stock'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                // primary: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
