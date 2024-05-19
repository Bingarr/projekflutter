import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/providers/bookmark_provider.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BookmarkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Terambil"),
        backgroundColor: const Color.fromARGB(255, 21, 111, 24),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: provider.items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(provider.items[index].title),
                  subtitle: Text(provider.items[index].subTitle),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
