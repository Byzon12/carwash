import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/cars.dart';

import 'package:intl/intl.dart';

class BookingHistoryPage extends StatelessWidget {
  final List<Booking> bookings;

  const BookingHistoryPage({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
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
