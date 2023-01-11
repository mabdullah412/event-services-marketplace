import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/header.dart';
import '../widgets/orders_container.dart';
import '../widgets/packages_container.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Header(title: 'Orders'),
              SizedBox(height: padding),
              OrdersContainer(),
              SizedBox(height: padding),
              Header(title: 'Packages'),
              SizedBox(height: padding),
              PackagesContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
