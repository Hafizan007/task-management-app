import 'package:equatable/equatable.dart';

class StoreTaskParams extends Equatable {
  final String title;
  final String description;
  final DateTime dueDate;

  const StoreTaskParams({
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  List<Object?> get props => [title, description, dueDate];
}
