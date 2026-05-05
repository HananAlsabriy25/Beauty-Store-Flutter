import 'package:flutter/material.dart';

class ShopProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];
  final List<Map<String, String>> _favoriteItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;
  List<Map<String, String>> get favoriteItems => _favoriteItems;

  
  int get cartCount {
    int totalCount = 0;
    for (var item in _cartItems) {
      totalCount += (item['quantity'] as int);
    }
    return totalCount;
  }

  void addToCart(Map<String, String> product) {
    int index = _cartItems.indexWhere((item) => item['name'] == product['name']);
    if (index >= 0) {
      _cartItems[index]['quantity'] = (_cartItems[index]['quantity'] ?? 1) + 1;
    } else {
      _cartItems.add({
        'name': product['name'],
        'price': product['price'],
        'image': product['image'],
        'quantity': 1,
      });
    }
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_cartItems[index]['quantity'] > 1) {
      _cartItems[index]['quantity']--;
    } else {
      _cartItems.removeAt(index);
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void toggleFavorite(Map<String, String> product) {
    int existingIndex = _favoriteItems.indexWhere((element) => element['name'] == product['name']);
    if (existingIndex >= 0) {
      _favoriteItems.removeAt(existingIndex);
    } else {
      _favoriteItems.add(product);
    }
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      String priceString = item['price']!.replaceAll('\$', '').trim();
      double price = double.parse(priceString);
      int qty = item['quantity'] ?? 1;
      total += (price * qty);
    }
    return total;
  }

  bool isExistInFavorites(String productName) {
    return _favoriteItems.any((element) => element['name'] == productName);
  }
}