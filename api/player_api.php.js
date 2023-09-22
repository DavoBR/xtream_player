export const config = {
    runtime: 'edge'
}

export default async function handler(request) {
    const params = new URL(request.url).searchParams

    params.append('username', process.env['ACCOUNT_USERNAME'])
    params.append('password', process.env['ACCOUNT_PASSWORD'])

    const actionUrl = `${process.env['SERVER_URL']}/player_api.php?${params}`

    try {
        return await fetch(actionUrl)
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