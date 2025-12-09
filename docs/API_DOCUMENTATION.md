/// Complete API Endpoints Documentation
/// توثيق نقاط نهاية API الكاملة

# API Documentation - الرابط العجيب
# Base URL: https://weirdlink.workers.dev/api/v1

---

## Authentication الوثائق

### 1. Login / Register
```
POST /auth/register
Content-Type: application/json

Request:
{
  "username": "string",
  "email": "string",
  "password": "string",
  "language": "ar|en"
}

Response (200 OK):
{
  "success": true,
  "playerId": "uuid",
  "token": "jwt_token",
  "message": "تم إنشاء الحساب بنجاح"
}

Error (400):
{
  "success": false,
  "error": "Username already exists",
  "code": "USERNAME_EXISTS"
}
```

### 2. Login
```
POST /auth/login
Content-Type: application/json

Request:
{
  "email": "string",
  "password": "string"
}

Response (200 OK):
{
  "success": true,
  "playerId": "uuid",
  "token": "jwt_token",
  "playerName": "string"
}
```

### 3. Refresh Token
```
POST /auth/refresh
Authorization: Bearer {token}

Response (200 OK):
{
  "success": true,
  "token": "new_jwt_token"
}
```

---

## Game Operations اللعبة

### 4. Get Questions
```
GET /questions?mode=wordToWord&difficulty=medium&limit=10
Authorization: Bearer {token}

Response (200 OK):
{
  "success": true,
  "questions": [
    {
      "id": "uuid",
      "mode": "wordToWord",
      "difficulty": "medium",
      "item1": "string",
      "item2": "string",
      "options": ["option1", "option2", ...],
      "correctLink": "string",
      "category": "string",
      "timeLimit": 12
    }
  ],
  "total": 10
}
```

### 5. Submit Answer
```
POST /game/submit-answer
Authorization: Bearer {token}
Content-Type: application/json

Request:
{
  "sessionId": "uuid",
  "questionId": "uuid",
  "selectedAnswer": "string",
  "timeTaken": 5,
  "isChainQuestion": false
}

Response (200 OK):
{
  "success": true,
  "isCorrect": true,
  "earnedScore": 150,
  "totalScore": 1250,
  "feedback": "ممتاز! إجابة صحيحة"
}
```

### 6. Create Session
```
POST /game/session/create
Authorization: Bearer {token}
Content-Type: application/json

Request:
{
  "mode": "wordToWord",
  "difficulty": "medium",
  "questionCount": 10,
  "isMultiplayer": false
}

Response (200 OK):
{
  "success": true,
  "sessionId": "uuid",
  "expiresIn": 3600,
  "startedAt": "2025-12-08T10:30:00Z"
}
```

### 7. End Session
```
POST /game/session/end
Authorization: Bearer {token}
Content-Type: application/json

Request:
{
  "sessionId": "uuid",
  "finalScore": 1500,
  "questionsAnswered": 10,
  "correctAnswers": 8
}

Response (200 OK):
{
  "success": true,
  "sessionSummary": {
    "score": 1500,
    "accuracy": 80,
    "duration": 312,
    "achievements": ["Perfect Game", "Speed Demon"],
    "levelUp": true,
    "newLevel": 15
  }
}
```

---

## Player Statistics الإحصائيات

### 8. Get Player Stats
```
GET /player/stats
Authorization: Bearer {token}

Response (200 OK):
{
  "success": true,
  "stats": {
    "playerId": "uuid",
    "username": "string",
    "level": 15,
    "totalScore": 45000,
    "gamesPlayed": 127,
    "winRate": 75.5,
    "favoriteMode": "wordToWord",
    "longestChain": 8,
    "achievements": ["badge1", "badge2"],
    "lastPlayedAt": "2025-12-08T10:30:00Z"
  }
}
```

### 9. Get Leaderboard
```
GET /leaderboard?limit=50&offset=0&timeframe=weekly
Authorization: Bearer {token}

Response (200 OK):
{
  "success": true,
  "leaderboard": [
    {
      "rank": 1,
      "playerId": "uuid",
      "username": "TopPlayer",
      "score": 125000,
      "wins": 500,
      "streak": 45
    }
  ],
  "playerRank": 127,
  "playerScore": 45000
}
```

### 10. Update Player Profile
```
PUT /player/profile
Authorization: Bearer {token}
Content-Type: application/json

Request:
{
  "username": "NewUsername",
  "profilePic": "url",
  "bio": "string",
  "preferences": {
    "soundEffects": true,
    "vibration": true,
    "notifications": true
  }
}

Response (200 OK):
{
  "success": true,
  "message": "Profile updated successfully"
}
```

---

## Real-time WebSocket الوقت الفعلي

### 11. WebSocket Connection
```
WS: wss://weirdlink.workers.dev/ws?token={jwt_token}&sessionId={sessionId}

Events:
{
  "type": "question_received",
  "data": { ...question_object }
}

{
  "type": "player_answered",
  "data": { playerId, answer, isCorrect }
}

{
  "type": "game_ended",
  "data": { finalScores, winner }
}

{
  "type": "error",
  "message": "Connection timeout"
}
```

---

## Anti-Cheat الحماية

### 12. Report Suspicious Activity
```
POST /anti-cheat/report
Authorization: Bearer {token}
Content-Type: application/json

Request:
{
  "reportedPlayerId": "uuid",
  "reason": "unnatural_timing|pattern_matching",
  "sessionId": "uuid",
  "evidence": {...}
}

Response (200 OK):
{
  "success": true,
  "reportId": "uuid",
  "message": "Report submitted for review"
}
```

### 13. Get Account Status
```
GET /account/status
Authorization: Bearer {token}

Response (200 OK):
{
  "success": true,
  "accountStatus": "active|suspended|flagged",
  "suspendedUntil": null,
  "reason": null
}
```

---

## Sync & Offline التزامن والأوفلاين

### 14. Sync Local Data
```
POST /sync/local-data
Authorization: Bearer {token}
Content-Type: application/json

Request:
{
  "lastSyncTime": "2025-12-08T09:00:00Z",
  "localSessions": [...],
  "localStats": {...}
}

Response (200 OK):
{
  "success": true,
  "synced": 5,
  "conflicts": 0,
  "serverData": {...},
  "nextSyncTime": "2025-12-08T11:00:00Z"
}
```

### 15. Download Questions (Offline)
```
GET /questions/download?limit=1000
Authorization: Bearer {token}

Response (200 OK):
{
  "success": true,
  "questions": [...],
  "totalSize": "5.2MB",
  "lastUpdated": "2025-12-08T08:00:00Z",
  "expireAt": "2025-12-15T08:00:00Z"
}
```

---

## Error Codes الأكواد

| Code | HTTP | Meaning |
|------|------|---------|
| AUTH_REQUIRED | 401 | Missing or invalid token |
| INVALID_CREDS | 401 | Wrong password/email |
| NOT_FOUND | 404 | Resource not found |
| RATE_LIMITED | 429 | Too many requests |
| SERVER_ERROR | 500 | Internal server error |
| SUSPICIOUS_ACTIVITY | 403 | Anti-cheat triggered |
| OFFLINE_MODE | 200 | Working in offline mode |

---

## Rate Limiting
- 100 requests/minute for authenticated users
- 10 requests/minute for public endpoints
- Burst limit: 500 requests/hour

---

## Security Headers
```
X-API-Version: 1.0
X-Rate-Limit-Remaining: 99
X-Request-ID: uuid
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
```

---

**Document Version: 1.0**
**Last Updated: 2025-12-08**
**Status: Complete & Ready for Implementation**
