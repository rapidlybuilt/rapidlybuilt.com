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

  // Rule 4: Rewrite paths without file extension to serve index.html
  // Check if URI doesn't have a file extension (no dot after last slash)
  var lastSlashIndex = uri.lastIndexOf('/');
  var lastDotIndex = uri.lastIndexOf('.');

  // If no dot after the last slash, or the dot is before the last slash, assume directory
  if (lastDotIndex <= lastSlashIndex) {
    // Rewrite to index.html (not a redirect, just internal routing)
    if (uri.endsWith('/')) {
      request.uri = uri + 'index.html';
    } else {
      request.uri = uri + '/index.html';
    }
  }

  return request;
}
