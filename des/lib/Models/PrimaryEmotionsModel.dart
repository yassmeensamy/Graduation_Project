class PrimaryMoodModel 
{
final String moodText;
 PrimaryMoodModel  ({required this.moodText});
 factory PrimaryMoodModel .fromJson(Map<String,dynamic>json)
 {
    return PrimaryMoodModel (moodText:json['name']);
 }
}