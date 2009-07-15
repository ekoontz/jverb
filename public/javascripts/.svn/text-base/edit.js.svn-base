function create_update_delete(controller,action,form_id,source_id) {
  var form = document.getElementById(form_id);
  var source = document.getElementById(source_id);
  form.action = "/jverb/"+controller+"/"+action;
  var copy;

  if (source) {
    // populate form with data from source_id
    var input_elements = source.getElementsByTagName("input");
    for (var i = 0; i < input_elements.length; i++) {
      var input = input_elements[i];
      copy = input.cloneNode(true);
      form.appendChild(copy);
    }
    
    var input_elements = source.getElementsByTagName("select");
    for (var i = 0; i < input_elements.length; i++) {
      var input = input_elements[i];
      copy = input.cloneNode(true);
      // find the selected option and set it in the copy.
      var options = input.getElementsByTagName("option");
      copy.value = options[input.selectedIndex].value;
      form.appendChild(copy);
    }
  }
  form.submit();
}

function edit(position) {

  var tr = document.getElementById("edit"+position);
  var div_elements = tr.getElementsByTagName("div");
  for (var i = 0; i < div_elements.length; i++) {
    var div = div_elements[i];
    if (div.getAttribute("class") == "edit") {
      div.style.display = "block";
    }
    if (div.getAttribute("class") == "show") {
      div.style.display = "none";
    }
  }
}

function cancel(position) {

  var tr = document.getElementById("edit"+position);
  var div_elements = tr.getElementsByTagName("div");
  for (var i = 0; i < div_elements.length; i++) {
    var div = div_elements[i];
    if (div.getAttribute("class") == "edit") {
      div.style.display = "none";
    }
    if (div.getAttribute("class") == "show") {
      div.style.display = "block";
    }
  }
}
