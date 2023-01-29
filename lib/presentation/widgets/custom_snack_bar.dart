import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';

enum SnackbarType {
  info,
  success,
  warning,
  error,
}

class CustomSnackbar extends StatefulWidget {
  const CustomSnackbar({
    required this.title,
    this.description,
    required this.snackbarType,
    Key? key,
  }) : super(key: key);

  final SnackbarType snackbarType;
  final String title;
  final String? description;

  @override
  State<CustomSnackbar> createState() => _CustomSnackbarState();
}

class _CustomSnackbarState extends State<CustomSnackbar> {
  String get title => widget.title;
  String? get description => widget.description;
  SnackbarType get snackbarType => widget.snackbarType;

  late Icon icon;
  late Color color;

  @override
  void initState() {
    if (snackbarType == SnackbarType.success) {
      color = const Color(0xFF00a28e);
      icon = const Icon(
        PhosphorIcons.checkCircleFill,
        size: 20,
        color: Color(0xFF00a28e),
      );
    } else if (snackbarType == SnackbarType.info) {
      color = const Color(0xFF9E9DFF);
      icon = const Icon(
        PhosphorIcons.infoFill,
        size: 20,
        color: Color(0xFF9E9DFF),
      );
    } else if (snackbarType == SnackbarType.warning) {
      color = const Color(0xFFec6f01);
      icon = const Icon(
        PhosphorIcons.warningFill,
        size: 20,
        color: Color(0xFFec6f01),
      );
    } else if (snackbarType == SnackbarType.error) {
      color = const Color(0xFFfe5630);
      icon = const Icon(
        PhosphorIcons.xCircleFill,
        size: 20,
        color: Color(0xFFfe5630),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: padding),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyMedium!
                    .apply(color: color),
              ),
            ),
          ],
        ),
        if (description != null) const SizedBox(height: padding / 2),
        if (description != null)
          Text(
            description!,
            style: Theme.of(context).primaryTextTheme.bodySmall,
          ),
      ],
    );
  }
}
