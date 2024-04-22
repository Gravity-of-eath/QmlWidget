import QtQuick 2.15
import QtQuick.Controls 2.15

import QArrayList 1.0

Rectangle {
    id: fragmentManager
    readonly property string tag: "FragmentManager-"
    property string name: "Def:"
    property var currentView: AbsFragment
    signal stackChange(var stackSize)
    signal currentViewChange(var currentView)
    color: "#00000000"
    signal abandonFocus

    property bool _replace: false
    property bool _replaceAll: false
    QArrayList {
        id: stack
    }

    onWidthChanged: {
        if (fragmentManager.currentView) {
            fragmentManager.currentView.width = fragmentManager.width
        }
    }
    onHeightChanged: {
        if (fragmentManager.currentView) {
            fragmentManager.currentView.height = fragmentManager.height
        }
    }
    function pushStack(fragmentInstance, activiFocus) {
        if (typeof fragmentInstance !== "undefined"
                && fragmentInstance !== null) {
            currentView = fragmentInstance
            if (activiFocus) {
                fragmentInstance.forceActiveFocus()
            }
            if (fragmentManager._replace) {
                popTopAndDestroy(false)
            } else if (fragmentManager._replaceAll) {
                popTopAndDestroy(true)
            }
            fragmentInstance.manager = this
            fragmentInstance.resume()
            var topFragment = stack.getTop()
            if (typeof topFragment !== "undefined" && topFragment !== null) {
                topFragment.pause()
            }
            stack.add(fragmentInstance)
            stackChange(stack.size())
            console.log(tag + name + " pushStack:---------stack.size:" + stack.size(
                            ))
        }
    }
    function createObject(clazz, activiFocus) {
        const component = Qt.createComponent(clazz)
        if (component.status !== Component.Ready) {
            console.log(tag + name + " createComponent <" + clazz
                        + "> error status:" + component.status)
            return
        }
        const incubator = component.incubateObject(fragmentManager, {
                                                       "width": fragmentManager.width,
                                                       "height": fragmentManager.height
                                                   }, Component.Synchronous)
        if (incubator === null) {
            console.log(tag + name + " incubateObject error !")
            return
        }
        if (incubator.status !== Component.Ready) {
            incubator.onStatusChanged = function (status) {
                if (status === Component.Ready) {
                    print("Object", incubator.object, "is now ready!")
                    fragmentManager.children = [incubator.object]
                    pushStack(incubator.object, activiFocus)
                }
            }
        } else {
            fragmentManager.children = [incubator.object]
            pushStack(incubator.object, activiFocus)
            print("Object", incubator.object, "is ready immediately!")
        }
    }

    function popTopAndDestroy(all) {
        var popSize = all ? stack.size() : 1
        for (var i = popSize; i > 0; i--) {
            var topFragment = stack.getTop()
            if (typeof topFragment !== "undefined" && topFragment !== null) {
                topFragment.deleted()
                topFragment.destroy()
                stack.pop()
            }
        }
    }

    function startFragment(frag, activiFocus = true) {
        fragmentManager._replace = false
        fragmentManager._replaceAll = false
        createObject(frag, activiFocus)
        console.log(tag + name + " startFragment : " + frag + " activiFocus:" + activiFocus)
    }

    function replaceFragment(frag, activiFocus = true) {
        fragmentManager._replace = true
        fragmentManager._replaceAll = false
        createObject(frag, activiFocus)
        console.log(tag + name + " replaceFragment : " + frag + " activiFocus:" + activiFocus)
    }

    function replaceAllFragment(frag, activiFocus = true) {
        fragmentManager._replace = false
        fragmentManager._replaceAll = true
        console.log(tag + name + " replaceAllFragment :" + frag + " activiFocus:" + activiFocus)
        createObject(frag, activiFocus)
    }

    function popFragment(activiFocus = true) {
        popTopAndDestroy(false)
        var topFragment = stack.getTop()
        if (typeof topFragment !== "undefined" && topFragment !== null) {
            fragmentManager.children = [topFragment]
            topFragment.resume()
            if (activiFocus) {
                topFragment.forceActiveFocus()
                currentView = topFragment
                fragmentManager.currentView.width = fragmentManager.width
                fragmentManager.currentView.height = fragmentManager.height
            }
            console.log(tag + name + " top: " + topFragment)
            return true
        } else {
            fragmentManager.children = []
            fragmentManager.forceActiveFocus()
            currentView = null
            stackChange(stack.size())
            console.log(tag + name + " stackChange " + stack.size())
        }
        console.log(tag + name + " popFragment stack.size:" + stack.size(
                        ) + " topFragment:" + topFragment)
        return false
    }

    function activeFocus() {
        currentView.forceActiveFocus()
        console.log(tag + name + " activeFocus:" + currentView)
    }

    function unActiveFocus() {
        currentView.focus = false
        abandonFocus()
        console.log(tag + name + " unActiveFocus:")
    }

    function getManager() {
        return this
    }
}
