import 'package:demo/core/common/widgets/simple_text.dart';
import 'package:flutter/material.dart';

class NavOption extends StatelessWidget {
  const NavOption({
    required this.setUserType,
    required this.title,
    required this.currentValue,
    required this.groupValue,
    super.key,
  });
  final void Function()? setUserType;
  final String title;
  final int groupValue;
  final int currentValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: setUserType,
      child: Row(
        children: [
          Transform.scale(
            scale: 1.5,
            child: Radio(
              fillColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
              value: currentValue,
              onChanged: (value) => setUserType?.call(),
              groupValue: groupValue,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 20, left: 5),
              child: SimpleText(
                text: title,
                maxlines: 4,
                mgTop: 12,
                mgBottom: 18,
                fontSize: 16,
                textAlign: TextAlign.start,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
