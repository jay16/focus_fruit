$(document).ready ->


  # 电脑浏览与手机浏览设置显示
  set_order_modal = (klass) ->
    #klass = ".order-modal"
    runtime = $("#hidden_runtime").attr("value");
    dlg = $(klass)

    wh = $(document).height()
    ww = $(document).width()
    dh = wh*0.6
    dw = 400
    $(klass+" input[type='text']").css("width","325px")
    $(klass+" textarea").css("width","325px")

    #手机端浏览单独设置
    if runtime == "mobile"
      dh = wh*0.6
      dw = ww*0.8
      $(klass+" input[type='text']").css("width","190px")
      $(klass+" textarea").css("width","190px")

    dlg.css({
      "position": "absolute",
      "top":  (wh-dh)/4,
      "left": (ww-dw)/2,
      #"height": dh,
      "width":  dw
    })
  #调用函数执行样式
  set_order_modal("#already_in_cart_modal")
