part of 'whether_bloc_bloc.dart';

sealed class WhetherBlocState extends Equatable {
  const WhetherBlocState();
  
  @override
  List<Object> get props => [];
}

final class WhetherBlocInitial extends WhetherBlocState {}

final class WhetherBlocLoading extends  WhetherBlocState {}

final class WhetherBlocFailure extends  WhetherBlocState {}

final class WhetherBlocSucess extends  WhetherBlocState{
  final Weather weather;
  WhetherBlocSucess(this.weather);
    @override
  List<Object> get props => [weather];
}
