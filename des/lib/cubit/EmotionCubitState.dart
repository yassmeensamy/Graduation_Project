

import '../Models/ActivityModel.dart';
import '../Models/ReasonModel.dart';

class SecondLayerCubitCubitState 
{

}
class EmotionCubitStateIntial extends SecondLayerCubitCubitState 
{
  
}

class EmotionCubitStateLoading extends SecondLayerCubitCubitState 
{
  
}
class EmotionCubitStateFailur extends SecondLayerCubitCubitState 
{
  final String errorMessage;
  EmotionCubitStateFailur(this.errorMessage);

}
class EmotionCubitStateSucess extends SecondLayerCubitCubitState 
{
  //final List<SecondMoodModel>Emotions;
  //EmotionCubitStateSucess(this.Emotions);
  EmotionCubitStateSucess();
}

class JournalingState extends  SecondLayerCubitCubitState 
{
              
}
class PrimaryEmotionsState extends SecondLayerCubitCubitState
{
  //List<PrimaryMoodModel>Emotions;
  PrimaryEmotionsState();
}
class Activities_ReasonsState extends SecondLayerCubitCubitState 
{
  final List<ActivityModel> Activities;
  final List<ReasonModel> Reasons;

  Activities_ReasonsState(this.Activities, this.Reasons);
}
class conclusionState extends SecondLayerCubitCubitState 
{}