---
handlers: <% name %>, <% name %>
tags: 
epic: 
start date: 
uat date: 
prod date: 
uat-release: false
uat-sign-off: false
prod-release: false
---
```dataviewjs
let tasks = dv.pages().file.tasks.filter(t => t.path === dv.current().file.path);

if (!tasks || tasks.length === 0) {
    dv.paragraph("No tasks found.");
} else {
    let completedTasks = tasks.filter(t => t.completed).length;
    let totalTasks = tasks.length;
    let progress = (completedTasks / totalTasks) * 100;

    let container = dv.el("div", "", { cls: "progress-container" });

    let progressDiv = document.createElement("div");
    progressDiv.className = "progress";

    let progressBar = document.createElement("div");
    progressBar.className = "progress-bar";
    progressBar.style.width = `${progress}%`;

    progressDiv.appendChild(progressBar);
    container.appendChild(progressDiv);

    dv.paragraph(`🏆 Completed: ${completedTasks}/${totalTasks} (${Math.round(progress)}%)`);
}
```

> [!check]- **Feature Release Checklist**  
> 


### FAQs