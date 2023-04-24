import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cubit/search_cubit.dart';
import '../blocs/cubit/filters_cubit.dart';

import '../models/genre.dart';

import '../widgets/loading_indicator_widget.dart';
import '../widgets/custom_app_bar_widget.dart';
import '../widgets/filter_dropdown_widget.dart';
import '../widgets/movie_list_tile_widget.dart';
import '../config/app_styles.dart';
import '../constants/constants.dart';

class SearchMoviesScreen extends StatefulWidget {
  const SearchMoviesScreen({super.key});

  @override
  State<SearchMoviesScreen> createState() => _SearchMoviesScreenState();
}

class _SearchMoviesScreenState extends State<SearchMoviesScreen> {
  final _scrollController = ScrollController();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<SearchCubit>(context)
            .searchResults(_textEditingController.text);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _textEditingController.dispose();
  }

  _searchMovies(query) {
    BlocProvider.of<SearchCubit>(context)
        .searchResults(query, initialSearch: true);
    BlocProvider.of<FiltersCubit>(context).resetFilters();
  }

  void _openDetailsScreen(movieId) {
    Navigator.of(context)
        .pushNamed(Navigation.movieDetailsPage, arguments: movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(appBarTitle: Content.searchTitle),
      body: Stack(
        children: [
          // Screen background
          Container(
            decoration: Decorations.backgroundDecoration,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                // Searching by name
                child: TextField(
                  controller: _textEditingController,
                  style: TextStyle(
                    color: Styles.textColor,
                  ),
                  decoration: InputDecoration(
                    floatingLabelStyle:
                        TextStyle(color: Styles.focusedItemBorderColor),
                    labelStyle: TextStyle(color: Styles.bordersColor),
                    labelText: Content.searchBarLabelText,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Styles.formIconColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Styles.bordersColor),
                        borderRadius: BorderRadius.circular(
                            RadiusValue.inputFieldRadius)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.focusedItemBorderColor,
                        ),
                        borderRadius: BorderRadius.circular(
                            RadiusValue.inputFieldRadius)),
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) => _searchMovies(value),
                ),
              ),
              // Filters
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: BlocBuilder<FiltersCubit, FiltersState>(
                  builder: (context, state) {
                    if (state is FiltersLoaded) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Wrap(
                          spacing: 8.0,
                          children: [
                            // Genre filter
                            FilterDropdownWidget(
                              title: Content.genreFilter,
                              value: state.selectedGenreId,
                              onChanged: (genreValue) {
                                BlocProvider.of<SearchCubit>(context)
                                    .filterMovies(
                                        genreId: genreValue,
                                        year: state.selectedYear);
                                BlocProvider.of<FiltersCubit>(context)
                                    .setGenreFilter(genreValue);
                              },
                              items: state.genres
                                  .map(_buildGenreMenuItem)
                                  .toList(),
                            ),
                            // Year filter
                            FilterDropdownWidget(
                              title: Content.yearFilter,
                              value: state.selectedYear,
                              onChanged: (year) {
                                BlocProvider.of<SearchCubit>(context)
                                    .filterMovies(
                                        year: year,
                                        genreId: state.selectedGenreId);
                                BlocProvider.of<FiltersCubit>(context)
                                    .setYearFilter(year);
                              },
                              items:
                                  state.years.map(_buildYearMenuItem).toList(),
                            ),
                            // Clear filters button
                            Container(
                              height: 40,
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Styles.bordersColor, width: 1),
                                borderRadius: BorderRadius.circular(
                                    RadiusValue.inputFieldRadius),
                              ),
                              child: TextButton.icon(
                                icon: Text(
                                  textAlign: TextAlign.start,
                                  Content.clearFilter,
                                  style: TextStyle(
                                      color: (state.selectedYear != null ||
                                              state.selectedGenreId != null)
                                          ? Styles.textColor
                                          : Styles.bordersColor),
                                ),
                                label: Icon(
                                  Icons.filter_alt_off_outlined,
                                  color: Styles.filterRestoreColor,
                                  size: 16,
                                ),
                                onPressed: () => _clearFilters(),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const LoadingIndicatorWidget();
                    }
                  },
                ),
              ),
              // Movies initial list
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchResultsLoaded) {
                    return Expanded(
                      child: ListView.builder(
                          controller:
                              state.reachedLastPage ? null : _scrollController,
                          itemCount: state.loadedMovies.length + 1,
                          itemBuilder: (context, index) {
                            if (index < state.loadedMovies.length) {
                              return MovieListTileWidget(
                                title: state.loadedMovies[index].title,
                                releaseDate:
                                    state.loadedMovies[index].releaseDate,
                                posterPath:
                                    state.loadedMovies[index].posterPath,
                                onTap: () => _openDetailsScreen(
                                    state.loadedMovies[index].id),
                              );
                            } else if (state.loadedMovies.length > 15) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: state.reachedLastPage
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                Content.noMoreData,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Styles.errorColor),
                                              ),
                                            ),
                                            Icon(
                                              Icons.warning,
                                              color: Styles.errorColor,
                                            ),
                                          ],
                                        )
                                      : const LoadingIndicatorWidget(),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    );
                    // Filtered movies list
                  } else if (state is SearchResultsFiltered) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: state.filteredMovies.length,
                          itemBuilder: (context, index) {
                            return MovieListTileWidget(
                              title: state.filteredMovies[index].title,
                              releaseDate:
                                  state.filteredMovies[index].releaseDate,
                              posterPath:
                                  state.filteredMovies[index].posterPath,
                              onTap: () => _openDetailsScreen(
                                  state.filteredMovies[index].id),
                            );
                          }),
                    );
                  } else {
                    return Expanded(
                      child: Center(
                          child: state is SearchResultsLoadFailed
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Content.noResults,
                                      style:
                                          TextStyle(color: Styles.errorColor),
                                    ),
                                    Icon(
                                      Icons.warning,
                                      color: Styles.errorColor,
                                    )
                                  ],
                                )
                              : Container()),
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  DropdownMenuItem<int> _buildGenreMenuItem(Genre genre) {
    return DropdownMenuItem(
      value: genre.id,
      child: Text(
        genre.name,
        style: TextStyle(color: Styles.textColor),
        textAlign: TextAlign.center,
      ),
    );
  }

  DropdownMenuItem<int> _buildYearMenuItem(int year) {
    return DropdownMenuItem(
      value: year,
      child: Text(
        year.toString(),
        style: TextStyle(color: Styles.textColor),
        textAlign: TextAlign.center,
      ),
    );
  }

  _clearFilters() {
    BlocProvider.of<SearchCubit>(context).removeFilters();
    BlocProvider.of<FiltersCubit>(context).resetFilters();
  }
}
