export const config = {
    runtime: 'edge',
}

export default async function handler(request) {
    const params = new URL(request.url).searchParams
    const streamUrl = [
        params.get('serverUrl'),
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

/*export default async function handler(request, response) {
    const streamUrl = [
        process.env['SERVER_URL'],
        request.query['streamType'],
        process.env['ACCOUNT_USERNAME'],
        process.env['ACCOUNT_PASSWORD'],
        request.query['streamId'],
    ].join('/')

    let fetchResponse
    let location

    try {
        fetchResponse = await fetch(streamUrl, { redirect: 'manual' })
        location = fetchResponse.headers.get('location')

        response.redirect(location)
    } catch (e) {
        response.status(500).json({
            error: e.toString(),
            status: fetchResponse?.status,
            location
        })
    }
}*/