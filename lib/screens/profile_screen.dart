import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/providers/auth_provider.dart';
import 'package:trashgrab/providers/base_provider.dart';
import 'package:trashgrab/screens/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/space_extension.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MyAuthProvider>();
    final baseProvider = context.watch<BaseProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: provider.streamProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  70.verticalSpace,
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            }
            if (!snapshot.hasData || snapshot.hasError) {
              return const Text('error');
            }
            final userData = snapshot.data!.data();
            encapFunction(
              () => provider.updateData(userData),
            );
            return Column(
              children: [
                80.verticalSpace,
                if (userData?['photo'] == '' || userData?['photo'] == null) ...[
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/icons/profile.jpg'),
                  ),
                ] else ...[
                  CachedNetworkImage(
                    imageUrl: userData!['photo'],
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) {
                      return CircleAvatar(
                        radius: 70,
                        backgroundImage: imageProvider,
                      );
                    },
                    progressIndicatorBuilder: (context, url, progress) {
                      return CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        radius: 70,
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        'assets/icons/profile.jpg',
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ],
                const SizedBox(height: 20),
                itemProfile(
                  'Name',
                  userData?['username'],
                  CupertinoIcons.person,
                ),
                const SizedBox(height: 10),
                itemProfile(
                  'Email',
                  userData?['email'],
                  CupertinoIcons.mail,
                ),
                const SizedBox(height: 10),
                itemProfile(
                  'Phone',
                  userData?['phone'],
                  CupertinoIcons.phone,
                ),
                const SizedBox(height: 10),
                itemProfile(
                  'Address',
                  userData?['address'],
                  CupertinoIcons.location,
                ),
                40.verticalSpace,
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                              imageUrl: userData?['photo'] ?? '',
                              addressText: userData?['address'],
                              emailText: userData?['email'],
                              nameText: userData?['username'],
                              phoneText: userData?['phone'],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: const Color.fromARGB(
                          255,
                          21,
                          111,
                          24,
                        ),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20, height: 10),
                    ElevatedButton(
                      onPressed: () {
                        provider.doLogout(
                          context,
                          () => baseProvider.changeIndex(0),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: const Color.fromARGB(
                          255,
                          21,
                          111,
                          24,
                        ),
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  itemProfile(String? title, String? subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: const Color.fromARGB(255, 21, 111, 24).withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title ?? '-'),
        subtitle: Text(subtitle ?? '-'),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
}
