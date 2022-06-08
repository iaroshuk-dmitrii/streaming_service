import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonTitle;
  final void Function()? onPressed;
  final bool transparent;
  final Size? minimumSize;

  const RoundedButton({
    Key? key,
    required this.buttonTitle,
    this.onPressed,
    this.transparent = false,
    this.minimumSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          side: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          primary: transparent ? Colors.transparent : Theme.of(context).colorScheme.secondary,
          onPrimary: Theme.of(context).colorScheme.onSecondary,
          alignment: Alignment.center,
          minimumSize: minimumSize,
        ),
        onPressed: onPressed,
        child: Text(
          buttonTitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

class SmallRoundedButton extends StatelessWidget {
  final String buttonTitle;
  final void Function()? onPressed;
  final bool transparent;
  final Size? minimumSize;

  const SmallRoundedButton({
    Key? key,
    required this.buttonTitle,
    this.onPressed,
    this.transparent = false,
    this.minimumSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          side: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          primary: transparent ? Colors.transparent : Theme.of(context).colorScheme.secondary,
          onPrimary: Theme.of(context).colorScheme.onSecondary,
          alignment: Alignment.center,
          minimumSize: minimumSize,
        ),
        onPressed: onPressed,
        child: Text(
          buttonTitle,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
