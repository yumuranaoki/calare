$(function(){
  if (true){
    if (gon.multi == true) {
      $("#group-registration-multi").modal("show")
    } else {
      $("#group-registration-two").modal("show")
    }
  }
});

var clipboadCopy = function(){
            var urltext = document.getElementById("url");
            console.log(urltext);
            urltext.select();
            document.execCommand("copy");
        }
