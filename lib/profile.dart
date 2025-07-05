// profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cars.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utilites/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required List<Booking> bookings});

  @override
  Widget build(BuildContext context) {
    final bookings = context.watch<CartProvider>().bookings;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Column(
        children: [
          _buildUserInfo(),
          const Divider(),
          Expanded(child: _buildBookingHistory(bookings)),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/avatar_placeholder.png'),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(' dollie', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('dollie@example.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingHistory(List bookings) {
    if (bookings.isEmpty) {
      return const Center(child: Text('No bookings yet.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Image.network(booking.carWash.imageUrl, width: 60, fit: BoxFit.cover),
            title: Text('${booking.carWash.name} - ${booking.service.name}'),
            subtitle: Text(
              'Date: ${DateFormat.yMMMd().add_jm().format(booking.dateTime)}\n'
              'Payment: ${booking.paymentMethod}\n'
              'Status: Confirmed',
            ),
          ),
        );
      },
    );
  }
}
