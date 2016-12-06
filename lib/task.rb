class Task
  attr_reader(:description, :list_id, :due_date)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @list_id = attributes.fetch(:list_id)
    @due_date =  attributes.fetch(:due_date)
  end



  define_singleton_method(:all) do
    #get all of 'tasks' table from DB into an array
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    #empty array for all of our tasks
    tasks = []
    #loop through all of tasks from returned_tasks
    returned_tasks.each() do |task|
      #gathers descriptions for each of the tasks
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      due_date = task.fetch('due_date')
      #pushes new instance of task to the task array
      tasks.push(Task.new({:description => description, :list_id => list_id, :due_date => due_date}))
    end
    tasks
  end

  define_method(:==) do |another_task|
    self.description().==(another_task.description()).&(self.list_id().==(another_task.list_id()))
  end
  define_method(:save) do
    #Uses PG gem to execute argument
      #Adds an input, description, to the description column in the tasks table
    DB.exec("INSERT INTO tasks (description, list_id, due_date) VALUES ('#{@description}', #{@list_id}, '#{@due_date}');")
  end
  define_singleton_method(:sort) do
    sorted_tasks_data= DB.exec("SELECT * FROM tasks ORDER BY due_date ASC;")
    sorted_tasks = []
    sorted_tasks_data.each() do |task|
    due_date = task.fetch("due_date")
    description = task.fetch("description")
    list_id = task.fetch("list_id").to_i()
    sorted_tasks.push(Task.new({:description => description, :list_id => list_id, :due_date => due_date}))
  end
    sorted_tasks
  end
 end
