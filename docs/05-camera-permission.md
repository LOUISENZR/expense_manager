# 5. Add Image from Camera or File Browser with Permission Handling

In this step, we will implement a feature to allow users to add an image from the camera or file browser when saving an expense receipt. This implementation will include proper permission handling for both Android and web platforms.

## 1. Add Dependencies

First, we need to add the `image_picker` and `permission_handler` dependencies to our `pubspec.yaml` file.

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^0.8.4+4
  permission_handler: ^10.0.0
```

## 2. Platform-Specific Configuration

### Android

In `android/app/src/main/AndroidManifest.xml`, add the following permissions:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

### iOS

In `ios/Runner/Info.plist`, add the following keys:

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to take pictures of receipts.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to select receipt images.</string>
```

## 3. Implement Permission Handling and Image Picking

Next, we will modify the `manage_expense_screen.dart` file to handle permissions and add a button that will open the camera or file browser. We will also add a widget to display the selected image.

```dart
// ...
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class _ManageExpenseScreenState extends State<ManageExpenseScreen> {
  // ...
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final permission = source == ImageSource.camera ? Permission.camera : Permission.photos;
    final status = await permission.status;

    if (status.isDenied) {
      // Show a dialog to explain why we need the permission
      final result = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Permission needed'),
          content: Text(
              'This app needs access to your ${source == ImageSource.camera ? 'camera' : 'photos'} to add a receipt image.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('OK'),
            ),
          ],
        ),
      );

      if (result != true) {
        return;
      }
    }

    final newStatus = await permission.request();

    if (newStatus.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } else {
      // Handle the case when permission is denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ...
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ...
            if (_image != null)
              Image.file(
                _image!,
                height: 150,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text('Camera'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.image),
                  label: Text('Gallery'),
                ),
              ],
            ),
            // ...
          ],
        ),
      ),
    );
  }
}
```

## 4. Update `expense.dart` Model

We need to add a field to our `Expense` model to store the path to the image file.

```dart
class Expense {
  // ...
  final String? imagePath;

  Expense({
    // ...
    this.imagePath,
  });
}
```

## 5. Save Image Path

Finally, we need to update the `_saveExpense` method in `manage_expense_screen.dart` to save the image path to the `Expense` object.

```dart
void _saveExpense() {
  // ...
  final newExpense = Expense(
    // ...
    imagePath: _image?.path,
  );
  // ...
}
```

## 6. Display Image in `expense_list_screen.dart`

We will update the `ExpenseCard` to display the image if it exists.

```dart
class ExpenseCard extends StatelessWidget {
  // ...
  @override
  Widget build(BuildContext context) {
    return Card(
      // ...
      child: Column(
        children: [
          // ...
          if (expense.imagePath != null)
            Image.file(
              File(expense.imagePath!),
              height: 150,
            ),
        ],
      ),
    );
  }
}
```

This will complete the implementation of the add image from camera or file browser feature with permission handling.
