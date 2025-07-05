import 'package:flutter_application_1/models/cars.dart';


class CartItem {
  final Service service;
  int quantity;

  CartItem({required this.service, this.quantity = 1});
}

class Cart {
  final List<CartItem> items = [];

  void add(Service service) {
    final index = items.indexWhere((item) => item.service.id == service.id);
    if (index >= 0) {
      items[index].quantity += 1;
    } else {
      items.add(CartItem(service: service));
    }
  }

  void remove(Service service) {
    items.removeWhere((item) => item.service.id == service.id);
  }

  void clear() => items.clear();

  double get total =>
      items.fold(0, (sum, item) => sum + item.service.price * item.quantity);

  bool get isEmpty => items.isEmpty;
}
