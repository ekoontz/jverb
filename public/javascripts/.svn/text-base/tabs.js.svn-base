function tab(set,tab,input_id) {
  // get all tabs for this set; hide all except this one.
  var i;
  var tab_set = document.getElementById(set+"_tabs");
  var body_set = document.getElementById(set+"_bodies");
  var selected_tab = document.getElementById(tab);
  var selected_body = document.getElementById(tab+"_body");

  if (tab_set && body_set && selected_tab && selected_body) {
    tab_list = tab_set.getElementsByTagName("th");
    for(i=0; i < tab_list.length; i++) {
      var tab_node = tab_list[i];

      var tab_id = tab_node.id;

      if (!tab_id) {
	/* a TH used for spacing: ignore and continue. */
	continue;
      }

      body_id = tab_id + "_body";
      var body = document.getElementById(body_id);
      if (!body) {
	alert("could not find body : " + body_id);
	return;
      }
      
      if (tab_node != selected_tab) {
	body.style.display = "none";
	tab_node.style.background = "white";
      }
      else {
	body.style.display = "block";
	tab_node.style.background = "#66eeff";
      }
    }
  }
  else {
    if (!tab_set) {
      alert("could not find tab_set : " + set);
    }

    if (!body_set) {
      alert("could not find body_set : " + body_set);
    }

    if (!selected_tab) {
      alert("could not find selected_tab : " + tab);
    }
  }
  if (input_id && document.getElementById(input_id)) {
    document.getElementById(input_id).value = tab;
  }
}
