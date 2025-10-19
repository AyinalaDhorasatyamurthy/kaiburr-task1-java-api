# Task 1: Java Backend and REST API

## 📋 Project Overview

This project implements a **Spring Boot REST API** for managing "task" objects that represent shell commands. The application provides endpoints for creating, reading, updating, deleting, and executing tasks, with data persistence using **MongoDB**.

## 🏗️ Architecture

- **Backend**: Spring Boot 3.5.6 with Java 17
- **Database**: MongoDB with Spring Data MongoDB
- **Build Tool**: Maven
- **API Documentation**: RESTful endpoints with JSON responses

## 📊 Data Models

### Task Object
```json
{
  "id": "68f4ad1e0f9d8b705366677e",
  "name": "Print Hello",
  "owner": "John Smith", 
  "command": "echo Hello World!",
  "taskExecutions": []
}
```

### TaskExecution Object
```json
{
  "startTime": "2025-10-19T09:19:41.402+00:00",
  "endTime": "2025-10-19T09:19:41.402+00:00",
  "output": "Executed: \"echo Executing task command\""
}
```

## 🚀 API Endpoints

| Method | Endpoint | Description | Request Body | Response |
|--------|----------|-------------|--------------|----------|
| `GET` | `/tasks` | Get all tasks | None | Array of tasks |
| `GET` | `/tasks/{id}` | Get task by ID | None | Single task |
| `GET` | `/tasks/search?name={name}` | Search tasks by name | None | Array of matching tasks |
| `POST` | `/tasks` | Create new task | Task object | Created task with ID |
| `PUT` | `/tasks/{id}` | Update existing task | Task object | Updated task |
| `DELETE` | `/tasks/{id}` | Delete task | None | 200 OK |
| `PUT` | `/tasks/{id}/execution` | Execute task command | String command | TaskExecution object |

## 🛠️ Setup Instructions

### Prerequisites
- Java 17 or higher
- Maven 3.6+
- MongoDB 4.4+

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd task-api
   ```

2. **Start MongoDB**
   ```bash
   # Windows (if installed as service)
   net start MongoDB
   
   # Or start MongoDB manually
   mongod
   ```

3. **Build and run the application**
   ```bash
   ./mvnw spring-boot:run
   ```

4. **Verify the application is running**
   - Health check: `http://localhost:8080/actuator/health`
   - API base: `http://localhost:8080/tasks`

## 📸 API Testing Screenshots

### 1. Health Check Endpoint
**Date/Time**: October 19, 2025, 2:49 PM  
**Endpoint**: `GET http://localhost:8080/actuator/health`

```
Status: 200 OK
Response: {"status":"UP"}
```

### 2. Get All Tasks (Empty Initially)
**Date/Time**: October 19, 2025, 2:49 PM  
**Endpoint**: `GET http://localhost:8080/tasks`

```
Status: 200 OK
Response: []
```

### 3. Create New Task
**Date/Time**: October 19, 2025, 2:49 PM  
**Endpoint**: `POST http://localhost:8080/tasks`

**Request Body**:
```json
{
  "name": "Print Hello",
  "owner": "John Smith",
  "command": "echo Hello World!"
}
```

**Response**:
```json
{
  "id": "68f4ad1e0f9d8b705366677e",
  "name": "Print Hello",
  "owner": "John Smith",
  "command": "echo Hello World!",
  "taskExecutions": null
}
```

### 4. Get Task by ID
**Date/Time**: October 19, 2025, 2:49 PM  
**Endpoint**: `GET http://localhost:8080/tasks/68f4ad1e0f9d8b705366677e`

```
Status: 200 OK
Response: {"id":"68f4ad1e0f9d8b705366677e","name":"Print Hello","owner":"John Smith","command":"echo Hello World!","taskExecutions":null}
```

### 5. Search Tasks by Name
**Date/Time**: October 19, 2025, 2:49 PM  
**Endpoint**: `GET http://localhost:8080/tasks/search?name=Print`

```
Status: 200 OK
Response: [{"id":"68f4ad1e0f9d8b705366677e","name":"Print Hello","owner":"John Smith","command":"echo Hello World!","taskExecutions":null}]
```

