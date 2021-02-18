import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yuk_chat/shared/theme.dart';

class UserPickImage extends StatefulWidget {
  @override
  _UserPickImageState createState() => _UserPickImageState();
}

class _UserPickImageState extends State<UserPickImage> {
  File _imagePicked;

  void _pickImage(bool isFromCamera) async {
    final pick = ImagePicker();
    final PickedFile filePicked = await pick.getImage(
        source: isFromCamera ? ImageSource.camera : ImageSource.gallery);
    if (filePicked != null) {
      final File image = File(filePicked.path);
      setState(() {
        _imagePicked = image;
      });
    }
  }

  void _selectImageSource() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pilih Tindakan", style: titleStyle),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Ambil dengan kamera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(true);
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text("Pilih melalui Galeri"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(false);
              },
            ),
            if (_imagePicked != null)
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Hapus Gambar"),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _imagePicked = null;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: InkWell(
            onTap: _selectImageSource,
            child: CircleAvatar(
              radius: 40,
              child: _imagePicked == null
                  ? Icon(Icons.add_a_photo, size: 30)
                  : null,
              backgroundImage:
                  _imagePicked == null ? null : FileImage(_imagePicked),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
