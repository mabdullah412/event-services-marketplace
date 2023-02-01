import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/order.dart';
import '../../data/repositories/order_repository.dart';

part 'get_orders_event.dart';
part 'get_orders_state.dart';

class GetOrdersBloc extends Bloc<GetOrdersEvent, GetOrdersState> {
  final OrderRepository orderRepository;

  GetOrdersBloc({
    required this.orderRepository,
  }) : super(GetOrdersInitial()) {
    on<GetOrders>(_onGetOrders);
  }

  Future<void> _onGetOrders(
    GetOrders event,
    Emitter<GetOrdersState> emit,
  ) async {
    emit(GetOrdersLoading());

    try {
      final List<Order> orders = await orderRepository.getOrders();
      emit(GetOrdersSuccess(orders: orders));
    } catch (err) {
      emit(GetOrdersFailure(error: err.toString()));
    }
  }
}
