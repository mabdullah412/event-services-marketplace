part of 'place_order_bloc.dart';

abstract class PlaceOrderState extends Equatable {
  const PlaceOrderState();

  @override
  List<Object> get props => [];
}

class PlaceOrderInitial extends PlaceOrderState {}

class PlaceOrderLoading extends PlaceOrderState {}

class PlaceOrderSuccess extends PlaceOrderState {}

class PlaceOrderFailure extends PlaceOrderState {
  final String error;

  const PlaceOrderFailure({required this.error});

  @override
  List<Object> get props => [];
}
