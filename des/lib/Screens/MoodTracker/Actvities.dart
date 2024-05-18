import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart' as constants;
import '../../Components/NextButton.dart';
import '../../Models/ActivityModel.dart';
import '../../Models/ReasonModel.dart';
import '../../cubit/EmotionCubit.dart';
import '../../cubit/cubit/activity_card_cubit.dart';
import '../../cubit/cubit/activity_card_state.dart';

class Activities extends StatelessWidget {
  final List<ActivityModel> activitiesList;
  final List<ReasonModel> reasonList;

  Activities({
    required this.activitiesList,
    required this.reasonList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 25, left: 25, bottom: 15),
            child: ListView(children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    
                    },
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                  ),
                  const SizedBox(width: 35),
                  TitleScreen(Title: "What activities\nhave you done today?"),
                ],
              ),
              ContentScreen(
                list: activitiesList,
                cardType: "activity",
              ),
              TitleScreen(Title: "Do you know why\nyou are feeling happy?"),
              ContentScreen(
                list: reasonList,
                cardType: "reason",
              ),

              SizedBox(
                  height: 20), // Positioned outside of Row for proper spacing
              NextButton(
                ontap: () {
                  BlocProvider.of<SecondLayerCubit>(context)
                      . saveansNavigateJournaling(context);
                },
                groundColor: constants.mint,
                text: "Next",
              ),
            ])));
  }
}

class TitleScreen extends StatelessWidget {
  String Title;
  TitleScreen({required this.Title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        Title,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class ContentScreen extends StatelessWidget {
  dynamic list;

  String cardType;
  ContentScreen({required this.list, required this.cardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            //mainAxisExtent: 90,
            childAspectRatio: .94,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ActivityCard(
              mood: list[index],
              index: index,
              backgroundColorAfter: Colors.black.withOpacity(.35),
              backgroundColorBefore: constants.mint,
              cardType: cardType,
            );
          },
        ),
      ],
    );
  }
}

class ActivityCard extends StatelessWidget {
  final dynamic mood; // Can be ActivityModel or ReasonModel
  final int index;
  final Color backgroundColorBefore;
  final Color backgroundColorAfter;
  final String cardType;

  const ActivityCard({
    Key? key,
    required this.mood,
    required this.index,
    required this.backgroundColorBefore,
    required this.backgroundColorAfter,
    required this.cardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivitiesCubit, ActivitiesState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isSelected = false;

        if (cardType == "activity") {
          isSelected = state.selectedActivities.contains(index);
          // Check selected activities
        } else if (cardType == "reason") {
          isSelected =
              state.selectedReasons.contains(index); // Check selected reasons
        }

        return InkWell(
          onTap: () {
            if (cardType == "activity") {
              if (isSelected) {
                context.read<ActivitiesCubit>().deselectActivity(index);
                context
                    .read<SecondLayerCubit>()
                    .ReasonSelected
                    .removeWhere((map) => map['activity'] == mood.Text);
              } else {
                context.read<ActivitiesCubit>().selectActivity(index);
                context.read<SecondLayerCubit>().StoreActivity(mood.Text);
              }
            } else if (cardType == "reason") {
              if (isSelected) {
                context
                    .read<ActivitiesCubit>()
                    .deselectReason(index); // Deselect reason
                context
                    .read<SecondLayerCubit>()
                    .ReasonSelected
                    .removeWhere((map) => map['reason'] == mood.Text);
              } else {
                context
                    .read<ActivitiesCubit>()
                    .selectReason(index); // Select reason
                context.read<SecondLayerCubit>().StoreReason(mood.Text);
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? backgroundColorAfter : backgroundColorBefore,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      image: NetworkImage(mood.ImagePath),
                      height: 50,
                      width: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/travel.png',
                            height: 50, width: 50);
                      }),
                  Text(
                    mood.Text,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
