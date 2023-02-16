import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/buyer_dashboard.dart';
import '../widgets/header.dart';
import '../widgets/seller_dashboard.dart';
import '../widgets/user_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Header(title: 'Profile'),
              SizedBox(height: padding),
              UserCard(),
              SizedBox(height: padding),
              BuyerDashboard(),
              SizedBox(height: padding),
              SellerDashboard(),
              SizedBox(height: padding),
            ],
          ),
        ),
      ),
    );
  }
}
