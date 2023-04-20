class PeopleController < ApplicationController
  def index
    @persons = Person.all
  end

  def new
    @person = Person.new
    @person.parent_id = params[:parent_id]
  end

  def show
    @person = Person.find(params[:id])
    @children = @person.children
    @grandchildren = @person.grandchildren
  end

  def create
    @person = Person.new(person_params)
    @person.parent_id = params[:person][:parent_id]

    if @person.save
      redirect_to person_path(@person), notice: 'Person was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy!

    redirect_to people_path
  end

  private

  def person_params
    params.require(:person).permit(:name, :parent_id)
  end
end
