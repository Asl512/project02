import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lan_code/back-end/domain/entities/review_entity.dart';
import 'package:lan_code/back-end/domain/entities/user_entity.dart';
import 'package:lan_code/back-end/redux/app/app_state.dart';
import 'package:lan_code/ui/common/colors.dart';
import 'package:lan_code/ui/common/textStyle.dart';
import 'package:lan_code/ui/widgets/image_box_widget.dart';
import 'package:lan_code/ui/widgets/style.dart';
import 'package:redux/redux.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Grey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            const _Header(),
          ];
        },
        body: const _Body(),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> _store = StoreProvider.of<AppState>(context);
    return SliverAppBar(
      backgroundColor: Blue,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20, color: White),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      expandedHeight: MediaQuery.of(context).size.height / 3,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            ImageBoxWidget(url: _store.state.excursionInfoState.excursion!.photo),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.3),
            ),
            Positioned(
              left: 20.0,
              bottom: 70.0,
              right: 20.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      _store.state.excursionInfoState.excursion!.name.toUpperCase(),
                      style: Montserrat(color: White, size: 25, style: Bold),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    height: 50,
                    padding: const EdgeInsets.only(right: 15),
                    alignment: Alignment.center,
                    child: Text(
                      _store.state.excursionInfoState.reviews!.length.toString() + " отзывов",
                      style: Montserrat(size: 15, style: SemiBold, color: White),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> _store = StoreProvider.of<AppState>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Написать отзыв могут только посетившие экскурсию путешествинники. ",
                    style: Montserrat(size: 13, color: Blue),
                  ),
                  TextSpan(
                    text: "Подробнее.",
                    style: Montserrat(style: SemiBold, size: 13, color: Red),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showModalBottomSheet(
                            backgroundColor: White.withOpacity(0),
                            context: context,
                            builder: (BuildContext context) {
                              return Container();
                            });
                      },
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                boxShadow: [ShadowForContainer()],
                color: White,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                if (_store.state.excursionInfoState.reviews!.isEmpty)
                  Container(
                    width: double.infinity / 2,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                    child: Text('У данного мероприятия пока что нет отзывов.',
                        style: Montserrat(color: Blue, size: 15, style: SemiBold)),
                  )
                else
                  for (int i = 0; i < _store.state.excursionInfoState.reviews!.length; i++)
                    Column(
                      children: [
                        Review(
                          user: _store.state.excursionInfoState.userReview![i],
                          review: _store.state.excursionInfoState.reviews![i],
                        ),
                        if (i % 2 == 0)
                          Container(width: double.infinity, height: 1, color: Blue.withOpacity(0.5))
                      ],
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Review extends StatelessWidget {
  final UserEntity user;
  final ReviewsEntity review;

  const Review({
    Key? key,
    required this.user,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      PhotoAuthor(user.photo),
                      GuideCheck(user.verified),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      user.name,
                      style: Montserrat(style: SemiBold, color: Blue, size: 15),
                    ),
                  )
                ],
              ),
              Text(
                review.date,
                style: Montserrat(style: Bold, color: Blue.withOpacity(0.7), size: 15),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              review.review,
              style: Montserrat(color: Blue, size: 13),
            ),
          )
        ],
      ),
    );
  }
}
