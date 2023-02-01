part of 'cancel_order_bloc.dart';

abstract class CancelOrderEvent extends Equatable {
  const CancelOrderEvent();

  @override
  List<Object> get props => [];
}

class CancelOrder extends CancelOrderEvent {
  final String orderId;

  const CancelOrder({required this.orderId});

  @override
  List<Object> get props => [];
}
