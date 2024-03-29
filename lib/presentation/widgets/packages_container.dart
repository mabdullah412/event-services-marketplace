import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/package.dart';
import '../../logic/bloc/get_orders_bloc.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import 'create_package_modal.dart';
import 'package_card.dart';

class PackagesContainer extends StatefulWidget {
  const PackagesContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<PackagesContainer> createState() => _PackagesContainerState();
}

class _PackagesContainerState extends State<PackagesContainer> {
  late GetPackagesBloc _getPackagesBloc;

  @override
  void initState() {
    _getPackagesBloc = BlocProvider.of<GetPackagesBloc>(context);
    _getPackagesBloc.add(GetPackages());
    super.initState();
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
                return const Padding(
                  padding: EdgeInsets.only(top: padding, bottom: padding),
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
                    return Padding(
                      padding: const EdgeInsets.only(bottom: padding / 2),
                      child: PackageCard(
                        package: package,
                        getPackagesBloc: _getPackagesBloc,
                        getOrdersBloc: BlocProvider.of<GetOrdersBloc>(context),
                      ),
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
          const SizedBox(height: padding / 2),
          ElevatedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return CreatePackageModal(
                    getPackagesBloc: _getPackagesBloc,
                  );
                },
              );
            },
            icon: const Icon(PhosphorIcons.plusBold, size: 20),
            label: const Text('Create a package'),
          ),
          const SizedBox(height: padding / 2),
          OutlinedButton.icon(
            onPressed: () {
              _getPackagesBloc.add(GetPackages());
            },
            icon: const Icon(PhosphorIcons.arrowCounterClockwiseBold),
            label: const Text('Refresh'),
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
        const SizedBox(height: padding / 2),
      ],
    );
  }
}
