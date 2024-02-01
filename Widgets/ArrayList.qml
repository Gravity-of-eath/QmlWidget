import QtQuick 2.15

QtObject {
    property int index: 0
    property var datas: []

    function add(data) {
        datas.push(data)
               index++
    }
    function get(indez) {
        return datas[indez]
    }
    function remove(indez) {
        datas.splice(indez, 1)
              index--
    }

    function replace(indez, data) {
        datas[indez] = data
    }

    function insert(indez, data) {
        if (indez > index) {
            datas[indez] = data
            index = indez
        } else {
            for (var i = index + 1; i > indez; i--) {
                datas[i] = datas[i - 1]
            }
        }
    }
}
