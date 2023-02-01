import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/order_repository.dart';
import 'get_orders_bloc.dart';

part 'cancel_order_event.dart';
part 'cancel_order_state.dart';

class CancelOrderBloc extends Bloc<CancelOrderEvent, CancelOrderState> {
  final OrderRepository orderRepository;
  final GetOrdersBloc getOrdersBloc;

  CancelOrderBloc({
    required this.orderRepository,
    required this.getOrdersBloc,
  }) : super(CancelOrderLoading()) {
    on<CancelOrder>(_onCancelOrder);
  }

  Future<void> _onCancelOrder(
    CancelOrder event,
    Emitter<CancelOrderState> emit,
  ) async {
    emit(CancelOrderLoading());

    try {
      final dynamic response = await orderRepository.cancelOrder(
        orderId: event.orderId,
      );

      if (response == false) {
        emit(const CancelOrderFailure(error: 'Token error'));
        return;
      }

      // recall getOrders after cancelling an order
      getOrdersBloc.add(GetOrders());

      emit(CancelOrderSuccess());
    } catch (err) {
      emit(CancelOrderFailure(error: err.toString()));
    }
  }
}
