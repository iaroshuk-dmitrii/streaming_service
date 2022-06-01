import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/ui/widgets/player_widget/player_widget_model.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PlayerWidgetModel>();
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (model.isPlaying) {
              model.pauseTrack();
            } else {
              model.playTrack();
            }
          },
          icon:
              model.isPlaying ? const Icon(Icons.pause_circle_outline_outlined) : const Icon(Icons.play_circle_outline),
        ),
        Expanded(
          child: Slider(
            value: model.playedTimeSeconds,
            max: model.playbackSeconds,
            onChanged: (value) {
              model.setTime(value);
            },
          ),
        ),
      ],
    );
  }
}
