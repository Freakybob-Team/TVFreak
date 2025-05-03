
sub Init()
    m.tvfreakHome = m.top.FindNode("tvfreakHome")
    m.top.tvfreakHome = m.tvfreakHome
    m.top.backgroundColor = "0x662D91"
    m.top.backgroundUri= "pkg:/images/background.jpg"
    m.loadingIndicator = m.top.FindNode("loadingIndicator")
    m.errorMessageLabel = m.top.FindNode("errorMessageLabel")
    m.issueMessageLabel = m.top.FindNode("issueMessageLabel")

    m.top.ObserveField("errorMessage", "OnErrorMessageChanged")
    m.top.ObserveField("issueMessage", "OnIssueMessageChanged")
    InitScreenStack()
    ShowGridScreen()
    RunContentTask() ' retrieving content
end sub

' The OnKeyEvent() function receives remote control key events
function OnkeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press
        ' handle "back" key press
        if key = "back"
            numberOfScreens = m.screenStack.Count()
            if numberOfScreens > 1
                CloseScreen(invalid)
                result = true
            end if
        end if
    end if
    return result
end function

sub OnErrorMessageChanged()
    m.errorMessageLabel.text = m.top.errorMessage
    m.errorMessageLabel.visible = true
    m.loadingIndicator.visible = false
end sub

sub OnIssueMessageChanged()
    m.issueMessageLabel.text = m.top.issueMessage
    m.issueMessageLabel.visible = true
end sub