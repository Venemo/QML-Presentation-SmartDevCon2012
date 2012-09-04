
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

Item {
    property variant currentSlide: null
    property int currentSlideIndex: -1

    function sanitizeCurrentSlide() {
        if (currentSlide === null && children.length > 0) {
            currentSlide = children[0];
            currentSlideIndex = 0;
        }
        else {
            console.log("No slides at all!");
        }
    }

    function goToNextSlide() {
        if (currentSlideIndex < children.length - 1) {
            currentSlide.forwardNavigateFrom();
            currentSlideIndex++;
            currentSlide = children[currentSlideIndex];
            currentSlide.forwardNavigateTo();
        }
    }

    function goToPreviousSlide() {
        if (currentSlideIndex > 0) {
            currentSlide.backwardNavigateFrom();
            currentSlideIndex--;
            currentSlide = children[currentSlideIndex];
            currentSlide.backwardNavigateTo();
        }
    }

    Component.onCompleted: {
        var i;
        var z = children.length;
        for (i = 0; i < children.length; i++) {
            children[i].visible = false;
            children[i].z = z;
            z--;
        }
        currentSlide = children[0];
        currentSlideIndex = 0;
        children[0].visible = true;
        //sanitizeCurrentSlide();
        //currentSlide.visible = true;
    }

    anchors.fill: parent
}
