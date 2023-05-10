part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageStateLoading extends ImageState {
  const ImageStateLoading();
}

class ImageStateLoaded extends ImageState {
  final List<ImageModel> imageModels;
  final ModeImage mode;
  const ImageStateLoaded(
    this.imageModels,
    this.mode,
  );
  @override
  List<Object> get props => [mode, imageModels];
}

class ImageStateError extends ImageState {
  final String error;

  const ImageStateError(
    this.error,
  );
}
