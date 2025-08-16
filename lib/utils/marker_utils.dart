import 'dart:ui' as Dui;
import 'package:flutter/material.dart' as Fui;
import 'package:flutter/services.dart';

class MarkerUtils {
  /// Convert image to raw data for use in markers
  static Future<Uint8List> getImageFromRawData(String imagePath, double width) async {
    try {
      // Load image data
      final imageData = await rootBundle.load(imagePath);
      
      // Create image codec
      final imageCodec = await Dui.instantiateImageCodec(
        imageData.buffer.asUint8List(),
        targetWidth: width.round(),
      );
      
      // Get first frame
      final imageFrame = await imageCodec.getNextFrame();
      
      // Convert image to byte data
      final imageByteData = await imageFrame.image.toByteData(
        format: Dui.ImageByteFormat.png,
      );

      return imageByteData!.buffer.asUint8List();
    } catch (e) {
      print('Error converting image to raw data: $e');
      rethrow;
    }
  }

  /// Create circular marker image
  static Future<Uint8List> createCircularMarker({
    required String imagePath,
    required double size,
    required Dui.Color borderColor,
    double borderWidth = 3.0,
  }) async {
    try {
      // Load base image
      final imageData = await rootBundle.load(imagePath);
      final codec = await Dui.instantiateImageCodec(
        imageData.buffer.asUint8List(),
        targetWidth: size.toInt(),
        targetHeight: size.toInt(),
      );
      final frame = await codec.getNextFrame();
      final image = frame.image;

      // Create canvas for drawing
      final pictureRecorder = Dui.PictureRecorder();
      final canvas = Dui.Canvas(pictureRecorder);
      
      // Draw circular background
      final paint = Dui.Paint()
        ..color = borderColor
        ..style = Dui.PaintingStyle.fill;
      
      canvas.drawCircle(
        Dui.Offset(size / 2, size / 2),
        size / 2,
        paint,
      );

      // Draw image inside circle
      final imageSize = size - (borderWidth * 2);
      canvas.drawImageRect(
        image,
        Dui.Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Dui.Rect.fromLTWH(borderWidth, borderWidth, imageSize, imageSize),
        Dui.Paint(),
      );

      // Convert to data
      final picture = pictureRecorder.endRecording();
      final finalImage = await picture.toImage(size.toInt(), size.toInt());
      final byteData = await finalImage.toByteData(format: Dui.ImageByteFormat.png);

      return byteData!.buffer.asUint8List();
    } catch (e) {
      print('Error creating circular marker: $e');
      rethrow;
    }
  }

  /// Create marker with text
  static Future<Uint8List> createTextMarker({
    required String text,
    required double width,
    required double height,
    Dui.Color backgroundColor = const Dui.Color(0xFF4285F4),
    Dui.Color textColor = const Dui.Color(0xFFFFFFFF),
    double fontSize = 14.0,
  }) async {
    try {
      final pictureRecorder = Dui.PictureRecorder();
      final canvas = Dui.Canvas(pictureRecorder);

      // Draw background
      final backgroundPaint = Dui.Paint()
        ..color = backgroundColor
        ..style = Dui.PaintingStyle.fill;

      final rect = Dui.Rect.fromLTWH(0, 0, width, height);
      canvas.drawRRect(
        Dui.RRect.fromRectAndRadius(rect, const Dui.Radius.circular(8)),
        backgroundPaint,
      );

      // Add text
      final textSpan = Fui.TextSpan(
        text: text,
        style: Fui.TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: Dui.FontWeight.bold,
        ),
      );

      final textPainter = Fui.TextPainter(
        text: textSpan,
        textDirection: Dui.TextDirection.ltr,
        textAlign: Dui.TextAlign.center,
      );

      textPainter.layout(maxWidth: width);
      
      final xCenter = (width - textPainter.width) / 2;
      final yCenter = (height - textPainter.height) / 2;
      
      textPainter.paint(canvas, Dui.Offset(xCenter, yCenter));

      // Convert to image
      final picture = pictureRecorder.endRecording();
      final image = await picture.toImage(width.toInt(), height.toInt());
      final byteData = await image.toByteData(format: Dui.ImageByteFormat.png);

      return byteData!.buffer.asUint8List();
    } catch (e) {
      print('Error creating text marker: $e');
      rethrow;
    }
  }
}