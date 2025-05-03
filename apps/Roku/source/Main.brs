sub Main()
    showChannelSGScreen()
end sub
  
sub showChannelSGScreen()
    print("")
    print("----------------------------------------------")
    print("TVFreak+ App for Roku systems")
    print("Made by the Freakybob-Team and mpax235!")
    print("----------------------------------------------")
    print("")
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.show()
  
    ' main loop
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
  
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while  
end sub