import 'package:flutter/material.dart';

import '../../data/models/package.dart';
import '../../logic/bloc/get_orders_bloc.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import 'package_details_modal.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    required this.package,
    required this.getPackagesBloc,
    required this.getOrdersBloc,
    Key? key,
  }) : super(key: key);

  final Package package;
  final GetPackagesBloc getPackagesBloc;
  final GetOrdersBloc getOrdersBloc;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return PackageDetailsModal(
              package: package,
              getPackagesBloc: getPackagesBloc,
              getOrdersBloc: getOrdersBloc,
            );
          },
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
              text: 'Items: ',
              style: Theme.of(context).primaryTextTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '${package.services.length}',
                  style: Theme.of(context).primaryTextTheme.bodyMedium!.apply(
                        fontWeightDelta: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
