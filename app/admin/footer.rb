module ActiveAdmin
  module Views
    class Footer < Component

      def build
        super :id => "footer"                                                    
        div do                                                                   
          small "Fellow"                                       
        end
      end

    end
  end
end