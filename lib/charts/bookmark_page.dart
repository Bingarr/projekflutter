import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:education_app/charts/bookmark_model.dart';

class BookmarksPage extends StatefulWidget {

  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  Widget build(BuildContext context) {
    var bookmarkBloc = Provider.of<BookmarkBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang Terambil"),
        backgroundColor: Color.fromARGB(255, 21, 111, 24),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: bookmarkBloc.items.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bookmarkBloc.items[index].title),
                  subtitle: Text(bookmarkBloc.items[index].subTitle),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

