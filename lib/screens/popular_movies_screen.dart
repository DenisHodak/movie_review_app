import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cubit/popular_movies_cubit.dart';
import '../blocs/cubit/navigation_cubit.dart';
import '../blocs/cubit/favorite_movies_cubit.dart';

import '../config/app_styles.dart';
import '../constants/constants.dart';
import '../widgets/movie_tile_widget.dart';
import '../widgets/custom_app_bar_widget.dart';
import '../widgets/loading_screen_failed_widget.dart';
import '../widgets/movies_grid_view_widget.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key});

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        BlocProvider.of<PopularMoviesCubit>(context).getPopularMovies();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        appBarTitle: Content.appTitle,
        actions: [
          IconButton(
            onPressed: () => _openSearchScreen(),
            icon: Icon(
              Icons.search,
              color: Styles.textColor,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Screen background
          Container(
            decoration: Decorations.backgroundDecoration,
          ),
          // Screen content
          BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
              return Container(
                child: state is NavigationHomepage
                    ? _allMoviesList()
                    : _favoriteMoviesList(),
              );
            },
          ),
        ],
      ),
      // Navigation
      bottomNavigationBar: Container(
        decoration: Decorations.bottomNavigationDecoration,
        child: CurvedNavigationBar(
          animationCurve: Curves.fastOutSlowIn,
          onTap: (value) => _changeScreenContent(value),
          color: Styles.navigationColor,
          backgroundColor: Styles.navigationBackgroundColor,
          buttonBackgroundColor: Styles.navigationButtonBackgroundColor,
          height: 50,
          items: [
            Icon(
              Icons.home,
              color: Styles.homeIconColor,
            ),
            Icon(
              Icons.favorite,
              color: Styles.favoriteIconColor,
            )
          ],
        ),
      ),
    );
  }

  BlocBuilder<FavoriteMoviesCubit, FavoriteMoviesState> _favoriteMoviesList() {
    return BlocBuilder<FavoriteMoviesCubit, FavoriteMoviesState>(
        builder: (context, state) {
      if (state.favoriteMovies.isNotEmpty) {
        return MoviesGridViewWidget(
          itemCount: state.favoriteMovies.length,
          itemBuilder: (context, index) => MovieTileWidget(
            id: state.favoriteMovies[index].id,
            title: state.favoriteMovies[index].title,
            posterPath: state.favoriteMovies[index].posterPath,
            releaseDate: state.favoriteMovies[index].releaseDate,
          ),
        );
      } else {
        return Center(
          child: Text(
            Content.noFavoriteMoviesMessage,
            style: TextStyle(
              color: Styles.errorColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        );
      }
    });
  }

  BlocBuilder<PopularMoviesCubit, PopularMoviesState> _allMoviesList() {
    return BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
      builder: (context, state) {
        if (state is PopularMovieInitialLoadInProgress) {
          return _loadingIndicator();
        } else if (state is PopularMoviesLoaded) {
          return MoviesGridViewWidget(
            itemCount: state.popularMovies.length + 1,
            scrollController: state.reachedLastPage ? null : _controller,
            itemBuilder: (context, index) {
              return index < state.popularMovies.length
                  ? MovieTileWidget(
                      id: state.popularMovies[index].id,
                      title: state.popularMovies[index].title,
                      posterPath: state.popularMovies[index].posterPath,
                      releaseDate: state.popularMovies[index].releaseDate,
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: state.reachedLastPage
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      Content.lastElementMessage,
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(color: Styles.errorColor),
                                    ),
                                  ),
                                  Icon(
                                    Icons.warning,
                                    color: Styles.errorColor,
                                  ),
                                ],
                              )
                            : _loadingIndicator(),
                      ),
                    );
            },
          );
        } else {
          return LoadingScreenFailedWidget(
            loadingDataFailed: state is PopularMovieLoadFailed,
            onPressed: _fetchPopularMovies(),
          );
        }
      },
    );
  }

  _fetchPopularMovies() {
    return BlocProvider.of<PopularMoviesCubit>(context).getPopularMovies;
  }

  _openSearchScreen() {
    Navigator.of(context).pushNamed(Navigation.searchPage);
  }

  _changeScreenContent(value) {
    BlocProvider.of<NavigationCubit>(context).changeView(value);
  }

  Widget _loadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: Styles.loadingColor,
      ),
    );
  }
}
