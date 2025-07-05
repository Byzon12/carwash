import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilites/item.dart';
import '../models/cars.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  final List<Booking> _bookings = [];

  List<CartItem> get items => _items;
  List<Booking> get bookings => _bookings;

  double get total =>
      _items.fold(0, (sum, item) => sum + item.service.price * item.quantity);

  bool get isEmpty => _items.isEmpty;

  void add(Service service) {
    final index = _items.indexWhere((item) => item.service.id == service.id);
    if (index >= 0) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(service: service));
    }
    notifyListeners();
  }

  void remove(Service service) {
    _items.removeWhere((item) => item.service.id == service.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void addBookings(List<Booking> newBookings) {
    _bookings.addAll(newBookings);
    notifyListeners();
  }
}
