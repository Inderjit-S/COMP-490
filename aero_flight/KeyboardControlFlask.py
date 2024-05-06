import KeyPressModule as KP
from djitellopy import Tello
from time import sleep
import cv2
import sys
from flask import Flask, Response

app = Flask(__name__)

# KP.init()
# me = Tello()
# me.connect()
# \\print(me.get_battery())
# me.streamon()

@app.route('/keyboard_control')
def keyboard_control():
    KP.init()
    me = Tello()
    me.connect()
    print(me.get_battery())
    me.streamon()
    def get_keyboard_input():
        lr, fb, ud, yv = 0, 0, 0, 0
        speed = 50
        if KP.getKey("LEFT"):
            lr = -speed
        elif KP.getKey("RIGHT"):
            lr = speed

        if KP.getKey("UP"):
            fb = speed
        elif KP.getKey("DOWN"):
            fb = -speed

        if KP.getKey("w"):
            ud = speed
        elif KP.getKey("s"):
            ud = -speed

        if KP.getKey("a"):
            yv = speed
        elif KP.getKey("d"):
            yv = -speed

        if KP.getKey("e"):
            me.land()
        if KP.getKey("q"):
            me.takeoff()

        if KP.getKey("p"):
            sys.exit()

        return [lr, fb, ud, yv]

    def generateFrames():
        while True:
            img = me.get_frame_read().frame
            img = cv2.resize(img, (360, 240))
            _, jpeg = cv2.imencode('.jpg', img)
            frame = jpeg.tobytes()
            yield (b'--frame\r\n'
                    b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n\r\n')
            # cv2.imshow("Image", img)
            # cv2.waitKey(1)

            vals = get_keyboard_input()
            me.send_rc_control(vals[0], vals[1], vals[2], vals[3])
            sleep(0.05)
    return Response(generateFrames(), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
    app.run(debug=True)
