import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Map<String, bool> likedPosts = {};
  Map<String, int> likeCounts = {
    'assets/sindoro.jpg': 144,
    'assets/nimo.png': 200,
  };
  Map<String, int> commentCounts = {
    'assets/sindoro.jpg': 12,
    'assets/nimo.png': 18,
  };

  void toggleLike(String imagePath) {
    setState(() {
      likedPosts[imagePath] = !(likedPosts[imagePath] ?? false);
      likeCounts[imagePath] = (likeCounts[imagePath] ?? 0) + (likedPosts[imagePath]! ? 1 : -1);
    });
  }

  void addComment(String imagePath) {
    setState(() {
      commentCounts[imagePath] = (commentCounts[imagePath] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travelgram'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset('assets/menu-burger.png', width: 24, height: 24),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _buildCategoryIcons(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerItem(context, 'assets/plane-alt.png', 'Tiket Pesawat'),
            _buildDrawerItem(context, 'assets/hotel.png', 'Hotel'),
            _buildDrawerItem(context, 'assets/umbrella-beach.png', 'Paket Wisata'),
            _buildDrawerItem(context, 'assets/bus-alt.png', 'Tiket Bus & Travel'),
            _buildDrawerItem(context, 'assets/train-side.png', 'Tiket Kereta Api'),
            _buildDrawerItem(context, 'assets/users.png', 'Komunitas'),
            _buildDrawerItem(context, 'assets/messages.png', 'Pesan'),
            _buildDrawerItem(context, 'assets/users.png', 'Profil'),
            _buildDrawerItem(context, 'assets/phone-call.png', 'Pusat Bantuan'),
            _buildDrawerItem(context, 'assets/user-headset.png', 'Hubungi Kami'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildPost('Rizky', 'Gunung Sindoro', 'assets/sindoro.jpg'),
                  _buildPost('Rizka', 'Gunung Merbabu', 'assets/nimo.png'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tambahkan fungsi untuk membuat post baru
        },
        backgroundColor: Colors.white,
        child: Image.asset('assets/plus.png', width: 30, height: 30),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/home.png')), label: 'Home'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/users.png')), label: 'Komunitas'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/messages.png')), label: 'Pesan'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/circle-user.png')), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String iconPath, String title) {
    return ListTile(
      leading: Image.asset(iconPath, width: 24, height: 24, color: Colors.black),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildPost(String username, String location, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(child: Text(username[0])),
            title: Text(username),
            subtitle: Text(location),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => toggleLike(imagePath),
                  child: Image.asset(
                    likedPosts[imagePath] == true ? 'assets/heart.png' : 'assets/heart.png',
                    width: 24,
                    height: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 5),
                Text('${likeCounts[imagePath]}'),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () => addComment(imagePath),
                  child: Image.asset(
                    'assets/comment-alt-dots.png',
                    width: 24,
                    height: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 5),
                Text('${commentCounts[imagePath]}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryIcons() {
    List<Map<String, dynamic>> categories = [
      {"icon": 'assets/plane-alt.png', "label": "Tiket Pesawat"},
      {"icon": 'assets/hotel.png', "label": "Hotel"},
      {"icon": 'assets/umbrella-beach.png', "label": "Paket Wisata"},
      {"icon": 'assets/bus-alt.png', "label": "Tiket Bus & Travel"},
      {"icon": 'assets/train-side.png', "label": "Tiket Kereta Api"},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categories.map((category) {
        return Column(
          children: [
            Image.asset(category["icon"], width: 40, height: 40, color: Colors.black),
            const SizedBox(height: 5),
            Text(category["label"], style: const TextStyle(fontSize: 12)),
          ],
        );
      }).toList(),
    );
  }
}