import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../data/models/service.dart';
import '../../data/repositories/service_repository.dart';
import '../../logic/bloc/get_services_bloc.dart';
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
  late GetServicesBloc _getServiceBloc;

  @override
  void initState() {
    _getServiceBloc = GetServicesBloc(serviceRepository: ServiceRepository());
    _getServiceBloc.add(GetServices(category: categoryName.toLowerCase()));
    super.initState();
  }

  @override
  void dispose() {
    _getServiceBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PopHeader(title: categoryName),
              const SizedBox(height: padding),
              BlocBuilder<GetServicesBloc, GetServicesState>(
                bloc: _getServiceBloc,
                builder: (context, state) {
                  if (state is GetServicesLoading ||
                      state is GetServicesInitial) {
                    return const Center(
                      heightFactor: 10,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }

                  if (state is GetServicesSuccess) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.services.length,
                        itemBuilder: (context, index) {
                          final Service service = state.services[index];
                          return ServiceContainer(service: service);
                        },
                      ),
                    );
                  }

                  if (state is GetServicesFailure) {
                    // TODO: Create service failure placeholder
                  }

                  return const Text('Bloc Error');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
