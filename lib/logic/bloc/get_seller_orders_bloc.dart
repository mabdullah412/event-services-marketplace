import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/service.dart';
import '../../data/repositories/order_repository.dart';

part 'get_seller_orders_event.dart';
part 'get_seller_orders_state.dart';

class GetSellerOrdersBloc
    extends Bloc<GetSellerOrdersEvent, GetSellerOrdersState> {
  final OrderRepository orderRepository;

  GetSellerOrdersBloc({required this.orderRepository})
      : super(GetSellerOrdersInitial()) {
    on<GetSellerOrders>(_onGetSellerOrders);
  }

  Future<void> _onGetSellerOrders(
    GetSellerOrders event,
    Emitter<GetSellerOrdersState> emit,
  ) async {
    emit(GetSellerOrdersLoading());

    try {
      final List<Service> orders = await orderRepository.getSellerOrders();
      emit(GetSellerOrdersSuccess(orders: orders));
    } catch (err) {
      emit(GetSellerOrdersFailure(error: err.toString()));
    }
  }
}
