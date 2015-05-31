var scripts = [];

chrome.runtime.onMessage.addListener(function(message, _, callback) {
  if (message.id === 'scripts') {
    callback({scripts: scripts});
  }
});

function updatePageIcon(tabId) {
  chrome.tabs.query({active: true}, function(tabs) {
    var current_url = tabs[0].url;
    var url = 'http://script-discovery.cfapps.io/scripts?' + $.param({url: current_url});

    $.getJSON(url, function(data) {
      scripts = data.scripts;
      var scriptCount = data.scripts.length;
      if (scriptCount > 0) {
        chrome.runtime.sendMessage({id: 'scripts_retrieved', tabId: tabId, scripts: data.scripts});
        var path = scriptCount > 9 ? '9_plus.png' : scriptCount + '.png';
        chrome.pageAction.setIcon({tabId: tabId, path: path});
        chrome.pageAction.show(tabId);
      }
    });
  });
}

chrome.tabs.onActivated.addListener(function(activeInfo) {
  chrome.pageAction.hide(activeInfo.tabId);

  updatePageIcon(activeInfo.tabId);
});

chrome.tabs.onUpdated.addListener(function(tabId, changeInfo, tab) {
  chrome.pageAction.hide(tabId);

  updatePageIcon(tabId);
});
