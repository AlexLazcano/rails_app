class PollsController < ApplicationController
  before_action :set_poll, only: %i[ show edit update destroy vote ]

  # GET /polls or /polls.json
  def index
    @polls = Poll.all
  end

  # GET /polls/1 or /polls/1.json
  def show
    @total_votes = @poll.options.sum(:votes) # Calculate total votes
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
    Rails.logger.debug "Loading poll with ID: #{params[:id]}"
    @poll = Poll.find(params[:id])
    Rails.logger.debug "Loaded poll: #{@poll.inspect}"
  end

  # POST /polls or /polls.json
  def create
    Rails.logger.debug "Creating poll with params: #{poll_params.inspect}"
    @poll = Poll.new(poll_params)

    if @poll.valid?
      Rails.logger.debug "Poll is valid"
    else
      Rails.logger.debug "Poll is invalid: #{@poll.errors.full_messages.join(", ")}"
    end

    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: "Poll was successfully created." }
        format.json { render :show, status: :created, location: @poll }
      else
        Rails.logger.debug "Failed to save poll: #{@poll.errors.full_messages.join(", ")}"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1 or /polls/1.json
  def update
    Rails.logger.debug "Updating poll with ID: #{params[:id]} and params: #{poll_params.inspect}"

    respond_to do |format|
      if @poll.update(poll_params)
        Rails.logger.debug "Poll successfully updated: #{@poll.inspect}"
        format.html { redirect_to @poll, notice: "Poll was successfully updated." }
        format.json { render :show, status: :ok, location: @poll }
      else
        Rails.logger.debug "Failed to update poll: #{@poll.errors.full_messages.join(", ")}"
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1 or /polls/1.json
  def destroy
    @poll.destroy!

    respond_to do |format|
      format.html { redirect_to polls_url, notice: "Poll was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /polls/1/vote
  def vote
    @option = @poll.options.find(params[:option_id])

    if @option
      @option.increment!(:votes)
      respond_to do |format|
        format.html { redirect_to @poll, notice: "Vote was successfully recorded." }
        format.json { render :show, status: :ok, location: @poll }
      end
    else
      respond_to do |format|
        format.html { redirect_to @poll, alert: "Option not found." }
        format.json { render json: { error: "Option not found" }, status: :not_found }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def poll_params
      params.require(:poll).permit(:question, options_attributes: [ :id, :text, :_destroy ])
    end
end
