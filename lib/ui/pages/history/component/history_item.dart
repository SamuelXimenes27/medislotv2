import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';

class HistoryItem extends StatefulWidget {
  final HistoryItemViewmodel item;
  const HistoryItem({Key? key, required this.item}) : super(key: key);

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  HistoryItemViewmodel get _item => widget.item;
  late HistoryPresenter _presenter;
  final textEditing = TextEditingController();
  double _rating = 3;

  @override
  void initState() {
    super.initState();
  }

  void openRatingModalSheet(int appointmentId) {
    _rating = 3;
    textEditing.clear();

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 350,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 5,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  R.string.rate,
                  style: Theme.of(context).textTheme.headline4,
                ),
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _rating = rating;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  R.string.ratingComment,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: textEditing,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await _presenter.rateAppointment(
                        RateAppointmentParams(
                          appointmentId: appointmentId,
                          rating: _rating,
                          message: textEditing.text,
                        ),
                      );
                      await _presenter.loadPage();
                    },
                    child: Text(R.string.rate))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    _presenter = Provider.of<HistoryPresenter>(context);

    return Column(
      children: [
        Row(
          children: [
            _buildImageWithBadge(),
            Expanded(
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildRowWithNameAndRateButton(),
                      const SizedBox(height: 4),
                      Text(
                        _item.specialty,
                        style: textTheme.bodyText1!.copyWith(fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _item.address,
                        style: textTheme.bodyText1!.copyWith(fontSize: 14, color: const Color(0xffB1b1b1)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          BadgeDate(
                            pathIcon: 'lib/ui/assets/imgs/icon_calendar.png',
                            text: _getDate(),
                          ),
                          const SizedBox(width: 17),
                          Flexible(
                            child: BadgeDate(
                              pathIcon: 'lib/ui/assets/imgs/icon_clock_yellow.png',
                              text: _getHour(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey.withOpacity(0.7),
        ),
      ],
    );
  }

  String _getHour() {
    final hour = DateFormat('jm').format(_item.dateTime);
    return hour;
  }

  String _getDate() {
    final weekday = DateFormat.EEEE().format(_item.dateTime).substring(0, 3);
    final date = DateFormat("dd/MM/yy").format(_item.dateTime);
    return '$weekday, $date';
  }

  Widget _buildRowWithNameAndRateButton() {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            _item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyText1!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _item.rating == null
            ? SizedBox(
                height: 23,
                width: 62,
                child: ElevatedButton(
                  onPressed: () => openRatingModalSheet(_item.id),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      R.string.rate,
                      style: textTheme.bodyText2!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            : Row(
                children: [
                  Text(
                    _item.rating.toString(),
                    style: textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Image.asset('lib/ui/assets/imgs/icon_star.png', height: 20)
                ],
              )
      ],
    );
  }

  Widget _buildImageWithBadge() {
    return SizedBox(
      height: 130,
      width: 135,
      child: Stack(
        children: [
          Container(
            height: 105,
            margin: const EdgeInsets.only(top: 12, left: 16),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(2, 2),
                  color: Colors.black.withOpacity(0.2),
                ),
                BoxShadow(
                  blurRadius: 8,
                  offset: const Offset(-2, -2),
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: _item.photo != null
                  ? Image.network(
                      _item.photo!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'lib/ui/assets/imgs/image_without_photo.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            top: 0,
            left: 100,
            child: BadgeVideo(isVideoAvailable: false, backgroundColor: Colors.white.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
