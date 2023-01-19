part of 'get_services_bloc.dart';

abstract class GetServicesEvent extends Equatable {
  const GetServicesEvent();

  @override
  List<Object> get props => [];
}

class GetServices extends GetServicesEvent {
  final String category;

  const GetServices({required this.category});

  @override
  List<Object> get props => [];
}
