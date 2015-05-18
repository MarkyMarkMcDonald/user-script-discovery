chrome.runtime.sendMessage({id: 'scripts'}, null, function(response) {
  var lis = '';

  response.scripts.forEach(function(script) {
    lis += '<dt><a href="' + script.link + '">' + script.name + '</a><dd class="description">' + script.description + '</span>';
  });

  document.getElementById('scripts').innerHTML = lis;
});

window.addEventListener('click', function(e) {
  if (e.target.href !== undefined) {
    chrome.tabs.create({url: e.target.href})
  }
});
