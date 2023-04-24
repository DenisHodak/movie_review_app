import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cubit/filters_cubit.dart';
import '../blocs/cubit/popular_movies_cubit.dart';
import '../blocs/cubit/movie_details_cubit.dart';
import '../blocs/cubit/cast_cubit.dart';
import '../blocs/cubit/navigation_cubit.dart';
import '../blocs/cubit/favorite_movies_cubit.dart';
import '../blocs/cubit/favorite_movie_cubit.dart';
import '../blocs/cubit/search_cubit.dart';
import '../constants/constants.dart';

import '../screens/movie_details_screen.dart';
import '../screens/popular_movies_screen.dart';
import '../screens/search_movies_screen.dart';

class Routes {
  final FavoriteMoviesCubit _favoriteMoviesCubit = FavoriteMoviesCubit();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Navigation.homePage:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PopularMoviesCubit()..getPopularMovies(),
              ),
              BlocProvider(
                create: (context) => NavigationCubit(),
              ),
              BlocProvider.value(
                value: _favoriteMoviesCubit,
              ),
            ],
            child: const PopularMoviesScreen(),
          ),
        );
      case Navigation.movieDetailsPage:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => MovieDetailsCubit()
                  ..getMovieDetails(movieId: routeSettings.arguments),
              ),
              BlocProvider(
                create: (context) =>
                    CastCubit()..getMovieCast(movieId: routeSettings.arguments),
              ),
              BlocProvider.value(
                value: _favoriteMoviesCubit,
              ),
              BlocProvider(
                create: (context) => FavoriteMovieCubit(),
              ),
            ],
            child: MovieDetailsScreen(movieId: routeSettings.arguments),
          ),
        );
      case Navigation.searchPage:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => SearchCubit(),
                    ),
                    BlocProvider(
                      create: (context) => FiltersCubit()..getGenres(),
                    ),
                  ],
                  child: const SearchMoviesScreen(),
                ));
      default:
        return null;
    }
  }
}
