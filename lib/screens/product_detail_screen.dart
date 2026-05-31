import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_providers.dart';
import '../models/product.dart'; // هذا السطر مهم جداً

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    // استقبال الـ ID (تأكدي أنكِ ترسلين ID من الشاشة الرئيسية)
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    
    final loadedProduct = Provider.of<ShopProvider>(context, listen: false)
        .products
        .firstWhere((prod) => prod.id == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl, 
                fit: BoxFit.contain, // لجعل صورة المنتج تظهر كاملة
                errorBuilder: (ctx, err, stack) => Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${loadedProduct.price} \$',
              style: const TextStyle(fontSize: 25, color: Colors.pink, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}