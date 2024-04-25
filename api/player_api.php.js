export const config = {
    runtime: 'edge'
}

export default async function handler(request) {
    const params = new URL(request.url).searchParams

    if (!params.get('serverUrl') || !params.get('username') || !params.get('password')) {
        params.set('serverUrl', process.env['SERVER_URL'])
        params.set('username', process.env['ACCOUNT_USERNAME'])
        params.set('password', process.env['ACCOUNT_PASSWORD'])
    }

    try {
        const resp = await fetch(`${params.get('serverUrl')}/player_api.php?${params}`)

        if (!params.get('action')) {
            const payload = await resp.json()
            delete payload['user_info']['username']
            delete payload['user_info']['password']
            return new Response(JSON.stringify(payload), {
                status: resp.status,
                headers: { 'content-type': 'application/json' }
            })
        }

        return resp;
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