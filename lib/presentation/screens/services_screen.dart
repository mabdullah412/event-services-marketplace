import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../data/repositories/service_repository.dart';
import '../widgets/pop_header.dart';
import '../widgets/service_container.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({
    required this.categoryName,
    super.key,
  });

  final String categoryName;

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String get categoryName => widget.categoryName;
  final ServiceRepository _serviceRepository = ServiceRepository();

  @override
  void initState() {
    getServices();
    super.initState();
  }

  Future<void> getServices() async {
    final data = await _serviceRepository.getServices(category: 'halls');
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PopHeader(title: widget.categoryName),
                const SizedBox(height: padding),
                const ServiceContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
