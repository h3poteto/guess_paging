module GuessHelper
  def paging(guess)
    hash = request.params
    hash.delete(:controller)
    hash.delete(:action)
    div = content_tag(:div, class: 'guess-paging') do
      content_tag(:ul) do
        if guess.current_page < 5
          first_paging(guess, hash)
        elsif guess.current_page > guess.max_page - 4
          last_paging(guess, hash)
        else
          middle_paging(guess, hash)
        end
      end
    end
    div.html_safe
  end

  def first_paging(guess, hash)
    li = ""
    (1..4).each do |i|
      li << if i == guess.current_page
              content_tag(:li, class: 'active') do
                "#{i}"
              end
            else
              content_tag(:li) do
                link_to("#{i}", request.path + "?" + hash.merge(page: i).to_param)
              end
            end
    end
    li << content_tag(:li, class: 'truncate') do
      "..."
    end
    li <<  content_tag(:li, class: 'last') do
      link_to("#{guess.max_page}", request.path + "?" + hash.merge(page: guess.max_page).to_param)
    end
    li.html_safe
  end

  def last_paging(guess, hash)
    li = content_tag(:li) do
      link_to("1", request.path + "?" + hash.merge(page: 1).to_param)
    end
    li << content_tag(:li, class: 'truncate') do
      "..."
    end
    ((guess.max_page - 3)..guess.max_page).each do |i|
      li << if i == guess.current_page
              content_tag(:li, class: 'active') do
                "#{i}"
              end
            else
              content_tag(:li) do
                link_to("#{i}", request.path + "?" + hash.merge(page: i).to_param)
              end
            end
    end
    li.html_safe
  end

  def middle_paging(guess, hash)
    li = content_tag(:li) do
      link_to("1", request.path + "?" + hash.merge(page: 1).to_param)
    end
    li << content_tag(:li, class: 'truncate') do
      "..."
    end
    ((guess.current_page - 2)..(guess.current_page + 2)).each do |i|
      li << if guess.current_page == i
              content_tag(:li, class: 'active') do
                "#{i}"
              end
            else
              content_tag(:li) do
                link_to("#{i}", request.path + "?" + hash.merge(page: i).to_param)
              end
            end
    end
    li << content_tag(:li) do
      "..."
    end
    li << content_tag(:li) do
      link_to("#{guess.max_page}", request.path + "?" + hash.merge(page: guess.max_page).to_param)
    end
    li.html_safe
  end
end
