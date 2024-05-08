part of 'pdf_preview_cubit.dart';

@immutable
sealed class PdfPreviewState {}

final class PdfPreviewInitial extends PdfPreviewState {}

final class PdfPreviewLoading extends PdfPreviewState {}

final class PdfPreviewSuccess extends PdfPreviewState {
  final String remotePDFpath;

  PdfPreviewSuccess({required this.remotePDFpath});
}

final class PdfPreviewFailure extends PdfPreviewState {}
