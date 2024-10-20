import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:meme/model/meme_model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class EditImage {
  final Memes meme;
  BuildContext context;
  EditImage({required this.meme, required this.context});
  Future<void> editImage() async {
    try {
      //taking storage permission
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      // Check if the URL is valid
      if (meme.url == null || meme.url!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid image URL.')),
        );
        return;
      }

      // Fetch the image data
      final response = await http.get(Uri.parse(meme.url!));
      if (response.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load image.')),
        );
        return;
      }

      // Open image editor
      final editedImage = await Navigator.push<Uint8List>(
        context,
        MaterialPageRoute(
          builder: (context) => ImageEditor(
            image: response.bodyBytes,
          ),
        ),
      );
      if (editedImage != null) {
        // Save the edited image to the gallery
        bool success = await ImageGallerySaver.saveImage(editedImage);
        if (success != null && success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image saved to gallery!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save image.')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
