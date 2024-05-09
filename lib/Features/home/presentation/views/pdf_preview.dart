import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../../../../Features/home/presentation/manager/bdf_preview_cubit/pdf_preview_cubit.dart';
import '../../../../../core/utils/styles.dart';

class PDFPreview extends StatefulWidget {
  const PDFPreview({Key? key}) : super(key: key);
  @override
  PDFPreviewState createState() => PDFPreviewState();
}

class PDFPreviewState extends State<PDFPreview> {
  late PDFViewController pdfViewController;
  int _totalPages = 0;
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Preview'),
      ),
      body: BlocConsumer<PdfPreviewCubit, PdfPreviewState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PdfPreviewSuccess) {
            return pdfBreviewBody(state.remotePDFpath);
          } else if (state is PdfPreviewFailure) {
            return const Center(
              child: Text(
                'Please try again later <(＿　＿)>',
                style: Styles.textStyle20,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Column pdfBreviewBody(String remotePDFpath) {
    return Column(
      children: [
        Expanded(
          child: PDFView(
            filePath: remotePDFpath,
            onRender: (pages) {
              setState(() {
                _totalPages = pages!;
              });
            },
            onViewCreated: (PDFViewController vc) {
              pdfViewController = vc;
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                _currentPage = page!;
              });
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            '$_currentPage/$_totalPages',
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
      ],
    );
  }
}
