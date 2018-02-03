function deleteRow(obj) {
  var tbody = document.getElementById("table_delete");
  var tr = obj.parentNode.parentNode.parentNode;
  tbody.removeChild(tr);
}
