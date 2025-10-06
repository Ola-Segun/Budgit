import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/receipt_scanning_repository_impl.dart';
import '../../data/services/camera_service.dart';
import '../../domain/usecases/process_receipt_image.dart';
import '../states/receipt_scanning_state.dart';

/// Provider for receipt scanning repository
final receiptScanningRepositoryProvider = Provider<ReceiptScanningRepositoryImpl>(
  (ref) => ReceiptScanningRepositoryImpl(),
);

/// Provider for camera service
final cameraServiceProvider = Provider<CameraService>(
  (ref) => CameraService(),
);

/// Provider for process receipt image use case
final processReceiptImageProvider = Provider<ProcessReceiptImage>(
  (ref) => ProcessReceiptImage(ref.watch(receiptScanningRepositoryProvider)),
);

/// State notifier provider for receipt scanning
final receiptScanningProvider = StateNotifierProvider<ReceiptScanningNotifier, ReceiptScanningState>(
  (ref) => ReceiptScanningNotifier(
    cameraService: ref.watch(cameraServiceProvider),
    processReceiptImage: ref.watch(processReceiptImageProvider),
  ),
);

/// Notifier for managing receipt scanning state
class ReceiptScanningNotifier extends StateNotifier<ReceiptScanningState> {
  final CameraService _cameraService;
  final ProcessReceiptImage _processReceiptImage;

  ReceiptScanningNotifier({
    required CameraService cameraService,
    required ProcessReceiptImage processReceiptImage,
  })  : _cameraService = cameraService,
        _processReceiptImage = processReceiptImage,
        super(const ReceiptScanningState());

  /// Initialize the camera
  Future<void> initializeCamera() async {
    state = state.copyWith(isInitializing: true, error: null);

    final result = await _cameraService.initialize();

    result.when(
      success: (_) {
        state = state.copyWith(
          isInitializing: false,
          isInitialized: true,
        );
      },
      error: (failure) {
        state = state.copyWith(
          isInitializing: false,
          error: failure.message,
        );
      },
    );
  }

  /// Capture receipt using camera
  Future<void> captureReceipt() async {
    if (!state.isInitialized) return;

    state = state.copyWith(isProcessing: true, error: null);

    final result = await _cameraService.takePicture();

    await result.when(
      success: (image) async => await _processImage(image),
      error: (failure) {
        state = state.copyWith(
          isProcessing: false,
          error: failure.message,
        );
      },
    );
  }

  /// Pick image from gallery
  Future<void> pickFromGallery() async {
    state = state.copyWith(isProcessing: true, error: null);

    final result = await _cameraService.pickFromGallery();

    await result.when(
      success: (image) async {
        if (image != null) {
          await _processImage(image);
        } else {
          state = state.copyWith(isProcessing: false);
        }
      },
      error: (failure) {
        state = state.copyWith(
          isProcessing: false,
          error: failure.message,
        );
      },
    );
  }

  /// Process the captured image
  Future<void> _processImage(File image) async {
    final result = await _processReceiptImage(image);

    result.when(
      success: (receiptData) {
        state = state.copyWith(
          isProcessing: false,
          receiptData: receiptData,
        );
        // Navigation will be handled by the screen
      },
      error: (failure) {
        state = state.copyWith(
          isProcessing: false,
          error: failure.message,
        );
      },
    );
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Reset state
  void reset() {
    state = const ReceiptScanningState();
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }
}