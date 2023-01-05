step for destroy action with confirmation in rails :-
 add gem rails-ujs
a) In application.js

//= require rails-ujs

b) In application.html.erb

 <%= javascript_include_tag "application" %>
 
 Rails search bar  with filter

  def self.search(search, email, name, profile, employee_id)
    if search.present?
      result = where("name ILIKE ? or email ILIKE ? or profile ILIKE ? or cast(employee_id as text) ILIKE ? or cast(contact_number as text) ILIKE ?" , "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")

      if search.present?
        result.where("email ILIKE ? and name ILIKE ? and profile ILIKE ? and cast(employee_id as text) ILIKE ?", "%#{email}%", "%#{name}%", "%#{profile}%", "%#{employee_id}%")
      end

    elsif email.present? or name.present? or profile.present? or employee_id.present?
      where("email ILIKE ? and name ILIKE ? and profile ILIKE ? and cast(employee_id as text) ILIKE ?" ,  "%#{email}%", "%#{name}%", "%#{profile}%", "%#{employee_id}%")

    else search.blank?
      all
    end
  end



