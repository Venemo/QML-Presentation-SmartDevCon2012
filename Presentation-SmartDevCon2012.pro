
TEMPLATE = app
TARGET = presentation
CONFIG += qt
QT += core gui quick script

INCLUDEPATH = /home/Timur/Projects/Others/qt5/qt-everywhere-opensource-src-5.0.0-beta1/qtbase/include
DEPENDPATH = /home/Timur/Projects/Others/qt5/qt-everywhere-opensource-src-5.0.0-beta1/qtbase/include

SOURCES += \
    main.cpp

OTHER_FILES += \
    qml/components/Slide.qml \
    qml/components/LiveEditor.qml \
    qml/Main.qml \
    qml/components/LiveCodingSlide.qml \
    qml/components/SlideContainer.qml \
    qml/components/BulletsSlide.qml \
    qml/components/SectionTitleSlide.qml \
    qml/components/StaticCodingSlide.qml

RESOURCES += \
    user-interface.qrc \
    images.qrc
