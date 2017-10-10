/*
 * Copyright (c) 2013, Juergen Bocklage-Ryannel, Johan Thelin
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the editors nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import QtQuick 2.0

Canvas {
   id: can
   parent: item1
   width: 800; height: 450

   anchors.top: parent.top
   anchors.topMargin: 10
   anchors.left: parent.left
   anchors.leftMargin: 10
   property real hue: 0
   property real lastX: width * Math.random()
   property real lastY: height * Math.random()

   // M1>>
   property bool requestLine: false
   property bool requestBlank: false
   // <<M1

   // M2>>
   Timer {
      id: lineTimer
      interval: 40
      repeat: true
      triggeredOnStart: true
      onTriggered: {
         can.requestLine = true
         can.requestPaint()
      }
   }

   Timer {
      id: blankTimer
      interval: 50
      repeat: true
      triggeredOnStart: true
      onTriggered: {
          can.requestBlank = true
          can.requestPaint()
      }
   }

   FancyCanvasButton {
       id: fancyCanvasButton
       x: 1150
       y: 48
       sourceImage: "qrc:/images/camera.png"

       onActivate: {
           capture()
           timers.delayAfterCapture()
       }
   }

   function capture() {
       lineTimer.stop()
       blankTimer.stop()
       var url = can.toDataURL('image/png')
       tImage.source = url
       tImage.update()
       tImage.source = url
       canvas.repaintImage = true;
       timers.requestPaintAfterDelay()
       fancyCanvasButton.x += 160
       fancyCanvasButton1.x += 240
       fancyCanvasButton.opacity = 0
       fancyCanvasButton1.opacity = 0

       timerDelayReturnedIcon.running = true
    }

   FancyCanvasButton {
       id: fancyCanvasButton1
       x: 1140
       y: 48
       sourceImage: "qrc:/images/no.png"

       onActivate: {
           fancyCanvasButton.x += 160
           fancyCanvasButton1.x += 240
           fancyCanvasButton.opacity = 0
           fancyCanvasButton1.opacity = 0

           timerDelayReturnedIcon.running = true
       }
   }
    Timer {
        id: timerDelayReturnedIcon
        interval: 1000
        repeat: false
        running: false
        onTriggered: {
            pathViewButtons.interactive = true
            loaderOnCanvas.deactivateLoader();
            mainButtons.activeButtons()
            mainButtons.disableChecked()
        }
    }
   onPaint: {
      var context = getContext('2d')
      if(requestLine) {
         line(context)
         requestLine = false
      }
      if(requestBlank) {
         blank(context)
         requestBlank = false
      }
   }

   function line(context) {
      context.save()
      context.translate(can.width/2, can.height/2)
      context.scale(0.9, 0.9)
      context.translate(-can.width/2, -can.height/2)
      context.beginPath()
      context.lineWidth = 5 + Math.random() * 10
      context.moveTo(lastX, lastY)
      lastX = can.width * Math.random()
      lastY = can.height * Math.random()
      context.bezierCurveTo(can.width * Math.random(),
                            can.height * Math.random(),
                            can.width * Math.random(),
                            can.height * Math.random(),
                            lastX, lastY);

      hue += Math.random()*0.1
      if(hue > 1.0) {
         hue -= 1
      }
      context.strokeStyle = Qt.hsla(hue, 0.5, 0.5, 1.0)
      // context.shadowColor = 'white';
      // context.shadowBlur = 10;
      context.stroke()
      context.restore()
   }

   function blank(context) {
      context.fillStyle = Qt.rgba(0,0,0,0.1)
      context.fillRect(0, 0, can.width, can.height)
   }

   Component.onCompleted: {
        lineTimer.start()
        blankTimer.start()
        fancyCanvasButton.x -= 130
        fancyCanvasButton1.x -= 210
        fancyCanvasButton.opacity = 1
        fancyCanvasButton1.opacity = 1
   }
}
