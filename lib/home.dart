import 'package:flutter/material.dart';
import 'post.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.menu, color: Colors.black),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.notifications, color: Colors.black),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Kategori Pariwisata
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: _buildCategoryIcons(),
              ),
            ),

            // Postingan
            _buildPost(
              context,
              name: "Rizky",
              location: "Gunung Sindoro",
              imageUrl: "assets/sindoro.jpg",
              likes: 144,
              comments: 12,
              postText: "",
            ),

            _buildPost(
              context,
              name: "Rizka",
              location: "",
              imageUrl: "",
              likes: 323,
              comments: 40,
              postText:
                  "Info tempat pariwisata yang alam - alam dong. Butuh refreshing soalnya pusing nyusun TA :)",
              recommendation: _buildRecommendation(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }

  // List Icon Kategori
  List<Widget> _buildCategoryIcons() {
    List<Map<String, dynamic>> categories = [
      {"icon": Icons.airplane_ticket, "label": "Tiket Pesawat"},
      {"icon": Icons.hotel, "label": "Hotel"},
      {"icon": Icons.place, "label": "Paket Wisata"},
      {"icon": Icons.directions_bus, "label": "Tiket Bus & Travel"},
      {"icon": Icons.confirmation_number, "label": "Tiket Kereta Api"},
    ];

    return categories
        .map((category) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Icon(category["icon"], color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Text(category["label"], style: const TextStyle(fontSize: 12)),
                ],
              ),
            ))
        .toList();
  }

  // Widget Postingan
  Widget _buildPost(
    BuildContext context, {
    required String name,
    required String location,
    required String imageUrl,
    required int likes,
    required int comments,
    required String postText,
    Widget? recommendation,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(name: name, imageUrl: imageUrl)),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(backgroundColor: Colors.blue),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (location.isNotEmpty) Text(location, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(imageUrl),
                ),
              if (postText.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(postText),
              ],
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.favorite, color: Colors.red),
                  const SizedBox(width: 5),
                  Text(likes.toString()),
                  const SizedBox(width: 20),
                  Icon(Icons.comment, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(comments.toString()),
                ],
              ),
              if (recommendation != null) ...[
                const Divider(),
                recommendation,
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Widget Rekomendasi Wisata
  Widget _buildRecommendation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Rekomendasi", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset("assets/nimo.png", width: 100, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "Ayo berkunjung ke NIMO HIGHLAND! Nikmati wisata alam yang indah dan beragam aktivitas seru.",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
