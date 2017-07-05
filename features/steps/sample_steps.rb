Given(/^the app has launched$/) do
  wait_for do
    !query("*").empty?
  end
end

And(/^I have done a specific thing$/) do
#  # Example: Given I am logged in
#    wait_for do
#      !query("* marked:'username'").empty?
#    end

     check_element_exists("label text:'Валерия Леоненко'")
     check_element_exists("label text:'Вадим Кокунов'")
     check_element_exists("label text:'Darya Sharova'")
#     screenshot('1.png')
#     screenshot("image_name.png")

     
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

When(/^I do something$/) do
#    |arg1|

    touch("tabBarButton index:1")
    
    check_element_exists("label text:'deadfall'")

    screenshot_embed(:prefix => "financeproject", :name => "0.png")
    
    touch("label text:'add'")
  
    screenshot_embed(:prefix => "financeproject", :name => "1.png")
    
    sleep(2)
    touch("textField placeholder:'summ'")
    wait_for_keyboard
    keyboard_enter_text("555\n")
    
    sleep(2)
    touch("textField placeholder:'name'")
    wait_for_keyboard
    keyboard_enter_text("cleveruser27\n")
    
    sleep(2)
    touch("label text:'Save'")
    sleep(2)
    touch("label text:'OK'")
    sleep(1)
    touch("label text:'Back'")
    
    swipe :up, offset:{x:0,y:250}
    
    

    
#    touch("label text:'Back'")
#    sleep(2)
#    touch("label text:'CCTV'")
#    

  # Example: When I create a new entry
#    tap("* marked:'Transactions'")
#    wait_for_keyboard
#    touch("tabBarButton index:1")
#    irb > query("tabBarButton marked:'Transactions'")
#    keyboard_enter_text("* marked:'entry_title'", 'My Entry')
  #
  #  tap("* marked:'submit'")
end

Then(/^something should happen$/) do
    sleep(2)
    check_element_exists("label text:'cleveruser27'")
    if ("label text:'cleveruser27'").empty?
        puts("my work is finished")
    end
    
  # Example: Then I should see the entry on my home page
  #  wait_for_element_exists("* text:'My Entry'")
end

