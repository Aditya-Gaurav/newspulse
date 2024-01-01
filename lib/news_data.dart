class News {
  final String title;
  final String description;
  final String imageUrl;
  final String author;
  final String sourceName;
  final DateTime createdAt;
  final List<String> tags;

  News({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.author,
    required this.sourceName,
    required this.createdAt,
    required this.tags,
  });
}
final List<News> newsList = [
  News(
    title: 'Flutter News 1',
    description: 'This is the first Flutter news item.',
    imageUrl: 'https://dummyimage.com/640x4:3',
    author: 'John Doe',
    sourceName: 'Flutter News Network',
    createdAt: DateTime(2023, 1, 15),
    tags: ['Flutter', 'Mobile', 'Tech'],
  ),
  News(
    title: 'Flutter News 2',
    description: 'Another exciting news from the Flutter world.',
    imageUrl: 'https://dummyimage.com/640x4:3',
    author: 'Jane Smith',
    sourceName: 'Tech Insights',
    createdAt: DateTime(2023, 1, 16),
    tags: ['Flutter', 'Update', 'Community'],
  ),
  News(
    title: 'Flutter News 3',
    description: 'Check out the latest updates in the Flutter community.',
    imageUrl: 'https://dummyimage.com/640x4:3',
    author: 'Bob Johnson',
    sourceName: 'Mobile Weekly',
    createdAt: DateTime(2023, 1, 17),
    tags: ['Flutter', 'Community', 'Mobile'],
  ),

    // Add  news data here
];
