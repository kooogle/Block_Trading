class Trade::DashboardController < Trade::BaseController
  def index
    block = params[:block] || 'btc'
    sta_time = params[:start] || Date.current.to_s
    end_time = params[:end] || Date.current.to_s
    @block = Block.find_by_english(block)
    tickers = @block.tickers.where("that_date >= ? AND that_date <= ?",sta_time,end_time)
    tickers = @block.tickers.last(48) if tickers.count == 0
    @date_array = tickers.map {|x| x.created_at.strftime('%H:%M')}
    @value_array = tickers.map {|x| x.last_price}
  end
end
