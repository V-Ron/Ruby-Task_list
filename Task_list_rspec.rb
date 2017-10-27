require 'rspec'
require 'date'
require_relative 'Task'

# Story: As a developer, I can create a Task.
describe "Task" do
  it "can create a Task" do
    expect{Task.new}.to_not raise_error
  end
# Story: As a developer, I can give a Task a title and retrieve it.
  it "can name and retrieve a task" do
    new_task = Task.new
    expect(new_task.show_name).to eq "New Task"
    expect(new_task.update_name("Groceries")).to eq "Groceries"
    new_task2 = Task.new("Chores")
    expect(new_task2.show_name).to eq "Chores"
  end

# Story: As a developer, I can give a Task a description and retrieve it
  it "can describe and retrieve a task" do
    new_task = Task.new
    expect(new_task.describe("Description")).to be_a(String)
  end

# Story: As a developer, I can mark a Task done.
  it "can mark a task done" do
    new_task = Task.new
    expect(new_task.status).to be false
    expect(new_task.update_status).to be true
  end
# Story: As a developer, when I print a Task that is done, its status is shown
  it "can show done status for done tasks" do
    new_task = Task.new
    expect(new_task.finished_status).to eq "Task incomplete"
    new_task.update_status
    expect(new_task.finished_status).to eq "Done"
  end
# Story: As a developer, I can add all of my Tasks to a TaskList.
# Hint: A TaskList has-many Tasks
  it "can add tasks to a task-list" do
    new_task = Task.new
    task_list1 = Task_list.new
    expect(task_list1.add_task(new_task)).to include(new_task)
  end

# Story: As a developer, I can create a DueDateTask, which is-a Task that has-a due date.
  it "can create a DueDateTask class" do
    expect{DueDateTask.new("Mon", "yes")}.to_not raise_error
    new_due_date_task = DueDateTask.new("Mon", "yes")
    expect(new_due_date_task.show_due_date).to eq (Date.today+7)
  end
# Story: As a developer, I can print an item with a due date with labels and values.
# Hint: When implementing to_s, use super to call to_s on the super class.
  it "can print due date task information with labels and values" do
    new_due_date_task = DueDateTask.new("Friday", "due")
    expect(new_due_date_task.to_s).to include("name: Friday, status: due, due date: #{@due_date}")
  end

end

describe "TaskList" do
  it "can create a Task list" do
    expect{Task_list.new}.to_not raise_error
  end

# Story: As a developer with a TaskList, I can get the completed items.
# trying to separate complete and incomplete tasks
  it "can get the completed items in Tasklist" do
    new_task1 = Task.new
    new_task2 = Task.new
    new_task3 = Task.new
    new_task3.update_status
    task_list1 = Task_list.new
    task_list1.add_task(new_task1)
    task_list1.add_task(new_task2)
    task_list1.add_task(new_task3)
    task_list1.get_task
    expect(task_list1.incomplete_tasks).to include(new_task1)
    expect(task_list1.complete_tasks).to include(new_task3)
  end
# Story: As a developer, I can add items with due dates to my TaskList.
# Hint: Consider keeping items with due dates separate from the other items.
  it "can add due date items to Tasklist" do
    task1 = DueDateTask.new("M", "no")
    task_list1 = Task_list.new
    expect(task_list1.add_due_task(task1)).to include(task1)
  end
# Story: As a developer with a TaskList, I can list all the not completed items that are due today. ->status is false and due_date is today.
  it "can list all not completed items due today" do
    task1 = DueDateTask.new("Due", false, Date.today)
    task2 = DueDateTask.new("groceries", false, Date.today)
    new_list = Task_list.new
    new_list.add_task(task1)
    new_list.add_task(task2)
    new_list.get_task
    expect(new_list.show_task_due_today).to include(task1)
    expect(new_list.show_task_due_today).to include(task2)
  end

# Story: As a developer with a TaskList, I can list all the not completed items in order of due date.
  it "can list not completed items in order of due date" do
    task1 = DueDateTask.new("Due", false, Date.today+1)
    task2 = DueDateTask.new("groceries", false, Date.today+2)
    new_list = Task_list.new
    new_list.add_task(task1)
    new_list.add_task(task2)
    new_list.get_task
    expect(new_list.sort_task_by_due_date).to eq([task1, task2])
  end

# Story: As a developer with a TaskList with and without due dates, I can list all the not completed items in order of due date, and then the items without due dates.
  it "can list all the not completed items in order of due date, then rest" do
    task1 = DueDateTask.new("Due", false, Date.today+1)
    task2 = DueDateTask.new("groceries", false, Date.today+2)
    task3 = Task.new
    new_list = Task_list.new
    new_list.add_task(task1)
    new_list.add_task(task2)
    new_list.add_task(task3)
    new_list.get_task
    expect(new_list.sort_task_by_due_date).to eq([task1, task2, task3])
  end

end
