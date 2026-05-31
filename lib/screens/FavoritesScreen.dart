import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_providers.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // تصفية المنتجات للحصول على المفضلة فقط
    final favoriteProducts = Provider.of<ShopProvider>(context)
        .products
        .where((prod) => prod.isFavorite)
        .toList();

    return Scaffold(
      body: favoriteProducts.isEmpty
          ? Center(child: Text('لا توجد منتجات في المفضلة'))
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: Image.network(favoriteProducts[i].imageUrl),
                title: Text(favoriteProducts[i].title),
                subtitle: Text('\$${favoriteProducts[i].price}'),
              ),
            ),
    );
  }
}