import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(List<File> files) onImagePicked;
  final List<File> initialImages;

  const ImagePickerWidget({
    super.key,
    required this.onImagePicked,
    this.initialImages = const [],
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  late List<File> _images;

  @override
  void initState() {
    super.initState();
    _images = List.from(widget.initialImages);
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() {
        _images.addAll(picked.map((e) => File(e.path)).toList());
      });
      widget.onImagePicked(_images);
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
    widget.onImagePicked(_images);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                SizedBox(height: 8),
                Text("Pick Image", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (_images.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _images.asMap().entries.map((entry) {
              final index = entry.key;
              final file = entry.value;
              return Stack(
                children: [
                  Image.file(file, height: 80, width: 80, fit: BoxFit.cover),
                  Positioned(
                    top: -10,
                    right: -10,
                    child: IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () => _removeImage(index),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
      ],
    );
  }
}
