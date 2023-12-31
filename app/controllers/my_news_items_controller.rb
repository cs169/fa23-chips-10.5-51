# frozen_string_literal: true

require 'httparty'

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
  def news_with_api
    @representative = Representative.find(params[:news_item][:representative_id])
    news_key = Rails.application.credentials[:NEWS_API_KEY]

    # replaced by mock data, for the news api have limited requests
    query_hash = {
      apiKey:   news_key,
      q:        "#{@representative.name} #{news_item_params[:issue]}",
      sortBy:   'publishedAt',
      pageSize: 5
    }
    response = HTTParty.get('https://newsapi.org/v2/everything', { query: query_hash })

    news_data = JSON.parse(response.body)

    @articles = news_data['articles']

    render('top_articles')
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
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue, :rating)
  end

  def set_issues_list
    @issues_list = ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare',
                    'Abortion', 'Student Loans', 'Gun Control', 'Unemployment',
                    'Climate Change', 'Homelessness', 'Racism', 'Tax Reform', 'Net Neutrality',
                    'Religious Freedom', 'Border Security', 'Minimum Wage', 'Equal Pay']
  end
end
