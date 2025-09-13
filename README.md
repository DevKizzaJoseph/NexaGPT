# NexaGPT - AI-Powered Coding Assistant

NexaGPT is a comprehensive AI-powered coding assistant built with NestJS (backend) and Next.js (frontend) that helps developers write better code, debug issues, and learn programming concepts.

## 🚀 Features

### Core Capabilities
- **Code Analysis & Review**: Identify bugs, suggest improvements, and optimize code
- **Code Generation**: Write clean, efficient code in multiple programming languages
- **Debugging**: Help identify and fix errors in code
- **Code Explanation**: Explain complex code concepts and algorithms
- **Best Practices**: Suggest coding standards, patterns, and conventions
- **Multi-language Support**: JavaScript, TypeScript, Python, Java, C++, Go, Rust, and more
- **Image Analysis**: Analyze code screenshots, diagrams, and technical images

### Technical Features
- **Real-time Streaming**: Live code generation and responses
- **File Upload**: Support for code files and images
- **Syntax Highlighting**: Beautiful code formatting and highlighting
- **Conversation Management**: Save and manage coding sessions
- **User Authentication**: Secure user management with JWT
- **Responsive Design**: Works on desktop and mobile devices

## 🛠️ Tech Stack

### Backend
- **Framework**: NestJS (Node.js)
- **Database**: PostgreSQL with pgvector extension
- **Cache/Queue**: Redis with BullMQ
- **AI Integration**: OpenAI API (GPT-4o)
- **Authentication**: JWT with role-based access control
- **File Storage**: Local file system with support for various formats

### Frontend
- **Framework**: Next.js 15 with React 19
- **Styling**: Tailwind CSS with Radix UI components
- **State Management**: React hooks and context
- **Code Highlighting**: Syntax highlighting for multiple languages
- **File Upload**: Drag-and-drop file upload with preview

### Infrastructure
- **Containerization**: Docker with Docker Compose
- **Database**: PostgreSQL with pgvector for AI embeddings
- **Queue Management**: Bull Dashboard for monitoring
- **Development**: Hot reloading and TypeScript support

## 📋 Prerequisites

- Node.js >= 20.0.0
- npm >= 10.0.0
- Docker and Docker Compose
- OpenAI API key

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone <repository-url>
cd ava
```

### 2. Environment Setup
Create environment files:

**Backend (.env)**:
```env
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
PORT=3001
NODE_ENV="development"
SWAGGER_ENABLED="true"

# Redis Configuration
REDIS_HOST="localhost"
REDIS_PORT=6379

# File Upload Configuration
MAX_FILE_SIZE=10485760
UPLOAD_PATH="./uploads"
```

**Frontend (.env.local)**:
```env
# API Configuration
NEXT_PUBLIC_API_URL="http://localhost:45671/api"
NEXT_PUBLIC_WS_URL="ws://localhost:45671"

# Application Configuration
NEXT_PUBLIC_APP_NAME="NexaGPT"
NEXT_PUBLIC_APP_DESCRIPTION="AI-powered coding assistant for developers"

# File Upload Configuration
NEXT_PUBLIC_MAX_FILE_SIZE=10485760
NEXT_PUBLIC_ALLOWED_FILE_TYPES=".js,.ts,.jsx,.tsx,.py,.java,.cpp,.c,.cs,.php,.rb,.go,.rs,.swift,.kt,.scala,.r,.m,.h,.sql,.json,.xml,.yaml,.yml,.md,.txt,.png,.jpg,.jpeg,.gif,.svg,.pdf"

# Theme Configuration
NEXT_PUBLIC_DEFAULT_THEME="dark"
```

### 3. Start with Docker Compose
```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### 4. Database Setup
```bash
# Run database migrations
cd backend
npm run prisma:deploy

# Generate Prisma client
npm run prisma:generate
```

### 5. Access the Application
- **Frontend**: http://localhost:45670
- **Backend API**: http://localhost:45671/api
- **API Documentation**: http://localhost:45671/swagger
- **Bull Dashboard**: http://localhost:4000

## 🏗️ Development Setup

### Backend Development
```bash
cd backend

# Install dependencies
npm install

# Start development server
npm run start:dev

# Run database migrations
npm run prisma:deploy

# Generate Prisma client
npm run prisma:generate
```

### Frontend Development
```bash
cd frontend

# Install dependencies
npm install

# Start development server
npm run dev

# Generate API types
npm run struct
```

## 📁 Project Structure

```
ava/
├── backend/                 # NestJS backend
│   ├── src/
│   │   ├── controllers/     # API controllers
│   │   ├── services/       # Business logic
│   │   ├── modules/        # Feature modules
│   │   ├── dtos/          # Data transfer objects
│   │   ├── guards/        # Authentication guards
│   │   └── prompts.ts     # AI prompts
│   ├── prisma/            # Database schema and migrations
│   └── uploads/           # File upload directory
├── frontend/              # Next.js frontend
│   ├── src/
│   │   ├── app/           # App router pages
│   │   ├── components/    # React components
│   │   ├── api/           # API client
│   │   └── lib/           # Utilities
├── docker-compose.yml     # Docker services
└── README.md
```

## 🔧 API Endpoints

### Chat Endpoints
- `POST /api/chat/message` - Send message and get AI response
- `GET /api/chat/conversations` - Get user conversations
- `GET /api/chat/conversations/:id` - Get specific conversation
- `PATCH /api/chat/conversations/:id` - Update conversation
- `DELETE /api/chat/conversations/:id` - Delete conversation

### File Upload Endpoints
- `POST /api/files/upload` - Upload code files or images
- `GET /api/files/:id` - Get file information
- `DELETE /api/files/:id` - Delete file

### User Management
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `GET /api/users/profile` - Get user profile
- `PATCH /api/users/profile` - Update user profile

## 🎨 UI Components

### Chat Interface
- Real-time message streaming
- File attachment support
- Code syntax highlighting
- Message feedback system
- Conversation management

### File Upload
- Drag-and-drop interface
- Multiple file support
- File type validation
- Upload progress indicators

### Code Display
- Syntax highlighting for multiple languages
- Copy-to-clipboard functionality
- Code formatting and beautification
- Error highlighting

## 🔒 Security Features

- JWT-based authentication
- Role-based access control (Admin, Contributor, Reader)
- File upload validation
- Input sanitization
- CORS configuration
- Rate limiting

## 📊 Database Schema

### Core Models
- **User**: User accounts and profiles
- **Conversation**: Chat conversations
- **Message**: Individual messages with attachments
- **CodeSnippet**: Saved code snippets
- **UploadedFile**: File uploads and metadata
- **MessageAttachment**: File attachments to messages

### Key Features
- Soft deletes for conversations
- File type categorization
- User role management
- Message feedback system

## 🚀 Deployment

### Production Build
```bash
# Build backend
cd backend
npm run build

# Build frontend
cd frontend
npm run build
```

### Docker Production
```bash
# Build and start production containers
docker-compose -f docker-compose.prod.yml up -d
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the API documentation at `/swagger`
- Review the code examples in the `/examples` directory

## 🔮 Roadmap

### Upcoming Features
- [ ] Code execution environment
- [ ] Collaborative coding sessions
- [ ] Integration with popular IDEs
- [ ] Advanced code analysis tools
- [ ] Custom AI model training
- [ ] Team workspaces
- [ ] Code version control integration

### Performance Improvements
- [ ] Caching optimization
- [ ] Database query optimization
- [ ] Real-time collaboration features
- [ ] Advanced file processing

---

**CodeGPT** - Empowering developers with AI-powered coding assistance 🚀