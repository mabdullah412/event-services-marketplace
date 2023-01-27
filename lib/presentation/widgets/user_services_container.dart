import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../logic/bloc/get_user_services_bloc.dart';
import '../router/custom_page_route.dart';
import '../screens/service_screen.dart';

class UserServicesContainer extends StatefulWidget {
  const UserServicesContainer({
    required this.getUserServicesBloc,
    super.key,
  });

  final GetUserServicesBloc getUserServicesBloc;

  @override
  State<UserServicesContainer> createState() => _UserServicesContainerState();
}

class _UserServicesContainerState extends State<UserServicesContainer> {
  GetUserServicesBloc get getUserServicesBloc => widget.getUserServicesBloc;

  @override
  void initState() {
    getUserServicesBloc.add(GetUserServices());
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
          Text(
            'Your Services',
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          BlocBuilder<GetUserServicesBloc, GetUserServicesState>(
            bloc: getUserServicesBloc,
            builder: (context, state) {
              if (state is GetUserServicesLoading ||
                  state is GetUserServicesInitial) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              }

              if (state is GetUserServicesFailure) {
                return const GetUserServicesFailurePlaceholder();
              }

              if (state is GetUserServicesSuccess) {
                if (state.services.isEmpty) {
                  return const NoUserServicesPlaceholder();
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.services.length,
                  itemBuilder: (context, index) {
                    final service = state.services[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: padding),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            CustomPageRoute(
                              child: ServiceScreen(service: service),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(radius),
                                ),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: padding),
                            Expanded(
                              child: Text(
                                service.title,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}

class NoUserServicesPlaceholder extends StatelessWidget {
  const NoUserServicesPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: padding),
      child: Column(
        children: [
          Text(
            'You have not added any services for sale.',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class GetUserServicesFailurePlaceholder extends StatelessWidget {
  const GetUserServicesFailurePlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Error occured while fetching your services.',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
