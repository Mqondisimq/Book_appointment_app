import 'package:flutter/material.dart';
import 'package:healthcare/screens/ViewBookings.dart';

class AppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingScreen(),
    );
  }
}

class Doctor {
  final String name;
  final String image;

  Doctor({required this.name, required this.image});
}

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Doctor selectedDoctor = Doctor(name: '', image: '');

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Widget buildDoctorAvatar(Doctor doctor) {
    var accentColor;
    return InkWell(
      onTap: () {
        setState(() {
          selectedDoctor = doctor;
        });
      },
      child: CircleAvatar(
        backgroundImage: AssetImage(doctor.image),
        radius: 40,
        backgroundColor: selectedDoctor == doctor
            ? Theme.of(context).colorScheme.secondary
            : Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthcare Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildDoctorAvatar(
                  Doctor(name: 'Dr. Smith', image: 'images/doctor1.jpg'),
                ),
                buildDoctorAvatar(
                  Doctor(name: 'Dr. Johnson', image: 'images/doctor2.jpg'),
                ),
                buildDoctorAvatar(
                  Doctor(name: 'Dr. Williams', image: 'images/doctor3.jpg'),
                ),
                buildDoctorAvatar(
                  Doctor(name: 'Dr. Davis', image: 'images/doctor4.jpg'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Selected Doctor: ${selectedDoctor.name}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Selected Date: ${selectedDate.toLocal()}',
                  ),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Selected Time: ${selectedTime.format(context)}',
                  ),
                ),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text('Select Time'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add your booking logic here
                    // For example, you can show a confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Booking Confirmation'),
                          content: Center(
                            child : Text(
                            'Appointment booked for ${selectedDoctor.name} on ${selectedDate.toLocal()} at ${selectedTime.format(context)}.',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Change the color
                    minimumSize: Size(150, 50), // Set the minimum size
                  ),
                  child: Text('Book Appointment'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Add logic to navigate to the ViewBookings screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewBookingsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Change the color
                    minimumSize: Size(150, 50), // Set the minimum size
                  ),
                  child: Text('View Booking'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
