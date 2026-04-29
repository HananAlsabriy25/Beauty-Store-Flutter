import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import '../providers/shop_providers.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {

    final shopProvider = Provider.of<ShopProvider>(context);
    final isFavorite = shopProvider.favoriteItems.any((element) => element['name'] == product['name']);
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']!),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           
            Image.asset(
              product['image']!, 
              fit: BoxFit.cover, 
              width: double.infinity, 
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Expanded(
                        child: Text(
                          product['name']!, 
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      
                      IconButton(
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                        color: Colors.red,
                        onPressed: () {
                          shopProvider.toggleFavorite(product as Map<String, String>);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  Text(
                    product['price']!, 
                    style: const TextStyle(fontSize: 20, color: Colors.pink, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'الوصف:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                 
                  Text(
                    product['desc']!, 
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}