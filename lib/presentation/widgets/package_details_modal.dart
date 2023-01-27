import 'package:event_planner/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/package.dart';
import '../../data/models/service.dart';
import '../../data/repositories/package_repository.dart';
import '../../logic/bloc/delete_package_bloc.dart';
import '../../logic/bloc/get_packages_bloc.dart';
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

  bool deletingPackage = false;
  late DeletePackageBloc _deletePackageBloc;

  @override
  void initState() {
    _deletePackageBloc = DeletePackageBloc(
      packageRepository: PackageRepository(),
      getPackagesBloc: getPackagesBloc,
    );
    super.initState();
  }

  @override
  void dispose() {
    _deletePackageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(padding),
          padding: const EdgeInsets.only(
            top: padding / 2,
            left: padding,
            right: padding,
            bottom: padding,
          ),
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
                  Text(
                    package.name,
                    style: Theme.of(context).primaryTextTheme.titleMedium,
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
                                title: 'Package deleted successfully',
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
                            deletingPackage = true;
                          });
                          _deletePackageBloc.add(
                            DeletePackage(packageId: package.id),
                          );
                        },
                        icon: state is DeletePackageLoading
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
              const SizedBox(height: padding / 2),
              RichText(
                text: TextSpan(
                  text: 'Date created: ',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text:
                          '${package.createdAt.year}-${package.createdAt.month}-${package.createdAt.day}',
                      style:
                          Theme.of(context).primaryTextTheme.bodyMedium!.apply(
                                fontWeightDelta: 2,
                              ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: padding),
              ListView.builder(
                shrinkWrap: true,
                itemCount: package.services.length,
                itemBuilder: (context, index) {
                  final Service service = package.services[index];
                  return PackageOrderServiceButton(service: service);
                },
              ),
              if (package.services.isEmpty)
                Text(
                  'You have not yet added any service in this package.',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
              const SizedBox(height: padding),
              ElevatedButton(
                onPressed:
                    package.services.isNotEmpty && deletingPackage == false
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
