import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

part 'pdf_preview_state.dart';

class PdfPreviewCubit extends Cubit<PdfPreviewState> {
  PdfPreviewCubit() : super(PdfPreviewInitial());
  void loadPdfPreview(String pdfUrl) {
    emit(PdfPreviewLoading());
    String remotePDFpath = "";

    Future<File> createFileOfPdfUrl() async {
      Completer<File> completer = Completer();
      log("Start download file from internet!");
      try {
        final url = pdfUrl;
        final filename = url.substring(url.lastIndexOf("/") + 1);
        var request = await HttpClient().getUrl(Uri.parse(url));
        var response = await request.close();
        var bytes = await consolidateHttpClientResponseBytes(response);
        var dir = await getApplicationDocumentsDirectory();
        log("Download files");
        log("${dir.path}/$filename");
        File file = File("${dir.path}/$filename");

        await file.writeAsBytes(bytes, flush: true);
        completer.complete(file);
      } catch (e) {
        emit(PdfPreviewFailure());
        throw Exception('Error parsing asset file!');
      }
      return completer.future;
    }
    createFileOfPdfUrl().then((f) {
        remotePDFpath = f.path;
        emit(PdfPreviewSuccess(remotePDFpath: remotePDFpath));
      });
  }
}
