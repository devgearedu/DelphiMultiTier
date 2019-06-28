  var channel = new ClientChannel(null, "MemoChannel");
  channel.onChannelStateChange = HandleChannelEvent;

  var callback1 = new ClientCallback(channel, "cb1",
    function(jsonValue) {
      if (jsonValue != null && jsonValue.created == null && jsonValue.close == null) {
        var memo = document.getElementById("CB1Memo");
		var txt = document.createTextNode(jsonValue + "\n");
		memo.appendChild(txt);
      }
      return true;
  });
  
  var callback2 = new ClientCallback(channel, "cb2",
    function(jsonValue) {
      if (jsonValue != null && jsonValue.created == null && jsonValue.close == null) {
        var memo = document.getElementById("CB2Memo");
		var txt = document.createTextNode(jsonValue + "\n");
		memo.appendChild(txt);
      }
      return true;
  });
  
  function startCB1()
  {
    if (channel.callbacks.length == 0) {
	  channel.connect(callback1);
	} else {
	  channel.registerCallback(callback1);
	}
  }
  
  function stopCB1()
  {
    channel.unregisterCallback(callback1);
  }
  
  function startCB2()
  {
    if (channel.callbacks.length == 0) {
	  channel.connect(callback2);
	} else {
	  channel.registerCallback(callback2);
	}
  }
  
  function stopCB2()
  {
    channel.unregisterCallback(callback2);
  }
  
  function stopAllCallbacks()
  {
    channel.disconnect();
  }
  
  function updateButtonsForCallbackStateChange(callbackId, started)
  {
    var startButton = callbackId == "cb1" ? document.getElementById("ButtonFirstStart") : document.getElementById("ButtonSecondStart");
	var stopButton = callbackId == "cb1" ? document.getElementById("ButtonFirstStop") : document.getElementById("ButtonSecondStop");

	startButton.disabled = started;
	stopButton.disabled = !started;

	if (!started)
	{
      var otherStartButton = callbackId == "cb1" ? document.getElementById("ButtonSecondStart") : document.getElementById("ButtonFirstStart");
	  var otherStopButton = callbackId == "cb1" ?  document.getElementById("ButtonSecondStop") : document.getElementById("ButtonFirstStop");
	} else {
	  document.getElementById("ButtonAllStop").disabled = false;
	}
  }
  
  function updateButtonsForTunnelClose()
  {
    document.getElementById("ButtonFirstStart").disabled = false;
	document.getElementById("ButtonFirstStop").disabled = true;
	document.getElementById("ButtonSecondStart").disabled = false;
	document.getElementById("ButtonSecondStop").disabled = true;
	document.getElementById("ButtonAllStop").disabled = true;
    document.getElementById("CB1Memo").value = "";
    document.getElementById("CB2Memo").value = "";
  }
  
  function HandleChannelEvent(EventItem) { //ClientChannelEventItem
    switch(EventItem.eventType) {
      case EventItem.channel.EVENT_CHANNEL_START:
        updateButtonsForCallbackStateChange(EventItem.callback.callbackId, true); break;
		
      case EventItem.channel.EVENT_CHANNEL_STOP:
        updateButtonsForTunnelClose(); break;
		
      case EventItem.channel.EVENT_CALLBACK_ADDED:
        updateButtonsForCallbackStateChange(EventItem.callback.callbackId, true); break;
		
      case EventItem.channel.EVENT_CALLBACK_REMOVED:
        updateButtonsForCallbackStateChange(EventItem.callback.callbackId, false); break;
		
      case EventItem.channel.EVENT_SERVER_DISCONNECT:
        updateButtonsForTunnelClose(); break;
      }
  }