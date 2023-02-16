import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/order_repository.dart';
import 'get_seller_orders_bloc.dart';

part 'complete_order_event.dart';
part 'complete_order_state.dart';

class CompleteOrderBloc extends Bloc<CompleteOrderEvent, CompleteOrderState> {
  final OrderRepository orderRepository;
  final GetSellerOrdersBloc getSellerOrdersBloc;

  CompleteOrderBloc({
    required this.orderRepository,
    required this.getSellerOrdersBloc,
  }) : super(CompleteOrderInitial()) {
    on<CompleteOrder>(_onCompleteOrder);
  }

  Future<void> _onCompleteOrder(
    CompleteOrder event,
    Emitter<CompleteOrderState> emit,
  ) async {
    emit(CompleteOrderLoading());

    try {
      final dynamic response = await orderRepository.completeOrder(
        orderId: event.orderId,
      );

      if (response == false) {
        emit(const CompleteOrderFailure(error: 'Token error'));
        return;
      }

      getSellerOrdersBloc.add(GetSellerOrders());

      emit(CompleteOrderSuccess());
    } catch (err) {
      emit(CompleteOrderFailure(error: err.toString()));
    }
  }
}
