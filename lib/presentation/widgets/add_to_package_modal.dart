import 'package:event_planner/data/repositories/package_repository.dart';
import 'package:event_planner/logic/bloc/add_to_package_bloc.dart';
import 'package:event_planner/presentation/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/package.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import 'create_package_modal.dart';
import 'packages_container.dart';

class AddToPackageModal extends StatefulWidget {
  const AddToPackageModal({
    required this.serviceId,
    required this.getPackagesBloc,
    Key? key,
  }) : super(key: key);

  final String serviceId;
  final GetPackagesBloc getPackagesBloc;

  @override
  State<AddToPackageModal> createState() => _AddToPackageModalState();
}

class _AddToPackageModalState extends State<AddToPackageModal> {
  String get serviceId => widget.serviceId;
  GetPackagesBloc get getPackagesBloc => widget.getPackagesBloc;
  late AddToPackageBloc _addToPackageBloc;

  @override
  void initState() {
    _addToPackageBloc = AddToPackageBloc(
      packageRepository: PackageRepository(),
      getPackagesBloc: getPackagesBloc,
    );
    getPackagesBloc.add(GetPackages());
    super.initState();
  }

  @override
  void dispose() {
    _addToPackageBloc.close();
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
                  Text(
                    'Select Package',
                    style: Theme.of(context).primaryTextTheme.titleMedium,
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return CreatePackageModal(
                            getPackagesBloc: getPackagesBloc,
                          );
                        },
                      );
                    },
                    icon: const Icon(PhosphorIcons.plus),
                    label: const Text('Create New'),
                  ),
                ],
              ),
              const SizedBox(height: padding),
              BlocBuilder(
                bloc: _addToPackageBloc,
                builder: (context, state) {
                  if (state is AddToPackageLoading) {
                    return const AddingToPackageLoadingPlaceholder();
                  }

                  if (state is AddToPackageSuccess) {
                    // _onWidgetDidBuild displays snackbar after
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
                            description:
                                'Service added to Package Successfully',
                            snackbarType: SnackbarType.success,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  }

                  if (state is AddToPackageFailure) {
                    // _onWidgetDidBuild displays snackbar after
                    // Build() has finished building
                    _onWidgetDidBuild(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: 'close',
                            onPressed: () {},
                          ),
                          content: const CustomSnackbar(
                            title: 'Error',
                            description:
                                'Error occured while adding serice to package.',
                            snackbarType: SnackbarType.error,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  }

                  return Container();
                },
              ),
              BlocBuilder<GetPackagesBloc, GetPackagesState>(
                bloc: getPackagesBloc,
                builder: (context, state) {
                  if (state is GetPackagesLoading ||
                      state is GetPackagesInitial) {
                    return const Padding(
                      padding: EdgeInsets.only(top: padding),
                      child: Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  }

                  if (state is GetPackagesSuccess) {
                    if (state.packages.isEmpty) {
                      return const NoPackagesPlaceholder();
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.packages.length,
                      itemBuilder: (context, index) {
                        final Package package = state.packages[index];
                        return AddServiceToPackageButton(
                          package: package,
                          serviceId: serviceId,
                          addToPackageBloc: _addToPackageBloc,
                        );
                      },
                    );
                  }

                  if (state is GetPackagesFailure) {
                    return const GetPackagesFailurePlaceholder();
                  }

                  return const Text('Bloc Error');
                },
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

class AddServiceToPackageButton extends StatelessWidget {
  /// A package card/button used to display availible packages while
  /// adding serive.

  const AddServiceToPackageButton({
    Key? key,
    required this.package,
    required this.serviceId,
    required this.addToPackageBloc,
  }) : super(key: key);

  final Package package;
  final String serviceId;
  final AddToPackageBloc addToPackageBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToPackageBloc, AddToPackageState>(
      bloc: addToPackageBloc,
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: padding / 2),
          child: OutlinedButton(
            onPressed: state is AddToPackageLoading
                ? null
                : () {
                    addToPackageBloc.add(
                      AddToPackage(packageId: package.id, serviceId: serviceId),
                    );
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    package.name,
                    style: Theme.of(context).primaryTextTheme.bodyMedium,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).primaryTextTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: '${package.services.length}',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium!
                            .apply(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeightDelta: 2,
                            ),
                      ),
                      const TextSpan(text: ' services'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddingToPackageLoadingPlaceholder extends StatelessWidget {
  const AddingToPackageLoadingPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
            const SizedBox(width: padding),
            Text(
              'adding to package',
              style: Theme.of(context).primaryTextTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: padding),
      ],
    );
  }
}
