App.cells = App.cable.subscriptions.create('LeaderboardChannel', {
  received: function(data) {
    this.renderMessage(data)
  },

  renderMessage: function(data) {
    return $("#leaderboard").html(data.html);
  }
});
