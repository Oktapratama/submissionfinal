import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';

class MockTopTvBloc extends MockBloc<TopTvEvent, TopTvState>
    implements TopRatedTvBloc {}

class TopRatedTVStateFake extends Fake implements TopTvState {}

class TopRatedTVEventFake extends Fake implements TopTvEvent {}
