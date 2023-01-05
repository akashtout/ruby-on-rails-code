step for destroy action with confirmation in rails 7 with sprocket :-
 add gem rails-ujs
a) In application.js

//= require rails-ujs

b) In application.html.erb

 <%= javascript_include_tag "application" %>
 
 --------------------Rails search bar  with filter -------------------------------------------------
 model.rb //file

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
-----------------------------------------------
controller//file code


  def index
    search = params[:search]
    email = params[:email]
    name = params[:name]
    profile = params[:profile]
    employee_id = params[:employee_id]
    @company_members = current_team_member.company.team_members.search(search, email, name, profile, employee_id)
    @team_members = @company_members
    authorize @team_members
  end
  
  ----------------------------------------------
  view//file code
  
  
  
  <div class="col-2">
          <%= form_tag(team_members_path, method: "get") do %>          
          <div class="subheader mb-2">Search</div>
          <div class="row g-2 align-items-center mb-3">
            <%= text_field_tag :search, params[:search], placeholder: "Search", class: "form-control" %>           
          </div>
          <div class="subheader mb-2">Filters</div>
          <div>
            <div class="row g-2 align-items-center mb-3">
              <%= text_field_tag :email, params[:email], placeholder: "Enter Email", class: "form-control" %>
            </div>
            <div class="row g-2 align-items-center mb-3">
              <%= text_field_tag :name, params[:name], placeholder: "Enter Name", class: "form-control" %>
            </div>
            <div class="row g-2 align-items-center mb-3">
              <%= text_field_tag :profile, params[:profile], placeholder: "Enter Profile", class: "form-control" %>
            </div>
            <div class="row g-2 align-items-center mb-3">
              <%= text_field_tag :employee_id, params[:employee_id], placeholder: "Enter Employee ID", class: "form-control" %>
            </div>            
          </div>
          <div class="mt-5">
            <%= submit_tag("Filter", class: "btn btn-primary w-100") %>
            <%= link_to "Reset to defaults", team_members_path, class: "btn btn-link w-100" %>                 
          </div>
          <% end %>  
        </div>


