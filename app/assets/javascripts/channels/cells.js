App.cells = App.cable.subscriptions.create('CellsChannel', {
  received: function(data) {
    this.renderMessage(data)
  },

  renderMessage: function(data) {
    return $(".board_cell[id="+data['cell_id']+"]").css("background", data['color_code']);
  }
});
