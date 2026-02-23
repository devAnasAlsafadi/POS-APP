import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  final int id;
  final String name;
  final String? mobile;

  const CustomerEntity({
    required this.id,
    required this.name,
    this.mobile,
  });

  @override
  List<Object?> get props => [id, name, mobile];
}
