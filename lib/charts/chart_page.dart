
import 'package:flutter/material.dart';
import 'package:education_app/charts/bookmark_model.dart';
import 'package:education_app/charts/bookmark_page.dart';
import 'package:education_app/charts/item_model.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<Map<String, dynamic>> itemsList = [
    {
      'title': 'Kaleng',
      'subtitle': 'Rp 5000/kg',
      'isFavorite': false,
      'image': 'assets/icons/kaleng.png', 
    },
    {
      'title': 'Plastik',
      'subtitle':
          'Rp 4500/kg',
      'isFavorite': false,
      'image': 'assets/icons/sampah-plastik.webp', 
    },
    {
      'title': 'Kardus',
      'subtitle':
          'Rp 4000/kg ',
      'isFavorite': false,
      'image': 'assets/icons/kardus.png', 
    },
    {
      'title': 'Kertas',
      'subtitle':
          'Rp 3000/kg',
      'isFavorite': false,
      'image': 'assets/icons/kertas.jpg',
    },
    {
      'title': 'Besi',
      'subtitle':
          'Rp 6000/kg',
      'isFavorite': false,
      'image': 'assets/icons/besi.jpg', 
    },
    {
      'title': 'Sampah Organik',
      'subtitle': 'Rp 0/kg',
      'isFavorite': false,
      'image': 'assets/icons/sampah-organik.jpeg', 
    },
  ];

  @override
  Widget build(BuildContext context) {
    var bookmarkBloc = Provider.of<BookmarkBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Jenis Sampah",
          textAlign: TextAlign.center,
          selectionColor: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 21, 111, 24),
        actions: [
          Row(
            children: [
              Text(bookmarkBloc.count.toString()),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookmarksPage(),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(itemsList[index]['image']),
                        radius: 35, 
                      ),
                      onTap: () {
                        bookmarkBloc.addCount();

                        ItemModel itemModel = new ItemModel(
                          title: itemsList[index]['title'],
                          subTitle: itemsList[index]['subtitle'],
                          isFavorite: !itemsList[index]
                              ['isFavorite'], 
                        );

                        bookmarkBloc.addItems(itemModel);

                        setState(() {
                          itemsList[index]['status'] = true;
                          itemsList[index]['isFavorite'] = !itemsList[index]
                              ['isFavorite']; // Update status favorit
                        });
                      },
                      title: Text(itemsList[index]['title']),
                      subtitle: Text(itemsList[index]['subtitle']),
                      trailing: itemsList[index][
                              'isFavorite'] 
                          ? Icon(Icons.add_box_outlined,
                              color: Colors
                                  .blue) 
                          : Icon(Icons.add_box),
                    ),
                    Divider(), 
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
