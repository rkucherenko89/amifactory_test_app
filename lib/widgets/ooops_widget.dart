import 'package:amifactory_test_app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OoopsWidget extends StatelessWidget {
  OoopsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const ooopsStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'KronaOne',
      fontWeight: FontWeight.w400,
      fontSize: 35,
    );

    const smthWentWrongStyle = TextStyle(
      color: Color(0xFFE2E2E2),
      fontWeight: FontWeight.w400,
      fontSize: 20,
    );

    const buttonStyle = TextStyle(
      color: Colors.white,
      fontSize: 17.5,
      fontWeight: FontWeight.w700,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 260),
              SvgPicture.asset(
                'assets/ooops.svg',
              ),
              const SizedBox(height: 34),
              const Text('Ooops..', style: ooopsStyle),
              const SizedBox(height: 4),
              const Text('Something went wrong!', style: smthWentWrongStyle),
              const SizedBox(height: 120),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.trailerButtonColor),
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(180, 48)),
                ),
                onPressed: () {},
                child: const Text('Retry', style: buttonStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
