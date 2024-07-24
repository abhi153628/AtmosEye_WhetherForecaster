part of 'whether_bloc_bloc.dart';

sealed class WhetherBlocEvent extends Equatable {
  const WhetherBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWether extends WhetherBlocEvent {
  final Position position;
  const FetchWether(this.position);
  
  @override
  List<Object> get props => [position];
 
}
