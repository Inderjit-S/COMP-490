import 'package:flutter/material.dart';

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({Key? key}) : super(key: key);

  @override
  _FoodMenuScreenState createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  int? selectedButtonIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 80.0),
            child: Center(
              child: Text(
                'FOOD MENU',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Color(0xFFAC90FF),
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color(0xFF4660E8),
                      offset: Offset(0, 8),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              // Implement back button functionality
            },
            color: Color.fromARGB(68, 0, 0, 0).withOpacity(0.4),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[800]!,
              Colors.blue[400]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                20.0, 0, 20.0, 20.0), // Adjusted padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Please select a food from the menu below',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromRGBO(113, 172, 255, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF9CAAFA),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF18235B), width: 4),
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(10),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      CircularButton(
                        imagePath: 'assets/icons/hamIcon.png',
                        isSelected: selectedButtonIndex == 0,
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 0;
                          });
                        },
                      ),
                      CircularButton(
                        imagePath: 'assets/icons/carrotIcon.png',
                        isSelected: selectedButtonIndex == 1,
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 1;
                          });
                        },
                      ),
                      CircularButton(
                        imagePath: 'assets/icons/icecreamIcon.png',
                        isSelected: selectedButtonIndex == 2,
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 2;
                          });
                        },
                      ),
                      CircularButton(
                        imagePath: 'assets/icons/breadIcon.png',
                        isSelected: selectedButtonIndex == 3,
                        onPressed: () {
                          setState(() {
                            selectedButtonIndex = 3;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onPressed;

  const CircularButton({
    required this.isSelected,
    required this.onPressed,
    this.icon,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Color(0xFF9CAAFA),
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Color(0xFF05FF00) : Colors.transparent,
                width: 4,
              ),
            ),
            child: Center(
              child: imagePath != null
                  ? Image.asset(
                      imagePath!,
                      width: 118, // Adjusted width
                      height: 118, // Adjusted height
                    )
                  : Icon(
                      icon,
                      size: 50,
                      color: isSelected
                          ? Color(0xFF6354ED)
                          : Color.fromARGB(255, 255, 255, 255),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
