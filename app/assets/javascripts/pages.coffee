# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.color_block').on 'click', (evt) ->
    $.ajax '/user_actions/user_color',
      type: 'POST'
      dataType: 'json'
      data:
        user: this.dataset
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        $(".color_grid .box div").removeClass("active_color");
        $(".color_grid .box div[id="+data['color_id']+"]").addClass("active_color");


$('.board_cell').on 'click', (evt) ->
  if $(".color_grid .box div.active_color").length > 0
    $.ajax '/user_actions/cell_color',
      type: 'POST'
      dataType: 'json'
      data:
        user: this.dataset
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Success")
  else
    alert("Select A Color First To Start Drawing")
