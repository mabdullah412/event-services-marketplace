import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../data/models/service.dart';
import '../router/custom_page_route.dart';
import '../screens/service_screen.dart';

class PackageOrderServiceButton extends StatelessWidget {
  /// Service button for viewing in packages and orders.

  const PackageOrderServiceButton({
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
