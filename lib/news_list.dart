// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import the services package
import 'package:audioplayers/audioplayers.dart'; // Add the audioplayers package
import 'news_data.dart'; // Import the data file
import 'news_details.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
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
            direction: DismissDirection.horizontal,
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
    );
  }

  void _handleDismiss(DismissDirection direction, int index) {
    if (direction == DismissDirection.endToStart) {
      // Right swipe (checkmark)
      _playSwipeSound();
      print('Swiped right on ${newsList[index].title}');
      // Add your logic for right swipe event here
    } else if (direction == DismissDirection.startToEnd) {
      // Left swipe (delete)
      _playSwipeSound();
      print('Swiped left on ${newsList[index].title}');
      setState(() {
        newsList.removeAt(index);
      });
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
          _playTapSound();
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

  void _playTapSound() {
    HapticFeedback.lightImpact(); // Use system haptic feedback for tap
  }
}


void main() {
  runApp(const MaterialApp(
    home: NewsList(),
  ));
}