import 'dart:async';
import 'dart:math';
import 'dart:ui' as UI;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUtils {

  // Find a bounds that contains all LatLng on the list
  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;

    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }

    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  // Create a marker bitmap
  static Future<BitmapDescriptor> createMarkerBitmap(
      String title, TextStyle? titleTextStyle, bool includeTitle) async {
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);

    // Draw place marker
    const icon = Icons.place;
    TextPainter iconPainter = TextPainter(
        text: TextSpan(
            text: String.fromCharCode(icon.codePoint),
            style: TextStyle(
                fontSize: 40.0,
                fontFamily: icon.fontFamily,
                color: Colors.red)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    iconPainter.layout();

    int iconWidth = iconPainter.width.toInt();
    int iconHeight = iconPainter.height.toInt();

    int totalWidth = iconWidth;
    int totalHeight = iconHeight;

    // Draw title if necessary
    if (includeTitle) {
      const makerBoxPadding = 5;
      TextPainter textPainter = TextPainter(
        text: TextSpan(text: title, style: titleTextStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      int textWidth = textPainter.width.toInt();
      int textHeight = textPainter.height.toInt();

      totalWidth = max(textWidth, iconWidth) + makerBoxPadding * 2;
      totalHeight += textHeight;

      UI.Image image = await loadUiImage("assets/images/marker_box.png");
      paintImage(
        canvas: canvas,
        rect: Rect.fromLTRB(0, 0, totalWidth.toDouble(), textHeight.toDouble()),
        fit: BoxFit.fitWidth,
        image: image,
      );

      textPainter.paint(canvas, Offset(makerBoxPadding.toDouble(), 0));
      iconPainter.paint(canvas,
          Offset((totalWidth / 2) - (iconWidth / 2), textHeight.toDouble()));
    } else {
      iconPainter.paint(canvas, const Offset(0, 0));
    }

    Picture p = recorder.endRecording();
    ByteData? pngBytes = await (await p.toImage(totalWidth, totalHeight))
        .toByteData(format: ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes!.buffer);

    return BitmapDescriptor.bytes(data);
  }
}

Future<UI.Image> loadUiImage(String imageAssetPath) async {
  final ByteData data = await rootBundle.load(imageAssetPath);
  final Completer<UI.Image> completer = Completer();
  UI.decodeImageFromList(Uint8List.view(data.buffer), (UI.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}
