import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../logic/bloc/get_user_services_bloc.dart';
import '../widgets/pop_header.dart';
import '../widgets/user_service_tile.dart';

class UserServicesScreen extends StatefulWidget {
  const UserServicesScreen({
    required this.getUserServicesBloc,
    super.key,
  });

  final GetUserServicesBloc getUserServicesBloc;

  @override
  State<UserServicesScreen> createState() => _UserServicesScreenState();
}

class _UserServicesScreenState extends State<UserServicesScreen> {
  GetUserServicesBloc get getUserServicesBloc => widget.getUserServicesBloc;

  @override
  void initState() {
    getUserServicesBloc.add(GetUserServices());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const PopHeader(title: 'Your Services'),
                const SizedBox(height: padding),
                BlocBuilder<GetUserServicesBloc, GetUserServicesState>(
                  bloc: getUserServicesBloc,
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    if (state is GetUserServicesLoading ||
                        state is GetUserServicesInitial) {
                      return const Center(
                        heightFactor: 10,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }

                    if (state is GetUserServicesSuccess) {
                      if (state.services.isEmpty) {
                        return const NoUserServicesPlaceholder();
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.services.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final service = state.services[index];
                          return UserServiceTile(
                            service: service,
                            getUserServicesBloc: getUserServicesBloc,
                          );
                        },
                      );
                    }

                    if (state is GetUserServicesFailure) {
                      return const GetUserServicesFailurePlaceholder();
                    }

                    return const Text('Bloc Error');
                  },
                ),
              ],
            ),
          ),
        ),
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
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(radius)),
        color: Theme.of(context).colorScheme.surface,
      ),
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
    return Container(
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(radius)),
        color: Theme.of(context).colorScheme.surface,
      ),
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
