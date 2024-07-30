import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../ui/components/components.dart';
import '../../../../ui/helpers/helpers.dart';
import '../../../../ui/pages/pages.dart';
import '../../../ui/mixins/mixins.dart';

class ResultClinicsPage extends StatefulWidget {
  final SearchResultClinicsPresenter presenter;
  const ResultClinicsPage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<ResultClinicsPage> createState() => _ResultClinicsPageState();
}

class _ResultClinicsPageState extends State<ResultClinicsPage> with NavigationManager {
  SearchResultClinicsPresenter get _presenter => widget.presenter;

  late List<HomeSearchClinicViewmodel> _clinics;

  convertToDecode() {
    final decoded = jsonDecode(Get.parameters['result']!);
    _clinics = (decoded as List).map((e) => HomeSearchClinicViewmodel.fromJson(e)).toList();
  }

  @override
  void initState() {
    convertToDecode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildDefaultAppBar(context, title: R.string.searchResult, onPressed: () {
        Navigator.pop(context);
      }),
      body: Builder(builder: (context) {
        handleNavigation(_presenter.navigateToStream);
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              const SizedBox(
                height: 27,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '${_clinics.length} ${R.string.resultsFound}',
                  style: textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 27,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: _clinics.length,
                itemBuilder: (context, index) {
                  var item = _clinics[index];

                  return GestureDetector(
                    onTap: () => _presenter.goToClinicPage(item.id),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 5, left: 16),
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                // borderRadius: const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8,
                                    // spreadRadius: 1,
                                    offset: Offset(2, 2),
                                    color: Colors.black12,
                                  ),
                                  BoxShadow(
                                    blurRadius: 8,
                                    // spreadRadius: 1,
                                    offset: Offset(-2, -2),
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                child: Image.network(
                                  item.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: SizedBox(
                                height: 70,
                                width: 70,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 21),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${item.city}, ${item.district}',
                                            style: textTheme.bodyText2!.copyWith(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (item.rating! > 0)
                                            Text(
                                              ' (${item.rating.toString().substring(0, 3)})',
                                              style: textTheme.bodyText2!
                                                  .copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
                                            ),
                                        ],
                                      ),
                                      Text(
                                        item.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, height: 1.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 70,
                                width: 70,
                                child: Center(
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
