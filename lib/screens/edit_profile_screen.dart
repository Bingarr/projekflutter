import 'package:provider/provider.dart';
import 'package:trashgrab/providers/auth_provider.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
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
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late MyAuthProvider provider;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.nameText);
    _emailController = TextEditingController(text: widget.emailText);
    _addressController = TextEditingController(text: widget.addressText);
    _phoneController = TextEditingController(text: widget.phoneText);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    provider = context.watch<MyAuthProvider>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  imageUrl: widget.imageUrl,
                  image: provider.localImage,
                  onTap: provider.pickImage,
                ),
              ),
              20.verticalSpace,
              TextFormField(
                readOnly: true,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  fillColor: Colors.green[100],
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  fillColor: Colors.green[50],
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  fillColor: Colors.green[50],
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
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
                  oldPhoto: widget.imageUrl,
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
