import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({
    super.key,
    this.image,
    this.onTap,
    required this.imageUrl,
  });

  final File? image;
  final String imageUrl;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Widget content = Image.asset('assets/icons/profile.jpg', fit: BoxFit.cover);
    if (image != null) {
      content = Image.file(
        image!,
        fit: BoxFit.cover,
      );
    } else if (imageUrl.isNotEmpty) {
      content = CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return Image.asset('assets/icons/profile.jpg');
        },
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(100),
        ),
        width: MediaQuery.of(context).size.height * 0.15,
        height: MediaQuery.of(context).size.height * 0.15,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: content,
        ),
      ),
    );
  }
}
