import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_yaho/blocs/image_bloc/image_bloc.dart';
import 'package:test_yaho/core/config/enum/enum.dart';
import 'package:test_yaho/core/utils/app_init.dart';
import 'package:test_yaho/repositories/image_repository.dart';
import 'package:test_yaho/views/common/card_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  static const double _endReachedThreshold = 10;
  late ImageRepository _imageRepository;
  late ImageBloc _imageBloc;
  int _nextPage = 1;
  bool _loading = false;

  @override
  void initState() {
    _imageRepository = ImageRepository(httpClient: AppInit.instance.httpClient);
    _imageBloc = ImageBloc(_imageRepository, ModeImage.grid);
    _controller.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (!_controller.hasClients || _loading) return;

    final thresholdReached =
        _controller.position.extentAfter < _endReachedThreshold;

    if (thresholdReached) {
      _loading = true;
      _imageBloc.add(FetchImageEvent(++_nextPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _imageRepository,
      child: BlocProvider(
        create: (context) => _imageBloc
          ..add(const FetchImageEvent(
            1,
          )),
        child: Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text('Friends',
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold)),
                    ),
                    BlocBuilder<ImageBloc, ImageState>(
                        buildWhen: (previous, current) {
                      return current is ImageStateLoaded;
                    }, builder: (context, state) {
                      return IconButton(
                        icon: (state is ImageStateLoaded &&
                                state.mode == ModeImage.list)
                            ? const Icon(Icons.list)
                            : const Icon(Icons.grid_view),
                        onPressed: () {
                          BlocProvider.of<ImageBloc>(context)
                              .add(const ChangeImageEvent());
                        },
                      );
                    })
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: BlocBuilder<ImageBloc, ImageState>(
                      buildWhen: (previous, current) {
                    return current is ImageStateLoaded;
                  }, builder: (context, state) {
                    if (state is ImageStateLoaded) {
                      var images = state.imageModels;
                      var mode = state.mode;
                      return mode == ModeImage.grid
                          ? GridView.builder(
                              controller: _controller,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 1 / 1.6,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 10),
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                var image = images[index];
                                return CardItem(
                                    direction: DirectionCard.vertical,
                                    avatar: image.avatar,
                                    fullName: image.fullName,
                                    email: image.email);
                              })
                          : ListView.builder(
                              controller: _controller,
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                var image = images[index];
                                return CardItem(
                                    direction: DirectionCard.horizontal,
                                    avatar: image.avatar,
                                    fullName: image.fullName,
                                    email: image.email);
                              });
                    }
                    return Container();
                  }),
                ),
                BlocBuilder<ImageBloc, ImageState>(builder: (context, state) {
                  if (state is ImageStateLoaded) {
                    _loading = false;
                    return const SizedBox();
                  } else {
                    return Container(
                      padding: const EdgeInsets.only(bottom: 16),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  }
                }),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
