import 'package:flutter/material.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [

          // Sidebar
          Container(
            width: 220,
            color: const Color(0xFFD32F2F),
            child: Column(
              children: [
                const SizedBox(height: 40),

                Image.asset('assets/bank_logo.png', height: 60),

                const SizedBox(height: 20),

                const Text(
                  "Swift Bank",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 40),

                sidebarItem(Icons.home, "Home"),
                sidebarItem(Icons.account_balance_wallet, "Accounts"),
                sidebarItem(Icons.settings, "Settings"),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const Text(
                        "Welcome to Swift Bank",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "We know what you buy and sell \n We know it all too well",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w100),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfilePage(),
                            ),
                          );
                        },
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/user.jpg'),
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text("Click profile to view details"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sidebarItem(IconData icon, String text) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: () {},
    );
  }
}