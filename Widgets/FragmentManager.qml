import QtQuick 2.15
import QArrayList 1.0

Rectangle {
    id: fragmentManager
    readonly property string tag: "FragmentManager-"
    property string name: "Def:"
    property var currentView
    signal stackChange(int stackSize)
    signal currentViewChange(var currentView)
    signal abandonFocus

    property bool _replace: false
    property bool _replaceAll: false
    QArrayList {
        id: stack
    }

    function pushStack(fragmentInstance, activiFocus) {
        if (typeof fragmentInstance !== "undefined"
                && fragmentInstance !== null) {
            currentView = fragmentInstance
            if (activiFocus) {
                fragmentInstance.forceActiveFocus()
            }
            if (fragmentManager._replace) {
                stack.pop()
            } else if (fragmentManager._replaceAll) {
                stack.clear()
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


    function startFragment(frag, activiFocus = true) {
        fragmentManager.replace = false
        fragmentManager.replaceAll = false
        createObject(frag, activiFocus)
        console.log(tag + name + " startFragment : " + frag + " activiFocus:" + activiFocus)
    }

    function replaceFragment(frag, activiFocus = true) {
        fragmentManager.replace = true
        fragmentManager.replaceAll = false
        createObject(frag, activiFocus)
        console.log(tag + name + " replaceFragment : " + frag + " activiFocus:" + activiFocus)
    }

    function replaceAllFragment(frag, activiFocus = true) {
        fragmentManager.replace = false
        fragmentManager._replaceAll = true
        console.log(tag + name + " replaceAllFragment :" + frag + " activiFocus:" + activiFocus)
        createObject(frag, activiFocus)
    }
    function popFragment(activiFocus = true) {
        stack.pop();
        var getTop = stack.getTop();
        var popp = stack.pop();
        if (typeof popp !== "undefined" && popp !== null) {
            fragmentManager.children = [popp];
            if (activiFocus) {
                popp.forceActiveFocus();
            }
            console.log(tag + name + " undefined " + popp);
            return true;
        } else {
            fragmentManager.children = [];
            stackChange(stack.size());
            console.log(tag + name + " stackChange " + popp);
        }
        console.log(tag + name + " popFragment stack.size:" + stack.size() + " popp:" + popp);
        return false;
    }

    function activeFocus() {
        currentView.forceActiveFocus();
        console.log(tag + name + " activeFocus:" + currentView);
    }

    function unActiveFocus() {
        abandonFocus();
        console.log(tag + name + " unActiveFocus:");
    }

    function getManager() {
        return this
    }

}
