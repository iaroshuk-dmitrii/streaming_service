import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonTitle;
  final void Function()? onPressed;

  const RoundedButton({Key? key, required this.buttonTitle, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          primary: Theme.of(context).colorScheme.secondary,
          onPrimary: Theme.of(context).colorScheme.onSecondary,
          alignment: Alignment.center,
        ),
        onPressed: onPressed,
        child: Text(buttonTitle),
      ),
    );
  }
}
