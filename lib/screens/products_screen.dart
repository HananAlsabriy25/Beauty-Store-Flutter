import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_providers.dart';
import '../models/product.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    // جلب البيانات عند فتح التطبيق (طلب الدكتور الأول)
    Future.delayed(Duration.zero).then((_) {
      Provider.of<ShopProvider>(context, listen: false).fetchAndSetProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    // تعريف shopData للوصول لبيانات الـ Provider
    final shopData = Provider.of<ShopProvider>(context);
    final products = shopData.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('متجر الجمال'),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      // استخدام isLoading لإظهار دائرة التحميل (طلب الدكتور الثالث)
      body: shopData.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.pink))
          : products.isEmpty
              ? const Center(child: Text('لا توجد منتجات حالياً، تأكد من الإنترنت'))
              : GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (ctx, i) {
                    final product = products[i];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.black87,
                          // زر المفضلة (طلب الدكتور الثاني)
                          leading: IconButton(
                            icon: Icon(
                              product.isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.pink,
                            ),
                            onPressed: () {
                              shopData.toggleFavorite(product.id);
                            },
                          ),
                          title: Text(
                            product.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 10),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.shopping_cart, color: Colors.pink),
                            onPressed: () {
                              shopData.addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('تمت إضافة ${product.title} للسلة')),
                              );
                            },
                          ),
                        ),
                        // عرض الصورة من الـ API (طلب الدكتور)
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, error, stackTrace) => const Icon(Icons.broken_image),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}