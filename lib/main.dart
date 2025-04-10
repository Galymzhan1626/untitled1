import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    InventoryMainPage(), // Home
    AddItemPage(),       // Add item
    BarcodePage(),       // Barcode
    HistoryPage(),       // History
    SettingsPage(),      // Settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF151829),
        title: Row(
          children: [
            PopupMenuButton<String>(
              onSelected: (value) {
                print("Selected: $value");
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 'Edit Profile', child: Text('Edit Profile')),
                PopupMenuItem(value: 'Logout', child: Text('Logout')),
              ],
              child: Row(
                children: [
                  Text('Profile', style: TextStyle(color: Colors.white)),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
            ),
            Spacer(),
            Text(
              '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),

      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF151829),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Barcode',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class InventoryMainPage extends StatelessWidget {
  final List<String> recentUpdates = List.generate(10, (index) => "Item ${index + 1} updated");

  final List<Map<String, dynamic>> categories = [
    {'title': 'All Items', 'icon': Icons.inventory_2},
    {'title': 'Low Stock', 'icon': Icons.warning},
    {'title': 'Add New', 'icon': Icons.add_box},
    {'title': 'Scan Barcode', 'icon': Icons.qr_code},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome back!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Here's a quick look at your inventory.", style: TextStyle(fontSize: 16)),
          SizedBox(height: 20),

          // GridView for quick actions
          Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(categories[index]['icon'], size: 32, color: Colors.white),
                        SizedBox(height: 8),
                        Text(categories[index]['title']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20),

          // ListView for recent updates
          Text("Recent Updates", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: recentUpdates.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.inventory),
                  title: Text(recentUpdates[index]),
                  subtitle: Text("Just now"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Add Item Page"));
  }
}

class BarcodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Barcode Scanner Page"));
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("History Page"));
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Settings Page"));
  }
}
