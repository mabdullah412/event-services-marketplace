part of 'cancel_order_bloc.dart';

abstract class CancelOrderState extends Equatable {
  const CancelOrderState();

  @override
  List<Object> get props => [];
}

class CancelOrderInitial extends CancelOrderState {}

class CancelOrderLoading extends CancelOrderState {}

class CancelOrderSuccess extends CancelOrderState {}

class CancelOrderFailure extends CancelOrderState {
  final String error;

  const CancelOrderFailure({required this.error});

  @override
  List<Object> get props => [];
}
