import 'package:core/bloc/tv/top_rated_tv_bloc.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => BlocProvider.of<TopRatedTvBloc>(context).add(TopRatedTvEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
            if (state is TopRatedTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvLoaded) {
              final result = state.result;
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
}
