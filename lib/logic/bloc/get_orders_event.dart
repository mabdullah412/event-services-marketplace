part of 'get_orders_bloc.dart';

abstract class GetOrdersEvent extends Equatable {
  const GetOrdersEvent();

  @override
  List<Object> get props => [];
}

class GetOrders extends GetOrdersEvent {}
