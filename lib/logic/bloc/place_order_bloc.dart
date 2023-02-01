import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/order_repository.dart';
import 'get_orders_bloc.dart';

part 'place_order_event.dart';
part 'place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  final OrderRepository orderRepository;
  final GetOrdersBloc getOrdersBloc;

  PlaceOrderBloc({
    required this.orderRepository,
    required this.getOrdersBloc,
  }) : super(PlaceOrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onPlaceOrder(
    PlaceOrder event,
    Emitter<PlaceOrderState> emit,
  ) async {
    emit(PlaceOrderLoading());

    try {
      final dynamic response = await orderRepository.cancelOrder(
        orderId: event.packageId,
      );

      if (response == false) {
        emit(const PlaceOrderFailure(error: 'Token error'));
        return;
      }

      // recall getOrders after placing an order
      getOrdersBloc.add(GetOrders());

      emit(PlaceOrderSuccess());
    } catch (err) {
      emit(PlaceOrderFailure(error: err.toString()));
    }
  }
}
