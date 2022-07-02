import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';

class MockPopularTvBloc extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}

class PopularTVEventFake extends Fake implements PopularTvEvent {}

class PopularTVStateFake extends Fake implements PopularTvState {}
