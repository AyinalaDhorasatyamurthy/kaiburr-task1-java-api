# Task API Testing Script
# Date: October 19, 2025
# Author: [Your Name]

Write-Host "=== TASK 1 API TESTING SCRIPT ===" -ForegroundColor Green
Write-Host "Date: $(Get-Date)" -ForegroundColor Yellow
Write-Host ""

# Test 1: Health Check
Write-Host "1. Testing Health Check..." -ForegroundColor Cyan
try {
    $health = Invoke-WebRequest -Uri "http://localhost:8080/actuator/health" -Method GET
    Write-Host "   Status: $($health.StatusCode)" -ForegroundColor Green
    Write-Host "   Response: $($health.Content)" -ForegroundColor White
} catch {
    Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Test 2: Get All Tasks
Write-Host "2. Testing GET All Tasks..." -ForegroundColor Cyan
try {
    $tasks = Invoke-WebRequest -Uri "http://localhost:8080/tasks" -Method GET
    Write-Host "   Status: $($tasks.StatusCode)" -ForegroundColor Green
    Write-Host "   Response: $($tasks.Content)" -ForegroundColor White
} catch {
    Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Test 3: Create Task
Write-Host "3. Testing POST Create Task..." -ForegroundColor Cyan
try {
    $body = @{
        name = "Test Task from Script"
        owner = "Script User"
        command = "echo Hello from PowerShell script"
    } | ConvertTo-Json
    
    $create = Invoke-WebRequest -Uri "http://localhost:8080/tasks" -Method POST -Body $body -ContentType "application/json"
    Write-Host "   Status: $($create.StatusCode)" -ForegroundColor Green
    Write-Host "   Response: $($create.Content)" -ForegroundColor White
    
    # Extract task ID for further tests
    $taskData = $create.Content | ConvertFrom-Json
    $taskId = $taskData.id
    Write-Host "   Task ID: $taskId" -ForegroundColor Yellow
} catch {
    Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Test 4: Get Task by ID
if ($taskId) {
    Write-Host "4. Testing GET Task by ID..." -ForegroundColor Cyan
    try {
        $getById = Invoke-WebRequest -Uri "http://localhost:8080/tasks/$taskId" -Method GET
        Write-Host "   Status: $($getById.StatusCode)" -ForegroundColor Green
        Write-Host "   Response: $($getById.Content)" -ForegroundColor White
    } catch {
        Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""

# Test 5: Search Tasks
Write-Host "5. Testing Search Tasks..." -ForegroundColor Cyan
try {
    $search = Invoke-WebRequest -Uri "http://localhost:8080/tasks/search?name=Test" -Method GET
    Write-Host "   Status: $($search.StatusCode)" -ForegroundColor Green
    Write-Host "   Response: $($search.Content)" -ForegroundColor White
} catch {
    Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Test 6: Execute Task
if ($taskId) {
    Write-Host "6. Testing Execute Task..." -ForegroundColor Cyan
    try {
        $execBody = '"echo Executing from PowerShell script"'
        $execution = Invoke-WebRequest -Uri "http://localhost:8080/tasks/$taskId/execution" -Method PUT -Body $execBody -ContentType "application/json"
        Write-Host "   Status: $($execution.StatusCode)" -ForegroundColor Green
        Write-Host "   Response: $($execution.Content)" -ForegroundColor White
    } catch {
        Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""

# Test 7: Update Task
if ($taskId) {
    Write-Host "7. Testing Update Task..." -ForegroundColor Cyan
    try {
        $updateBody = @{
            name = "Updated Test Task"
            owner = "Updated Script User"
            command = "echo Updated Hello from PowerShell"
        } | ConvertTo-Json
        
        $update = Invoke-WebRequest -Uri "http://localhost:8080/tasks/$taskId" -Method PUT -Body $updateBody -ContentType "application/json"
        Write-Host "   Status: $($update.StatusCode)" -ForegroundColor Green
        Write-Host "   Response: $($update.Content)" -ForegroundColor White
    } catch {
        Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""

# Test 8: Delete Task
if ($taskId) {
    Write-Host "8. Testing Delete Task..." -ForegroundColor Cyan
    try {
        $delete = Invoke-WebRequest -Uri "http://localhost:8080/tasks/$taskId" -Method DELETE
        Write-Host "   Status: $($delete.StatusCode)" -ForegroundColor Green
        Write-Host "   Response: $($delete.Content)" -ForegroundColor White
    } catch {
        Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""

# Test 9: Verify Deletion
Write-Host "9. Verifying Deletion..." -ForegroundColor Cyan
try {
    $finalTasks = Invoke-WebRequest -Uri "http://localhost:8080/tasks" -Method GET
    Write-Host "   Status: $($finalTasks.StatusCode)" -ForegroundColor Green
    Write-Host "   Response: $($finalTasks.Content)" -ForegroundColor White
} catch {
    Write-Host "   Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== TESTING COMPLETED ===" -ForegroundColor Green
Write-Host "Date: $(Get-Date)" -ForegroundColor Yellow

