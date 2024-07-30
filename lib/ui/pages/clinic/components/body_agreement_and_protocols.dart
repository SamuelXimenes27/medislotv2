import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../../../../ui/helpers/helpers.dart';

class BodyAgreementAndProtocols extends StatefulWidget {
  final List<InsurerEntity> insurers;
  const BodyAgreementAndProtocols({Key? key, required this.insurers}) : super(key: key);

  @override
  State<BodyAgreementAndProtocols> createState() => _BodyAgreementAndProtocolsState();
}

class _BodyAgreementAndProtocolsState extends State<BodyAgreementAndProtocols> {
  bool isShowSeeAll = true;
  bool isSeeAll = false;
  List<InsurerEntity> get _insurers => widget.insurers;

  @override
  void initState() {
    isShowSeeAll = _insurers.length <= 4 ? false : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  R.string.insurers,
                  style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              if (isShowSeeAll)
                Expanded(
                  flex: 2,
                  child: TextButton(
                    style: ButtonStyle(
                      alignment: Alignment.centerRight,
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero,
                      ),
                    ),
                    child: Text(
                      isSeeAll ? R.string.close : R.string.seeAll,
                      style: textTheme.bodyText2!.copyWith(
                        color: colorScheme.primary,
                        fontSize: 12,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isSeeAll = !isSeeAll;
                      });
                    },
                  ),
                )
            ],
          ),
        ),
        SizedBox(
          height: isSeeAll ? 20.0 * _insurers.length : 80,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: const ScrollPhysics(),
            itemCount: getCount(),
            itemBuilder: (context, index) {
              final item = _insurers[index];

              return Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText1!.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  int getCount() {
    if (_insurers.length <= 4) {
      return _insurers.length;
    } else {
      return isSeeAll ? _insurers.length : 4;
    }
  }
}
