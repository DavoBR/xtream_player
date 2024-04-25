import httpProxy from 'npm:http-proxy'


const port = Deno.env.get('PORT')

httpProxy.createProxyServer({target:'http://localhost:9000'}).listen(port);
