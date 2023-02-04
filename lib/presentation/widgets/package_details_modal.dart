import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/package.dart';
import '../../data/models/service.dart';
import '../../data/repositories/package_repository.dart';
import '../../logic/bloc/delete_package_bloc.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import '../../logic/bloc/remove_from_package_bloc.dart';
import 'custom_snack_bar.dart';
import 'package_order_service_button.dart';

class PackageDetailsModal extends StatefulWidget {
  /// Modal bottom sheet that shows details of the provided package.

  const PackageDetailsModal({
    Key? key,
    required this.package,
    required this.getPackagesBloc,
  }) : super(key: key);

  final Package package;
  final GetPackagesBloc getPackagesBloc;
  // final PlaceOrderBloc placeOrderBloc
  // final GetOrdersBloc getOrdersBloc

  @override
  State<PackageDetailsModal> createState() => _PackageDetailsModalState();
}

class _PackageDetailsModalState extends State<PackageDetailsModal> {
  GetPackagesBloc get getPackagesBloc => widget.getPackagesBloc;
  Package get package => widget.package;

  bool deleting = false;
  late int totalPrice;

  late DeletePackageBloc _deletePackageBloc;
  late RemoveFromPackageBloc _removeFromPackageBloc;
  final PackageRepository _packageRepository = PackageRepository();

  @override
  void initState() {
    _deletePackageBloc = DeletePackageBloc(
      packageRepository: _packageRepository,
      getPackagesBloc: getPackagesBloc,
    );

    _removeFromPackageBloc = RemoveFromPackageBloc(
      packageRepository: _packageRepository,
      getPackagesBloc: getPackagesBloc,
    );

    totalPrice = 0;
    for (var i = 0; i < package.services.length; i++) {
      totalPrice = totalPrice + package.services[i].price;
    }

    super.initState();
  }

  @override
  void dispose() {
    _deletePackageBloc.close();
    _removeFromPackageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(padding),
          padding: const EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.name,
                        style: Theme.of(context).primaryTextTheme.titleMedium,
                      ),
                      const SizedBox(height: padding / 4),
                      Text(
                        'Created on ${package.createdAt.year}-${package.createdAt.month}-${package.createdAt.day}',
                        style: Theme.of(context).primaryTextTheme.bodySmall,
                      ),
                    ],
                  ),
                  BlocConsumer<DeletePackageBloc, DeletePackageState>(
                    bloc: _deletePackageBloc,
                    listenWhen: (previous, current) {
                      return previous != current;
                    },
                    listener: (context, state) {
                      if (state is DeletePackageSuccess) {
                        _onWidgetDidBuild(() {
                          // _onWidgetDidBuild displays snackbar after
                          // Build() has finished building
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: 'close',
                                onPressed: () {},
                              ),
                              content: const CustomSnackbar(
                                title: 'Success',
                                description: 'Package deleted successfully',
                                snackbarType: SnackbarType.success,
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        });
                      }

                      if (state is DeletePackageFailure) {
                        _onWidgetDidBuild(() {
                          // _onWidgetDidBuild displays snackbar after
                          // Build() has finished building
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: 'close',
                                onPressed: () {},
                              ),
                              content: const CustomSnackbar(
                                title: 'Error',
                                description:
                                    'Error occured while removing package',
                                snackbarType: SnackbarType.error,
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        });
                      }
                    },
                    buildWhen: (previous, current) {
                      return previous != current;
                    },
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            deleting = true;
                          });
                          _deletePackageBloc.add(
                            DeletePackage(packageId: package.id),
                          );
                        },
                        icon: deleting == true
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                ),
                              )
                            : Icon(
                                PhosphorIcons.trash,
                                color: Theme.of(context).colorScheme.error,
                                size: 20,
                              ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: padding),
              Text(
                'Rs ${totalPrice.toDouble()}',
                style: Theme.of(context).primaryTextTheme.titleLarge,
              ),
              const Divider(),
              const SizedBox(height: padding),
              BlocConsumer<RemoveFromPackageBloc, RemoveFromPackageState>(
                bloc: _removeFromPackageBloc,
                listenWhen: (previous, current) => previous != current,
                listener: (context, state) {
                  if (state is RemoveFromPackageSuccess) {
                    // _onWidgetDidBuild executes below code after
                    // Build() has finished building
                    _onWidgetDidBuild(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: 'close',
                            onPressed: () {},
                          ),
                          content: const CustomSnackbar(
                            title: 'Success',
                            description: 'Service removed from package.',
                            snackbarType: SnackbarType.success,
                          ),
                        ),
                      );

                      Navigator.pop(context);
                    });
                  }

                  if (state is RemoveFromPackageFailure) {
                    _onWidgetDidBuild(() {
                      // _onWidgetDidBuild displays snackbar after
                      // Build() has finished building
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: 'close',
                            onPressed: () {},
                          ),
                          content: const CustomSnackbar(
                            title: 'Error',
                            description:
                                'Error occured while removing service from package',
                            snackbarType: SnackbarType.error,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  }
                },
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: package.services.length,
                    itemBuilder: (context, index) {
                      final Service service = package.services[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: padding / 2),
                        child: Row(
                          children: [
                            Expanded(
                              child: PackageOrderServiceButton(
                                service: service,
                                getPackagesBloc: getPackagesBloc,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  deleting = true;
                                });

                                _removeFromPackageBloc.add(
                                  RemoveFromPackage(
                                    packageId: package.id,
                                    serviceId: service.id,
                                  ),
                                );

                                // package.services.removeAt(index);

                                // setState(() {
                                //   deleting = false;
                                // });
                              },
                              icon: deleting == true
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      ),
                                    )
                                  : const Icon(
                                      PhosphorIcons.trashLight,
                                      size: 20,
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              if (package.services.isEmpty)
                Text(
                  'You have not yet added any service in this package.',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
              const SizedBox(height: padding),
              const Divider(),
              const SizedBox(height: padding / 2),
              ElevatedButton(
                onPressed: package.services.isNotEmpty && deleting == false
                    ? () {}
                    : null,
                child: const Text('Place order'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onWidgetDidBuild(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callback();
    });
  }
}
