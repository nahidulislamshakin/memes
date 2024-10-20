import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:meme/model/meme_model.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:gal/gal.dart';

class EditImage {
  final Memes meme;
  BuildContext context;
  EditImage({required this.meme, required this.context});

//This function call the image editor class which is from image editor plus package
  Future<void> editImage() async {
    try {
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
          const SnackBar(content: Text('Failed to load image.')),
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
        //getting the path of the edited image
        final tempDir = await getTemporaryDirectory();
        final imagePath =
            '${tempDir.path}/edited_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final file = File(imagePath);
        await file.writeAsBytes(editedImage);

        // Save the edited image to the gallery using gal package
        await Gal.putImage(file.path);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery!'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
