import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_providers.dart';
import 'product_detail_screen.dart'; 

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;

  CategoryProductsScreen({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // جلب المنتجات من الـ Provider وتصفيتها حسب الفئة (التعديل الأهم)
    final shopProvider = Provider.of<ShopProvider>(context);
    final filteredProducts = shopProvider.products
        .where((prod) => prod.category == categoryName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: filteredProducts.isEmpty 
      ? const Center(child: Text('لا توجد منتجات في هذه الفئة حالياً'))
      : GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.82, 
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (ctx, i) {
          final product = filteredProducts[i]; // استخدام كائن المنتج المحدث
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(), // تأكدي من تعديل شاشة التفاصيل لاستقبال ID
                  settings: RouteSettings(arguments: product.id),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network( // التغيير لـ Image.network لدعم الـ API
                        product.imageUrl, 
                        fit: BoxFit.cover, 
                        width: double.infinity,
                        errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 6, 8, 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          product.description,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        const SizedBox(height: 4), 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${product.price} \$', 
                              style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 13)
                            ),
                            GestureDetector(
                              onTap: () {
                                // دالة الإضافة للسلة المحدثة
                                shopProvider.addToCart(product);
                                ScaffoldMessenger.of(ctx).showSnackBar(
                                  SnackBar(
                                    content: Text('تمت إضافة ${product.title} بنجاح!', textAlign: TextAlign.right),
                                    backgroundColor: Colors.green,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: const Icon(Icons.add_shopping_cart, color: Colors.pink, size: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6), 
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}