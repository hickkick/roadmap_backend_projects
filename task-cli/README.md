# Task Tracker — Ruby Solution

Hello!

This is my solution to the [Task Tracker project](https://roadmap.sh/projects/task-tracker), built with **Ruby**. It was fun to implement, and I hope you enjoy checking it out. I was supposed to write tests, but the project was *too much fun*. Now I fear the tests will ruin the mood. 🤷‍♂️

> **Note:** This program is not designed for large-scale data. It’s a simple console-based tracker.

---

## How it works

### Adding a new task

```bash
task-cli add "Buy groceries"
# Output: Task added successfully (ID: 1)
```

### Updating and deleting tasks

```bash
task-cli update 1 "Buy groceries and cook dinner"
task-cli delete 1
```

### Marking a task as in progress or done

```bash
task-cli mark-in-progress 1
task-cli mark-done 1
```

### Listing all tasks

```bash
task-cli list
```

### Listing tasks by status

```bash
task-cli list done
task-cli list todo
task-cli list in-progress
```

---

Thank you for your attention 🙌
