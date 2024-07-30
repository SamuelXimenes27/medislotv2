import 'package:flutter/material.dart';

class BodyRowWithNameAndRating extends StatelessWidget {
  final String name;
  final double? rating;
  const BodyRowWithNameAndRating({
    Key? key,
    required this.name,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 56,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Text(
              name,
              style: textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (rating != null && rating! > 0)
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text(rating.toString().substring(0, 3)),
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
