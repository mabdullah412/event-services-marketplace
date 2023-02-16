part of 'get_seller_orders_bloc.dart';

abstract class GetSellerOrdersState extends Equatable {
  const GetSellerOrdersState();

  @override
  List<Object> get props => [];
}

class GetSellerOrdersInitial extends GetSellerOrdersState {}

class GetSellerOrdersLoading extends GetSellerOrdersState {}

class GetSellerOrdersSuccess extends GetSellerOrdersState {
  final List<Service> orders;

  const GetSellerOrdersSuccess({required this.orders});

  @override
  List<Object> get props => [];
}

class GetSellerOrdersFailure extends GetSellerOrdersState {
  final String error;

  const GetSellerOrdersFailure({required this.error});

  @override
  List<Object> get props => [];
}
