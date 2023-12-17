/*
 List<String> moods = ["Disappointed", "offfffff"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.95),
      
      body: Padding(
        padding: EdgeInsets.only(top: 100, right: 20, left: 20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          // Add shadow by setting elevation
          child: Container(
            width: 376,
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 140, 65, 65),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey, // Shadow color
                  offset: Offset(0, 3), // Offset (x, y) controls the shadow's position
                  blurRadius: 2, // Spread of the shadow
                  spreadRadius: 1, // Optional, controls the size of the shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure the column takes minimum vertical space
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Image.asset("Assets/Pictures/Emoji 7.png", height: 45, width: 45),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sad",
                          style: TextStyle(
                            fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "20:11",
                          style: TextStyle(
                            fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                        color: Color(0xff8B4CFC),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
               
                Row(children: [
                  Text("you felt"),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: moods.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        index == moods.length - 1 ? moods[index] : '${moods[index]},',
                        style: TextStyle(
                          fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
              ]
          ),
        ),
      ),
      
    ),
    
    );
  }
}
*/