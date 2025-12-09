/**
 * Cloudflare Worker - Weird Link Game API
 * Main entry point for the game backend
 * 
 * Routes:
 * - POST   /auth/register
 * - POST   /auth/login
 * - POST   /auth/refresh-token
 * - GET    /questions
 * - GET    /questions/:id
 * - POST   /sessions
 * - PATCH  /sessions/:id
 * - GET    /players/me
 * - GET    /players/leaderboard
 * - POST   /sync/queue
 */

export default {
    async fetch(request, env, ctx) {
        // Enable CORS
        if (request.method === 'OPTIONS') {
            return new Response(null, {
                headers: {
                    'Access-Control-Allow-Origin': '*',
                    'Access-Control-Allow-Methods': 'GET, POST, PATCH, DELETE, OPTIONS',
                    'Access-Control-Allow-Headers': 'Content-Type, Authorization',
                },
            });
        }

        const url = new URL(request.url);
        const path = url.pathname;

        // Route requests
        if (path.startsWith('/auth/register') && request.method === 'POST') {
            return handleRegister(request, env);
        }

        if (path.startsWith('/auth/login') && request.method === 'POST') {
            return handleLogin(request, env);
        }

        if (path.startsWith('/auth/refresh-token') && request.method === 'POST') {
            return handleRefreshToken(request, env);
        }

        if (path.startsWith('/questions') && request.method === 'GET') {
            return handleGetQuestions(request, env);
        }

        if (path.match(/\/questions\/[^/]+$/) && request.method === 'GET') {
            return handleGetQuestion(request, env);
        }

        if (path.startsWith('/sessions') && request.method === 'POST') {
            return handleCreateSession(request, env);
        }

        if (path.match(/\/sessions\/[^/]+$/) && request.method === 'PATCH') {
            return handleUpdateSession(request, env);
        }

        if (path.startsWith('/players/me') && request.method === 'GET') {
            return handleGetPlayerProfile(request, env);
        }

        if (path.startsWith('/players/leaderboard') && request.method === 'GET') {
            return handleGetLeaderboard(request, env);
        }

        if (path.startsWith('/sync/queue') && request.method === 'POST') {
            return handleSyncQueue(request, env);
        }

        // 404 Not Found
        return new Response(JSON.stringify({ error: 'Not Found' }), {
            status: 404,
            headers: { 'Content-Type': 'application/json' },
        });
    },
};

// ============ Auth Handlers ============

async function handleRegister(request, env) {
    const { username, email, password } = await request.json();

    // TODO: Validate input
    // TODO: Check if user exists
    // TODO: Hash password
    // TODO: Store in D1 database
    // TODO: Generate JWT token

    return new Response(
        JSON.stringify({
            success: true,
            token: 'jwt_token_here',
            user: { id: 'user_id', username, email },
        }),
        { headers: { 'Content-Type': 'application/json' } }
    );
}

async function handleLogin(request, env) {
    const { email, password } = await request.json();

    // TODO: Validate email/password
    // TODO: Retrieve user from D1
    // TODO: Compare passwords
    // TODO: Generate JWT

    return new Response(
        JSON.stringify({
            success: true,
            token: 'jwt_token_here',
            user: { id: 'user_id', email },
        }),
        { headers: { 'Content-Type': 'application/json' } }
    );
}

async function handleRefreshToken(request, env) {
    const { refreshToken } = await request.json();

    // TODO: Validate refresh token
    // TODO: Generate new JWT

    return new Response(
        JSON.stringify({
            success: true,
            token: 'new_jwt_token',
        }),
        { headers: { 'Content-Type': 'application/json' } }
    );
}

// ============ Question Handlers ============

async function handleGetQuestions(request, env) {
    const url = new URL(request.url);
    const page = url.searchParams.get('page') || 1;
    const limit = url.searchParams.get('limit') || 10;
    const gameMode = url.searchParams.get('mode');
    const difficulty = url.searchParams.get('difficulty');

    // TODO: Query D1 database for questions
    // TODO: Apply filters
    // TODO: Paginate results

    return new Response(
        JSON.stringify({
            success: true,
            data: [],
            total: 0,
            page,
            limit,
        }),
        { headers: { 'Content-Type': 'application/json' } }
    );
}

async function handleGetQuestion(request, env) {
    const questionId = request.url.split('/').pop();

    // TODO: Query D1 for specific question
    // TODO: Apply security checks (content hash verification)

    return new Response(
        JSON.stringify({
            success: true,
            data: {},
        }),
        { headers: { 'Content-Type': 'application/json' } }
    );
}

// ============ Session Handlers ============

async function handleCreateSession(request, env) {
    const { playerId, gameMode, difficulty, questionCount } = await request.json();

    // TODO: Validate JWT
    // TODO: Create session record in D1
    // TODO: Select questions based on criteria

    return new Response(
        JSON.stringify({
            success: true,
            sessionId: 'session_id_here',
            questions: [],
        }),
        { headers: { 'Content-Type': 'application/json' } }
    );
}

async function handleUpdateSession(request, env) {
    const sessionId = request.url.split('/').pop();
    const { answers, finalScore } = await request.json();

    // TODO: Verify session ownership (JWT)
    // TODO: Validate answers (anti-cheat checks)
    // TODO: Calculate final score
    // TODO: Update player stats
    // TODO: Store session results in D1

    return new Response(
        JSON.stringify({
            success: true,
            message: 'Session updated',
        }),
        { headers: { 'Content-Type': 'application/json' } }
    );
}

// ============ Player Handlers ============

async function handleGetPlayerProfile(request, env) {
    // TODO: Extract JWT from header
    // TODO: Get player data from D1
    // TODO: Calculate stats

    return new Response(
        JSON.stringify({
            success: true,
            player: {},
        }),
        { headers: { 'Content-Type': 'application/json' } }
    );
}

async function handleGetLeaderboard(request, env) {
    const url = new URL(request.url);
    const page = url.searchParams.get('page') || 1;
    const limit = url.searchParams.get('limit') || 10;

    // TODO: Query D1 leaderboard cache
    // TODO: Paginate results

    return new Response(
        JSON.stringify({
            success: true,
            data: [],
            total: 0,
        }),
        { headers: { 'Content-Type': 'application/json' } }
    );
}

// ============ Sync Handler ============

async function handleSyncQueue(request, env) {
    const { playerId, data } = await request.json();

    // TODO: Validate JWT
    // TODO: Process offline data
    // TODO: Update D1 with all changes
    // TODO: Return sync status

    return new Response(
        JSON.stringify({
            success: true,
            synced: true,
        }),
        { headers: { 'Content-Type': 'application/json' } }
    );
}

// ============ Utilities ============

function addCORSHeaders(response) {
    response.headers.set('Access-Control-Allow-Origin', '*');
    return response;
}

function jsonResponse(data, status = 200) {
    return new Response(JSON.stringify(data), {
        status,
        headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
        },
    });
}
