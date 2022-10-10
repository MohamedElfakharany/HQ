import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/models/model_test.dart';
import 'package:hq/screens/main_screens/search_screen.dart';
import 'package:hq/screens/main_screens/widgets_components/widgets_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';

class TestItemsScreen extends StatelessWidget {
  const TestItemsScreen({Key? key, required this.categoryId}) : super(key: key);
  final categoryId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getTests(categoriesId: categoryId)..getCategories(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: GeneralAppBar(
              title: AppCubit.get(context).categoriesModel?.data?[categoryId-1].title ?? '',
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      FadeRoute(
                        page: const SearchScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                    color: blueColor,
                  ),
                ),
                horizontalMiniSpace
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ConditionalBuilder(
                condition: state is! AppGetTestsLoadingState,
                builder: (context) => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => TestItemCard(index: index),
                  separatorBuilder: (context, index) => verticalMiniSpace,
                  itemCount: AppCubit.get(context).testsModel?.data?.length ?? 0,
                ),
                fallback: (context) => const Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      ),
    );
  }
}
