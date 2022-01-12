import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsnews/src/core/config/flavor_config.dart';
import 'package:newsnews/src/features/main_screen/presentation/cubit/news_cubit.dart';
import 'package:newsnews/src/widgets/circle_loading.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FlavorConfig.instance.name)),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const CircleLoading();
          } else if (state is NewsError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is NewsLoaded) {
            return ListView.builder(
              itemCount: state.listArticle.length,
              itemBuilder: (context, index) {
                return Text(state.listArticle[index].title ?? "");
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
