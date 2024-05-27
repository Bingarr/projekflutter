import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/utils/extensions/tap_extension.dart';
import 'package:trashgrab/utils/space_extension.dart';

class ChartItem extends StatelessWidget {
  const ChartItem({
    Key? key,
    required this.name,
    required this.image,
    required this.harga,
    required this.removeTap,
    required this.addTap,
    required this.itemCount,
  }) : super(key: key);

  final String name;
  final String image;
  final String harga;
  final String itemCount;
  final Function()? removeTap;
  final Function()? addTap;

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
      child: Column(
        children: [
          ListTile(
            leading: child,
            title: Text(
              name,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(harga),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.remove_outlined,
                size: 30,
              ).extCupertino(onTap: removeTap),
              15.horizontalSpace,
              Text(
                itemCount,
                style: const TextStyle(fontSize: 23),
              ),
              15.horizontalSpace,
              const Icon(
                Icons.add,
                size: 30,
              ).extCupertino(onTap: addTap),
              10.horizontalSpace,
            ],
          ),
          10.verticalSpace,
        ],
      ),
    );
  }
}
