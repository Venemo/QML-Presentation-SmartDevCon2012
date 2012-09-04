
// Copyright (c) 2012, Timur Kristóf <venemo@fedoraproject.org>
// Particle system: Copyright (C) 2012, Andrew Baldwin
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    property alias codeText: liveEditorCode.text

    function animateShow() {
        showAnimation.start();
    }
    function animateHide() {
        hideAnimation.start();
    }
    function toggle() {
        console.log(visible)
        if (!visible)
            animateShow();
        else
            animateHide();
    }

    id: liveEditor
    color: "#66000000"
    clip: true
    width: 550
    height: 500
    radius: 20
    anchors.left: parent.left
    anchors.leftMargin: -20
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: 30
    focus: true
    Keys.onPressed: {
        if (event.key === Qt.Key_F12) {
            console.log("editor f12")
            toggle();
            event.accepted = true;
        }
    }
    transform: Rotation {
        angle: 0
        axis {
            x: 0
            y: 1
            z: 1
        }

        NumberAnimation on angle {
            id: hideAnimation
            duration: 400
            from: 0
            to: 90
            running: false
            onStarted: showAnimation.stop();
            onStopped: liveEditor.visible = false;
        }

        NumberAnimation on angle {
            id: showAnimation
            duration: 400
            from: 90
            to: 0
            running: false
            onStarted: {
                liveEditor.visible = true;
                hideAnimation.stop();
            }
        }
    }

    Flickable {
        contentHeight: liveEditorCode.height
        anchors {
            fill: parent
            margins: 20
            leftMargin: 40
        }

        TextEdit {
            id: liveEditorCode
            color: "#fff"
            width: parent.width
            font {
                pixelSize: 20
                family: "monospace"
            }
            wrapMode: TextEdit.Wrap
            onCursorPositionChanged: {
                cursorRect.x = liveEditorCode.cursorRectangle.x
                cursorRect.y = liveEditorCode.cursorRectangle.y
                stars.burst(5);
            }

            Rectangle {
                id: cursorRect
                color: "white"
                height: liveEditorCode.cursorRectangle.height
                width: liveEditorCode.cursorRectangle.width
            }

            ParticleSystem {
                id: particles
            }

            ImageParticle {
                id: star
                system: particles
                anchors.fill: parent
                groups: ["A"]
                source: "qrc:/img/star.png"
                colorVariation: 100
                color: "#00111111"
            }

            Emitter {
                 id: stars
                 group: "A"
                 system: particles
                 anchors.fill: cursorRect
                 lifeSpan: 800
                 velocity: PointDirection { yVariation: 100; xVariation: 100 }
                 acceleration: PointDirection { xVariation: 100; yVariation: 100 }
                 size: 40
                 sizeVariation: 20
                 endSize: 60
                 emitRate: 25
                 enabled: false
             }
        }
    }
}
