import 'package:flutter/material.dart';

/// Overlay widget that shows the receipt scanning frame
class CameraOverlay extends StatelessWidget {
  const CameraOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        // Calculate frame dimensions (roughly 80% of screen width, 60% of screen height)
        final frameWidth = screenWidth * 0.8;
        final frameHeight = screenHeight * 0.6;
        final frameLeft = (screenWidth - frameWidth) / 2;
        final frameTop = (screenHeight - frameHeight) / 2;

        return Stack(
          children: [
            // Semi-transparent overlay
            Container(
              color: Colors.black.withOpacity(0.4),
            ),

            // Cut out the frame area
            Positioned(
              left: frameLeft,
              top: frameTop,
              width: frameWidth,
              height: frameHeight,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),

            // Corner indicators
            ..._buildCornerIndicators(frameLeft, frameTop, frameWidth, frameHeight),

            // Scanning line animation
            _buildScanningLine(frameLeft, frameTop, frameWidth, frameHeight),
          ],
        );
      },
    );
  }

  List<Widget> _buildCornerIndicators(double left, double top, double width, double height) {
    const cornerSize = 24.0;
    const cornerWidth = 4.0;

    return [
      // Top-left corner
      Positioned(
        left: left - cornerWidth / 2,
        top: top - cornerWidth / 2,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white, width: cornerWidth),
              left: BorderSide(color: Colors.white, width: cornerWidth),
            ),
          ),
        ),
      ),

      // Top-right corner
      Positioned(
        left: left + width - cornerSize + cornerWidth / 2,
        top: top - cornerWidth / 2,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white, width: cornerWidth),
              right: BorderSide(color: Colors.white, width: cornerWidth),
            ),
          ),
        ),
      ),

      // Bottom-left corner
      Positioned(
        left: left - cornerWidth / 2,
        top: top + height - cornerSize + cornerWidth / 2,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: cornerWidth),
              left: BorderSide(color: Colors.white, width: cornerWidth),
            ),
          ),
        ),
      ),

      // Bottom-right corner
      Positioned(
        left: left + width - cornerSize + cornerWidth / 2,
        top: top + height - cornerSize + cornerWidth / 2,
        child: Container(
          width: cornerSize,
          height: cornerSize,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: cornerWidth),
              right: BorderSide(color: Colors.white, width: cornerWidth),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildScanningLine(double left, double top, double width, double height) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: const ScanningLine(),
    );
  }
}

/// Animated scanning line that moves up and down
class ScanningLine extends StatefulWidget {
  const ScanningLine({super.key});

  @override
  State<ScanningLine> createState() => _ScanningLineState();
}

class _ScanningLineState extends State<ScanningLine> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          left: 0,
          top: _animation.value * (context.findRenderObject() as RenderBox?)!.size.height,
          right: 0,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}