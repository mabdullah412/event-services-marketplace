part of 'get_orders_bloc.dart';

abstract class GetOrdersState extends Equatable {
  const GetOrdersState();

  @override
  List<Object> get props => [];
}

class GetOrdersInitial extends GetOrdersState {}

class GetOrdersLoading extends GetOrdersState {}

class GetOrdersSuccess extends GetOrdersState {
  final List<Order> orders;

  const GetOrdersSuccess({required this.orders});

  @override
  List<Object> get props => [];
}

class GetOrdersFailure extends GetOrdersState {
  final String error;

  const GetOrdersFailure({required this.error});

  @override
  List<Object> get props => [];
}
