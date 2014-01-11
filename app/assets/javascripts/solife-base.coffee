# solife.com网站全局功能代码
$(document).ready ->

  # 电脑浏览与手机浏览设置显示
  set_order_modal = (klass, runtime) ->
    dlg = $(klass)

    wh = $(document).height()
    ww = $(document).width()
    dh = wh*0.6
    dw = "400px"
    $(klass+" input").css("width","310px")
    $(klass+" textarea").css("width","310px")

    if runtime == "mobile"
      dh = wh*0.6
      dw = ww*0.8
      $(klass+" input").css("width","180px")
      $(klass+" textarea").css("width","180px")

    dlg.css({
      "position": "absolute",
      "top": (wh-dh)/4,
      "left":(ww-dw)/2,
      "height": dh,
      "width": dw
    })
