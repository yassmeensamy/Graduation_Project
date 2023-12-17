class JournalingState 
{
  const JournalingState ();
}
class IntialJournalingState extends JournalingState 
{

}
class WritingJouenalingState extends JournalingState 
{
   final int wordsNumbers;
   WritingJouenalingState(this.wordsNumbers);
}
class limitJournalingState extends JournalingState
{
 final  bool isWritingAllowed ;
 limitJournalingState(this.isWritingAllowed);
}


