part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

class GetServices extends ServiceEvent {
  final String category;

  const GetServices({required this.category});

  @override
  List<Object> get props => [];
}
