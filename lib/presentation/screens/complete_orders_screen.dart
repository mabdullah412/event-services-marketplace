import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../data/models/service.dart';
import '../../logic/bloc/get_seller_orders_bloc.dart';
import '../widgets/pop_header.dart';
import '../widgets/seller_order_item.dart';

class CompleteOrdersScreen extends StatefulWidget {
  const CompleteOrdersScreen({
    required this.getSellerOrdersBloc,
    super.key,
  });

  final GetSellerOrdersBloc getSellerOrdersBloc;

  @override
  State<CompleteOrdersScreen> createState() => _CompleteOrdersScreenState();
}

class _CompleteOrdersScreenState extends State<CompleteOrdersScreen> {
  GetSellerOrdersBloc get getSellerOrdersBloc => widget.getSellerOrdersBloc;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PopHeader(title: 'Complete Orders'),
              const SizedBox(height: padding),
              BlocBuilder<GetSellerOrdersBloc, GetSellerOrdersState>(
                bloc: getSellerOrdersBloc,
                builder: (context, state) {
                  if (state is GetSellerOrdersLoading ||
                      state is GetSellerOrdersInitial) {
                    return Container(
                      padding: const EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(radius),
                        ),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      child: const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is GetSellerOrdersSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        final Service service = state.orders[index];
                        return SellerOrderItem(
                          service: service,
                          getSellerOrdersBloc: getSellerOrdersBloc,
                        );
                      },
                    );
                  }

                  return const Text('Bloc Error');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
