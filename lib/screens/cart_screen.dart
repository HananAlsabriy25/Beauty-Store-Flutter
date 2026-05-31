import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_providers.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<ShopProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة المشتريات'),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'السلة فارغة حالياً 🛒',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (ctx, i) {
                      final quantity = cartItems[i]['quantity'] ?? 1;
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: Image.network(
                            cartItems[i]['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(cartItems[i]['title']),
                          subtitle: Text(
                            '\$${cartItems[i]['price']} × $quantity',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // زر الإنقاص
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                onPressed: () => cartProvider.decreaseQuantity(i),
                              ),
                              Text(
                                '$quantity',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              // زر الزيادة
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                onPressed: () => cartProvider.increaseQuantity(i),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // كرت عرض المجموع النهائي وزر الشراء
                Card(
                  margin: const EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'المجموع:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            cartProvider.clearCart();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم إتمام الطلب بنجاح! 🎉')),
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                          child: const Text('اطلب الآن', style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}