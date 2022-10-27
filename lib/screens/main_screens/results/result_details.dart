import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hq/cubit/cubit.dart';
import 'package:hq/cubit/states.dart';
import 'package:hq/screens/main_screens/results/widget_components.dart';
import 'package:hq/shared/components/general_components.dart';
import 'package:hq/shared/constants/colors.dart';
import 'package:hq/shared/constants/general_constants.dart';
import 'package:hq/shared/network/local/const_shared.dart';
import 'package:hq/translations/locale_keys.g.dart';

class ResultDetailsScreen extends StatefulWidget {
  const ResultDetailsScreen({Key? key, required this.resultId}) : super(key: key);
  final int resultId;
  @override
  State<ResultDetailsScreen> createState() => _ResultDetailsScreenState();
}

class _ResultDetailsScreenState extends State<ResultDetailsScreen> {

  @override
  void initState(){
    super.initState();
    AppCubit.get(context).getLabResults(resultId: widget.resultId);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var result =  AppCubit.get(context)
            .labResultsModel?.data?.first;
        return Scaffold(
          backgroundColor: greyExtraLightColor,
          appBar: GeneralAppBar(
            title: '${LocaleKeys.TxtTestResult.tr()} ( ${result?.countResult ?? ''} )',
            appBarColor: greyExtraLightColor,
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 70,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(
                        radius,
                      ),
                      border: Border.all(
                        width: 1,
                        color: greyLightColor,
                      ),
                    ),
                    padding:
                        const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                '# ${result?.id ?? ''}',
                                style: titleSmallStyle,
                                textAlign: TextAlign.start,
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            result?.date?.date ?? '',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => InkWell(
                      onTap: (){},
                      child: ResultsDetailsCart(labResultsDataFileModel: result!.results![index],),
                    ),
                    separatorBuilder: (context, index) => verticalMiniSpace,
                    itemCount: result?.results?.length ?? 0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
