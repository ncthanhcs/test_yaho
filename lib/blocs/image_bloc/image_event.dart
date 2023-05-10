part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class FetchImageEvent extends ImageEvent {
  final int page;

  const FetchImageEvent(
    this.page,
  );
}

class ChangeImageEvent extends ImageEvent {
  const ChangeImageEvent();
}
