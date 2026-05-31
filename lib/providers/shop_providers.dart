import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ShopProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Map<String, dynamic>> _cartItems = [];
  bool _isLoading = false; 

  List<Product> get products => _products;
  List<Map<String, dynamic>> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  // حساب المجموع الإجمالي بناءً على السعر والكمية
  double get totalAmount {
    double total = 0.0;
    for (var item in _cartItems) {
      final price = item['price'];
      final quantity = item['quantity'] ?? 1;
      double parsedPrice = 0.0;
      
      if (price is num) {
        parsedPrice = price.toDouble();
      } else if (price is String) {
        parsedPrice = double.tryParse(price) ?? 0.0;
      }
      total += parsedPrice * quantity;
    }
    return total;
  }

  List<Product> _buildProducts(List<dynamic> items, SharedPreferences prefs) {
    final List<Product> loadedProducts = [];
    for (var item in items) {
      final isFav = prefs.getBool('fav_${item['id']}') ?? false;
      final product = Product.fromJson(item as Map<String, dynamic>);
      product.isFavorite = isFav;
      loadedProducts.add(product);
    }
    return loadedProducts;
  }

  Future<void> fetchAndSetProducts() async {
    _isLoading = true;
    notifyListeners(); 

    const url = 'https://api.allorigins.win/raw?url=https://dummyjson.com/products';
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // تحميل السلة المحفوظة تلقائياً عند فتح التطبيق
      if (prefs.containsKey('user_cart')) {
        final savedCart = json.decode(prefs.getString('user_cart')!) as List<dynamic>;
        _cartItems = savedCart.map((item) => item as Map<String, dynamic>).toList();
      }

      try {
        final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));
        if (response.statusCode == 200) {
          final responseData = json.decode(response.body) as Map<String, dynamic>;
          final extractedData = (responseData['products'] as List<dynamic>? ?? []);

          _products = _buildProducts(extractedData, prefs);
          await prefs.setString('offline_products', json.encode(extractedData));
        } else {
          throw Exception('Failed to load products');
        }
      } catch (error) {
        if (prefs.containsKey('offline_products')) {
          final offlineData = json.decode(prefs.getString('offline_products')!) as List<dynamic>;
          _products = _buildProducts(offlineData, prefs);
        }
      }
    } catch (e) {
      debugPrint('حدث خطأ: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }

  void toggleFavorite(String id) async {
    final prodIndex = _products.indexWhere((p) => p.id == id);
    if (prodIndex >= 0) {
      _products[prodIndex].isFavorite = !_products[prodIndex].isFavorite;
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('fav_$id', _products[prodIndex].isFavorite);
    }
  }

  // إضافة للسلة مع دعم الكمية الافتراضية والحفظ
  void addToCart(Product product) async {
    final existingIndex = _cartItems.indexWhere((item) => item['id'] == product.id);
    
    if (existingIndex >= 0) {
      // إذا كان المنتج موجوداً مسبقاً، نزيد الكمية
      _cartItems[existingIndex]['quantity'] = (_cartItems[existingIndex]['quantity'] ?? 1) + 1;
    } else {
      // إذا كان منتجاً جديداً
      _cartItems.add({
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'image': product.imageUrl,
        'quantity': 1,
      });
    }
    notifyListeners();
    _saveCartToPrefs();
  }

  // زيادة الكمية من داخل السلة
  void increaseQuantity(int index) {
    _cartItems[index]['quantity'] = (_cartItems[index]['quantity'] ?? 1) + 1;
    notifyListeners();
    _saveCartToPrefs();
  }

  // إنقاص الكمية أو حذف المنتج إذا وصلت للصفر
  void decreaseQuantity(int index) {
    final currentQty = _cartItems[index]['quantity'] ?? 1;
    if (currentQty > 1) {
      _cartItems[index]['quantity'] = currentQty - 1;
    } else {
      _cartItems.removeAt(index);
    }
    notifyListeners();
    _saveCartToPrefs();
  }

  // دالة مساعدة لحفظ السلة محلياً
  void _saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_cart', json.encode(_cartItems));
  }

  void clearCart() async {
    _cartItems.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_cart');
  }
}