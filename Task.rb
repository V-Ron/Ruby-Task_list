

require 'date'

class Task_list
  # need to create an dempty array to push tasks into
  def initialize
    @task_list = []
    @due_tasks = []
  end

  def add_due_task (task)
    @due_tasks << task
  end

  def add_task(task)
# add task to the task_list array
    @task_list << task
  end

  def get_task
    @complete_tasks = []
    @incomplete_tasks = []
    for i in @task_list
      if i.status == false
        @incomplete_tasks << i
      elsif i.status == true
        @complete_tasks << i
      end
    end
  end

  # incomplete_sorted_by_date
  def sort_task_by_due_date
    tempArray= []
    no_duedate = []
    for i in @incomplete_tasks
      if i.respond_to?(:show_due_date)
        tempArray << i
      else
        no_duedate << i
      end
    end
    tempArray.sort_by {|task| task.show_due_date}
    p @incomplete_tasks = tempArray + no_duedate
  end

  def show_task_due_today
    for i in @incomplete_tasks
      if i.show_due_date == Date.today
        p i
      end
    end
  end

  def complete_tasks
    @complete_tasks
  end

  def incomplete_tasks
    @incomplete_tasks
  end

end

class Task
  def initialize(name = "New Task", status = false)
    @name = name
    @status = status
  end

  def show_name
    @name
  end

  def update_name(name)
    @name = name
  end

  def describe(string)
    @describe = string
  end

  def status
    @status
  end
  def update_status
    @status = !@status
  end
  def finished_status
    if @status == false
      p "Task incomplete"
    else
      p "Done"
    end
  end
end

class DueDateTask < Task
  def initialize(name, status, due_date=Date.today+7 )
    @due_date = due_date
    super(name, status)
  end

  def show_due_date
    @due_date
  end

  def to_s
    p "name: #{@name}, status: #{@status}, due date: #{@due_date}"
  end
end


DueDateTask.new("Monday", "done")
