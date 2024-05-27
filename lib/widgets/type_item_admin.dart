import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/utils/extensions/tap_extension.dart';

class TypeItemAdmin extends StatelessWidget {
  const TypeItemAdmin({
    Key? key,
    required this.name,
    required this.image,
    required this.harga,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final String image;
  final String harga;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (image.isEmpty) {
      child = CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[400],
      );
    } else {
      child = CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            radius: 30,
            backgroundImage: imageProvider,
          );
        },
        progressIndicatorBuilder: (context, url, progress) {
          return CircleAvatar(
            backgroundColor: Colors.grey[400],
            radius: 30,
          );
        },
        errorWidget: (context, url, error) {
          return CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[400],
          );
        },
      );
    }

    return Card(
      child: ListTile(
        leading: child,
        title: Text(
          name,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(harga),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              Icons.edit_square,
              size: 30,
              color: Colors.amber[700],
            ).extCupertino(onTap: onTap),
          ],
        ),
      ),
    );
  }
}
