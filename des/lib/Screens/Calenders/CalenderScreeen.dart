
import '../../../constants.dart' as constants;
/*
class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold
    ( 
      body: 
      Padding(
        padding: const EdgeInsets.only(top:40),
        child: Center(child:
        Column(
          children: [
               Row(children: [
             IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios ,color: Colors.black,)),
             Text("Hello, Yara!",style: GoogleFonts.comfortaa( color: Colors.black,fontSize:25,fontWeight: FontWeight.w700 ),),
                ],),
            SizedBox(height: 20,),
                Text("Mindful Moments Tracker",style: GoogleFonts.comfortaa( color: Colors.blue,fontSize:25 ) ),
                
                 Expanded( // Use Expanded to prevent infinite height issues in Column
                child: Calendar(),
              ),
      
          ],
        ),
        ),
      )
    );
}
}

class Calendar extends StatefulWidget {
  @override
  _ImageCalendarState createState() => _ImageCalendarState();
}

class _ImageCalendarState extends State<Calendar> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime? _selectedDay;

  // Map to associate dates with specific images
  final Map<DateTime, String> dayImages = {
    DateTime(2024, 1, 1): 'Assets/Proud.png',
    DateTime(2024, 1, 2): 'Assets/Proud.png',
    // Add more entries for each date you want to map to an image
  };

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 12,left: 12,top:30), // Uniform padding
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: constants.babyBlue30,
          ),
          width: 400,
          height: 520,
          child: 
          Padding(
            padding: const EdgeInsets.only(left:7,right: 7),
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              calendarFormat: _calendarFormat,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              
              rowHeight: 85,
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, events) {
                 
                  String imagePath = dayImages[date] ?? 'Assets/Proud.png';
                  return 
                  Center(child:
                  Column( children: [
                    Image.asset(imagePath, width: 45, height: 45),
                    SizedBox(height: 2,),
                    Text(date.day.toString(),style: GoogleFonts.comfortaa()),
                  ],),
              );
                  /*
                  Center(
                    child: Image.asset(imagePath, width: 50, height: 50),
                  );
                  */
                },
              ),
              headerStyle: HeaderStyle(
                decoration: BoxDecoration(color: Colors.transparent), 
                formatButtonVisible: false, 
                titleCentered: true,
              ),
             
            ),
          ),
        ),
      ),
    );
  }
}
*/