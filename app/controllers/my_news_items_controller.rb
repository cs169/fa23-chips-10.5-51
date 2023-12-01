# frozen_string_literal: true
require 'httparty'
require 'logger'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list, :set_issues_list
  before_action :set_news_item, only: %i[edit update destroy]


  def new
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      @representative.news_items << @news_item # added for task 2.1: to make news items get displayed in index
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  # part 2.2
  def search_news_with_api
    news_key = Rails.application.credentials[:NEWS_API_KEY]

    response = HTTParty.get("https://newsapi.org/v2/everything", {
      query: {
        apiKey: news_key,
        q: "#{@representative.name} #{news_item_params[:issue]}",
        sortBy: 'publishedAt',
        pageSize: 5
      }
    })


    # Parse the response JSON
    news_data = JSON.parse(response.body)

    puts(news_data)

    @articles = news_data['articles']

    render 'show_news'
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue)
  end

  def set_issues_list
    @issues_list = ["Free Speech", "Immigration", "Terrorism", "Social Security and
    Medicare", "Abortion", "Student Loans", "Gun Control", "Unemployment",
    "Climate Change", "Homelessness", "Racism", "Tax Reform", "Net
    Neutrality", "Religious Freedom", "Border Security", "Minimum Wage",
    "Equal Pay"]
  end


end
