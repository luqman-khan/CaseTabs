$(".card-link").onmouseover(function(){
  $.post({url: "/home/user_details.json",{id: "@Casetabs"} success: function(result){
    $("#div1").html(result);
  }});
});

$("button").click(function(){
  $.post("demo_test_post.asp",
  {
    name: "Donald Duck",
    city: "Duckburg"
  },
  function(data, status){
    alert("Data: " + data + "\nStatus: " + status);
  });
}); 