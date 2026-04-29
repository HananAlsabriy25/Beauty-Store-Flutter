import 'package:flutter/material.dart';

class ShopProvider with ChangeNotifier {

  final List<Map<String, String>> _cartItems = [];


  final List<Map<String, String>> _favoriteItems = [];

  
  List<Map<String, String>> get cartItems => _cartItems;

  
  List<Map<String, String>> get favoriteItems => _favoriteItems;


  int get cartCount => _cartItems.length;


  void addToCart(Map<String, String> product) {
    _cartItems.add(product);
    notifyListeners(); 
  }

  void removeFromCart(Map<String, String> product) {
    _cartItems.remove(product);
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
    total += double.parse(priceString);
  }
  return total;
}
  
  bool isExistInFavorites(String productName) {
    return _favoriteItems.any((element) => element['name'] == productName);
  }
}