Given(/^the app has$/) do
  wait_for do
    !query("*").empty?
  end
end

And(/^I have done a specific thi$/) do
#  # Example: Given I am logged in
#    wait_for do
#      !query("* marked:'username'").empty?
#    end

     check_element_exists("label text:'Валерия Леоненко'")
     check_element_exists("label text:'Вадим Кокунов'")
     check_element_exists("label text:'Darya Sharova'")
#
#     irb >  touch("tabBarButton index:1")

#    touch("* marked:'username'")
#    wait_for_keyboard
#    keyboard_enter_text("cleveruser27")
#
#    touch("* marked:'password'")
#    wait_for_keyboard
#    keyboard_enter_text("pa$$w0rd")
#
#    wait_for_element_exists("* marked:'Transactions'")
#    wait_for_keyboard

#    touch("barButtonItem")

    

  # Remember: any Ruby is allowed in your step definitions
  did_something = true

  unless did_something
    fail 'Expected to have done something'
  end
end

When(/^I do someth$/) do
    
    touch("tabBarButton index:1")
    
    check_element_exists("label text:'deadfall'")
#    sleep(5)
    touch("label text:'deadfall'")
    
#    sleep(5)

    

  # Example: When I create a new entry
#    tap("* marked:'Transactions'")
#    wait_for_keyboard
#    touch("tabBarButton index:1")
#    irb > query("tabBarButton marked:'Transactions'")
#    keyboard_enter_text("* marked:'entry_title'", 'My Entry')
  #
  #  tap("* marked:'submit'")
end

Then(/^something should happe$/) do
    check_element_exists("label text:'Food'")
  # Example: Then I should see the entry on my home page
  #  wait_for_element_exists("* text:'My Entry'")
end

