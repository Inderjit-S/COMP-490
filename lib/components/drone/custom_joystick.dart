import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as Math;

class CustomJoystick extends StatefulWidget {
  final double radius;
  final double stickRadius;
  final Function callback;
  final String position;

  const CustomJoystick({
    Key? key,
    required this.radius,
    required this.stickRadius,
    required this.callback,
    required this.position,
  }) : super(key: key);

  @override
  _CustomJoystickState createState() => _CustomJoystickState();
}

class _CustomJoystickState extends State<CustomJoystick> {
  final GlobalKey _joystickContainer = GlobalKey();
  double yOff = 0, xOff = 0;
  double _x = 0, _y = 0;
  String _position = " ";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final RenderBox renderBoxWidget =
          _joystickContainer.currentContext?.findRenderObject() as RenderBox;
      final offset = renderBoxWidget.localToGlobal(Offset.zero);

      xOff = offset.dx;
      yOff = offset.dy;
    });

    _centerStick();
  }

  void _centerStick() {
    setState(() {
      _x = widget.radius;
      _y = widget.radius;
      _position = widget.position;
    });

    _sendCoordinates(_x, _y, _position);
  }

  int map(x, in_min, in_max, out_min, out_max) {
    return ((x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min)
        .floor();
  }

  void _onPointerMove(PointerEvent details) {
    final RenderBox renderBoxWidget =
        _joystickContainer.currentContext?.findRenderObject() as RenderBox;
    final Size size = renderBoxWidget.size;

    double x = details.position.dx - xOff;
    double y = details.position.dy - yOff;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      // Swap x and y coordinates for landscape mode
      double temp = x;
      x = y;
      y = temp;

      // Adjust xOff and yOff accordingly
      xOff = details.position.dy - size.height;
      yOff = size.width - details.position.dx;
    }

    if (_isStickInside(x, y, widget.radius, widget.radius,
        widget.radius - widget.stickRadius)) {
      setState(() {
        _x = x;
        _y = y;
        _position = widget.position;
      });

      _sendCoordinates(x, y, _position);
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    _centerStick();
  }

  void _sendCoordinates(double x, double y, String z) {
    double speed = y - widget.radius;
    double direction = x - widget.radius;

    var vSpeed = -1 *
        map(speed, 0, (widget.radius - widget.stickRadius).floor(), 0, 100);
    var vDirection =
        map(direction, 0, (widget.radius - widget.stickRadius).floor(), 0, 100);

    widget.callback(vDirection, vSpeed, z);
  }

  bool _isStickInside(x, y, circleX, circleY, circleRadius) {
    var absX = Math.pow((x - circleX).abs(), 2.0);
    var absY = Math.pow((y - circleY).abs(), 2.0);
    return Math.sqrt(absX + absY) < circleRadius;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerMove: _onPointerMove,
        onPointerUp: _onPointerUp,
        child: Container(
          key: _joystickContainer,
          width: widget.radius * 2,
          height: widget.radius * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            color: Colors.grey.shade800,
          ),
          child: Stack(
            children: [
              Positioned(
                left: _x - widget.stickRadius,
                top: _y - widget.stickRadius,
                child: Container(
                  width: widget.stickRadius * 2,
                  height: widget.stickRadius * 2,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(widget.stickRadius),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JoystickService {
  static Future<String> getJoystickLeft() async {
    final dbRefJoystickLeft =
        FirebaseDatabase.instance.reference().child('left_joystick_movement');
    final snapshot = await dbRefJoystickLeft.once();
    final data = snapshot.snapshot.value;
    return data.toString();
  }

  static Future<String> getJoystickRight() async {
    final dbRefJoystickRight =
        FirebaseDatabase.instance.reference().child('right_joystick_movement');
    final snapshot = await dbRefJoystickRight.once();
    final data = snapshot.snapshot.value;
    return data.toString();
  }

  static Future<void> updateJoystickLeft(String movement) async {
    final dbRefJoystickLeft =
        FirebaseDatabase.instance.reference().child('left_joystick_movement');
    await dbRefJoystickLeft.set(movement).catchError((error) {
      print('Error updating movementt: $error');
      throw Exception('Failed to update movement');
    });
  }

  static Future<void> updateJoystickRight(String movement) async {
    final dbRefJoystickRight =
        FirebaseDatabase.instance.reference().child('right_joystick_movement');
    await dbRefJoystickRight.set(movement).catchError((error) {
      print('Error updating movement: $error');
      throw Exception('Failed to update movement');
    });
  }
}