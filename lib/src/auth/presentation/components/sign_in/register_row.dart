import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:demo/core/utils/language_constants.dart';
import 'package:flutter/material.dart';

class RegisterRow extends StatelessWidget {
  const RegisterRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 60),
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SimpleText(
            text: translation().dontHaveAccount,
            withTextScale: false,
          ),
          SizedBox(
            child: TextButton(
              onPressed: () {},
              child: SimpleText(
                text: translation().signup,
                fontWeight: FontWeight.bold,
                withTextScale: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
