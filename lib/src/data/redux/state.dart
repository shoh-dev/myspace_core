import 'package:equatable/equatable.dart';

sealed class ReduxStateStatus extends Equatable {
  const ReduxStateStatus();
}

class StateInitial extends ReduxStateStatus {
  const StateInitial();

  @override
  List<Object?> get props => [];
}

class ReduxStateLoading extends ReduxStateStatus {
  const ReduxStateLoading();

  @override
  List<Object?> get props => [];
}

class ReduxStateLoaded extends ReduxStateStatus {
  const ReduxStateLoaded();

  @override
  List<Object?> get props => [];
}

class ReduxStateError extends ReduxStateStatus {
  final String message;

  const ReduxStateError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return message;
  }
}

extension StateStatusX on ReduxStateStatus {
  bool get isInitial => this is StateInitial;
  bool get isLoading => this is ReduxStateLoading;
  bool get isLoaded => this is ReduxStateLoaded;
  bool get isError => this is ReduxStateError;
}

abstract class ReduxState extends Equatable {
  final ReduxStateStatus status;

  const ReduxState({
    required this.status,
  });

  @override
  List<Object?> get props => [status];

  ReduxState copyWith({
    ReduxStateStatus? status,
  });
}
