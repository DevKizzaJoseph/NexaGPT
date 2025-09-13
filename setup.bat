@echo off
REM NexaGPT Setup Script for Windows
REM This script helps you get NexaGPT up and running quickly on Windows

echo 🚀 NexaGPT Setup Script
echo ======================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not installed. Please install Docker Desktop first.
    echo Download from: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker Compose is not installed. Please install Docker Compose first.
    pause
    exit /b 1
)

echo [SUCCESS] Docker and Docker Compose are installed

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] Node.js is not installed. You'll need it for development.
    echo Please install Node.js ^>= 20.0.0 from https://nodejs.org/
) else (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo [SUCCESS] Node.js is installed: %NODE_VERSION%
)

echo.
echo [INFO] Setting up environment files...

REM Create backend .env if it doesn't exist
if not exist "backend\.env" (
    echo [INFO] Creating backend\.env file...
    (
        echo # Database Configuration
        echo DATABASE_URL="postgresql://postgres:Newpassword@localhost:2345/CodeGPT?schema=public"
        echo.
        echo # JWT Configuration
        echo JWT_SECRET="your-super-secret-jwt-key-change-this-in-production"
        echo JWT_EXPIRES_IN="7d"
        echo.
        echo # OpenAI Configuration
        echo OPENAI_API_KEY="your-openai-api-key-here"
        echo OPENAI_MODEL_CHAT="gpt-4o"
        echo OPENAI_MODEL_TITLE="gpt-4o-mini"
        echo OPENAI_VECTOR_STORE_ID="your-vector-store-id"
        echo.
        echo # Server Configuration
        echo PORT=45671
        echo NODE_ENV="development"
        echo SWAGGER_ENABLED="true"
        echo.
        echo # Redis Configuration
        echo REDIS_HOST="localhost"
        echo REDIS_PORT=6379
        echo.
        echo # File Upload Configuration
        echo MAX_FILE_SIZE=10485760
        echo UPLOAD_PATH="./uploads"
    ) > backend\.env
    echo [SUCCESS] Created backend\.env file
) else (
    echo [INFO] Backend .env file already exists
)

REM Create frontend .env.local if it doesn't exist
if not exist "frontend\.env.local" (
    echo [INFO] Creating frontend\.env.local file...
    (
        echo # API Configuration
        echo NEXT_PUBLIC_API_URL="http://localhost:45671/api"
        echo NEXT_PUBLIC_WS_URL="ws://localhost:45671"
        echo.
        echo # Application Configuration
        echo NEXT_PUBLIC_APP_NAME="CodeGPT"
        echo NEXT_PUBLIC_APP_DESCRIPTION="AI-powered coding assistant for developers"
        echo.
        echo # File Upload Configuration
        echo NEXT_PUBLIC_MAX_FILE_SIZE=10485760
        echo NEXT_PUBLIC_ALLOWED_FILE_TYPES=".js,.ts,.jsx,.tsx,.py,.java,.cpp,.c,.cs,.php,.rb,.go,.rs,.swift,.kt,.scala,.r,.m,.h,.sql,.json,.xml,.yaml,.yml,.md,.txt,.png,.jpg,.jpeg,.gif,.svg,.pdf"
        echo.
        echo # Theme Configuration
        echo NEXT_PUBLIC_DEFAULT_THEME="dark"
    ) > frontend\.env.local
    echo [SUCCESS] Created frontend\.env.local file
) else (
    echo [INFO] Frontend .env.local file already exists
)

echo.
echo [INFO] Starting Docker services...

REM Create uploads directory
if not exist "backend\uploads" mkdir backend\uploads

REM Start services
docker-compose up -d

if %errorlevel% neq 0 (
    echo [ERROR] Failed to start Docker services
    pause
    exit /b 1
)

echo [SUCCESS] Docker services started

echo [INFO] Waiting for services to be ready...
timeout /t 10 /nobreak >nul

REM Setup database if Node.js is available
node --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [INFO] Setting up database...
    cd backend
    echo [INFO] Installing backend dependencies...
    npm install
    if %errorlevel% neq 0 (
        echo [WARNING] Failed to install dependencies. Please run manually: cd backend ^&^& npm install
    ) else (
        echo [INFO] Running database migrations...
        npm run prisma:deploy
        echo [INFO] Generating Prisma client...
        npm run prisma:generate
        echo [SUCCESS] Database setup complete
    )
    cd ..
) else (
    echo [WARNING] Node.js not found. Please install Node.js and run database setup manually:
    echo   cd backend ^&^& npm install ^&^& npm run prisma:deploy ^&^& npm run prisma:generate
)

echo.
echo 🎉 NexaGPT is now running!
echo ==========================
echo.
echo Access URLs:
echo   Frontend:     http://localhost:45670
echo   Backend API:  http://localhost:45671/api
echo   API Docs:     http://localhost:45671/swagger
echo   Bull Dashboard: http://localhost:4000
echo.
echo Next Steps:
echo   1. Update your OpenAI API key in backend\.env
echo   2. Visit http://localhost:45670 to start using NexaGPT
echo   3. Check the README.md for detailed documentation
echo.
echo Useful Commands:
echo   View logs:    docker-compose logs -f
echo   Stop services: docker-compose down
echo   Restart:      docker-compose restart
echo.
echo [SUCCESS] Setup complete! 🚀
echo.
pause
