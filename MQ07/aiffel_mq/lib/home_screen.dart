import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> saveImagePermanently(String imagePath) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String newPath =
      '${directory.path}/${DateTime.now().toIso8601String()}.png';
  final File newImage = await File(imagePath).copy(newPath);
  return newImage.path;
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display Picture')),
      // Use the image path to create the Image widget
      body: Image.file(File(imagePath)),
    );
  }
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.max,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview with an AppBar.
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Take a Picture'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () =>
                    Navigator.of(context).pop(), // Exit the camera screen
              ),
            ),
            body: CameraPreview(_controller),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                try {
                  await _initializeControllerFuture;

                  // Lock focus and exposure before taking the picture
                  await _controller.setFocusMode(FocusMode.locked);
                  await _controller.setExposureMode(ExposureMode.locked);

                  // Capture the image
                  final picture = await _controller.takePicture();

                  // Unlock focus and exposure after taking the picture
                  await _controller.setFocusMode(FocusMode.auto);
                  await _controller.setExposureMode(ExposureMode.auto);

                  final String imagePath =
                      await saveImagePermanently(picture.path);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DisplayPictureScreen(imagePath: imagePath),
                    ),
                  ).then((result) {
                    if (result != null) {
                      Navigator.of(context).pop(result);
                    }
                  });
                } catch (e) {
                  print(e);
                }
              },
              child: const Icon(Icons.camera_alt),
            ),
          );
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  final CameraDescription camera;

  const HomeScreen({super.key, required this.camera});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _navigateAndDisplayPicture() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: widget.camera),
      ),
    );

    if (result != null) {
      // Handle the returned image path here. For example, navigate to DisplayPictureScreen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              DisplayPictureScreen(imagePath: result as String),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    // Do something with the selected image
    if (image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imagePath: image.path),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.house),
          centerTitle: true,
          title: const Text('Pet Obesity Check'),
        ),
        body: Stack(
          children: [
            Align(
              alignment: const Alignment(0.0, -0.6),
              child: Image.asset(
                'images/dog.jpg',
                width: 300,
                height: 300,
              ),
            ),
            Align(
              alignment: const Alignment(-0.4, 0.3),
              child: IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        TakePictureScreen(camera: widget.camera),
                  ));
                },
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.3),
              child: IconButton(
                icon: const Icon(Icons.camera),
                onPressed: _navigateAndDisplayPicture,
              ),
            ),
            Align(
              alignment: const Alignment(0.4, 0.3),
              child: IconButton(
                icon: const Icon(Icons.photo_album),
                onPressed: _pickImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
