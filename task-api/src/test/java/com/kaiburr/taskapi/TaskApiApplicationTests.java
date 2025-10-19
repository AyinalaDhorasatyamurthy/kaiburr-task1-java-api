package com.kaiburr.taskapi;

import com.kaiburr.taskapi.controller.TaskController;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class TaskApiApplicationTests {

    // Inject the TaskController to check if it is loaded into the application context
    @Autowired
    private TaskController taskController;

    @Test
    void contextLoads() {
        // Check if the application context loads successfully
        // This will fail the test if Spring Boot cannot load the context
    }

    @Test
    void controllerIsLoaded() {
        // This test will pass if the TaskController is correctly loaded into the Spring context
        assertThat(taskController).isNotNull(); // Ensures that the TaskController is available
    }
}

