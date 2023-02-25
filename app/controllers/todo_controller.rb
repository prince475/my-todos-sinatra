class TodoController < AppController

    set :views, './app/views'

    # @method: This displays a small welcome message
    get '/hello' do
        'our very first controller'
    end

    # @method: Adds a new Todo to the DB todos DB
    post '/todos/create' do
        begin
            todo = Todo.create (self.data(create: true))
            json_response(code: 201, data: todo)
        rescue => e
            json_response(code: 422, data: { error: e.message })
        end
    end

    # @method: Displays all todos
    get '/todos' do
        todos = Todo.all
        json_response(data: todos)
    end

    # @view: Renders an erb file which shows all our Todos from the DB
    # erb has content_type because we want to override the default set above
    get '/view/todos' do
        @todos = Todo.all.map { |todo|
            {
                todo: todo,
                badge: todo_status_badge(todo.status)
            }
        }
        @i = 1
        erb_response :todos
    end

    # @method: update existing To-Do item according to :id
    put '/todos/update/:id' do
        begin
            todo = Todo.find(self.todo_id)
            todo.update(self.data)
            json_response(data: { message: 'todo updated successfully' })
        rescue => e
            json_response(code: 422 ,data: { error: e.message })
        end
    end

    # @method: Delete existing To-Do based on :id
    delete '/todos/destroy/:id' do
        begin
            todo = Todo.find(self.todo_id)
            todo.destroy
            json_response(data: { message: 'todo deleted successfully' })
        rescue => e
            json_response(code: 422 ,data: { error: e.message })
        end
    end

    private

    # @helper: format body data
    def data(create: false)
        payload = JSON.parse(request.body.read)
        if create
            payload['creadetAt'] = Time.now
        end
        payload
    end

    # @helper: retrieve to-do :id
    def todo_id
        params['id'].to_i
    end

    # @helper: format status style
    def todo_status_badge(status)
        case status
            when 'CREATED'
                'bg-info'
            when 'ONGOING'
                'bg-success'
            when 'CANCELLED'
                'bg-primary'
            when 'COMPLETED'
                'bg-warning'
            else
                'bg-dark'
        end
    end


end


# class TodoController < Sinatra::Base

#     # by default sinatra looks for our erb in the views folder which is supposed to be in the root path.
#     # for our case, since its not located there then we set the path at this instance.
#     set :views, './app/views'

#     get '/hello' do
#         "Our very first controller"
#     end

#     # Our post method that allows us to add values to the db
#     # post method and then provide your route
#     # our route will be /todo/create
#     post '/todos/create' do

#       # requests can be sent with pieces of data
#       # using a request object which will have the request header plus the body
#       # calling the read method on the body to see what it contains
#       # Ensuring that our body mainatains the JSON fomart then we use a helper JSON.parse.
#       # Converts type of data given into a valid JSON object.
#       data = JSON.parse(request.body.read)
#       # create a new record in the table which can be done wih a hash, block or attributes manually set.

#       # putting a rescue block
#       begin

#         # approach 1 (individual column)

#         # today = Time.now
#         # title = data["title"]
#         # description = data["description"]
#         # todo = Todo.create(title: title, description: description, createdAt: today)
#         # todo.to_json

#         # approach 2 (hash of columns)
#         today = Time.now
#         data["createdAt"] = today
#         todo = Todo.create(data)
#         [201, todo.to_json]
#         # this is a custom way to build a status code for successful requests.
#       rescue => e
#         [422 ,{
#             error: "an error occurred while reading a new todo."
#         }.to_json]
#     end
#       # Time.now this gives a time stamp
#       # todo is an object
#       # data.to_s
#       # in ruby you can have rescue blocks which contains a block of  code that when the code runs and it encounters
#       # an error then it is cought by the rescue block.
#       # a rescue block has the following syntax use key word begin then {code} there after a recue => e
#       # resque says, don't terminate just yet I might have a solution.
#     end

#     # to view our todos we will use a get request.

#     get '/todos' do
#       todos = Todo.all
#       [200, todos.to_json]
#     end

#     get '/view/todos' do
#         @todos = Todo.all
#         erb :todos
#     end

#     # put method with a dynamic path using direct path parameters applying the use of regex. this allows us to update.
#     # retrieve the id value using a hash params and use it to retrieve the id as a symbol:id or as a string"id".
#     # you can have as many path parameters as you want so long as the :preceedes it.
#     # use an active record method .find to find the the record using the id  in out todos.

#     put '/todos/update/:id' do
#         begin
#             # using our data which is in JSON format that should be read by the put method
#             # having our code in a rescue block incase an invalid id is returned
#             data = JSON.parse(request.body.read)
#             todo_id = params['id'].to_i
#             todo = Todo.find(todo_id)
#             todo.update(data)
#             { message: 'todo updated successfully updated' }.to_json
#         rescue => e
#             [422 ,{
#                 error: e.message
#             }].to_json
#         end
#     end

#     # destroying a record using the id as reference and the ,destroy method.

#     delete '/todos/destroy/:id' do
#         begin
#             todo_id = params['id'].to_i
#             todo = Todo.find(todo_id)
#             todo.destroy
#             { message: 'todo deleted successfully' }.to_json
#         rescue => e
#             [422 ,{ error: e.message }].to_json
#         end
#     end
# end

    # post '/todos/create' do
    #     data = JSON.parse(request.body.read)


    #     # putting  a rescue block
    #     begin

    #     # approach 1 (individual columns)
    #     # today = Time.now
    #     # title = data['title']
    #     # description = data['description']
    #     # todo = Todo.create(title: title, description: description, createdAt: today, updatedAt: today)
    #     # todo.to_json

    #     # approach 2 (hash of columns)
    #     today = Time.now
    #     data['createdAt'] = today
    #     todo = Todo.create(data)
    #     [201, todo.to_json]
    #     rescue => e
    #         [422 ,{

    #             error: 'an error occurred while creating a new Todo'
    #         }.to_json]
    #     end
    # end
    #     get '/todos' do
    #         todos = Todo.all
    #         [200, todos.to_json]
    #     end
    # end

    #     put '/todos/update/:id' do
    #         data = JSON.parse(request.body.read)
    #         todo_id = params['id'].to_i
    #         todo = Todo.find[todo_id]
    #         todo.update(data)
    #         { message: "todo updated successfully"}.to_json
    #     rescue => e
    #         [422, { error: e.message }.to_json]
    #     end

    # delete '/todos/destroy/:id' do
    #     begin
    #         todo_id = params[:id].to_i
    #         todo = Todo.find(todo_id)
    #         todo.destroy
    #         { message: 'todo deleted successfully' }.to_json
    #     rescue => e
    #         [422, { error: e.message }.to_json]
    #     end
    # end

