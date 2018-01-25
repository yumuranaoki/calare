$(function () {
  var clipboard = new Clipboard('.copy-btn');
  clipboard.on('success', function(e){
    e.clearSelection();
    $('#tooltip-button').tooltip("show");
  });
  clipboard.on('error', function(e){
    e.clearSelection();
    alert("ブラウザが対応しておりません");
  });
});
