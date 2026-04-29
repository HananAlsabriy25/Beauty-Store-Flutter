
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_providers.dart';
import 'product_detail_screen.dart'; 

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;

  // قائمة المنتجات
  final List<Map<String, String>> allProducts = [
    // 1. قسم العطور
    {'name': 'عطر ديور الوردي', 'price': '55 \$', 'image': 'assets/images/perf1.jpg', 'cat': 'عطور راقية', 'desc': 'نفحات زهور فرنسية راقية.'},
    {'name': 'دهن العود الملكي', 'price': '65 \$', 'image': 'assets/images/perf2.jpg', 'cat': 'عطور راقية', 'desc': 'فخامة التراث الشرقي الأصيل.'},
    {'name': 'مسك النظافة', 'price': '40 \$', 'image': 'assets/images/perf3.jpg', 'cat': 'عطور راقية', 'desc': 'انتعاش يدوم طويلاً.'},
    {'name': 'معطر جسم لوكس', 'price': '20 \$', 'image': 'assets/images/perf4.jpg', 'cat': 'عطور راقية', 'desc': 'نعومة وحيوية لبشرتكِ.'},
    
    // 2. قسم المكياج
    {'name': 'أحمر شفاه ملكي', 'price': '15 \$', 'image': 'assets/images/make1.jpg', 'cat': 'مكياج احترافي', 'desc': 'لون غني وثبات مثالي.'},
    {'name': 'ماسكرا كثافة', 'price': '12 \$', 'image': 'assets/images/make2.jpg', 'cat': 'مكياج احترافي', 'desc': 'رموش طويلة وجذابة.'},
    {'name': 'كريم أساس ناعم', 'price': '25 \$', 'image': 'assets/images/make3.jpg', 'cat': 'مكياج احترافي', 'desc': 'تغطية طبيعية وحريرية.'},
    {'name': 'ظلال عيون ساحرة', 'price': '20 \$', 'image': 'assets/images/make4.jpg', 'cat': 'مكياج احترافي', 'desc': 'ألوان متنوعة لكل مناسبة.'},

    // 3. قسم العناية بالبشرة
    {'name': 'كريم مرطب سيرافيه', 'price': '22 \$', 'image': 'assets/images/skin1.jpg', 'cat': 'عناية بالبشرة', 'desc': 'ترطيب عميق وحماية للبشرة.'},
    {'name': 'واقي شمس شفاف', 'price': '25 \$', 'image': 'assets/images/skin2.jpg', 'cat': 'عناية بالبشرة', 'desc': 'حماية من الشمس بلا أثر دهني.'},
    {'name': 'غسول وجه رغوي', 'price': '18 \$', 'image': 'assets/images/skin3.jpg', 'cat': 'عناية بالبشرة', 'desc': 'تنظيف لطيف ومنعش.'},
    {'name': 'سيروم فيتامين C12', 'price': '35 \$', 'image': 'assets/images/skin4.jpg', 'cat': 'عناية بالبشرة', 'desc': 'إشراقة ونضارة فورية.'},

    // 4. قسم العناية بالشعر
    {'name': 'شامبو الإصلاح', 'price': '15 \$', 'image': 'assets/images/hair1.jpg', 'cat': 'عناية بالشعر', 'desc': 'تغذية عميقة للشعر المجهد.'},
    {'name': 'سيروم اللمعان', 'price': '28 \$', 'image': 'assets/images/hair2.jpg', 'cat': 'عناية بالشعر', 'desc': 'لمعان حريري ونعومة فائقة.'},
    {'name': 'زيت الأرغان', 'price': '32 \$', 'image': 'assets/images/hair3.jpg', 'cat': 'عناية بالشعر', 'desc': 'تقوية الشعر من الجذور.'},
    {'name': 'ماسك كارسيل', 'price': '25 \$', 'image': 'assets/images/hair4.jpg', 'cat': 'عناية بالشعر', 'desc': 'ترميم وحيوية مكثفة.'},
  ];

  CategoryProductsScreen({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final filteredProducts = allProducts.where((prod) => prod['cat'] == categoryName).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.82, 
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (ctx, i) => InkWell(
          onTap: () {
          
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: filteredProducts[i]),
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
                    child: Image.asset(
                      filteredProducts[i]['image']!, 
                      fit: BoxFit.cover, 
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 6, 8, 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filteredProducts[i]['name']!,
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Text(
                        filteredProducts[i]['desc']!,
                        maxLines: 1,
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      const SizedBox(height: 4), 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            filteredProducts[i]['price']!, 
                            style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 13)
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: ctx,
                                builder: (context) => AlertDialog(
                                  title: const Text('تأكيد الإضافة', textAlign: TextAlign.right),
                                  content: Text('هل تريد فعلاً إضافة "${filteredProducts[i]['name']}" إلى سلة المشتريات؟', textAlign: TextAlign.right),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                                      onPressed: () {
                                        
                                        Provider.of<ShopProvider>(context, listen: false).addToCart(filteredProducts[i] as Map<String, String>);
                                        Navigator.pop(context); 
                                        ScaffoldMessenger.of(ctx).showSnackBar(
                                          SnackBar(
                                            content: Text('تمت إضافة ${filteredProducts[i]['name']} بنجاح!', textAlign: TextAlign.right),
                                            backgroundColor: Colors.green,
                                            duration: const Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: const Text('إضافة الآن'),
                                    ),
                                  ],
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
        ),
      ),
    );
  }
}