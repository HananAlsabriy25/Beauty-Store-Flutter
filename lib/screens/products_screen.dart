import 'package:flutter/material.dart';
import 'category_products_screen.dart';
class ProductsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'عطور راقية', 'image': 'assets/images/perf1.jpg', 'color': Colors.pink[50]},
    {'name': 'مكياج احترافي', 'image': 'assets/images/make1.jpg', 'color': Colors.purple[50]},
    {'name': 'عناية بالبشرة', 'image': 'assets/images/skin1.jpg', 'color': Colors.blue[50]},
    {'name': 'عناية بالشعر', 'image': 'assets/images/hair1.jpg', 'color': Colors.green[50]},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('متجر الجمال - الأقسام'),
        backgroundColor: Colors.pink,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {}, 
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            childAspectRatio: 1,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: categories.length,
          itemBuilder: (ctx, i) => InkWell(
           onTap: () {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => CategoryProductsScreen(
        categoryName: categories[i]['name'], 
      ),
    ),
  );
},
            child: Container(
              decoration: BoxDecoration(
                color: categories[i]['color'],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.pink.withOpacity(0.2)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        categories[i]['image'], 
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    categories[i]['name'],
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}