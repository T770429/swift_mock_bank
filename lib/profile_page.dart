import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD32F2F),
        title: const Text("Account Details"),
      ),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [

                Text("Client Name: Taylor Swift",
                    style: TextStyle(fontSize: 18)),

                SizedBox(height: 10),

                Text("Savings Account Number: 1213-5613-9013",
                    style: TextStyle(fontSize: 18)),

                SizedBox(height: 10),

                Text("Balance: \$1,301,300,000.00",
                    style: TextStyle(fontSize: 18)),

                SizedBox(height: 10),

                Text("Client Address: 21 Cornelia Street, New York City",
                    style: TextStyle(fontSize: 18)),

                SizedBox(height: 10),

                Text("Client Age: 36",
                    style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}