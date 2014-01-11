function setupDlg(runtime)
{
    var wh = $(document).height();
    var ww = $(document).width();
    var dlgw= $(".modal-border");
    var dlg = $(".modal");
    var dh = wh*0.6;
    var dw = "400px";
    if(runtime=="mobile") {
      dh = wh*0.6; 
      dw = ww*0.8;
    }

    dlgw.css("top",0);
    dlgw.css("left",0);
    dlgw.css("height",wh);
    dlgw.css("width",ww);
    dlg.css("top",(wh-dh)/4);
    dlg.css("left",(ww-dw)/2);
    dlg.css("height",dh);
    dlg.css("width",dw);
}
