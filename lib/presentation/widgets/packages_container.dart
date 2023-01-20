import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../data/models/package.dart';
import '../../data/repositories/package_repository.dart';
import '../../logic/bloc/create_package_bloc.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import 'package_card.dart';

class PackagesContainer extends StatefulWidget {
  const PackagesContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<PackagesContainer> createState() => _PackagesContainerState();
}

class _PackagesContainerState extends State<PackagesContainer> {
  final PackageRepository packageRepository = PackageRepository();
  late GetPackagesBloc _getPackagesBloc;

  @override
  void initState() {
    _getPackagesBloc = GetPackagesBloc(packageRepository: packageRepository);
    _getPackagesBloc.add(GetPackages());
    super.initState();
  }

  @override
  void dispose() {
    _getPackagesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder(
            bloc: _getPackagesBloc,
            builder: (context, state) {
              if (state is GetPackagesLoading || state is GetPackagesInitial) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
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
                    return PackageCard(package: package);
                  },
                );
              }

              if (state is GetPackagesFailure) {
                return const GetPackagesFailurePlaceholder();
              }

              return const Text('Bloc Error');
            },
          ),
          const SizedBox(height: padding),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return CreatePackageSnackBar(
                    getPackagesBloc: _getPackagesBloc,
                    packageRepository: packageRepository,
                  );
                },
              );
            },
            child: const Text('Create a package'),
          ),
        ],
      ),
    );
  }
}

class GetPackagesFailurePlaceholder extends StatelessWidget {
  const GetPackagesFailurePlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Error occured while fetching packages.',
          style: Theme.of(context).primaryTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class CreatePackageSnackBar extends StatefulWidget {
  const CreatePackageSnackBar({
    required this.getPackagesBloc,
    required this.packageRepository,
    Key? key,
  }) : super(key: key);

  final GetPackagesBloc getPackagesBloc;
  final PackageRepository packageRepository;

  @override
  State<CreatePackageSnackBar> createState() => _CreatePackageSnackBarState();
}

class _CreatePackageSnackBarState extends State<CreatePackageSnackBar> {
  GetPackagesBloc get getPackagesBloc => widget.getPackagesBloc;
  PackageRepository get packageRepository => widget.packageRepository;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _packageNameFocusNode = FocusNode();
  late CreatePackageBloc _createPackageBloc;
  String packageName = '';

  @override
  void initState() {
    _createPackageBloc = CreatePackageBloc(
      getPackagesBloc: getPackagesBloc,
      packageRepository: packageRepository,
    );
    super.initState();
  }

  @override
  void dispose() {
    _createPackageBloc.close();
    super.dispose();
  }

  Future<void> createPackage() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    _createPackageBloc.add(CreatePackage(name: packageName));
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
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create a package',
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
              const SizedBox(height: padding),
              Form(
                key: _formKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  keyboardType: TextInputType.name,
                  focusNode: _packageNameFocusNode,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Package name cannot be empty.';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    packageName = value!;
                  },
                  onFieldSubmitted: (value) {
                    _formKey.currentState!.validate();
                  },
                ),
              ),
              const SizedBox(height: padding),
              BlocBuilder<CreatePackageBloc, CreatePackageState>(
                bloc: _createPackageBloc,
                builder: (context, state) {
                  if (state is CreatePackageFailure) {
                    // _onWidgetDidBuild displays snackbar after
                    // Build() has finished building
                    _onWidgetDidBuild(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error creating package.'),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  }

                  if (state is CreatePackageSuccess) {
                    // _onWidgetDidBuild displays snackbar after
                    // Build() has finished building
                    _onWidgetDidBuild(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Package created.'),
                        ),
                      );
                      Navigator.pop(context);
                    });
                  }

                  return ElevatedButton(
                    onPressed:
                        state is CreatePackageLoading ? null : createPackage,
                    child: state is CreatePackageLoading
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : const Text('Create'),
                  );
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

class NoPackagesPlaceholder extends StatelessWidget {
  const NoPackagesPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'You have no packages.',
          style: Theme.of(context).primaryTextTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: padding),
        Text(
          'Packages work like carts, you can add as many items you want in a package and then checkout that package. You can also work with multiple packages at the same time.',
          style: Theme.of(context).primaryTextTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
