// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pro_image_editor/models/editor_image.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import '../../../widgets/auto_image.dart';
import '../types/filter_matrix.dart';
import 'filter_generator.dart';

/// Represents an image where filters and blur factors can be applied.
class FilteredImage extends StatelessWidget {
  /// The width of the image.
  final double width;

  /// The height of the image.
  final double height;

  /// The design mode of the image editor.
  final ImageEditorDesignModeE designMode;

  /// The list of filters to be applied on the image.
  final FilterMatrix filters;

  /// The editor image to display.
  final EditorImage image;

  /// How the image should be inscribed into the space allocated for it.
  final BoxFit fit;

  /// The blur factor
  final double blurFactor;

  const FilteredImage(
      {super.key,
      required this.width,
      required this.height,
      required this.designMode,
      required this.filters,
      required this.image,
      required this.blurFactor,
      this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    Widget img = AutoImage(
      image,
      fit: fit,
      width: width,
      height: height,
      designMode: designMode,
    );

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        // StackFit.expand is importent for [transformed_content_generator.dart]
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          img,
          ColorFilterGenerator(filters: filters, child: img),
          ClipRect(
            clipBehavior: Clip.hardEdge,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurFactor, sigmaY: blurFactor),
              child: Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
