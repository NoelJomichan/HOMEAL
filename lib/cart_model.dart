import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale
  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Shahi Paneer", "148.00", "images/paneer.png", Colors.green],
    ["Dal Roti", "250.00", "images/roti_dal.png", Colors.yellow],
    ["Chicken Biryani", "148.0", "images/biryani.jpeg", Colors.brown],
    ["Pav Bhaji", "100.00", "images/pav_bhaji.jpeg", Colors.blue],
    ["Dal Roti", "250.00", "images/roti_dal.png", Colors.yellow],
    ["Chicken Biryani", "148.00", "images/biryani.jpeg", Colors.brown],
    ["Pav Bhaji", "100.00", "images/pav_bhaji.jpeg", Colors.blue],
    ["Shahi Paneer", "148.00", "images/paneer.png", Colors.brown],
  ];
  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
    // double totalPrice = 0;
    //
    // for (int i = 0; i < ModifiedPrice.length; i++) {
    //   totalPrice += double.parse(ModifiedPrice[i]);
    // }
    // return totalPrice.toStringAsFixed(2);
  }

  // -----------------------------------------------------------------------------------------------


  List _ModifiedPrice = [];
  get ModifiedPrice => _ModifiedPrice;

  final List basePrice = [5, 5, 2 ,5, 10, 10];
  get BasePrice => basePrice;

  final List _ItemList =  [
    'Burger', 'Pizza'
  ];
  get itemList => _ItemList;

  final List _ItemIngredients = [
    ['Cream', 'Dahi', 'Ginger Garlic Paste', 'Masala', 'Paneer', 'Tomato Puree',],
    ['Roti', 'Usad Dal', 'Ghee', 'Haldi', 'Cream', 'Masala'],
    ['Chicken', 'Masala', 'Rice', 'Ghee', 'Dry Fruits', 'Onion'],
    ['Pav', 'Pav Bhaji Masala', 'Onion', 'Aloo', 'Butter', 'Peas'],
  ];
  get itemIngredients => _ItemIngredients;

  final List _defaultValue = [
    [100.0,100.0,100.0,100.0,100.0,100.0,],
  ];
  get DefaultValue => _defaultValue;

  List _ModifiedItemVal = [];
  get modifiedItemList => _ModifiedItemVal;

  void addPrice(double price) {
    _ModifiedPrice.add(price.toString());
    notifyListeners();
  }

  void addItem(int index) {
    _ModifiedItemVal.add(_ItemList[index]);
    notifyListeners();
  }

  void removeItem(int index) {
    _ModifiedItemVal.removeAt(index);
    notifyListeners();
  }

}
