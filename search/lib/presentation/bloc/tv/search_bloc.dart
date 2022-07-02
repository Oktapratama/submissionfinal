import 'package:core/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../domain/search_tv.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv tv;

  SearchTvBloc({required this.tv}) : super(TVSearchEmpty()) {
    on<OnTvQueryChanged>((event, emit) async {
      final dataQuery = event.query;

      emit(TvSearchLoading());
      final dataResult = await tv.execute(dataQuery);

      dataResult.fold((failure) {
        emit(TvSearchError(failure.message));
      }, (data) {
        emit(SearchTvData(data));
      });
    }, transformer: _debounceTV(const Duration(milliseconds: 500)));
  }

  EventTransformer<OnTVQueryChanged> _debounceTV<OnTVQueryChanged>(
      Duration dur) {
    return (events, mapper) => events.debounceTime(dur).switchMap(mapper);
  }
}
