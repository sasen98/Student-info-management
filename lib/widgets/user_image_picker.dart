import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFunction;
  const UserImagePicker({Key? key, required this.imagePickFunction})
      : super(key: key);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  final picker = ImagePicker();
  void _getImage() async {
    final pickedImageFromCam = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImageFromCam!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFunction(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 80,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        const SizedBox(height: 5),
        TextButton.icon(
            icon: const Icon(Icons.camera_alt),
            onPressed: _getImage,
            label: const Text('Take Photo')),
      ],
    );
  }
}
