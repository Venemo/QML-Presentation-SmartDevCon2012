
// Copyright (c) 2012, Timur Kristóf <venemo@fedoraproject.org>
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

Rectangle {
    property alias sectionTitle: sectionTitleText.text
    property alias slideTitle: slideTitleText.text
    property color accentColor: "#fff"
    property color bgColor: "#00f"
    property color normalTextColor: "#fff"

    function forwardNavigateTo() {
        showOpacityAnimation.start();
    }

    function forwardNavigateFrom() {
        hideRotationAnimation.start();

    }

    function backwardNavigateTo() {
        showRotationAnimation.start();
    }

    function backwardNavigateFrom() {
        hideOpacityAnimation.start();
    }


    id: slide
    color: "#00000000"
    anchors.fill: parent

    transform: Rotation {
        id: myRotation
        angle: 0
        axis {
            x: 1
            y: -1
            z: 1
        }

        NumberAnimation on angle {
            id: showRotationAnimation
            duration: 400
            from: 90
            to: 0
            running: false
            onStarted: {
                hideOpacityAnimation.stop();
                hideRotationAnimation.stop();
                slide.visible = true;
            }
        }

        NumberAnimation on angle {
            id: hideRotationAnimation
            duration: 400
            from: 0
            to: 90
            running: false
            onStarted: {
                showOpacityAnimation.stop();
                showRotationAnimation.stop();
            }

            onStopped: slide.visible = false;
        }
    }

    NumberAnimation on opacity {
        id: showOpacityAnimation
        duration: 600
        from: 0.0
        to: 1.0
        running: false
        onStarted: {
            hideOpacityAnimation.stop();
            hideRotationAnimation.stop();
            slide.visible = true;
            myRotation.angle = 0;
        }
    }

    NumberAnimation on opacity {
        id: hideOpacityAnimation
        duration: 600
        from: 1.0
        to: 0.0
        running: false
        onStarted: {
            showRotationAnimation.stop();
            showOpacityAnimation.stop();
            slide.visible = true;
            myRotation.angle = 0;
        }
        onStopped: slide.visible = false;
    }

    Image {
        source: "qrc:/img/bg.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    Text {
        id: slideTitleText
        color: accentColor
        font.pixelSize: 70
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 20
        }
    }

    Rectangle {
        color: accentColor
        height: 6
        visible: slideTitleText.text !== ""
        anchors {
            left: parent.left
            right: parent.right
            top: slideTitleText.bottom
            leftMargin: 8
            rightMargin: 8
        }
    }

    Rectangle {
        height: 50
        color: accentColor
        visible: sectionTitleText.text !== ""
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: 5
        }

        Text {
            id: sectionTitleText
            color: bgColor
            font.pixelSize: 25
            anchors.centerIn: parent
        }
    }

}
