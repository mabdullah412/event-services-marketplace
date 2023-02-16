part of 'complete_order_bloc.dart';

abstract class CompleteOrderEvent extends Equatable {
  const CompleteOrderEvent();

  @override
  List<Object> get props => [];
}

class CompleteOrder extends CompleteOrderEvent {
  final String orderId;

  const CompleteOrder({required this.orderId});

  @override
  List<Object> get props => [];
}
