import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_providers.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final shopProvider = Provider.of<ShopProvider>(context);
    final favorites = shopProvider.favoriteItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('منتجاتي المفضلة'),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'لم تقومي بإضافة أي منتج للمفضلة بعد!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: Image.asset(favorites[i]['image']!, width: 50),
                title: Text(favorites[i]['name']!),
                subtitle: Text(favorites[i]['price']!),
                trailing: const Icon(Icons.favorite, color: Colors.red),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: favorites[i]),
                    ),
                  );
                },
              ),
            ),
    );
  }
}