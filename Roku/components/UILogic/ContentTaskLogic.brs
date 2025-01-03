
sub RunContentTask()
    m.contentTask = CreateObject("roSGNode", "MainLoaderTask")
    m.contentTask.ObserveField("content", "OnMainContentLoaded")
    m.contentTask.control = "run"
    m.loadingIndicator.visible = true
end sub

sub OnMainContentLoaded() ' invoked when content is ready to be used
    m.GridScreen.SetFocus(true) 
    m.loadingIndicator.visible = false 
    m.GridScreen.content = m.contentTask.content 
end sub