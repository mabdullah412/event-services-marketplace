import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/enums.dart';

class OrderServiceStatus extends StatelessWidget {
  const OrderServiceStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  final Status status;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: status == Status.pending
          ? Colors.red.withAlpha(30)
          : status == Status.completed
              ? const Color(0xFF00a28e).withAlpha(30)
              : const Color(0xFFec6f01).withAlpha(30),
      child: Icon(
        status == Status.pending
            ? PhosphorIcons.clock
            : status == Status.completed
                ? PhosphorIcons.check
                : PhosphorIcons.x,
        size: 15,
        color: status == Status.pending
            ? Colors.red
            : status == Status.completed
                ? const Color(0xFF00a28e)
                : const Color(0xFFec6f01),
      ),
    );
  }
}
