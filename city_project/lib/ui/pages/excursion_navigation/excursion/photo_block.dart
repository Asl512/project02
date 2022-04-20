import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/back-end/redux/excursion/excursion_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:redux/redux.dart';

class PhotoBlock extends StatelessWidget {
  const PhotoBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExcursionInfoState>(
      converter: (store) => store.state.excursionInfoState,
      builder: (context, store) {
        if (store.photos != null) {
          return const _Photos();
        }
        return Container();
      },
    );
  }
}

class _Photos extends StatelessWidget {
  const _Photos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> _store = StoreProvider.of<AppState>(context);
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 10, bottom: 25),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [ShadowForContainer()],
        color: White,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: _store.state.excursionInfoState.photos!.photos.length > 1
          ? Row(
              children: [
                PhotoHalfBlock(
                  image: _store.state.excursionInfoState.photos!.photos.first,
                  func: () => showPhotoDialog(context),
                ),
                _store.state.excursionInfoState.photos!.photos.length > 2
                    ? Column(
                        children: [
                          TextButton(
                            onPressed: () => showPhotoDialog(context),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                _store.state.excursionInfoState.photos!.photos[1],
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.width / 3 * 1.5 / 2,
                                width: MediaQuery.of(context).size.width / 2.5,
                                loadingBuilder: (
                                  BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Placholder(
                                    MediaQuery.of(context).size.width / 2.5,
                                    MediaQuery.of(context).size.width / 3 * 1.5 / 2,
                                  );
                                },
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => showPhotoDialog(context),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    _store.state.excursionInfoState.photos!.photos[2],
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.width / 3 * 1.5 / 2,
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    loadingBuilder: (
                                      BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress,
                                    ) {
                                      if (loadingProgress == null) return child;
                                      return Placholder(
                                        MediaQuery.of(context).size.width / 2.5,
                                        MediaQuery.of(context).size.width / 3 * 1.5 / 2,
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.width / 3 * 1.5 / 2,
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  child: Text(
                                    '+' +
                                        (_store.state.excursionInfoState.photos!.photos.length - 2)
                                            .toString(),
                                    style: Montserrat(size: 40, color: White, style: SemiBold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : PhotoHalfBlock(
                        image: _store.state.excursionInfoState.photos!.photos[1],
                        func: () => showPhotoDialog(context),
                      ),
              ],
            )
          : PhotoBlockOne(func: () => showPhotoDialog(context)),
    );
  }

  void showPhotoDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PhotoCarousel();
      },
    );
  }
}

class PhotoHalfBlock extends StatelessWidget {
  final void Function() func;
  final String image;

  const PhotoHalfBlock({
    Key? key,
    required this.image,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: func,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.width / 3 * 1.5 + 15,
          width: MediaQuery.of(context).size.width / 2.5,
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) return child;
            return Placholder(size.width / 2.5, size.width / 3 * 1.5 + 15);
          },
        ),
      ),
    );
  }
}

class PhotoBlockOne extends StatelessWidget {
  final void Function() func;

  const PhotoBlockOne({
    Key? key,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> _store = StoreProvider.of<AppState>(context);
    return TextButton(
      onPressed: func,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          _store.state.excursionInfoState.photos!.photos.first,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.width / 3 * 1.5 + 15,
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) return child;
            return Placholder(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.width / 3 * 1.5 + 15,
            );
          },
        ),
      ),
    );
  }
}

class PhotoCarousel extends StatefulWidget {
  const PhotoCarousel({Key? key}) : super(key: key);

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  int indexNow = 1;

  @override
  Widget build(BuildContext context) {
    final Store<AppState> _store = StoreProvider.of<AppState>(context);
    return Stack(
      children: [
        Swiper(
          onIndexChanged: (index) => setState(() => indexNow = index + 1),
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: InteractiveViewer(
                child: Image.network(
                  _store.state.excursionInfoState.photos!.photos[index],
                  loadingBuilder: (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator(color: White));
                  },
                ),
              ),
            );
          },
          curve: Curves.decelerate,
          indicatorLayout: PageIndicatorLayout.NONE,
          itemCount: _store.state.excursionInfoState.photos!.photos.length,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 13,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: White,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Фотографии с экскурсии',
                      style: Montserrat(style: Bold, color: White, size: 17),
                    ),
                    Text(
                      indexNow.toString() +
                          ' из ' +
                          _store.state.excursionInfoState.photos!.photos.length.toString(),
                      style: Montserrat(style: SemiBold, color: White, size: 15),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
