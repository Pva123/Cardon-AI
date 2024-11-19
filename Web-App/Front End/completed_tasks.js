document.addEventListener("DOMContentLoaded", function() {
    const completedTasksContainer = document.getElementById("filtered-tasks");
    const allTasks = JSON.parse(localStorage.getItem("completedTasks")) || [];
    const dateRangeContainer = document.getElementById("date-range");
    const startDateInput = document.getElementById("start-date");
    const endDateInput = document.getElementById("end-date");

    // Function to initialize the page with "All Time" tasks
    function initializePage() {
        displayTasks("allTime"); // Show "All Time" by default
    }

    // Function to handle filter changes
    function filterTasks() {
        const filterValue = document.getElementById("filter").value;
        
        // Show date range inputs only if "Custom" is selected
        if (filterValue === "custom") {
            dateRangeContainer.style.display = "block";
        } else {
            dateRangeContainer.style.display = "none";
            displayTasks(filterValue);
        }
    }

    // Function to display tasks based on selected filter
    function displayTasks(filter) {
        completedTasksContainer.innerHTML = ""; // Clear previous tasks display

        const now = new Date();
        let filteredTasks = [];

        if (filter === "allTime") {
            filteredTasks = allTasks;
        } else if (filter === "day") {
            filteredTasks = allTasks.filter(task => isSameDay(now, new Date(task.completedAt)));
        } else if (filter === "yesterday") {
            filteredTasks = allTasks.filter(task => isYesterday(new Date(task.completedAt)));
        } else if (filter === "week") {
            filteredTasks = allTasks.filter(task => isSameWeek(now, new Date(task.completedAt)));
        } else if (filter === "previousWeek") {
            filteredTasks = allTasks.filter(task => isPreviousWeek(new Date(task.completedAt)));
        } else if (filter === "month") {
            filteredTasks = allTasks.filter(task => isSameMonth(now, new Date(task.completedAt)));
        } else if (filter === "previousMonth") {
            filteredTasks = allTasks.filter(task => isPreviousMonth(new Date(task.completedAt)));
        }

        displayFilteredTasksByDate(filteredTasks);
    }

    // Function to filter tasks by custom date range
    function filterByDateRange() {
        const startDate = new Date(startDateInput.value);
        const endDate = new Date(endDateInput.value);
        completedTasksContainer.innerHTML = ""; // Clear previous tasks display

        if (!startDate || !endDate || isNaN(startDate) || isNaN(endDate)) {
            completedTasksContainer.innerHTML = "<p>Please select a valid date range.</p>";
            return;
        }

        const filteredTasks = allTasks.filter(task => {
            const taskDate = new Date(task.completedAt);
            return taskDate >= startDate && taskDate <= endDate;
        });

        displayFilteredTasksByDate(filteredTasks);
    }

    // Function to display tasks grouped by date, with day of the week included
    function displayFilteredTasksByDate(tasks) {
        if (tasks.length === 0) {
            completedTasksContainer.innerHTML = "<p>No tasks found for this filter.</p>";
            return;
        }

        // Group tasks by completion date
        const tasksByDate = tasks.reduce((acc, task) => {
            const taskDate = new Date(task.completedAt);
            const dateKey = `${taskDate.toLocaleDateString()} (${taskDate.toLocaleDateString('en-US', { weekday: 'long' })})`;
            if (!acc[dateKey]) {
                acc[dateKey] = [];
            }
            acc[dateKey].push(task);
            return acc;
        }, {});

        // Display tasks grouped by their completion date with day of the week
        Object.keys(tasksByDate).forEach(date => {
            const dateLabel = document.createElement("h4");
            dateLabel.textContent = date;
            dateLabel.style.fontWeight = "bold";
            completedTasksContainer.appendChild(dateLabel);

            tasksByDate[date].forEach(task => {
                const taskElement = document.createElement("div");
                taskElement.textContent = task.text;
                taskElement.style.textDecoration = "line-through";
                taskElement.style.marginLeft = "10px";
                completedTasksContainer.appendChild(taskElement);
            });
        });
    }

    // Date helper functions
    function isSameDay(d1, d2) {
        return d1.toDateString() === d2.toDateString();
    }

    function isYesterday(date) {
        const yesterday = new Date();
        yesterday.setDate(yesterday.getDate() - 1);
        return isSameDay(yesterday, date);
    }

    function isSameWeek(currentDate, targetDate) {
        const startOfWeek = new Date(currentDate);
        startOfWeek.setDate(currentDate.getDate() - currentDate.getDay());
        startOfWeek.setHours(0, 0, 0, 0);

        const endOfWeek = new Date(startOfWeek);
        endOfWeek.setDate(startOfWeek.getDate() + 6);
        endOfWeek.setHours(23, 59, 59, 999);

        return targetDate >= startOfWeek && targetDate <= endOfWeek;
    }

    function isPreviousWeek(date) {
        const startOfLastWeek = new Date();
        startOfLastWeek.setDate(startOfLastWeek.getDate() - startOfLastWeek.getDay() - 7);
        startOfLastWeek.setHours(0, 0, 0, 0);

        const endOfLastWeek = new Date(startOfLastWeek);
        endOfLastWeek.setDate(startOfLastWeek.getDate() + 6);
        endOfLastWeek.setHours(23, 59, 59, 999);

        return date >= startOfLastWeek && date <= endOfLastWeek;
    }

    function isSameMonth(currentDate, targetDate) {
        return currentDate.getMonth() === targetDate.getMonth() &&
               currentDate.getFullYear() === targetDate.getFullYear();
    }

    function isPreviousMonth(date) {
        const currentDate = new Date();
        let prevMonth = currentDate.getMonth() - 1;
        let prevYear = currentDate.getFullYear();

        if (prevMonth < 0) {
            prevMonth = 11;
            prevYear -= 1;
        }

        return date.getMonth() === prevMonth && date.getFullYear() === prevYear;
    }

    // Event listeners
    document.getElementById("filter").addEventListener("change", filterTasks);
    startDateInput.addEventListener("change", filterByDateRange);
    endDateInput.addEventListener("change", filterByDateRange);

    // Initialize page with "All Time" tasks
    initializePage();
});