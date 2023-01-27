import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../data/models/package.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import 'package_details_modal.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    required this.package,
    required this.getPackagesBloc,
    Key? key,
  }) : super(key: key);

  final Package package;
  final GetPackagesBloc getPackagesBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: padding),
      child: OutlinedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return PackageDetailsModal(
                package: package,
                getPackagesBloc: getPackagesBloc,
              );
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              package.name,
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                package.services.length.toString(),
                style: Theme.of(context).primaryTextTheme.bodySmall!.apply(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
