
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
import "./components"

Item {
    focus: true
    Keys.onEscapePressed: {
        console.log("ESC pressed - bye!")
        Qt.quit();
    }
    Keys.onPressed: {
        if (event.key === Qt.Key_F12) {
            liveEditor.toggle();
            event.accepted = true;
        }
        else if (event.key === Qt.Key_PageUp) {
            slideContainer.goToPreviousSlide();
            event.accepted = true;
        }
        else if (event.key === Qt.Key_PageDown) {
            slideContainer.goToNextSlide();
            event.accepted = true;
        }

    }

    Image {
        id: squirrel
        source: "qrc:/img/squirrel.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        visible: false
    }

    Image {
        source: "qrc:/img/bg.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    MouseArea {
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent
        onPressed: {
            if (mouse.button === Qt.LeftButton) {
                slideContainer.goToNextSlide();
                mouse.accepted = true;
            }
            else if (mouse.button === Qt.RightButton) {
                slideContainer.goToPreviousSlide();
                mouse.accepted = true;
            }
        }
    }

    SlideContainer {
        id: slideContainer

        SectionTitleSlide {
            slideTitle: "How to develop user experiences with QML\n(for Mer)"

            Text {
                font.bold: true
                text: "Timur Kristóf"
                color: "#fff"
                font.pixelSize: 30
                font.family: "monospace"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 100
            }
        }

        SectionTitleSlide {
            slideTitle: "Have you ever used a declarative UI?"
            sectionTitle: "Introduction to QML"
        }

        BulletsSlide {
            slideTitle: "Advantages of a declarative UI"
            sectionTitle: "Introduction to QML"
            bullets: [
                "SoC (Separation of Concerns)",
                "Time saver",
                "Very easy to use (even for designers)",
                "Readable code: object tree instead of imperative logic"
            ]
        }

        BulletsSlide {
            slideTitle: "Where can I use QML?"
            sectionTitle: "Introduction to QML"
            bullets: [
                "Nokia phones (Symbian, MeeGo)",
                "Desktops (Linux, Windows, Mac)",
                "Mer products (Jolla, Nemo Mobile, Seadot, etc) ",
                "Blackberry",
                "community port to Android, iOS, Windows (Phone) 8",
                "Recent news: Digia buys Qt from Nokia"
            ]
        }

        BulletsSlide {
            slideTitle: "What is Qt?"
            sectionTitle: "Introduction to QML"
            bullets: [
                "C++ UI framework (20 years experience)",
                "Used to focus on desktop, now mobile",
                "Open governance"
            ]
        }

        LiveCodingSlide {
            slideTitle: "Basics"
            sectionTitle: "Introduction to QML"
            codeText: "import QtQuick 2.0

Rectangle {
  color: 'white'
  anchors.centerIn: parent
  width: 200
  height: 200

  // child items here
  // animation, text, etc.
}"
        }

        StaticCodingSlide {
            slideTitle: "How to run?"
            sectionTitle: "Introduction to QML"
            codeText: "qmlviewer /yourproject/YourFile.qml\n\n(or embed in a C++ app)"
        }

        BulletsSlide {
            slideTitle: "Advantages of QML"
            sectionTitle: "Introduction to QML"
            bullets: [
                "JSON style (not XML)",
                "Scriptable with JS (V8)",
                "Hardware acceleration",
                "Bindings everywhere",
                "Interoperable with C++",
                "Model-View architecture",
                "Compiled to native code",
                "QML 2: Integrated shaders"
            ]
        }

        SectionTitleSlide {
            slideTitle: "Components for QML"
            sectionTitle: "QML Components"
        }

        BulletsSlide {
            slideTitle: "What are components?"
            sectionTitle: "QML Components"
            bullets: [
                "Reusable blocks of code",
                "1 QML file = 1 component",
                "e.g. buttons, text fields, etc."
            ]
        }

        LiveCodingSlide {
            slideTitle: "Example button component"
            sectionTitle: "QML Components"
            editorWidth: 800
            codeText: "import QtQuick 2.0

Rectangle {
  property alias text: buttonText.text
  signal clicked

  id: button
  radius: 10
  width: buttonText.width * 1.5
  height: buttonText.height * 1.75
  border.color: button.style.borderColor
  border.width: 2
  gradient: button.style.normalGradient
  anchors.centerIn: parent

  Text {
    id: buttonText
    anchors.centerIn: parent
    font.pixelSize: 25
    color: button.style.fontColor
    text: 'Press me'
  }
  MouseArea {
    id: buttonMouseArea
    anchors.fill: parent
    onPressed: button.gradient = button.style.pressedGradient
    onReleased: button.gradient = button.style.normalGradient
    onClicked: button.clicked()
  }

  property variant style: QtObject {
    property Gradient normalGradient: Gradient {
      stops: [
        GradientStop { position: 0; color: 'white'; },
        GradientStop { position: 1; color: '#dddddd'; }
      ]
    }
    property Gradient pressedGradient: Gradient {
      stops: [
        GradientStop { position: 0; color: 'white'; },
        GradientStop { position: 1; color: 'white'; }
      ]
    }
    property string borderColor: '#b7b7b7'
    property string fontColor: 'black'
  }
}"
        }

        StaticCodingSlide {
            slideTitle: "Using this component"
            sectionTitle: "QML Components"
            codeText: "import QtQuick 2.0
import './mycomponents'

Button {
  text: 'Your text'
  style.borderColor: 'black'
}"
        }

        BulletsSlide {
            slideTitle: "Perhaps you hate reinventing the wheel"
            sectionTitle: "QML Components"
            bullets: [
                "There are premade components",
                "e.g. buttons, text fields, etc."
            ]
        }

        StaticCodingSlide {
            slideTitle: "The qt-components project"
            sectionTitle: "QML Components"
            codeText: "import QtQuick 1.1
import com.nokia.meego 1.1
// or import com.nokia.symbian
// or the blackberry components
// etc.

PageStackWindow {
  Page {
    // ...

    Button {
      text: 'Your text'
    }
  }
}"
        }

        BulletsSlide {
            slideTitle: "The qt-components project"
            sectionTitle: "QML Components"
            bullets: [
                "Usually platform specific (look & feel)",
                "Nemo Mobile uses the MeeGo components",
                "desktop components prototype, etc."
            ]
        }

        SectionTitleSlide {
            slideTitle: "QML 2: What's new in Qt 5?"
            sectionTitle: "QML 2"
        }

        LiveCodingSlide {
            slideTitle: "Inline GLSL shaders"
            sectionTitle: "QML 2"
            codeText: "import QtQuick 2.0

ShaderEffect {
  property variant tex: squirrel
  anchors.centerIn: parent
  width: 400
  height: width / squirrel.width * squirrel.height

  fragmentShader: '
    uniform sampler2D tex;
    uniform lowp float qt_Opacity;
    varying highp vec2 qt_TexCoord0;

    void main() {
      gl_FragColor = texture2D(tex, qt_TexCoord0) * qt_TexCoord0.x * qt_TexCoord0.y * 2.0 * qt_Opacity;
    }'
}"
        }

        BulletsSlide {
            slideTitle: "Graphics stack"
            sectionTitle: "QML 2"
            bullets: [
                "New graphics stack",
                "Minimum requirement: OpenGL ES 2.0",
                "Scene graph based (really really fast)"
            ]
        }

        SectionTitleSlide {
            slideTitle: "How to make this into a Mer product?"
            sectionTitle: "About Mer UXes"
        }

        BulletsSlide {
            slideTitle: "Creating a Mer UX"
            sectionTitle: "About Mer UXes"
            bullets: [
                "Create your UI",
                "If needed, use components for\n  window management (lipstick)",
                "Configure uxlaunch",
                "Create a Mer image (with the SDK)"
            ]
        }

        SectionTitleSlide {
            slideTitle: "Questions?"
        }

        SectionTitleSlide {
            slideTitle: "Thanks for watching!"

            Text {
                font.bold: true
                text: "Timur Kristóf\nE-mail: timur.kristof@gmail.com\nTwitter: Venemo\nBlog: http://devblog.timur.hu/"
                color: "#fff"
                font.pixelSize: 30
                font.family: "monospace"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 100
            }
        }
    }
}
