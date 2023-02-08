import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../data/models/service.dart';
import '../../data/repositories/service_repository.dart';
import '../../logic/bloc/get_packages_bloc.dart';
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
                    if (state.services.isEmpty) {
                      return const NoServicesPlaceholder();
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.services.length,
                        itemBuilder: (context, index) {
                          final Service service = state.services[index];
                          return BlocProvider.value(
                            value: BlocProvider.of<GetPackagesBloc>(context),
                            child: ServiceContainer(service: service),
                          );
                        },
                      ),
                    );
                  }

                  if (state is GetServicesFailure) {
                    const GetServicesFailurePlaceholder();
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

class GetServicesFailurePlaceholder extends StatelessWidget {
  const GetServicesFailurePlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Error occured while fetching services.',
          style: Theme.of(context).primaryTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class NoServicesPlaceholder extends StatelessWidget {
  const NoServicesPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(radius)),
      ),
      child: Column(
        children: [
          Text(
            '0 services of this type at the moment.',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: padding / 2),
          Text(
            'Be sure to check back in a while.',
            style: Theme.of(context).primaryTextTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
