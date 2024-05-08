import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Features/home/presentation/manager/bdf_preview_cubit/pdf_preview_cubit.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../../core/widgets/custom_button.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({super.key, required this.bookurl});
  final String bookurl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
                backgroundColor: const Color(0xffEF8262),
                textColor: Colors.white,
                text: 'Free Preview',
                fontSize: 16,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                onPressed: () {
                  BlocProvider.of<PdfPreviewCubit>(context)
                      .loadPdfPreview(bookurl);
                  GoRouter.of(context).push(AppRouter.kPDFPreview);
                }),
          ),
        ],
      ),
    );
  }
}
