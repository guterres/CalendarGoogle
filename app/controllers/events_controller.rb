class EventsController < ApplicationController
  before_action :unconfirm_logged_in

  def index
    begin
      if params[:min_time].present? && params[:max_time].present?
        @events = service.list_events('primary', single_events: true, order_by: 'startTime', time_min: DateTime.parse(params[:min_time]).to_s, time_max: DateTime.parse(params[:max_time]).to_s)
      elsif params[:min_time].present? && !params[:max_time].present?
        @events = service.list_events('primary', single_events: true,  order_by: 'startTime', time_min: DateTime.parse(params[:min_time]).to_s)
      elsif !params[:min_time].present? && params[:max_time].present?
        @events = service.list_events('primary', single_events: true,  order_by: 'startTime', time_max: DateTime.parse(params[:max_time]).to_s)
      else
        @events = service.list_events('primary', single_events: true,  order_by: 'startTime')
      end
    rescue Google::Apis::AuthorizationError => exception
      session[:authorization] = nil
      redirect_to home_url
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.valid?
      event_api = Google::Apis::CalendarV3::Event.new({
        start: Google::Apis::CalendarV3::EventDateTime.new(date_time: DateTime.parse("#{@event.date_start} #{@event.time_start}")),
        end: Google::Apis::CalendarV3::EventDateTime.new(date_time: DateTime.parse("#{@event.date_end} #{@event.time_end}")),
        summary: @event.title,
        location: @event.location,
        description: @event.description
      })

      service.insert_event('primary', event_api)
      redirect_to events_url
    else
      render 'new'
    end
  end

  private

  def service
    service_api = Google::Apis::CalendarV3::CalendarService.new
    service_api.authorization = GoogleAPI.client.update!(session[:authorization])
    service_api
  end

  def event_params
    params.require(:event).permit(:title, :date_start, :time_start, :date_end, :time_end, :location, :description)
  end

  def unconfirm_logged_in
    redirect_to home_url if session[:authorization].nil?
  end
end
