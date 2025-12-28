import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/introduction/view/mixin/introduction_mixin.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
class IntroductionView extends StatefulWidget {
  const IntroductionView({super.key});

  @override
  State<IntroductionView> createState() => _IntroductionViewState();
}

class _IntroductionViewState extends BaseState<IntroductionView> with IntroductionMixin {
  @override
  Widget build(BuildContext context) {
    final bodyStyle = TextStyle(fontSize: context.sized.normalValue);

    final pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: context.sized.mediumValue,
        fontWeight: FontWeight.w700,
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.only(
        top: context.padding.normal.top,
        left: context.padding.normal.left,
        right: context.padding.normal.right,
      ),
      imagePadding: EdgeInsets.only(top: context.padding.low.top),
    );

    return IntroductionScreen(
      key: introKey,
      allowImplicitScrolling: false,
      globalHeader: Align(
        alignment: Alignment.centerRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: context.padding.low.top, right: context.padding.low.right),
            child: SizedBox(width: context.sized.height * 0.07, height: context.sized.height * 0.07, child: Assets.images.logo.image(package: 'gen')),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: 'Keşfet ve Oku',
          body: 'İlgi alanlarına göre başlıkları keşfet, '
              'kullanıcıların deneyimlerini ve yorumlarını oku.',
          image: Assets.images.intro1.image(package: 'gen'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Fikrini Paylaş',
          body: 'Düşüncelerini özgürce yaz, '
              'başkalarının fikirlerine katkıda bulun '
              'ya da yeni bir başlık başlat.',
          image: Assets.images.intro2.image(package: 'gen'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Sohbet Et ve Bağlan',
          body: 'Ortak ilgi alanlarında insanlarla tanış, '
              'sohbet et ve topluluğa dahil ol.\n\n'
              'Bu özellikleri kullanmak için hesap oluşturman gerekir.',
          image: Assets.images.intro3.image(package: 'gen'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () async {
        onIntroEnd(context);
      },
      onSkip: () async {
        onIntroEnd(context);
      },
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      back: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      skip: const Text(
        'Skip',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
      done: const Text(
        'Done',
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(context.padding.normal.top),
      controlsPadding: EdgeInsets.all(context.sized.normalValue),
      dotsDecorator: DotsDecorator(
        size: Size(context.sized.lowValue, context.sized.lowValue),
        color: Colors.black,
        activeSize: Size(context.sized.normalValue, context.sized.lowValue),
        activeColor: Colors.black,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(context.sized.normalValue)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(context.sized.lowValue)),
        ),
      ),
    );
  }
}
