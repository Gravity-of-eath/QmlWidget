import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    readonly property string tag: "LinearLayout: "
    property bool verticalLayout: false
    property bool centerHorizontal: false
    property bool centerVertical: false
    color: "#00000000"
    clip: true
    onChildrenChanged: {
        requestUpdate()
    }
    Component.onCompleted: {
        layout()
    }
    function layout() {
        console.log(tag + "root width: " + width + " " + "root height: "
                    + height + " " + "verticalLayout:" + verticalLayout+"   children.length= "+children.length)
        var i = 0
        var child
        var visibleChildCount = 0
        if (verticalLayout) {
            var totalUseVspace = 0
            var maxChildWidth = 0
            for (i = 0; i < children.length; i++) {
                child = children[i]
                if (child.visible) {
                    totalUseVspace += child.height
                    totalUseVspace += child.anchors.topMargin
                    totalUseVspace += child.anchors.bottomMargin
                    visibleChildCount++
                    if (maxChildWidth < (child.width + child.anchors.leftMargin
                                         + child.anchors.rightMargin)) {
                        maxChildWidth = (child.width + child.anchors.leftMargin
                                         + child.anchors.rightMargin)
                    }
                } else {

                    // console.log(tag + " id:" + child.id + " height:" + child.height
                    //     + " child.visible:" + child.visible)
                }
            }
            if (root.width === 0) {
                root.width = maxChildWidth
            }
            if (root.height === 0) {
                root.height = totalUseVspace
            }
            if (centerVertical) {
                var space = (height - totalUseVspace) / (visibleChildCount + 1)
                var usedVspace = space
                for (i = 0; i < children.length; i++) {
                    child = children[i]
                    if (child.visible) {
                        usedVspace += child.anchors.topMargin
                        child.y = usedVspace
                        child.x = centerHorizontal ? (width - child.width)
                                                     / 2 : child.anchors.leftMargin
                        usedVspace += child.height
                        usedVspace += child.anchors.bottomMargin
                        usedVspace += space
                    }
                }
            } else {
                usedVspace = 0
                for (i = 0; i < children.length; i++) {
                    child = children[i]
                    if (child.visible) {
                        usedVspace += child.anchors.topMargin
                        child.y = usedVspace
                        child.x = centerHorizontal ? (width - child.width)
                                                     / 2 : child.anchors.leftMargin
                        usedVspace += child.anchors.bottomMargin
                        usedVspace += child.height
                    }
                }
            }
        } else {
            var totalUseHspace = 0
            visibleChildCount = 0
            var maxChildHeight = 0
            for (i = 0; i < children.length; i++) {
                child = children[i]
                if (child.visible) {
                    totalUseHspace += child.width
                    totalUseHspace += child.anchors.leftMargin
                    totalUseHspace += child.anchors.rightMargin
                    visibleChildCount++
                    if (maxChildHeight < (child.height + child.anchors.topMargin
                                          + child.anchors.bottomMargin)) {
                        maxChildHeight = (child.height + child.anchors.topMargin
                                          + child.anchors.bottomMargin)
                    }
                } else {
                    console.log("child :" + child.id + "  child.visible:" + child.visible)
                }
            }
             console.log("totalUseHspace :" + totalUseHspace + "  maxChildHeight:" + maxChildHeight)
            if (root.width === 0) {
                root.width = totalUseHspace
            }
            if (root.height === 0) {
                root.height = maxChildHeight
            }

            if (centerHorizontal) {
                var spaceH = (width - totalUseHspace) / (visibleChildCount + 1)
                var usedHspace = spaceH
                for (i = 0; i < children.length; i++) {
                    child = children[i]
                    if (child.visible) {
                        usedHspace += child.anchors.leftMargin
                        child.x = usedHspace
                        child.y = centerVertical ? ((height - child.height)
                                                    / 2) : child.anchors.topMargin
                        usedHspace += child.width
                        usedHspace += child.anchors.rightMargin
                        usedHspace += spaceH
                    }
                }
            } else {
                usedHspace = 0
                for (i = 0; i < children.length; i++) {
                    child = children[i]
                    console.log("usedHspace :" + usedHspace + "  child.width:" + child.width)
                    if (child.visible) {
                        usedHspace += child.anchors.leftMargin
                        child.x = usedHspace
                        child.y = centerVertical ? (root.height - child.height)
                                                   / 2 : child.anchors.topMargin
                        usedHspace+=child.width
                        usedHspace+=child.anchors.rightMargin
                    }
                }
            }
        }
    }
}
