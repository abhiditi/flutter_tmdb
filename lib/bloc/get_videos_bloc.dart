import 'package:flutter/cupertino.dart';
import 'package:fluttertmdb/model/video_response.dart';
import 'package:fluttertmdb/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieVideosBloc {
  final MovieRepo _repo = MovieRepo();
  final BehaviorSubject<VideoResponse> _subject =
      BehaviorSubject<VideoResponse>();
  getMovieVideos(int id) async {
    VideoResponse response = await _repo.getMovieVideos(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<VideoResponse> get subject => _subject;
}

final movieVideosBloc = MovieVideosBloc();
