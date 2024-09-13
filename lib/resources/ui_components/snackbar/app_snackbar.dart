import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class AppSnackbar {
  AppSnackbar._();

  static void _showTopSnackBar(
    BuildContext context,
    Widget snackBar,
  ) {
    final overlay = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: snackBar,
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  static void showInfo(
    BuildContext context, {
    required String message,
  }) {
    _showTopSnackBar(
      context,
      SnackBarWidget(
        message: message,
        color: AppTheme.infoColor,
        showTrailerIcon: false,
      ),
    );
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    bool showTrailerIcon = true,
  }) {
    _showTopSnackBar(
      context,
      SnackBarWidget(
        message: message,
        color: AppTheme.successColor,
        showTrailerIcon: showTrailerIcon,
      ),
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    bool showTrailerIcon = true,
  }) {
    _showTopSnackBar(
      context,
      SnackBarWidget(
        message: message,
        color: AppTheme.errorColor,
        showTrailerIcon: showTrailerIcon,
      ),
    );
  }
}

class SnackBarWidget extends StatelessWidget {
  final String message;
  final Color color;
  final bool showTrailerIcon;

  const SnackBarWidget({
    super.key,
    required this.message,
    required this.color,
    this.showTrailerIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.primaryPadding,
          vertical: 8,
        ),
        child: Row(
          children: [
            SvgPicture.asset(AssetsPaths.errorMark),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
