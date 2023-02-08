import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../data/models/service.dart';
import '../../logic/bloc/get_packages_bloc.dart';
import '../router/custom_page_route.dart';
import '../screens/service_screen.dart';

class ServiceContainer extends StatelessWidget {
  const ServiceContainer({
    required this.service,
    Key? key,
  }) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
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
                    child: const Icon(PhosphorIcons.userCircle),
                  ),
                  const SizedBox(width: padding),
                  Text(
                    service.seller.name,
                    style: Theme.of(context).primaryTextTheme.bodyMedium,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                constraints: const BoxConstraints(),
                icon: const Icon(PhosphorIcons.dotsThreeVerticalBold),
              ),
            ],
          ),

          // white space
          const SizedBox(height: padding),

          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.network(
              service.coverImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 50,
                  padding: const EdgeInsets.all(5),
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
            ),
          ),

          // Container(
          //   height: 200,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(radius),
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          // ),

          // white space
          const SizedBox(height: padding),

          // details
          Text(
            service.title,
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            service.price.toString(),
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            service.description,
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            service.location,
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),
          Text(
            service.ratingsAverage.toString(),
            style: Theme.of(context).primaryTextTheme.bodyMedium,
          ),

          // white space
          // const SizedBox(height: padding),
          const Divider(),
          const SizedBox(height: padding),

          // learn more, save for later, add to package,
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

              // Row
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    icon: const Icon(PhosphorIcons.bookmarkSimple),
                  ),
                  const SizedBox(width: padding),
                  IconButton(
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    icon: const Icon(PhosphorIcons.listPlus),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
