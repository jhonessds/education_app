import 'package:flutter/material.dart';

class LoginOptionIconButton extends StatelessWidget {
  const LoginOptionIconButton({
    required this.child,
    required this.callback,
    super.key,
  });

  final Widget child;
  final void Function() callback;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onTap: callback,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 47,
          width: 47,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: child,
        ),
      ),
    );
  }
}
