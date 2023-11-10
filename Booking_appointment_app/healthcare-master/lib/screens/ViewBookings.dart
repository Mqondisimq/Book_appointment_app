import 'package:flutter/material.dart';

class ViewBookingsScreen extends StatelessWidget {
  // Dummy list of appointments for demonstration purposes
  final List<Appointment> appointments = [
    Appointment(
      doctor: Doctor(name: 'Dr. Smith', image: 'images/doctor1.jpg'),
      date: DateTime.now().add(Duration(days: 1)),
      time: TimeOfDay(hour: 14, minute: 30),
    ),
    Appointment(
      doctor: Doctor(name: 'Dr. Johnson', image: 'images/doctor2.jpg'),
      date: DateTime.now().add(Duration(days: 2)),
      time: TimeOfDay(hour: 10, minute: 0),
    ),
    Appointment(
      doctor: Doctor(name: 'Dr. Williams', image: 'images/doctor3.jpg'),
      date: DateTime.now().add(Duration(days: 2)),
      time: TimeOfDay(hour: 10, minute: 0),
    ),
    Appointment(
      doctor: Doctor(name: 'Dr. Davis', image: 'images/doctor4.jpg'),
      date: DateTime.now().add(Duration(days: 2)),
      time: TimeOfDay(hour: 10, minute: 0),
    ),
    // Add more appointments as needed
  ];

  // Function to filter appointments based on selected date and time
  List<Appointment> getFilteredAppointments(DateTime selectedDate, TimeOfDay selectedTime) {
    return appointments
        .where((appointment) =>
    appointment.date.year == selectedDate.year &&
        appointment.date.month == selectedDate.month &&
        appointment.date.day == selectedDate.day &&
        appointment.time.hour == selectedTime.hour &&
        appointment.time.minute == selectedTime.minute)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Assuming you have received the selected date and time from the previous screen
    DateTime selectedDate = DateTime.now().add(Duration(days: 2));
    TimeOfDay selectedTime = TimeOfDay(hour: 10, minute: 0);

    List<Appointment> filteredAppointments = getFilteredAppointments(selectedDate, selectedTime);

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Bookings'),
      ),
      body: ListView.builder(
        itemCount: filteredAppointments.length,
        itemBuilder: (context, index) {
          final appointment = filteredAppointments[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(appointment.doctor.image),
            ),
            title: Text('${appointment.doctor.name}'),
            subtitle: Text(
              'Date: ${appointment.date.toLocal()}, Time: ${appointment.time.format(context)}',
            ),
          );
        },
      ),
    );
  }
}

class Appointment {
  final Doctor doctor;
  final DateTime date;
  final TimeOfDay time;

  Appointment({required this.doctor, required this.date, required this.time});
}

// The Doctor class remains the same
class Doctor {
  final String name;
  final String image;

  Doctor({required this.name, required this.image});
}
