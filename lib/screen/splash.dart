
import 'package:flutter/material.dart';
import 'package:jpshua/widgets/base_widget.dart';

import '../view_model/splash_vm.dart';

class Splash extends BaseWidget<SplashVM>{
  const Splash({super.key});

  @override
  Widget buildUI(BuildContext context, SplashVM viewModel) {
    return Container();
    //   MyScaffold(
    //     child:  Center(child:AnimatedTextKit(
    //   animatedTexts: [
    //     TypewriterAnimatedText(
    //       strTitle,
    //       textStyle: const TextStyle(
    //         fontSize: 32.0,
    //         fontWeight: FontWeight.bold,
    //       ),
    //       speed: const Duration(milliseconds:300),
    //     ),
    //   ],
    //
    //   totalRepeatCount: 4,
    //   pause: const Duration(milliseconds: 1000),
    //   displayFullTextOnTap: true,
    //   stopPauseOnTap: true,
    // ),)
    // );
  }

}