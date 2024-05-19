import 'package:provider/provider.dart';
import 'package:trashgrab/providers/auth_provider.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    Key? key,
    this.nameText,
    this.emailText,
    this.addressText,
    this.phoneText,
    required this.imageUrl,
  }) : super(key: key);

  final String? nameText;
  final String? emailText;
  final String? addressText;
  final String? phoneText;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MyAuthProvider>();
    final _nameController = TextEditingController(text: nameText);
    final _emailController = TextEditingController(text: emailText);
    final _addressController = TextEditingController(text: addressText);
    final _phoneController = TextEditingController(text: phoneText);

    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              provider.clearLocalImage();
              pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Edit Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: ProfileImagePicker(
                  imageUrl: imageUrl,
                  image: provider.localImage,
                  onTap: provider.pickImage,
                ),
              ),
              20.verticalSpace,
              TextField(
                readOnly: true,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  fillColor: Colors.green[100],
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  fillColor: Colors.green[50],
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  fillColor: Colors.green[50],
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  fillColor: Colors.green[50],
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => provider.editProfile(
                  context: context,
                  address: _addressController.text,
                  username: _nameController.text,
                  oldPhoto: imageUrl,
                  phone: _phoneController.text,
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
