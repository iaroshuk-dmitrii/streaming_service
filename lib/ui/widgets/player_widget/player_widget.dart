import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/repositories/player_client.dart';
import 'package:streaming_service/ui/widgets/player_widget/player_widget_model.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({Key? key}) : super(key: key);

  void Function()? _playButtonPress(PlayerWidgetModel model) {
    if (model.playerState == PlayerState.unknown) {
      return null;
    } else {
      return () {
        if (model.playerState == PlayerState.playing) {
          model.pauseTrack();
        } else {
          model.playTrack();
        }
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PlayerWidgetModel>();
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          color: Theme.of(context).colorScheme.primary,
          onPressed: _playButtonPress(model),
          icon: (model.playerState == PlayerState.playing)
              ? const Icon(Icons.pause_circle_outline_outlined, size: 30)
              : const Icon(Icons.play_circle_outline, size: 30),
        ),
        Expanded(
          child: Slider(
            value: model.playedTimeMilliseconds,
            max: model.fullTimeInMilliseconds,
            onChanged: (value) {
              model.setTime(value);
            },
          ),
        ),
      ],
    );
  }
}