### 6. Execute Task Command
**Date/Time**: October 19, 2025, 2:49 PM  
**Endpoint**: `PUT http://localhost:8080/tasks/68f4ad1e0f9d8b705366677e/execution`

**Request Body**: `"echo Executing task command"`

**Response**:
```json
{
  "startTime": "2025-10-19T09:19:41.402+00:00",
  "endTime": "2025-10-19T09:19:41.402+00:00",
  "output": "Executed: \"echo Executing task command\""
}
```

### 7. Update Task
**Date/Time**: October 19, 2025, 2:49 PM  
**Endpoint**: `PUT http://localhost:8080/tasks/68f4ad1e0f9d8b705366677e`

**Request Body**:
```json
{
  "name": "Updated Print Hello",
  "owner": "Jane Smith",
  "command": "echo Updated Hello World!"
}
```

**Response**:
```json
{
  "id": "68f4ad1e0f9d8b705366677e",
  "name": "Updated Print Hello",
  "owner": "Jane Smith",
  "command": "echo Updated Hello World!",
  "taskExecutions": [
    {
      "startTime": "2025-10-19T09:19:41.402+00:00",
      "endTime": "2025-10-19T09:19:41.402+00:00",
      "output": "Executed: \"echo Executing task command\""
    }
  ]
}
```

### 8. Delete Task
**Date/Time**: October 19, 2025, 2:49 PM  
**Endpoint**: `DELETE http://localhost:8080/tasks/68f4ad1e0f9d8b705366677e`

```
Status: 200 OK
Response: (empty)
```

### 9. Verify Deletion
**Date/Time**: October 19, 2025, 2:49 PM  
**Endpoint**: `GET http://localhost:8080/tasks`

```
Status: 200 OK
Response: []
```

## 🔧 Features Implemented

### ✅ Core Requirements
- [x] Task object with all required properties (id, name, owner, command, taskExecutions)
- [x] TaskExecution object with Date objects for startTime/endTime
- [x] MongoDB integration for data persistence
- [x] All required REST API endpoints
- [x] Command validation (blocks unsafe commands like 'rm', 'shutdown')
- [x] Task execution with TaskExecution creation

### ✅ Additional Features
- [x] Health check endpoint (`/actuator/health`)
- [x] Comprehensive error handling
- [x] JSON request/response format
- [x] Proper HTTP status codes
- [x] MongoDB case-sensitive database handling

## 🧪 Testing

The application has been thoroughly tested using:
- **PowerShell/curl** for command-line testing
- **Postman** for GUI-based API testing
- **MongoDB shell** for database verification

All endpoints return proper HTTP status codes and JSON responses as specified in the requirements.

## 📁 Project Structure

```
task-api/
├── src/
│   ├── main/
│   │   ├── java/com/kaiburr/taskapi/
│   │   │   ├── TaskApiApplication.java          # Main Spring Boot application
│   │   │   ├── controller/
│   │   │   │   └── TaskController.java          # REST API endpoints
│   │   │   ├── model/
│   │   │   │   ├── Task.java                    # Task entity
│   │   │   │   └── TaskExecution.java           # TaskExecution entity
│   │   │   └── repository/
│   │   │       └── TaskRepository.java          # MongoDB repository
│   │   └── resources/
│   │       └── application.properties           # Application configuration
│   └── test/
│       └── java/com/kaiburr/taskapi/
│           └── TaskApiApplicationTests.java     # Unit tests
├── pom.xml                                      # Maven dependencies
└── README.md                                    # This file
```

## 🚀 Getting Started

1. **Start MongoDB** on your local machine
2. **Run the application**: `./mvnw spring-boot:run`
3. **Test the API** using the provided endpoints
4. **View data** in MongoDB using `mongosh Kaiburr --eval "db.tasks.find()"`

## 📝 Notes

- The application uses MongoDB database named "Kaiburr" (case-sensitive)
- TaskExecution objects use proper Date formatting for startTime/endTime
- Command validation prevents execution of potentially dangerous commands
- All API responses follow RESTful conventions with appropriate HTTP status codes

---

**Developer**: [Ayinala Dhorasatyamurthy]  
**Date**: October 19, 2025  
**Task**: Kaiburr Task 1 - Java Backend and REST API

