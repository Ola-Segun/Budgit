import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/receipt_scanning_providers.dart';

/// Widget that displays the camera preview
class CameraPreviewWidget extends ConsumerWidget {
  const CameraPreviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraService = ref.watch(cameraServiceProvider);

    if (!cameraService.isInitialized || cameraService.controller == null) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: cameraService.controller!.value.previewSize!.height,
          height: cameraService.controller!.value.previewSize!.width,
          child: CameraPreview(cameraService.controller!),
        ),
      ),
    );
  }
}