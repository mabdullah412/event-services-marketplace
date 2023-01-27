import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/package.dart';
import '../../data/models/service.dart';
import '../router/custom_page_route.dart';
import '../screens/service_screen.dart';

class PackageCard extends StatelessWidget {
  const PackageCard({
    required this.package,
    Key? key,
  }) : super(key: key);

  final Package package;

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
              return PackageDetailsContainer(package: package);
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

class PackageDetailsContainer extends StatelessWidget {
  const PackageDetailsContainer({
    Key? key,
    required this.package,
  }) : super(key: key);

  final Package package;

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
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      PhosphorIcons.trash,
                      color: Theme.of(context).colorScheme.error,
                      size: 20,
                    ),
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
                  return PackageServiceButton(service: service);
                },
              ),
              if (package.services.isEmpty)
                Text(
                  'You have not yet added any service in this package.',
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
              const SizedBox(height: padding),
              ElevatedButton(
                onPressed: package.services.isEmpty ? null : () {},
                child: const Text('Place order'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PackageServiceButton extends StatelessWidget {
  const PackageServiceButton({
    Key? key,
    required this.service,
  }) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: padding / 2),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.of(context).push(
            CustomPageRoute(child: ServiceScreen(service: service)),
          );
        },
        elevation: 0,
        fillColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(radius),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      service.title,
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Rs. ',
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: '${service.price}',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyMedium!
                              .apply(
                                fontWeightDelta: 2,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
