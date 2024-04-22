import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    clip: true
    signal deleted()
    signal resume()
    signal pause()
    color: "#00000000"
    readonly property string tag: "AbsFragment: "
    property var manager:FragmentManager
    property real backKey: -1


    Component.onCompleted: {
        console.log(tag + "root width: " + width + " " + "root height: " + height)
    }

    function startFragment(frag, activiFocus = true) {
        manager.startFragment(frag, activiFocus)
    }

    function replaceFragment(frag, activiFocus = true) {
        manager.replaceFragment(frag, activiFocus)
    }
    function popFragment() {
        manager.popFragment()
    }

    function onBack() {
        manager.popFragment()
    }
    Keys.onPressed: {
        if (event.key === backKey) {
            event.accepted = true
            onBack()
        }
    }
}
