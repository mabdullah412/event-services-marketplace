import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/service.dart';
import '../../data/repositories/package_repository.dart';
import '../../data/repositories/service_repository.dart';
import '../../logic/bloc/delete_service_bloc.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import '../../logic/bloc/get_user_services_bloc.dart';
import '../router/custom_page_route.dart';
import '../screens/service_screen.dart';

class UserServiceTile extends StatefulWidget {
  const UserServiceTile({
    required this.service,
    required this.getUserServicesBloc,
    Key? key,
  }) : super(key: key);

  final Service service;
  final GetUserServicesBloc getUserServicesBloc;

  @override
  State<UserServiceTile> createState() => _UserServiceTileState();
}

class _UserServiceTileState extends State<UserServiceTile> {
  GetUserServicesBloc get getUserServicesBloc => widget.getUserServicesBloc;
  Service get service => widget.service;

  late DeleteServiceBloc _deleteServiceBloc;

  @override
  void initState() {
    _deleteServiceBloc = DeleteServiceBloc(
      getUserServicesBloc: getUserServicesBloc,
      serviceRepository: ServiceRepository(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _deleteServiceBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: padding),
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(radius)),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(radius),
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    // color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Image.network(
                    service.coverImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(PhosphorIcons.xBold, size: 20),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: padding),
              Expanded(
                child: Text(
                  service.title,
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: padding / 4),
          const Divider(),
          const SizedBox(height: padding / 4),
          ItemField(
            title: 'Category',
            value: service.category,
          ),
          const SizedBox(height: padding / 2),
          ItemField(
            title: 'Reviews',
            value: service.ratingsQuantity.toString(),
          ),
          const SizedBox(height: padding / 2),
          ItemField(
            title: 'Price (Rs)',
            value: service.price.toString(),
          ),
          const SizedBox(height: padding / 4),
          const Divider(),
          const SizedBox(height: padding / 4),
          BlocBuilder<DeleteServiceBloc, DeleteServiceState>(
            bloc: _deleteServiceBloc,
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: state is DeleteServiceLoading
                          ? null
                          : () {
                              Navigator.of(context).push(
                                CustomPageRoute(
                                  // passing new instance just bcz it is needed in the
                                  // service screen,
                                  // No problem will occur,
                                  // bcz user cannot buy or review their own service.
                                  child: BlocProvider.value(
                                    value: GetPackagesBloc(
                                      packageRepository: PackageRepository(),
                                    ),
                                    child: ServiceScreen(service: service),
                                  ),
                                ),
                              );
                            },
                      icon:
                          const Icon(PhosphorIcons.arrowArcRightBold, size: 20),
                      label: const Text('Go To'),
                    ),
                  ),
                  const SizedBox(width: padding),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.error,
                      ),
                    ),
                    onPressed: state is DeleteServiceLoading
                        ? null
                        : () {
                            _deleteServiceBloc.add(
                              DeleteService(serviceId: service.id),
                            );
                          },
                    child: state is DeleteServiceLoading
                        ? const SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(PhosphorIcons.trashBold, size: 20),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ItemField extends StatelessWidget {
  const ItemField({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).primaryTextTheme.bodyMedium,
        ),
        Text(
          value,
          style: Theme.of(context).primaryTextTheme.bodyMedium!.apply(
                color: Theme.of(context).primaryTextTheme.bodyLarge!.color,
                fontWeightDelta: 1,
              ),
        ),
      ],
    );
  }
}
