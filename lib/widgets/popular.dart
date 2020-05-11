import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertmdb/bloc/get_movies_bloc.dart';
import 'package:fluttertmdb/model/movie.dart';
import 'package:fluttertmdb/model/movie_response.dart';
import 'package:fluttertmdb/screens/second_screen.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  void initState() {
    super.initState();
    moviesBloc..getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
        stream: moviesBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapShot) {
          if (snapShot.hasData) {
            if (snapShot.data.error != null && snapShot.data.error.length > 0) {
              return _buildErrorWidget(snapShot.data.error);
            }
            return _buildMoviesWidget(snapShot.data);
          } else if (snapShot.hasError) {
            return _buildErrorWidget(snapShot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Loading...")],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("some error occurred")],
      ),
    );
  }

  Widget _buildMoviesWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        child: Center(
          child: Text("Loading..."),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Container(
              width: 40.0,
              height: 80.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage("https://image.tmdb.org/t/p/w200/" +
                          movies[index].poster),
                      fit: BoxFit.cover)),
            ),
            title: Text(movies[index].title),
            subtitle: Text(movies[index].title),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(movie: movies[index])));
            },
          );
        },
      );
    }
  }
}
