// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function check_length() {
  var f = document.getElementById("micropost_content");
  var b = document.getElementById("micropost_submit");
  var max = 140;
  var value = max - f.value.length;
  document.getElementById("how_many_chars").innerHTML= value;
  if (value < 0) {
    b.disabled = true;
  }
  else {
    b.disabled = false;
  }
}
