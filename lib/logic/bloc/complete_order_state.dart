part of 'complete_order_bloc.dart';

abstract class CompleteOrderState extends Equatable {
  const CompleteOrderState();

  @override
  List<Object> get props => [];
}

class CompleteOrderInitial extends CompleteOrderState {}

class CompleteOrderLoading extends CompleteOrderState {}

class CompleteOrderSuccess extends CompleteOrderState {}

class CompleteOrderFailure extends CompleteOrderState {
  final String error;

  const CompleteOrderFailure({required this.error});

  @override
  List<Object> get props => [];
}
