// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'news_data.dart';
import 'news_details.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News List'),
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          News news = newsList[index];
          return Dismissible(
            key: Key(news.title),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.check, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              _handleDismiss(direction, index);
            },
            child: NewsListItem(news: news),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/profile_image.jpg'), // Replace with your profile image
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'John Doe', // Replace with your name
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    'john.doe@example.com', // Replace with your email
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Add your settings logic here
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
                // Add your help logic here
              },
            ),
          ],
        ),
      ),
    );
  }

void _handleDismiss(DismissDirection direction, int index) {
  _playSwipeSound();
      // _showThumbsUpAnimation(context);
  // ScaffoldMessenger.of(context)
  //       .showSnackBar(const SnackBar(content: Text('Item dismissed')));
          
  if (direction == DismissDirection.endToStart) {
    // Right swipe (checkmark)
    print('Swiped right on ${newsList[index].title}');
    // Add your logic for right swipe event here
       // Right swipe (checkmark)
      print('Swiped right on ${newsList[index].title}');
         setState(() {
      newsList.removeAt(index);
    });
       ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Your disliked the News')));
      
  } else if (direction == DismissDirection.startToEnd) {
    // Left swipe (delete)
    print('Swiped left on ${newsList[index].title}');
 
          
  }
}



  void _showThumbsUpAnimation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200.0,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              child: const Icon(
                Icons.thumb_up,
                size: 80.0,
                color: Colors.green,
              ),
              onEnd: () {
                  // Wait for 2 seconds before closing the bottom sheet
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
              });
              },
            ),
          ),
        );
      },
    );
  }


  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle bottom navigation tab tap
    switch (index) {
      case 0:
        // Home tab
        break;
      case 1:
        // Favorites tab
        break;
      case 2:
        // Profile tab
        break;
    }
  }

  void _playSwipeSound() {
    HapticFeedback.lightImpact(); // Use system haptic feedback for swipe
  }
}

class NewsListItem extends StatelessWidget {
  final News news;

  const NewsListItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Handle news item tap
          // _playTapSound();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailsPage(news: news),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Author: ${news.author}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Source: ${news.sourceName}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Created At: ${news.createdAt.toString()}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Tags: ${news.tags.join(', ')}',
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                news.title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(news.description),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(news.imageUrl),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NewsList(),
    );
  }
}