import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_yaho/core/config/enum/enum.dart';
import 'package:test_yaho/models/image_model.dart';
import 'package:test_yaho/repositories/image_repository.dart';
part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository _imageRepository;
  ModeImage mode;
  List<ImageModel> imageModels = [];
  int totalPage = 1;
  ImageBloc(this._imageRepository, this.mode)
      : super(const ImageStateLoading()) {
    on<FetchImageEvent>((event, emit) async {
      try {
        if (event.page <= totalPage) {
          emit(const ImageStateLoading());

          final groupImage = await _imageRepository.getListImage(event.page);
          if (groupImage != null) {
            imageModels.addAll(groupImage.images);
            totalPage = groupImage.totalPages;
            emit(ImageStateLoaded(imageModels, mode));
          }
        }
      } catch (e) {
        print('error $e');
        emit(ImageStateError(e.toString()));
      }
    });
    on<ChangeImageEvent>((event, emit) async {
      if (mode == ModeImage.grid) {
        mode = ModeImage.list;
      } else {
        mode = ModeImage.grid;
      }
      emit(ImageStateLoaded(
        imageModels,
        mode,
      ));
    });
    ;
  }
}
