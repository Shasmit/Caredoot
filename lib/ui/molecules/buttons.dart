import 'package:flutter/material.dart';

import '../../core/constants/app_text_styles.dart';

class ButtonsWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const ButtonsWidget({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, left: 35, right: 35),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xff0048C4),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.grey,
                  width: 0.2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            shadowColor: MaterialStateProperty.all(
              Colors.transparent,
            ),
          ),
          child: Text(
            buttonText,
            style: AppTextStyles.textStyle12w400Black.copyWith(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
