import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/core/theme.dart';

enum ListTileType { darkTrailerIcon, darkTrailerText, lightTrailerIcon }

class AppListTile extends StatelessWidget {
  final void Function()? onPressed;
  final IconData leading;
  final String title;
  final String? trailerText;
  final ListTileType type;
  const AppListTile._({
    required this.leading,
    required this.type,
    required this.title,
    this.trailerText,
    this.onPressed,
  });

  factory AppListTile.darkTrailerIcon({
    void Function()? onPressed,
    required IconData leading,
    required String title,
  }) {
    return AppListTile._(
      onPressed: onPressed,
      leading: leading,
      type: ListTileType.darkTrailerIcon,
      title: title,
    );
  }

  factory AppListTile.lightTrailerIcon({
    void Function()? onPressed,
    required IconData leading,
    required String title,
  }) {
    return AppListTile._(
      onPressed: onPressed,
      leading: leading,
      type: ListTileType.lightTrailerIcon,
      title: title,
    );
  }

  factory AppListTile.darkTrailerText(
      {void Function()? onPressed,
      required IconData leading,
      required String title,
      required String trailerText}) {
    return AppListTile._(
      onPressed: onPressed,
      leading: leading,
      type: ListTileType.darkTrailerText,
      title: title,
      trailerText: trailerText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      ListTileType.darkTrailerIcon => Container(
          color: Colors.black,
          child: ListTile(
            onTap: onPressed,
            leading: Icon(
              leading,
              color: Colors.white,
            ),
            title: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppTheme.primaryButtonFontSize),
            ),
            trailing: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 21,
            ),
          ),
        ),
      ListTileType.lightTrailerIcon => ListTile(
          onTap: onPressed,
          leading: Icon(
            leading,
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: AppTheme.primaryButtonFontSize),
          ),
          trailing: const Icon(
            Icons.play_arrow,
            size: 21,
          ),
        ),
      ListTileType.darkTrailerText => Container(
          color: Colors.black,
          child: ListTile(
              onTap: onPressed,
              leading: Icon(
                leading,
                color: Colors.white,
              ),
              title: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppTheme.primaryButtonFontSize),
              ),
              trailing: Text(
                trailerText!,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppTheme.primaryButtonFontSize),
              )),
        ),
    };
  }
}
