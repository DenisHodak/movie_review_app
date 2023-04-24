import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/movie_genres_widget.dart';
import '../widgets/custom_app_bar_widget.dart';
import '../widgets/loading_screen_failed_widget.dart';
import '../widgets/cast_widget.dart';
import '../widgets/loading_indicator_widget.dart';
import '../blocs/cubit/movie_details_cubit.dart';
import '../blocs/cubit/cast_cubit.dart';
import '../blocs/cubit/favorite_movies_cubit.dart';
import '../blocs/cubit/favorite_movie_cubit.dart';
import '../config/app_styles.dart';
import '../config/config.dart';
import '../constants/constants.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.movieId});
  final dynamic movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWidget(appBarTitle: Content.movieDetailsTitle),
        body: Stack(
          children: [
            // Screen background
            Container(
              decoration: Decorations.backgroundDecoration,
            ),
            // Movie details
            BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
              builder: (context, state) {
                if (state is MovieDetailsLoading) {
                  return const LoadingIndicatorWidget();
                } else if (state is MovieDetailsLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Movie poster
                        Container(
                          height: 250,
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: Styles.movieDetailsPosterGradientColor,
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            image: DecorationImage(
                              opacity: 0.7,
                              image: NetworkImage(
                                Config.imageUrl(
                                    state.movieDetails.backdropPath),
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // Movie title
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 4, left: 8, right: 8),
                          child: Text(
                            state.movieDetails.title,
                            style: TextStyle(
                              color: Styles.textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Movie info: release year, duration, rating
                        Row(
                          children: [
                            if (state.movieDetails.releaseDate?.year != null)
                              _textWithIcon(
                                  text: state.movieDetails.releaseDate!.year
                                      .toString(),
                                  icon: Icons.calendar_month_outlined),
                            if (state.movieDetails.duration != null)
                              _textWithIcon(
                                  text:
                                      "${state.movieDetails.duration!['hours']}h ${state.movieDetails.duration!['minutes']}m",
                                  icon: Icons.watch_later_outlined),
                            if (state.movieDetails.rating != 0.0)
                              _textWithIcon(
                                  text:
                                      "${state.movieDetails.rating.toStringAsFixed(2)}/10",
                                  icon: Icons.star,
                                  iconColor: Styles.starColor),
                          ],
                        ),
                        // Movie genres
                        if (state.movieDetails.genres != null)
                          MovieGenresWidget(genres: state.movieDetails.genres!),
                        _spacer(),
                        // Movie overview
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            state.movieDetails.overview,
                            style: TextStyle(
                                color: Styles.textColor, fontSize: 16),
                          ),
                        ),
                        _spacer(),
                        //Cast title
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            Content.movieCastTitle,
                            style: TextStyle(
                              color: Styles.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        // Cast slider
                        BlocBuilder<CastCubit, CastState>(
                          builder: (context, state) {
                            if (state is CastLoading) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: LoadingIndicatorWidget(),
                              );
                            } else if (state is CastLoaded) {
                              return SizedBox(
                                height: 275,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.cast.length,
                                  itemBuilder: (context, index) => CastWidget(
                                    cast: state.cast[index],
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 5.0),
                                child: Text(
                                  Content.movieCastErrorMessage,
                                  style: TextStyle(color: Styles.textColor),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return LoadingScreenFailedWidget(
                    loadingDataFailed: state is MovieDetailsLoadFailed,
                    onPressed: () => _openMovieDetails(movieId, context),
                  );
                }
              },
            ),
          ],
        ),
        // Save to favorites button.
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
            builder: (contextMovieDetails, stateMovieDetails) {
          if (stateMovieDetails is MovieDetailsLoaded) {
            BlocProvider.of<FavoriteMovieCubit>(context).checkMovieStatus(
                movie: stateMovieDetails.movieDetails,
                movieList: BlocProvider.of<FavoriteMoviesCubit>(context)
                    .state
                    .favoriteMovies);
            return BlocBuilder<FavoriteMovieCubit, FavoriteMovieState>(
              builder: (contextFavoriteMovie, stateFavoriteMovie) {
                return FloatingActionButton(
                  backgroundColor: Styles.floatingButtonBackgroundColor,
                  onPressed: () {
                    if (stateFavoriteMovie is MovieIsFavorite) {
                      _removeMovieFromFavorites(
                          stateMovieDetails.movieDetails, context);
                    }
                    if (stateFavoriteMovie is MovieIsNotFavorite) {
                      _addMovieToFavorites(
                          stateMovieDetails.movieDetails, context);
                    }
                  },
                  child: Icon(
                    Icons.favorite,
                    color: stateFavoriteMovie is MovieIsFavorite
                        ? Styles.favoriteColor
                        : Styles.notFavoriteColor,
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        }));
  }

  _openMovieDetails(movieId, context) {
    BlocProvider.of<MovieDetailsCubit>(context)
        .getMovieDetails(movieId: movieId);
  }

  _addMovieToFavorites(movieDetails, context) {
    BlocProvider.of<FavoriteMoviesCubit>(context).addToFavorites(movieDetails);
    BlocProvider.of<FavoriteMovieCubit>(context).selectMovieAsFavorite();
  }

  _removeMovieFromFavorites(movieDetails, context) {
    BlocProvider.of<FavoriteMoviesCubit>(context)
        .removeFromFavorites(movieDetails);
    BlocProvider.of<FavoriteMovieCubit>(context).unselectMovieAsFavorite();
  }

  _textWithIcon(
      {required String text, required IconData icon, Color? iconColor}) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 4.0),
          child: Icon(
            icon,
            size: 15,
            color: iconColor ?? Styles.textColor,
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Styles.textColor, fontSize: 15),
        )
      ],
    );
  }

  _spacer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Divider(
        color: Styles.spacerColor,
        thickness: 1,
      ),
    );
  }
}
