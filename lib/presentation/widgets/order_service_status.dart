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
          : const Color(0xFF00a28e).withAlpha(30),
      child: Icon(
        status == Status.pending ? PhosphorIcons.clock : PhosphorIcons.check,
        size: 15,
        color: status == Status.pending ? Colors.red : const Color(0xFF00a28e),
      ),
    );
  }
}
