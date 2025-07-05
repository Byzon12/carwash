import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart.dart';
import 'package:flutter_application_1/dashboard.dart';
import 'package:flutter_application_1/his.dart';
import 'package:flutter_application_1/models/cars.dart';
import 'package:flutter_application_1/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Booking> _bookings = [];

  void _addBooking(Booking booking) {
    setState(() {
      _bookings.add(booking);
      _selectedIndex = 1; // Switch to Bookings tab after booking
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(onBook: _addBooking),
      BookingHistoryPage(bookings: _bookings),
      ProfilePage(bookings: _bookings),
      const CartPage(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Car Wash App')),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.book_online), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Cart'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
