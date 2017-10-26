

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
  def initialize(due_date=Date.today+7 )
    @due_date = due_date
    super
  end

  def show_due_date
    @due_date
  end

  def to_s
    @name
    @describe
    @status
    @due_date
  end
end
