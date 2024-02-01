import QtQuick 2.15

Rectangle {
    id: outRect
    width: 80
    height: 50
    property bool showLoadingOnly: false
    property string stateChecked: "/res/open.png"
    property string stateUnchecked: "/res/close.png"
    property string stateLoading: "/res/loading.png"
    property int checked: 1
    property int loading: -1
    color: "#00FFFFFF"

    property int checkState: 0

    onCheckStateChanged: {
        console.log("onCheckStateChanged: ", checkState)
        switch (checkState) {
        case checked:
            loadingSrc.visible = false
            mRotationAnimation.stop()
            btnSrc.visible = true
            btnSrc.source=stateChecked
            break
        case loading:
            loadingSrc.visible = true
            btnSrc.visible = !showLoadingOnly
            mRotationAnimation.restart()
            break
        default:
            loadingSrc.visible = false
            mRotationAnimation.stop()
            btnSrc.visible = true
            btnSrc.source=stateUnchecked
        }
    }
    Image {
        id: btnSrc
        anchors.fill: parent
        source: stateUnchecked
    }
    Image {
        height: parent.height
        width: parent.height
        id: loadingSrc
        anchors.centerIn: parent
        source: stateLoading
        visible: false
    }
    PropertyAnimation {
        id: mRotationAnimation
        target: loadingSrc
        from: 0
        to: 360
        duration: 1200
        loops: Animation.Infinite
        properties: "rotation"
    }
//    PropertyAnimation {
//        id: openAnimation
//        target: btnSrc
//        from: stateUnchecked
//        to: stateChecked
//        duration: 100
//        properties: "source"
//    }

//    PropertyAnimation {
//        id: closeAnimation
//        target: btnSrc
//        from: stateChecked
//        to: stateUnchecked
//        duration: 100
//        properties: "source"
//    }
}
