import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../constants/enums.dart';
import '../../data/models/service.dart';
import '../../data/repositories/order_repository.dart';
import '../../logic/bloc/complete_order_bloc.dart';
import '../../logic/bloc/get_seller_orders_bloc.dart';
import '../widgets/order_service_status.dart';
import '../widgets/pop_header.dart';

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

class SellerOrderItem extends StatefulWidget {
  const SellerOrderItem({
    required this.service,
    required this.getSellerOrdersBloc,
    super.key,
  });

  final Service service;
  final GetSellerOrdersBloc getSellerOrdersBloc;

  @override
  State<SellerOrderItem> createState() => _SellerOrderItemState();
}

class _SellerOrderItemState extends State<SellerOrderItem> {
  GetSellerOrdersBloc get getSellerOrdersBloc => widget.getSellerOrdersBloc;
  Service get service => widget.service;

  bool dissableOnPressed = false;
  late CompleteOrderBloc _completeOrderBloc;

  @override
  void initState() {
    _completeOrderBloc = CompleteOrderBloc(
      orderRepository: OrderRepository(),
      getSellerOrdersBloc: getSellerOrdersBloc,
    );
    super.initState();
  }

  @override
  void dispose() {
    _completeOrderBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: padding / 2),
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.buyer!.name,
                  style: Theme.of(context).primaryTextTheme.bodySmall,
                ),
                const SizedBox(height: padding / 4),
                Text(
                  service.title,
                  style: Theme.of(context).primaryTextTheme.bodyLarge,
                ),
                const SizedBox(height: padding / 4),
                Text(
                  'Quantity: ${service.quantity}',
                  style: Theme.of(context).primaryTextTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (service.status! == Status.completed)
            OrderServiceStatus(status: service.status!),
          if (service.status! == Status.pending)
            ElevatedButton(
              onPressed: dissableOnPressed == false
                  ? () {
                      setState(() {
                        dissableOnPressed = true;
                      });

                      _completeOrderBloc.add(
                        CompleteOrder(orderId: service.orderItemId!),
                      );
                    }
                  : null,
              child: dissableOnPressed == false
                  ? const Icon(
                      PhosphorIcons.checkBold,
                      size: 20,
                    )
                  : const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}
