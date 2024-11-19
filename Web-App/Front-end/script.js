document.addEventListener('DOMContentLoaded', function() {
    const calendarContent = document.getElementById('calendar-content');
    const taskContainer = document.getElementById('task-container');
    const animationContainer = document.getElementById('animation');
    const completedTasksContainer = document.getElementById('completed-tasks-container');
    const prevBtn = document.getElementById("prev-btn");
    const nextBtn = document.getElementById("next-btn");
    const todayBtn = document.getElementById("today-btn");
    const viewSelect = document.getElementById("calendar-view-select");

    let completedTasks = JSON.parse(localStorage.getItem("completedTasks")) || [];
    let events = JSON.parse(localStorage.getItem("events")) || [];
    let habits = JSON.parse(localStorage.getItem("habits")) || [];
    let completedItems = 0;
    let currentDate = new Date();

    const habitContainer = document.getElementById("habit-list");
    const overallProgressBar = document.getElementById("overall-progress-bar");

    function showHabitInput() {
        const existingInput = habitContainer.querySelector("input");
        if (existingInput) existingInput.remove();
    
        const inputField = document.createElement("input");
        inputField.type = "text";
        inputField.placeholder = "Enter habit name and press Enter";
        inputField.style.cssText = `
            width: 90%; background: transparent; color: inherit; border: 1px dashed #333;
            outline: none; font-family: monospace; font-size: 16px;
            text-align: left; margin: 5px 0;
        `;
    
        habitContainer.appendChild(inputField);
        inputField.focus();
    
        inputField.addEventListener("keypress", function(event) {
            if (event.key === "Enter") {
                const habitName = inputField.value.trim();
                if (habitName) {
                    addHabit(habitName, "daily"); // Default to daily
                    inputField.remove();
                }
            }
        });
    
        inputField.addEventListener("blur", function() {
            if (!inputField.value.trim()) {
                inputField.remove();
            }
        });
    }

    // Toggle profile info
    function toggleProfile() {
        const profileInfo = document.getElementById('profile-info');
        profileInfo.style.display = profileInfo.style.display === 'none' ? 'block' : 'none';
    }

    function addHabit(text, frequency) {
        const newHabit = {
            id: Date.now(),
            text: text,
            frequency: frequency,
            completedDays: 0,
            targetDays: frequency === "daily" ? 30 : frequency === "weekly" ? 4 : 1,
            startDate: new Date().toISOString() // Track when habit was added
        };
        habits.push(newHabit);
        localStorage.setItem("habits", JSON.stringify(habits));
        displayHabits();
        updateOverallProgress();
    }

    function addTaskWithDate(container, taskText, dueDate = null, dueTime = null) {
        const taskElement = document.createElement("div");
        taskElement.classList.add("task-item");
    
        taskElement.innerHTML = `
            <span>${taskText}</span>
            ${dueDate ? `<span class="due-date">${dueDate}</span>` : ""}
            ${dueTime ? `<span class="due-time">${dueTime}</span>` : ""}
            <button class="check-btn" onclick="markTaskComplete(this)">✓</button>
        `;
        container.appendChild(taskElement);
    }
    
    function displayHabits() {
        habitContainer.innerHTML = '';
        habits.forEach((habit) => {
            const habitItem = document.createElement("div");
            habitItem.classList.add("habit-item");
    
            // Habit text
            const habitText = document.createElement("span");
            habitText.classList.add("habit-text");
            habitText.textContent = habit.text;
    
            // Dropdown for frequency
            const habitDropdown = document.createElement("div");
            habitDropdown.classList.add("habit-dropdown");
            const select = document.createElement("select");
            ["daily", "weekly", "monthly", "custom"].forEach(option => {
                const opt = document.createElement("option");
                opt.value = option;
                opt.textContent = option.charAt(0).toUpperCase() + option.slice(1);
                if (habit.frequency === option) opt.selected = true;
                select.appendChild(opt);
            });
            select.onchange = () => updateHabitFrequency(habit.id, select.value);
            habitDropdown.appendChild(select);
    
            // Checkmark button
            const habitCheckmark = document.createElement("span");
            habitCheckmark.classList.add("habit-checkmark");
            habitCheckmark.textContent = "[✓]";
            habitCheckmark.onclick = () => markHabitComplete(habit.id);
    
            // Delete button with inline confirmation
            const habitDelete = document.createElement("span");
            habitDelete.classList.add("habit-delete");
            habitDelete.style.color = "blue";
            habitDelete.textContent = "[delete]";
            habitDelete.onclick = () => {
                habitDelete.textContent = "Are you sure? [yes] [no]";
                habitDelete.style.cursor = "pointer";
    
                // Yes confirmation
                const confirmYes = document.createElement("span");
                confirmYes.textContent = "[yes]";
                confirmYes.style.color = "blue";
                confirmYes.style.cursor = "pointer";
                confirmYes.onclick = () => {
                    deleteHabit(habit.id);
                };
    
                // No confirmation
                const confirmNo = document.createElement("span");
                confirmNo.textContent = "[no]";
                confirmNo.style.color = "blue";
                confirmNo.style.cursor = "pointer";
                confirmNo.onclick = () => {
                    habitDelete.textContent = "[delete]";
                    habitDelete.onclick = () => deleteHabit(habit.id);
                };
    
                habitDelete.innerHTML = "Are you sure? ";
                habitDelete.appendChild(confirmYes);
                habitDelete.append(" ");
                habitDelete.appendChild(confirmNo);
            };
    
            // Progress bar with percentage display
            const habitProgressBar = document.createElement("div");
            habitProgressBar.classList.add("habit-progress-bar");
            const progressFill = document.createElement("div");
            progressFill.classList.add("habit-progress-fill");
            const progressPercent = calculateHabitProgress(habit);
            progressFill.style.width = `${progressPercent}%`;
            progressFill.style.backgroundColor = "green";
            habitProgressBar.appendChild(progressFill);
    
            // Progress text
            const progressText = document.createElement("span");
            progressText.textContent = `${progressPercent}%`;
            progressText.style.color = "green";
            progressText.style.marginLeft = "5px";
    
            habitItem.appendChild(habitText);
            habitItem.appendChild(habitDropdown);
            habitItem.appendChild(habitCheckmark);
            habitItem.appendChild(habitProgressBar);
            habitItem.appendChild(progressText); // Adding percentage next to progress bar
            habitItem.appendChild(habitDelete);
    
            habitContainer.appendChild(habitItem);
        });
        updateOverallProgress();
    }

    function updateHabitFrequency(habitId, newFrequency) {
        const habit = habits.find(h => h.id === habitId);
        habit.frequency = newFrequency;
        habit.targetDays = newFrequency === "daily" ? 30 : newFrequency === "weekly" ? 4 : 1;
        habit.completedDays = 0;
        localStorage.setItem("habits", JSON.stringify(habits));
        displayHabits();
        updateOverallProgress();
    }

    function markHabitComplete(habitId) {
        const habit = habits.find(h => h.id === habitId);
        
        // Only increment if habit's completed days are less than its target days
        if (habit.completedDays < habit.targetDays) {
            habit.completedDays += 1;
        }
    
        // Prevent habit from exceeding 100% completion
        if (habit.completedDays > habit.targetDays) {
            habit.completedDays = habit.targetDays;
        }
    
        // Update storage and refresh UI
        localStorage.setItem("habits", JSON.stringify(habits));
        displayHabits();
        updateOverallProgress();
    }

    function deleteHabit(habitId) {
        const habit = habits.find(h => h.id === habitId);
        const confirmDelete = confirm(`Are you sure you want to delete the habit "${habit.text}"?`);
        if (confirmDelete) {
            habits = habits.filter(habit => habit.id !== habitId);
            localStorage.setItem("habits", JSON.stringify(habits));
            displayHabits();
            updateOverallProgress();
        }
    }
    
    function updateOverallProgress() {
        // Handle case when there are no habits
        if (habits.length === 0) {
            document.getElementById("overall-progress-bar").textContent = "Overall Consistency: 0%";
            return;
        }
    
        // Sum each habit's consistency percentage and divide by the number of habits
        const totalConsistency = habits.reduce((sum, habit) => {
            // Calculate individual consistency and cap at 100%
            const habitConsistency = Math.min((habit.completedDays / habit.targetDays) * 100, 100);
            return sum + habitConsistency;
        }, 0);
    
        // Calculate the average consistency across all habits
        const overallConsistency = Math.floor(totalConsistency / habits.length);
    
        // Update the text and progress bar for overall consistency
        const overallProgressBar = document.getElementById("overall-progress-bar");
        overallProgressBar.textContent = `Overall Consistency: ${overallConsistency}%`;
    
        // Visual bar display for overall consistency
        const progressVisual = document.createElement("div");
        progressVisual.style.cssText = `
            height: 8px;
            width: 80%;
            background-color: #e0e0e0;
            margin-left: 10px;
            position: relative;
        `;
    
        const progressFill = document.createElement("div");
        progressFill.style.cssText = `
            height: 100%;
            width: ${overallConsistency}%;
            background-color: green;
            transition: width 0.5s ease;
        `;
    
        // Clear existing progress display and apply the new one
        overallProgressBar.innerHTML = "";  // Clear to avoid stacking bars
        overallProgressBar.appendChild(document.createTextNode(`Overall Consistency: ${overallConsistency}%`));
        overallProgressBar.appendChild(progressVisual);
        progressVisual.appendChild(progressFill);
    }


    function calculateHabitProgress(habit) {
        const startDate = new Date(habit.startDate);
        const now = new Date();
        const daysSinceStart = Math.floor((now - startDate) / (1000 * 60 * 60 * 24));
    
        const targetCompletions = habit.frequency === "daily" 
            ? daysSinceStart 
            : habit.frequency === "weekly" 
                ? Math.floor(daysSinceStart / 7)
                : Math.floor(daysSinceStart / 30);
    
        const progressPercent = Math.min(100, Math.floor((habit.completedDays / targetCompletions) * 100));
        return progressPercent || 0;
    }

    displayHabits();

    function displayStoredEvents() {
        const events = JSON.parse(localStorage.getItem("events")) || [];

        events.forEach(event => {
            const cells = calendarContent.querySelectorAll(".calendar-cell, .events");
            cells.forEach(cell => {
                const cellDate = cell.getAttribute("data-date");
                const cellHour = cell.getAttribute("data-hour");

                if (cellDate === event.date && (!cellHour || cellHour == new Date(event.date + ' ' + event.startTime).getHours())) {
                    const eventElement = document.createElement("div");
                    eventElement.textContent = `[Event] ${event.text}`;
                    eventElement.style.cssText = "color: blue; font-weight: bold; margin-top: 5px;";
                    cell.appendChild(eventElement);
                }
            });
        });
    }

    // Event Listeners
    document.querySelector('.add-btn[onclick*="calendar"]').addEventListener("click", () => openEventModal());

    // Initial load
    displayStoredEvents();

    // Load Calendar based on selected view
    function loadCalendar(view = "month") {
        const daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
        let viewContent = '';

        if (view === "month") {
            const monthYear = currentDate.toLocaleString('default', { month: 'long', year: 'numeric' });
            viewContent += `<div id="calendar-header">${monthYear}</div>`;
            viewContent += `<div class="calendar-days">${daysOfWeek.map(day => `<span>${day}</span>`).join('')}</div>`;

            const firstDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
            const lastDayOfMonth = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);
            const startDay = firstDayOfMonth.getDay();
            const totalDays = lastDayOfMonth.getDate();

            let dayCounter = 1;
            let prevMonthDays = new Date(currentDate.getFullYear(), currentDate.getMonth(), 0).getDate();
            let nextMonthDayCounter = 1;

            for (let i = 0; i < 6; i++) {
                viewContent += '<div class="calendar-row">';
                for (let j = 0; j < 7; j++) {
                    if (i === 0 && j < startDay) {
                        viewContent += `<div class="calendar-cell outside-month" data-day="${prevMonthDays - startDay + j + 1}"></div>`;
                    } else if (dayCounter > totalDays) {
                        viewContent += `<div class="calendar-cell outside-month" data-day="${nextMonthDayCounter}"></div>`;
                        nextMonthDayCounter++;
                    } else {
                        viewContent += `<div class="calendar-cell" data-day="${dayCounter}"></div>`;
                        dayCounter++;
                    }
                }
                viewContent += '</div>';
            }
        } else if (view === "week") {
            const startOfWeek = new Date(currentDate);
            startOfWeek.setDate(currentDate.getDate() - currentDate.getDay());
            const monthYear = currentDate.toLocaleString('default', { month: 'long', year: 'numeric' });
            
            viewContent += `<div id="calendar-header">${monthYear}</div>`;
            viewContent += `<div class="calendar-days">${daysOfWeek.map(day => `<span>${day}</span>`).join('')}</div>`;

            viewContent += '<div class="week-view">';
            viewContent += '<div class="time-column">';
            for (let hour = 0; hour < 24; hour++) {
                viewContent += `<div class="hour"><div class="time">${hour}:00</div></div>`;
            }
            viewContent += '</div>';

            for (let i = 0; i < 7; i++) {
                const dayDate = new Date(startOfWeek);
                dayDate.setDate(startOfWeek.getDate() + i);
                viewContent += `<div class="day-column" data-date="${dayDate.toISOString().split('T')[0]}">`;
                viewContent += `<div class="day-header">${dayDate.getDate()}</div>`;
                for (let hour = 0; hour < 24; hour++) {
                    viewContent += `
                        <div class="hour">
                            <div class="events" data-hour="${hour}"></div>
                        </div>
                    `;
                }
                viewContent += '</div>';
            }
            viewContent += '</div>';
        } else if (view === "day") {
            const dayDate = currentDate.toLocaleDateString('default', { weekday: 'long', month: 'long', day: 'numeric', year: 'numeric' });
            viewContent += `<div id="calendar-header">${dayDate}</div>`;
            viewContent += '<div class="day-view">';

            for (let hour = 0; hour < 24; hour++) {
                viewContent += `
                    <div class="hour">
                        <div class="time">${hour}:00</div>
                        <div class="events" data-hour="${hour}"></div>
                    </div>
                `;
            }

            viewContent += '</div>';
        }

        calendarContent.innerHTML = viewContent;

        // Add click event to calendar cells for adding events
        addEventListenersToCalendarCells();
        displayStoredEvents(); // Display previously stored events
    }

    // Navigation functions for Calendar
    function goToPrevious() {
        const view = viewSelect.value;
        if (view === "day") {
            currentDate.setDate(currentDate.getDate() - 1);
        } else if (view === "week") {
            currentDate.setDate(currentDate.getDate() - 7);
        } else if (view === "month") {
            currentDate.setMonth(currentDate.getMonth() - 1);
        }
        loadCalendar(view);
    }

    function goToNext() {
        const view = viewSelect.value;
        if (view === "day") {
            currentDate.setDate(currentDate.getDate() + 1);
        } else if (view === "week") {
            currentDate.setDate(currentDate.getDate() + 7);
        } else if (view === "month") {
            currentDate.setMonth(currentDate.getMonth() + 1);
        }
        loadCalendar(view);
    }

    function goToToday() {
        currentDate = new Date();
        loadCalendar(viewSelect.value);
    }

    // Task and Habit Animation and Functions
    function loadAnimation() {
        const rows = Math.floor(completedItems / 2);
        const pyramid = Array.from({ length: rows }, (_, i) =>
            " ".repeat(rows - i - 1) + "/".padEnd(i + 1, "_").padEnd(i * 2 + 1, "\\")
        ).join("\n");

        animationContainer.innerHTML = `<pre>${pyramid}</pre>`;
    }

    function animateWorker() {
        const workerBlink = [" O ", " O_", " O "];
        let blinkIndex = 0;
        setInterval(() => {
            document.getElementById('animation').innerHTML = workerBlink[blinkIndex];
            blinkIndex = (blinkIndex + 1) % workerBlink.length;
        }, 1000); // Blinks every second
    }

    function addItem(container, itemText) {
        const newItem = document.createElement("div");
        newItem.classList.add("item");
        newItem.style.cssText = "display: flex; align-items: center; margin-top: 5px;";

        const checkMark = document.createElement("span");
        checkMark.textContent = "[✓]";
        checkMark.style.cssText = "color: green; cursor: pointer; margin-right: 5px;";

        // Set creation timestamp for the task
        const creationTimestamp = new Date().toISOString();

        checkMark.addEventListener("click", () => markAsCompleted(newItem, itemText, creationTimestamp));

        const text = document.createElement("span");
        text.textContent = itemText;

        newItem.appendChild(checkMark);
        newItem.appendChild(text);

        container.appendChild(newItem);
        completedItems++;
    }

    function showInputField(container, type) {
        const existingInput = container.querySelector("input");
        if (existingInput) existingInput.remove();
    
        const inputField = document.createElement("input");
        inputField.type = "text";
        inputField.placeholder = `Enter ${type} and press Enter`;
        inputField.style.cssText = `
            width: 90%; background: transparent; color: inherit; border: 1px dashed #333;
            outline: none; font-family: monospace; font-size: 16px;
            text-align: left; margin: 5px 0;
        `;
    
        container.appendChild(inputField);
        inputField.focus();
    
        inputField.addEventListener("keypress", function(event) {
            if (event.key === "Enter") {
                const itemText = inputField.value.trim();
                if (itemText) {
                    if (type === "task") {
                        addItem(container, itemText); // For tasks
                    } else if (type === "habit") {
                        addHabit(itemText, "daily"); // Add as a daily habit by default
                        displayHabits(); // Refresh habit list to display the new habit
                    }
                    inputField.remove(); // Clear input after adding
                }
            }
        });
    
        inputField.addEventListener("blur", function() {
            if (!inputField.value.trim()) {
                inputField.remove();
            }
        });
    }

    document.querySelector('.add-btn[onclick*="task"]').addEventListener("click", () => showInputField(taskContainer, "task"));
document.querySelector('.add-btn[onclick*="habit"]').addEventListener("click", () => showInputField(habitContainer, "habit"));

    function markAsCompleted(item, text, creationTimestamp) {
        item.querySelector("span:nth-child(2)").style.cssText = "text-decoration: line-through; color: gray;";
        
        const completionTimestamp = new Date().toISOString();

        const completedTask = {
            text: text,
            createdAt: creationTimestamp,
            completedAt: completionTimestamp
        };

        completedTasks.unshift(completedTask);
        localStorage.setItem("completedTasks", JSON.stringify(completedTasks));

        displayRecentCompletedTasks();
        item.remove();
    }

    function displayRecentCompletedTasks() {
        completedTasksContainer.innerHTML = "";

        const recentTasks = completedTasks.slice(0, 5);
        recentTasks.forEach(task => {
            const taskElement = document.createElement("div");
            taskElement.textContent = task.text;
            taskElement.style.textDecoration = "line-through";
            completedTasksContainer.appendChild(taskElement);
        });

        document.querySelector("#completed-tasks-section button").style.display = completedTasks.length > 5 ? "block" : "none";
    }

    // Function to add event listeners for adding events on calendar cells
    function addEventListenersToCalendarCells() {
        const calendarCells = calendarContent.querySelectorAll(".calendar-cell, .events");

        calendarCells.forEach(cell => {
            cell.addEventListener("click", function() {
                const cellDate = cell.getAttribute("data-date");
                const cellHour = cell.getAttribute("data-hour");

                openEventModal(cellDate, cellHour);
            });
        });
    }

    // Show and hide profile information
    function showProfile() {
        document.getElementById('profile-info').style.display = 'block';
    }

    function hideProfile() {
        document.getElementById('profile-info').style.display = 'none';
    }

    // Navigate back
    function goBack() {
        window.history.back();
    }

    // Function to handle adding the event to the cell
    function addEvent(cell, eventText) {
        const eventElement = document.createElement("div");
        eventElement.textContent = `[Event] ${eventText}`;
        eventElement.style.cssText = "color: blue; font-weight: bold; margin-top: 5px;";

        cell.appendChild(eventElement);

        // Store event in local storage
        const events = JSON.parse(localStorage.getItem("events")) || [];
        const eventDate = currentDate.toDateString();
        events.push({ text: eventText, date: eventDate });
        localStorage.setItem("events", JSON.stringify(events));
    }

    viewSelect.addEventListener("change", () => {
        loadCalendar(viewSelect.value);
        displayStoredEvents();
    });
    prevBtn.addEventListener("click", goToPrevious);
    nextBtn.addEventListener("click", goToNext);
    todayBtn.addEventListener("click", goToToday);

    loadCalendar(viewSelect.value);
    loadAnimation();
    animateWorker();
    displayRecentCompletedTasks();

    let isDragging = false;
    let startCell = null;
    let selectionArea = null;

    function handleMouseDown(event) {
        if (event.target.classList.contains('events')) {
            isDragging = true;
            startCell = event.target;
            selectionArea = document.createElement('div');
            selectionArea.classList.add('selection-area');
            startCell.appendChild(selectionArea);
        }
    }

    function handleMouseMove(event) {
        if (isDragging && selectionArea) {
            const endCell = event.target;
            const startRect = startCell.getBoundingClientRect();
            const endRect = endCell.getBoundingClientRect();

            const top = Math.min(startRect.top, endRect.top);
            const height = Math.abs(startRect.top - endRect.top) + startRect.height;

            selectionArea.style.top = `${top - startRect.top}px`;
            selectionArea.style.height = `${height}px`;
        }
    }

    function handleMouseUp(event) {
        if (isDragging) {
            isDragging = false;
            const endCell = event.target;
            const startHour = startCell.getAttribute('data-hour');
            const endHour = endCell.getAttribute('data-hour');
            const date = startCell.closest('.day-column').getAttribute('data-date');

            openEventModal(date, startHour, endHour);
            if (selectionArea) {
                selectionArea.remove();
                selectionArea = null;
            }
        }
    }

    function addEventListenersToCalendarCells() {
        const calendarCells = calendarContent.querySelectorAll(".calendar-cell, .events");

        calendarCells.forEach(cell => {
            cell.addEventListener("mousedown", handleMouseDown);
            cell.addEventListener("mousemove", handleMouseMove);
            cell.addEventListener("mouseup", handleMouseUp);
        });
    }

    function openEventModal(date = "", startHour = "", endHour = "") {
        const eventModal = document.getElementById("event-modal");
        eventModal.style.display = "block";

        if (date) {
            document.getElementById("event-date").value = date;
        }
        if (startHour) {
            document.getElementById("event-start-time").value = `${startHour}:00`;
        }
        if (endHour) {
            document.getElementById("event-end-time").value = `${endHour}:00`;
        }
    }

    function closeEventModal() {
        const eventModal = document.getElementById("event-modal");
        eventModal.style.display = "none";
        document.getElementById("event-form").reset();
    }

    function addCalendarEvent() {
        const title = document.getElementById("event-title").value;
        const date = document.getElementById("event-date").value;
        const startTime = document.getElementById("event-start-time").value;
        const endTime = document.getElementById("event-end-time").value;
        const description = document.getElementById("event-description").value;

        const event = {
            title,
            date,
            startTime,
            endTime,
            description
        };

        let events = JSON.parse(localStorage.getItem("events")) || [];
        events.push(event);
        localStorage.setItem("events", JSON.stringify(events));

        closeEventModal();
        loadCalendar(viewSelect.value); // Refresh the calendar view
    }

    document.getElementById("event-modal-close").addEventListener("click", closeEventModal);
    document.getElementById("event-modal-save").addEventListener("click", addCalendarEvent);
});

