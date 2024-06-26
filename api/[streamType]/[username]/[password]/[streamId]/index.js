export const config = {
    runtime: 'edge',
}

export default async function handler(request) {
    const params = new URL(request.url).searchParams
    if(params.get('username') === 'default' && params.get('password') === 'default') { 
        params.set('username', process.env['ACCOUNT_USERNAME'])
        params.set('password', process.env['ACCOUNT_PASSWORD'])
    }
    const streamUrl = [
        params.get('serverUrl') || process.env['SERVER_URL'],
        params.get('streamType'),
        params.get('username'),
        params.get('password'),
        params.get('streamId'),
    ].join('/')

    try {
        return await fetch(streamUrl, { redirect: 'manual' })
    } catch (e) {
        return new Response(JSON.stringify({
            error: e.toString()
        }), {
            status: 500,
            headers: {
                'content-type': 'application/json'
            }
        })
    }
}