
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

Slide {
    property alias codeText: liveEditor.codeText
    property variant lastCreatedItem: null
    property alias editorWidth: liveEditor.width

    id: liveCodingSlide

    LiveEditor {
        id: liveEditor
        onCodeTextChanged: {
            var newItem = Qt.createQmlObject(codeText, liveCodeContainer, null);

            if (newItem !== null) {
                if (lastCreatedItem !== undefined && lastCreatedItem !== null) {
                    lastCreatedItem.destroy();
                }

                lastCreatedItem = newItem;
                newItem.visible = true;
            }
        }
    }
    Item {
        id: liveCodeContainer
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: liveEditor.visible ? liveEditor.right : parent.left
            right: parent.right
        }
    }
}
