function handler(event) {
  var request = event.request;
  var uri = request.uri;

  // Rule 1: Redirect paths with underscores to dashes
  if (uri.includes('_')) {
    var newUri = uri.replace(/_/g, '-');
    return {
      statusCode: 301,
      statusDescription: 'Moved Permanently',
      headers: {
        'location': { value: newUri }
      }
    };
  }

  // Rule 2: Redirect explicit /index.html to directory path
  if (uri.endsWith('/index.html')) {
    var newUri = uri.slice(0, -11); // Remove '/index.html'
    return {
      statusCode: 301,
      statusDescription: 'Moved Permanently',
      headers: {
        'location': { value: newUri }
      }
    };
  }

  // Rule 3: Redirect trailing slashes to no trailing slash (except root)
  if (uri.length > 1 && uri.endsWith('/')) {
    var newUri = uri.slice(0, -1); // Remove trailing slash
    return {
      statusCode: 301,
      statusDescription: 'Moved Permanently',
      headers: {
        'location': { value: newUri }
      }
    };
  }

  // Rule 4: Rewrite paths to serve index.html unless they have .html or .json extension
  var knownExtensions = ['html', 'json'];
  var lastSlashIndex = uri.lastIndexOf('/');
  var lastDotIndex = uri.lastIndexOf('.');
  var extension = '';
  if (lastDotIndex > lastSlashIndex) {
    extension = uri.substring(lastDotIndex + 1).toLowerCase();
  }
  if (knownExtensions.indexOf(extension) === -1) {
    var acceptHeader = request.headers['accept'] ? request.headers['accept'].value : '';
    var indexFile = acceptHeader.indexOf('application/json') !== -1 ? 'index.json' : 'index.html';

    // Rewrite to index file (not a redirect, just internal routing)
    if (uri.endsWith('/')) {
      request.uri = uri + indexFile;
    } else {
      request.uri = uri + '/' + indexFile;
    }
  }

  return request;
}
