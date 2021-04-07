import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/onboarding_step.dart';
import 'package:places/main.dart' show AppRouter;
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/text_styles.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingStep> _onboardingSteps = [
    OnboardingStep(
      icon: iconOnboardingPointer,
      title: 'Добро пожаловать в Путеводитель',
      subtitle: 'Ищи новые локации и сохраняй самые любимые.',
    ),
    OnboardingStep(
      icon: iconOnboardingRoute,
      title: 'Построй маршрут и отправляйся в путь',
      subtitle: 'Достигай цели максимально быстро и комфортно.',
    ),
    OnboardingStep(
      icon: iconOnboardingTap,
      title: 'Добавляй места, которые нашёл сам',
      subtitle: 'Делись самыми интересными и помоги нам стать лучше!',
    ),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          TextButton(
            child: Text(
              'Пропустить',
              style: subtitle1.copyWith(
                color: successColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AppRouter.sightList);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: PageView(
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: [
                  for (OnboardingStep step in _onboardingSteps)
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            step.icon,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(height: 40.0),
                          Text(
                            step.title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            step.subtitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _onboardingSteps.length; i++)
                  i == currentIndex
                      ? Container(
                          width: 24.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: successColor,
                          ),
                        )
                      : Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: secondaryTextColor.withOpacity(0.56),
                          ),
                        )
              ],
            ),
            SizedBox(height: 36.0),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: (currentIndex + 1) == _onboardingSteps.length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ElevatedButton(
                    child: Text('НА СТАРТ'),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(AppRouter.sightList);
                    },
                  ),
                ),
              )
            : SizedBox(height: 48.0),
      ),
    );
  }
}
