import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../data/models/service.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import '../../logic/providers/user_data_provider.dart';
import '../router/custom_page_route.dart';
import '../screens/service_screen.dart';
import 'add_to_package_modal.dart';
import 'custom_snack_bar.dart';

class ServiceContainer extends StatelessWidget {
  const ServiceContainer({
    required this.service,
    Key? key,
  }) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<UserDataProvider>(
      context,
      listen: false,
    ).getId();

    return Container(
      padding: const EdgeInsets.all(padding),
      margin: const EdgeInsets.only(bottom: padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // seller Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      service.seller.name[0],
                      style:
                          Theme.of(context).primaryTextTheme.bodyMedium!.apply(
                                color: Theme.of(context).colorScheme.surface,
                                fontWeightDelta: 2,
                              ),
                    ),
                  ),
                  const SizedBox(width: padding),
                  Text(
                    service.seller.name,
                    style: Theme.of(context).primaryTextTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: padding / 2),
          const Divider(),
          const SizedBox(height: padding / 2),

          // image
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 180),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.network(
                service.coverImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    padding: const EdgeInsets.all(padding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Center(
                      child: Text(
                        'Error occured while fetching image.',
                        style: Theme.of(context).primaryTextTheme.bodyMedium,
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return Container(
                    padding: const EdgeInsets.all(padding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
              ),
            ),
          ),

          // white space
          const SizedBox(height: padding),

          // details
          Text(
            service.title,
            style: Theme.of(context).primaryTextTheme.titleLarge,
          ),

          const SizedBox(height: padding / 4),

          Text(
            'Rs. ${service.price.toDouble()}',
            style: Theme.of(context).primaryTextTheme.titleMedium!.apply(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),

          const SizedBox(height: padding / 4),

          Text(
            service.description,
            style: Theme.of(context).primaryTextTheme.bodyMedium,
            maxLines: 5,
          ),
          Text(
            '...',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),

          const SizedBox(height: padding / 2),
          const Divider(),
          const SizedBox(height: padding / 2),

          // learn more, add to package,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    CustomPageRoute(
                      child: BlocProvider.value(
                        value: BlocProvider.of<GetPackagesBloc>(context),
                        child: ServiceScreen(service: service),
                      ),
                    ),
                  );
                },
                child: const Text('Learn more'),
              ),
              IconButton(
                onPressed: () {
                  if (userId == service.seller.id) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {},
                        ),
                        content: const CustomSnackbar(
                          snackbarType: SnackbarType.info,
                          title: 'Info',
                          description:
                              'You cannot buy or review your own services',
                        ),
                      ),
                    );

                    return;
                  }

                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (contextBuilder) {
                      return AddToPackageModal(
                        serviceId: service.id,
                        getPackagesBloc:
                            BlocProvider.of<GetPackagesBloc>(context),
                      );
                    },
                  );
                },
                constraints: const BoxConstraints(),
                icon: const Icon(PhosphorIcons.listPlus),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
