function updatePageIcon(tabId) {
  chrome.tabs.query({active: true}, function(tabs) {
    var current_url = tabs[0].url;
    var url = 'http://localhost:4567/scripts?' + $.param({url: current_url});

    $.getJSON(url, function(data) {
      var scriptCount = Math.min(5, data.scripts.length);
      if (scriptCount > 0) {
        var path = 'icon_' + scriptCount + '.png';
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
