class User
    attr_accessor :first_name,:last_name, :email, :full_name
  
    def initialize(attributes = {})
      @first_name = attributes[:first_name]
      @last_name = attributes[:last_name]
      @full_name = "#{first_name} #{last_name}"
      @email = attributes[:email]
    end
  
    def formatted_email
      "#{@name} <#{@email}>"
    end

    def alphabetical_name
        return  "#{@first_name}, #{@last_name}"
    end
  end