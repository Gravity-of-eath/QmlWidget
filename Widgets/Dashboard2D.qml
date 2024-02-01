import QtQuick 2.15

Rectangle {
    property var baseImage
    property var coverImage
    property var pointImage
    property int fillType: Image.PreserveAspectFit
    property real max: 12000
    property real mix: 0
    property real value: 0
    property var runType: RunType.Top2Bottom
    enum RunType {
        Top2Bottom,
        Bottom2Top,
        Left2Right,
        Right2Left,
        Clockwise,
        AntClockwise
    }
    enum FillMode { Stretch, PreserveAspectFit, PreserveAspectCrop, Tile, TileVertically, TileHorizontally, Pad }


    onValueChanged: {

    }

    Image {
        id: base
        width: parent.width
        height: parent.height
        source: baseImage
        fillMode: fillType
    }

    Image {
        id: cover
        width: parent.width
        height: parent.height
        source: coverImage
        fillMode: fillType
    }

    Image {
        id: point
        width: parent.width
        height: parent.height
        source: pointImage
        fillMode: fillType
    }
}
