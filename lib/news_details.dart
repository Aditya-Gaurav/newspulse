import 'package:flutter/material.dart';
import 'package:flutter_app/news_list.dart';
import 'news_data.dart'; // Import the data file

class NewsDetailsPage extends StatelessWidget {
  final News news;

  const NewsDetailsPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
      ),
      body: SingleChildScrollView(
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
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: NewsList(),
  ));
}