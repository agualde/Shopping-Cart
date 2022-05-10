module ApplicationHelper

    def categories
        c = Category.all
        categories = []
        c.each do |category|
            categories << category.name.capitalize
        end
        return categories.uniq
    end

    def current_order
        if !session[:order_id].nil?
            Order.find(session[:order_id]) rescue Order.new
        else
            Order.new
        end
    end
end
