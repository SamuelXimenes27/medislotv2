import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';

class UpcomingItem extends StatelessWidget {
  final bool isVideo;
  final bool isVideoAvailable;
  final UpcomingViewmodel upcomingViewmodel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final UpcomingPresenter presenter;

  const UpcomingItem({
    Key? key,
    required this.isVideo,
    required this.isVideoAvailable,
    required this.scaffoldKey,
    required this.upcomingViewmodel,
    required this.presenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(
          height: 110,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 110,
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
                      child: upcomingViewmodel.profressionalPhoto != null
                          ? Image.asset(
                              'lib/ui/assets/imgs/image_without_photo.png',
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              upcomingViewmodel.profressionalPhoto!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          upcomingViewmodel.name,
                          style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          upcomingViewmodel.specialty,
                          style: textTheme.bodyText1!.copyWith(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            BadgeDate(
                              pathIcon: 'lib/ui/assets/imgs/icon_calendar.png',
                              text: _getDate(upcomingViewmodel.dateTime),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: BadgeDate(
                                pathIcon: 'lib/ui/assets/imgs/icon_clock_yellow.png',
                                text: _getHour(upcomingViewmodel.dateTime),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (isVideo)
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () => handleVideoTap(context, isVideoAvailable),
                      child: BadgeVideo(isVideoAvailable: isVideoAvailable),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 17),
        Divider(color: Colors.grey.withOpacity(0.3)),
        const SizedBox(height: 17),
      ],
    );
  }

  String _getHour(DateTime value) {
    final hour = DateFormat('jm').format(value);
    return hour;
  }

  String _getDate(DateTime value) {
    final weekday = DateFormat.EEEE().format(value).substring(0, 3);
    final date = DateFormat("dd/MM/yy").format(value);
    return '$weekday, $date';
  }

  void handleVideoTap(BuildContext context, bool isVideoAvailable) {
    if (isVideoAvailable) {
      presenter.goToVideoCall(upcomingViewmodel.upcomingId);
    } else {
      showInSnackBar(context);
    }
  }

  void showInSnackBar(BuildContext context) {
    var snackBar = SnackBar(
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        content: Row(
          children: [
            const Icon(
              Icons.warning,
              color: Color.fromARGB(255, 204, 196, 130),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                R.string.warningVideoOnlyDayOfAppointment,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
