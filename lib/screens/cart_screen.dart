import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_providers.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final shopProvider = Provider.of<ShopProvider>(context);
    final cartItems = shopProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة المشتريات'),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'سلتك فارغة، ابدأ بالتسوق الآن!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (ctx, i) => Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(cartItems[i]['image']!),
                        ),
                        title: Text(cartItems[i]['name']!),
                        subtitle: Text('السعر: ${cartItems[i]['price']}'),
                       trailing: IconButton(
                       icon: const Icon(Icons.remove_circle, color: Colors.red),
                       onPressed: () {
                      
                       shopProvider.removeFromCart(cartItems[i]);
    
                       
                       ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                       content: Text('تم حذف المنتج من السلة'),
                       duration: Duration(seconds: 1),
                         ),
                        );
                      },
                  ),
                      ),
                    ),
                  ),
                ),
                
Container(
  padding: const EdgeInsets.all(20),
  child: Column(
    children: [

      Text(
        'إجمالي المبلغ: \$${shopProvider.totalPrice.toStringAsFixed(2)}', 
        style: const TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold, 
          color: Colors.pink
        ),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
  onPressed: () {
   
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم إرسال طلبك بنجاح!', textAlign: TextAlign.right),
        backgroundColor: Colors.pink,
        duration: Duration(seconds: 2),
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.pink,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  child: const Text(
    'إتمام الشراء',
    style: TextStyle(color: Colors.white, fontSize: 18),
  ),
),
    ],
  ),
),
              ],
            ),
    );
  }
}