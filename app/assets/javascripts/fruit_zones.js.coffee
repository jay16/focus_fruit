# solife.com网站全局功能代码
$(document).ready ->

  $("body").css({
    "height": $(document).height()-50
  })

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
      "height": dh,
      "width":  dw
    })
  #调用函数执行样式
  set_order_modal(".order-modal")

  get_by_id = (id) ->
    document.getElementById(id)

  chk_submit_enable = () ->
    name  = get_by_id("order_name").value.length > 0 ? true : false
    phone = get_by_id("order_phone").value.length > 0 ? true : false
    address = get_by_id("order_address").value.length > 0 ? true : false
    date_at = get_by_id("order_date_at").value.length > 0 ? true : false
    remark = get_by_id("order_remark").value.length > 0 ? true : false
    if name and phone and address and date_at
      $("input[type='submit']").removeAttr("disabled")
    else
      $("input[type='submit']").attr("disabled","disabled")

  $("#order_name").keyup () ->
    chk_submit_enable()

  $("#order_phone").keyup () ->
    chk_submit_enable()

  $("#order_address").keyup () ->
    chk_submit_enable()

  $("#order_date_at").keyup () ->
    chk_submit_enable()

  $("#order_remark").keyup () ->
    chk_submit_enable()
