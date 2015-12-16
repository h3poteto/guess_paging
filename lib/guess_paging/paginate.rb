module GuessPaging
  class Paginate
    attr_reader :current_page, :max_page, :count, :query, :records

    def initialize(query: nil, per_page: 10, essential: 3)
      @query = query
      @key = Digest::MD5.hexdigest(query.all.to_sql.to_s)
      @per_page = per_page
      @essential = essential
    end

    def guess(page_params: nil)
      get_max_page
      if page(page_params).length < @per_page
        last_page = @query.count / @per_page + 1
        RedisClient.set(@key, last_page) if last_page != get_max_page
        @records = @query.limit(@per_page).offset(@per_page * (last_page - 1))
        @current_page = last_page
        @max_page = last_page
        @count = @query.count
      else
        @current_page = get_page(page_params)
        @max_page = get_max_page
        @count = @max_page * @per_page
      end
    end

    private

    def get_page(page_params)
      page_params ? page_params.to_i : 1
    end

    def page(page_params)
      @records = @query.limit(@per_page).offset(@per_page * (get_page(page_params) - 1))
    end

    def get_max_page
      max = RedisClient.get(@key).to_i
      if max.blank? || max.zero?
        all = @query.count
        max = all % @per_page == 0 ? all / @per_page : (all / @per_page + 1)
        RedisClient.set(@key, max)
      end

      count_digit = max.to_s.length
      if count_digit > @essential
        i = max.to_f / (10 ** (count_digit - @essential))
        last_page = (i.ceil * 10 ** (count_digit - @essential)).to_i
      end
      last_page ||= max
    end
  end
end
