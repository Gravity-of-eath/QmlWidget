import QtQuick 2.15

Rectangle {
    id: container
    readonly property int clockwise: 1
    readonly property int antClockwise: 2
    readonly property int btom2Top: 3
    readonly property int top2Btom: 4
    readonly property int left2Right: 5
    readonly property int right2Left: 6

    property string baseImage: ""
    property string coverImage: ""
    property string pointImage: ""
    property int fillType: Image.PreserveAspectFit
    property real max: 12000
    property real min: 0
    property real value: 5000
    property int runType: 1
    property int stopAngle: 70
    property real swap: 0
    property real rotaX: 0.5
    property real rotaY: 0.5
    property int startAngle: -240
    property int radius: 140
    property real total: 0
    property real current: 0

    color: "#00000000"

    onValueChanged: calcAngle()

    onMaxChanged: calcAngle()

    onMinChanged: calcAngle()

    function calcAngle() {
        console.log("calcAngle   max:" + max + "  min:" + min + "  value:" + value)
        if (max > min && value > min && value < max) {
            total = max - min
            current = value - min
            //            swap = startAngle + ((current / total) * (stopAngle - startAngle))
            //            console.log("swap: " + swap)
            canvas.markDirty(canvas.calDirtyRect())
        }
    }

    Image {
        id: base
        width: parent.width
        height: parent.height
        source: baseImage
        //        fillMode: Image.
    }

    Canvas {
        id: canvas
        width: parent.width
        height: parent.height
        antialiasing: true
        function calDirtyRect() {

            return Qt.rect(0, 0, width, height)
        }
        onPaint: {
            if (container.coverImage === "") {
                return
            }
            console.log("onPaint------------: " + container.runType)

            var ctx = getContext("2d")
            switch (container.runType) {
            case container.clockwise:
                drawRotation(ctx, true)
                break
            case container.antClockwise:
                drawRotation(ctx, false)
                break
            case container.btom2Top:
                drawVertical(ctx, true)
                break
            case container.top2Btom:
                drawVertical(ctx, fasle)
                break
            case container.left2Right:
                drawHorizontal(ctx, true)
                break
            case container.right2Left:
                drawHorizontal(ctx, false)
                break
            }
        }
    }

    function drawRotation(ctx, dir) {
        console.log("drawRotation: " + dir)
        var rota_x = container.rotaX >= 1 ? container.rotaX : container.rotaX * container.width
        var rota_y = container.rotaY >= 1 ? container.rotaY : container.rotaY * container.height
        var o = Qt.point(rota_x, rota_y)
        var lt = Qt.point(0, 0)
        var lb = Qt.point(0, container.height)
        var rt = Qt.point(container.width, 0)
        var rb = Qt.point(container.width, container.height)
        var rudis = Math.max(Math.max(pointDistance(o, lt),
                                      pointDistance(o, lb)), Math.max(
                                 pointDistance(o, rt), pointDistance(o, rb)))

        var swap = (container.current / container.total)
                * (container.stopAngle - container.startAngle)

        var end = !dir ? (container.startAngle + swap) : (container.stopAngle - swap)
        var fromAngle = dir ? Math.PI * (container.startAngle / 180) : Math.PI * (end / 180)
        var toAngle = dir ? Math.PI * (end / 180) : Math.PI * (container.startAngle / 180)
        console.log("swap: " + swap + "  end: " + end + "  fromAngle: "
                    + fromAngle + "  toAngle: " + toAngle)
        ctx.reset()
        ctx.save()
        ctx.strokeStyle = 'red'
        // 创建裁剪范围
        ctx.beginPath()

        //            ctx.fillStyle = "black"
        ctx.moveTo(rota_x, rota_y)
        ctx.arc(rota_x, rota_y, rudis, fromAngle, toAngle, false)
        ctx.closePath()
        ctx.clip() // 根据路径裁剪
        // 绘制图像并应用裁剪
        ctx.drawImage(container.coverImage, 0, 0, container.width,
                      container.height)
        // 恢复状态
        ctx.restore()
        // ctx.drawImage(image, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight)
        //  其中，image 表示要绘制的图片，可以是 Image 对象或者 CanvasImage 对象；
        //  dx 和 dy 表示绘制的图片左上角在画布上的坐标；
        // dWidth 和 dHeight 表示绘制的图片的宽度和高度，如果不指定则默认使用图片的原始大小；
        //   sx 和 sy 表示要绘制的图片的左上角在原图中的坐标；
        //   sWidth 和 sHeight 表示要绘制的图片在原图中的宽度和高度，如果不指定则默认使用图片的原始大小。
        //            ctx.drawImage(container.pointImage, 0, 0, 10, 16, rota_x,
        //                          rota_y, 10, 16)
        if (container.pointImage !== "") {
            //                console.log("container.pointImage"+container.pointImage)
            ctx.save()
            ctx.translate(rota_x, rota_y)
            ctx.rotate((Math.PI) * ((end + 90) / 180))
            ctx.translate(-rota_x, -rota_y)
            ctx.drawImage(container.pointImage, 0, 0, container.width,
                          container.height)
            ctx.restore()
        }
    }

    function drawHorizontal(ctx, dir) {
        ctx.reset()
        ctx.save()
        ctx.strokeStyle = 'red'
        // 创建裁剪范围
        ctx.beginPath()
        var endX = (container.current / container.total) * container.width
        ctx.beginPath()
        if (dir) {
            ctx.moveTo(0, 0)
            ctx.lineTo(endX, 0)
            ctx.lineTo(endX, container.height)
            ctx.lineTo(0, container.height)
        } else {
            ctx.moveTo(container.width, 0)
            ctx.lineTo(container.width - endX, 0)
            ctx.lineTo(container.width - endX, container.height)
            ctx.lineTo(container.width, container.height)
        }
        ctx.closePath()
        ctx.clip() // 根据路径裁剪
        ctx.drawImage(container.coverImage, 0, 0, container.width,
                      container.height)
        // 恢复状态
        ctx.restore()
    }

    function drawVertical(ctx, dir) {
        ctx.reset()
        ctx.save()
        ctx.strokeStyle = 'red'
        // 创建裁剪范围
        ctx.beginPath()
        var endY = (container.current / container.total) * container.height
        ctx.beginPath()
        if (dir) {
            ctx.moveTo(0, container.height)
            ctx.lineTo(0, container.height - endY)
            ctx.lineTo(container.width, container.height - endY)
            ctx.lineTo(container.width, container.height)
        } else {
            ctx.moveTo(0, 0)
            ctx.lineTo(0, endY)
            ctx.lineTo(container.width, endY)
            ctx.lineTo(container.width, 0)
        }
        ctx.closePath()
        ctx.clip() // 根据路径裁剪
        ctx.drawImage(container.coverImage, 0, 0, container.width,
                      container.height)
        // 恢复状态
        ctx.restore()
    }
    function pointDistance(point1, point2) {
        return Math.sqrt(Math.pow(point1.x - point2.x,
                                  2) + Math.pow(point1.y - point2.y, 2))
    }
}
