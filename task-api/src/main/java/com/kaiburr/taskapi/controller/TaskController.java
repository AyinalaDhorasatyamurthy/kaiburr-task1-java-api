package com.kaiburr.taskapi.controller;

import com.kaiburr.taskapi.model.Task;
import com.kaiburr.taskapi.model.TaskExecution;
import com.kaiburr.taskapi.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/tasks")
public class TaskController {

    @Autowired
    private TaskRepository taskRepository;

    // GET all tasks
    @GetMapping
    public List<Task> getAllTasks() {
        return taskRepository.findAll();
    }

    // GET a task by ID
    @GetMapping("/{id}")
    public Task getTaskById(@PathVariable String id) {
        return taskRepository.findById(id).orElseThrow(() -> new RuntimeException("Task not found"));
    }

    // GET tasks by name (search)
    @GetMapping("/search")
    public List<Task> getTasksByName(@RequestParam String name) {
        return taskRepository.findByNameContaining(name);
    }

    // POST method to create a new task
    @PostMapping
    public Task createTask(@RequestBody Task task) {
        validateCommand(task.getCommand());  // Optional: Add command validation
        return taskRepository.save(task);  // Save to the repository
    }

    // PUT method to update a task or create if doesn't exist
    @PutMapping("/{id}")
    public Task updateTask(@PathVariable String id, @RequestBody Task task) {
        Task existingTask = taskRepository.findById(id).orElseThrow(() -> new RuntimeException("Task not found"));
        existingTask.setName(task.getName());
        existingTask.setOwner(task.getOwner());
        existingTask.setCommand(task.getCommand());
        // Optionally update other fields as necessary
        return taskRepository.save(existingTask);  // Save the updated task
    }

    // DELETE a task by ID
    @DeleteMapping("/{id}")
    public void deleteTask(@PathVariable String id) {
        taskRepository.deleteById(id);  // Delete task by ID from the repository
    }

    // PUT to execute task and add TaskExecution
    @PutMapping("/{taskId}/execution")
    public TaskExecution executeTask(@PathVariable String taskId, @RequestBody String command) {
        String output = "Executed: " + command;  // Placeholder output

        Task task = taskRepository.findById(taskId).orElseThrow(() -> new RuntimeException("Task not found"));

        // Create a TaskExecution and set output
        TaskExecution execution = new TaskExecution();
        Date now = new Date();
        execution.setStartTime(now);
        execution.setEndTime(now);
        execution.setOutput(output);

        // Initialize taskExecutions list if it's null
        if (task.getTaskExecutions() == null) {
            task.setTaskExecutions(new java.util.ArrayList<>());
        }
        task.getTaskExecutions().add(execution);
        taskRepository.save(task);  // Save task with updated execution history

        return execution;  // Return the execution result
    }

    // Helper method for command validation
    private void validateCommand(String command) {
        if (command.contains("rm") || command.contains("shutdown")) {
            throw new RuntimeException("Unsafe command detected");
        }
    }
}
