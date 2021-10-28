import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_page_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:tv/utils/utils.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }
  void didPopNext() {
        BlocProvider.of<TvWatchlistPageBloc>(context, listen: false)
          ..add(FetchWatchlistTv());
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TvWatchlistPageBloc>(context, listen: false)
          ..add(FetchWatchlistTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Series Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistPageBloc, WatchlistPageState>(
          builder: (context, state) {
            if (state is WatchlistPageLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistPageLoaded) {
              final result = state.result;
              if (result.length == 0) {
                return Center(child: Text("Nothing to see here"));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
              );
            } else {
              return Text("");
            }
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
