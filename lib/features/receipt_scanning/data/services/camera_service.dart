import 'dart:io';

import 'package:budget_tracker/core/error/failures.dart';
import 'package:budget_tracker/core/error/result.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

/// Service for handling camera operations and image capture
class CameraService {
  CameraController? _controller;
  List<CameraDescription>? _cameras;

  /// Initialize the camera service
  Future<Result<void>> initialize() async {
    try {
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        return Result.error(UnknownFailure('No cameras available'));
      }

      // Use the first available camera (usually back camera)
      final camera = _cameras!.first;
      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();
      return Result.success(null);
    } catch (e) {
      return Result.error(UnknownFailure('Failed to initialize camera: $e'));
    }
  }

  /// Get the camera controller
  CameraController? get controller => _controller;

  /// Check if camera is initialized
  bool get isInitialized => _controller?.value.isInitialized ?? false;

  /// Capture a photo and return the file
  Future<Result<File>> takePicture() async {
    try {
      if (_controller == null || !_controller!.value.isInitialized) {
        return Result.error(UnknownFailure('Camera not initialized'));
      }

      final image = await _controller!.takePicture();
      return Result.success(File(image.path));
    } catch (e) {
      return Result.error(UnknownFailure('Failed to take picture: $e'));
    }
  }

  /// Pick image from gallery
  Future<Result<File?>> pickFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        return Result.success(null); // User cancelled
      }

      return Result.success(File(pickedFile.path));
    } catch (e) {
      return Result.error(UnknownFailure('Failed to pick image from gallery: $e'));
    }
  }

  /// Dispose of camera resources
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }
}