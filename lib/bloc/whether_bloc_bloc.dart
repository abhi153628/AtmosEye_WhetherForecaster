import 'package:atmoseye/data/my_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'whether_bloc_event.dart';
part 'whether_bloc_state.dart';

class WhetherBlocBloc extends Bloc<WhetherBlocEvent, WhetherBlocState> {
  WhetherBlocBloc() : super(WhetherBlocInitial()) {
    on<FetchWether>((event, emit) async {
      emit(WhetherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
        Position position = await Geolocator.getCurrentPosition();

        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
            print(weather);
        emit(WhetherBlocSucess(weather));
      } catch (e) {
        emit(WhetherBlocFailure());
      }
    });
  }
}
