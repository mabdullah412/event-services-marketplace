part of 'place_order_bloc.dart';

abstract class PlaceOrderEvent extends Equatable {
  const PlaceOrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrder extends PlaceOrderEvent {
  final String packageId;

  const PlaceOrder({required this.packageId});

  @override
  List<Object> get props => [];
}
