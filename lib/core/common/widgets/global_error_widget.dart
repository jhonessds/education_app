import 'package:flutter/material.dart';

class GlobalErrorWidget extends StatelessWidget {
  const GlobalErrorWidget({
    required this.connectionError,
    super.key,
    this.onTryAgainPressed,
    this.color,
  });
  final bool connectionError;
  final void Function()? onTryAgainPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.clear,
          color: Colors.red,
          size: 40,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Text(
            connectionError
                ? 'Houve um problema em sua conexão'
                : 'Não foi possível processar sua solicitação',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: color ?? Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        if (onTryAgainPressed != null)
          OutlinedButton(
            onPressed: onTryAgainPressed,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: const BorderSide(
                width: 2,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Text(
                'Tentar novamente',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
      ],
    );
  }
}
