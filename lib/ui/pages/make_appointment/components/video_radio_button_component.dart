import 'package:flutter/material.dart';

import '../../../../ui/helpers/helpers.dart';

class VideoRadioButton extends StatefulWidget {
  final bool isVideoAvailable;
  final bool? isVideoOptionSelected;
  final void Function(bool?)? onchanged;
  const VideoRadioButton({
    Key? key,
    required this.isVideoAvailable,
    required this.isVideoOptionSelected,
    required this.onchanged,
  }) : super(key: key);

  @override
  State<VideoRadioButton> createState() => _VideoRadioButtonState();
}

class _VideoRadioButtonState extends State<VideoRadioButton> {
  bool get _videoAvailable => widget.isVideoAvailable;
  bool? get _videoOptionSelected => widget.isVideoOptionSelected;
  void Function(bool?)? get _onchanged => widget.onchanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        isThreeLine: true,
        title: Text(R.string.videoCall),
        subtitle: _videoAvailable
            ? Row(
                children: [
                  Text(R.string.yes),
                  Radio(
                    value: true,
                    visualDensity: VisualDensity.compact,
                    groupValue: _videoOptionSelected,
                    onChanged: _onchanged,
                  ),
                  const Spacer(),
                  Text(R.string.no),
                  Radio(
                    value: false,
                    groupValue: _videoOptionSelected,
                    onChanged: _onchanged,
                  )
                ],
              )
            : const Text('Indisponível'),
      ),
    );
  }
}
