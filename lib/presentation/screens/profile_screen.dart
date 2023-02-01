import 'package:event_planner/presentation/widgets/sell_services_container.dart';
import 'package:event_planner/presentation/widgets/user_services_container.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../data/repositories/service_repository.dart';
import '../../logic/bloc/get_user_services_bloc.dart';
import '../widgets/buyer_dashboard.dart';
import '../widgets/header.dart';
import '../widgets/seller_dashboard.dart';
import '../widgets/user_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late GetUserServicesBloc _getUserServicesBloc;

  @override
  void initState() {
    _getUserServicesBloc = GetUserServicesBloc(
      serviceRepository: ServiceRepository(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _getUserServicesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Header(title: 'Profile'),
              const SizedBox(height: padding),
              const UserCard(),
              const SizedBox(height: padding),
              const BuyerDashboard(),
              const SizedBox(height: padding),
              const SellerDashboard(),
              const SizedBox(height: padding),
              UserServicesContainer(
                getUserServicesBloc: _getUserServicesBloc,
              ),
              const SizedBox(height: padding),
              SellServicesContainer(
                getUserServicesBloc: _getUserServicesBloc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
