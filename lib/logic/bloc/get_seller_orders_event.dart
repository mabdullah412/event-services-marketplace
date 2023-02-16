part of 'get_seller_orders_bloc.dart';

abstract class GetSellerOrdersEvent extends Equatable {
  const GetSellerOrdersEvent();

  @override
  List<Object> get props => [];
}

class GetSellerOrders extends GetSellerOrdersEvent {}
