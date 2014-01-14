#= require showdown
#= require ace
#= require_self


function getScrollHeight(e) {
      return e[0].scrollHeight !== undefined ? e[0].scrollHeight : e.find("html")[0].scrollHeight !== undefined && e.find("html")[0].scrollHeight !== 0 ? e.find("html")[0].scrollHeight : e.find("body")[0].scrollHeight
}

function syncPreview() {
    var e = ace.edit("markdown"),
        t = $("#preview"),
        converter = new Showdown.converter();

    var content  = e.getValue();
    var markdown = converter.makeHtml(content);

    t.html(markdown);
    $("#fruit_desc").val(content);
    $("#fruit_markdown").val(markdown);

    var r = getScrollHeight(t),
        n = e.getSession().getLength(),
        i = e.getFirstVisibleRow() / n;
        t.scrollTop(i * r)
}

