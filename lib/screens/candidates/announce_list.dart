import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class AnnounceList extends StatefulWidget {
  const AnnounceList({Key? key}) : super(key: key);

  @override
  _AnnounceListState createState() => _AnnounceListState();
}

class _AnnounceListState extends State<AnnounceList> {
  final CardSwiperController controller = CardSwiperController();

  @override
  Widget build(BuildContext context) {

    List<Container> cards = [
      Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.orangeAccent,
              image: DecorationImage(
                image: AssetImage('assets/img/artisan.jpg'),
                fit: BoxFit.cover,
              )),
          child: const Text('Card 1')),
      Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.orangeAccent,
              image: DecorationImage(
                image: AssetImage('assets/img/artisan.jpg'),
                fit: BoxFit.cover,
              )),
          child: const Text('Card 2')),
      Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.orangeAccent,
              image: DecorationImage(
                image: AssetImage('assets/img/artisan.jpg'),
                fit: BoxFit.cover,
              )),
          child: const Text('Card 3')),
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Annonces'),
        ),
        body: SafeArea(
            child: Column(
      children: [
        Flexible(
          child: CardSwiper(
            cardsCount: cards.length,
            numberOfCardsDisplayed: 3,
            isLoop: false,
            onUndo: _onUndo,
            onSwipe: _onSwipe,
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) =>
                    cards[index],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () => controller.swipe(CardSwiperDirection.left),
                backgroundColor : Colors.black,
                foregroundColor: Colors.white,
                child: const Icon(Icons.message),
              ),
              FloatingActionButton(
                onPressed: () =>
                    controller.swipe(CardSwiperDirection.right),
                child: const Icon(Icons.rotate_left),
              ),
              FloatingActionButton(
                onPressed: () => controller.swipe(CardSwiperDirection.top),
                backgroundColor : Colors.red,
                foregroundColor: Colors.white,

                child: const Icon(Icons.favorite),
              ),
            ],
          ),
        ),
      ],
    )));
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}
