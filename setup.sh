#!/bin/bash

# NexaGPT Startup Script
# This script helps you get NexaGPT up and running quickly

set -e

echo "🚀 NexaGPT Setup Script"
echo "======================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is installed
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    print_success "Docker and Docker Compose are installed"
}

# Check if Node.js is installed
check_node() {
    if ! command -v node &> /dev/null; then
        print_warning "Node.js is not installed. You'll need it for development."
        print_status "Please install Node.js >= 20.0.0 from https://nodejs.org/"
    else
        NODE_VERSION=$(node --version)
        print_success "Node.js is installed: $NODE_VERSION"
    fi
}

# Create environment files if they don't exist
setup_env_files() {
    print_status "Setting up environment files..."
    
    # Backend .env
    if [ ! -f "backend/.env" ]; then
        print_status "Creating backend/.env file..."
        cat > backend/.env << EOF
# Database Configuration
DATABASE_URL="postgresql://postgres:Newpassword@localhost:2345/CodeGPT?schema=public"

# JWT Configuration
JWT_SECRET="your-super-secret-jwt-key-change-this-in-production"
JWT_EXPIRES_IN="7d"

# OpenAI Configuration
OPENAI_API_KEY="your-openai-api-key-here"
OPENAI_MODEL_CHAT="gpt-4o"
OPENAI_MODEL_TITLE="gpt-4o-mini"
OPENAI_VECTOR_STORE_ID="your-vector-store-id"

# Server Configuration
PORT=45671
NODE_ENV="development"
SWAGGER_ENABLED="true"

# Redis Configuration
REDIS_HOST="localhost"
REDIS_PORT=6379

# File Upload Configuration
MAX_FILE_SIZE=10485760
UPLOAD_PATH="./uploads"
EOF
        print_success "Created backend/.env file"
    else
        print_status "Backend .env file already exists"
    fi
    
    # Frontend .env.local
    if [ ! -f "frontend/.env.local" ]; then
        print_status "Creating frontend/.env.local file..."
        cat > frontend/.env.local << EOF
# API Configuration
NEXT_PUBLIC_API_URL="http://localhost:45671/api"
NEXT_PUBLIC_WS_URL="ws://localhost:45671"

# Application Configuration
NEXT_PUBLIC_APP_NAME="CodeGPT"
NEXT_PUBLIC_APP_DESCRIPTION="AI-powered coding assistant for developers"

# File Upload Configuration
NEXT_PUBLIC_MAX_FILE_SIZE=10485760
NEXT_PUBLIC_ALLOWED_FILE_TYPES=".js,.ts,.jsx,.tsx,.py,.java,.cpp,.c,.cs,.php,.rb,.go,.rs,.swift,.kt,.scala,.r,.m,.h,.sql,.json,.xml,.yaml,.yml,.md,.txt,.png,.jpg,.jpeg,.gif,.svg,.pdf"

# Theme Configuration
NEXT_PUBLIC_DEFAULT_THEME="dark"
EOF
        print_success "Created frontend/.env.local file"
    else
        print_status "Frontend .env.local file already exists"
    fi
}

# Start Docker services
start_services() {
    print_status "Starting Docker services..."
    
    # Create uploads directory
    mkdir -p backend/uploads
    
    # Start services
    docker-compose up -d
    
    print_success "Docker services started"
    
    # Wait for services to be ready
    print_status "Waiting for services to be ready..."
    sleep 10
    
    # Check if services are running
    if docker-compose ps | grep -q "Up"; then
        print_success "Services are running"
    else
        print_error "Some services failed to start. Check logs with: docker-compose logs"
        exit 1
    fi
}

# Setup database
setup_database() {
    print_status "Setting up database..."
    
    # Wait for database to be ready
    print_status "Waiting for database to be ready..."
    sleep 5
    
    # Run database migrations
    cd backend
    if command -v npm &> /dev/null; then
        print_status "Installing backend dependencies..."
        npm install
        
        print_status "Running database migrations..."
        npm run prisma:deploy
        
        print_status "Generating Prisma client..."
        npm run prisma:generate
        
        print_success "Database setup complete"
    else
        print_warning "npm not found. Please install Node.js and run database setup manually:"
        print_status "cd backend && npm install && npm run prisma:deploy && npm run prisma:generate"
    fi
    cd ..
}

# Display access information
show_access_info() {
    echo ""
    echo "🎉 NexaGPT is now running!"
    echo "=========================="
    echo ""
    echo "Access URLs:"
    echo "  Frontend:     http://localhost:45670"
    echo "  Backend API:  http://localhost:45671/api"
    echo "  API Docs:     http://localhost:45671/swagger"
    echo "  Bull Dashboard: http://localhost:4000"
    echo ""
    echo "Next Steps:"
    echo "  1. Update your OpenAI API key in backend/.env"
    echo "  2. Visit http://localhost:45670 to start using NexaGPT"
    echo "  3. Check the README.md for detailed documentation"
    echo ""
    echo "Useful Commands:"
    echo "  View logs:    docker-compose logs -f"
    echo "  Stop services: docker-compose down"
    echo "  Restart:      docker-compose restart"
    echo ""
}

# Main execution
main() {
    echo "Starting CodeGPT setup..."
    echo ""
    
    # Check prerequisites
    check_docker
    check_node
    
    # Setup environment files
    setup_env_files
    
    # Start services
    start_services
    
    # Setup database
    setup_database
    
    # Show access information
    show_access_info
    
    print_success "Setup complete! 🚀"
}

# Run main function
main "$@"
