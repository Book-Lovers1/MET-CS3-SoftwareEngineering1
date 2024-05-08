import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/api_services.dart';
import '../../../../../core/utils/styles.dart';
import '../../../data/data_sources/home_remote_data_source.dart';
import '../../../data/repos/home_repo_impl.dart';
import '../../manager/similar_books_cubit/similar_books_cubit.dart';
import 'similar_books_list_view_bloc_builder.dart';

class SimilarBooksSection extends StatelessWidget {
  const SimilarBooksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You can also like',
          style: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
       BlocProvider(
          create: (context) => SimilarBooksCubit(
             HomeRepoImpl(
                homeRemoteDataSource: HomeRemoteDataSourceImpl(
                  ApiServise(
                    Dio(),
                  ),
                ),
              ),
          )..fetchSimilarBooks(),
          child: const SimilarBooksListViewBlocBuilder(),
        ),
      ],
    );
  }
}
