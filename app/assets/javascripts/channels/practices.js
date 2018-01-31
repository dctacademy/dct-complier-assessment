App.messages = App.cable.subscriptions.create('PracticesChannel', {  
  received: function(data) {
    $("#code").removeClass('hidden')
    // code.getDoc().setValue('this is live code')
    return window.code.getDoc().setValue(this.renderMessage(data));
  },

  renderMessage: function(data) {
    return data.message;
  }
});