
function Init()
    m.top.ObserveField("visible", "OnVisibleChange")
    m.top.ObserveField("itemFocused", "OnItemFocusedChanged")
    m.buttons = m.top.FindNode("buttons")
    m.poster = m.top.FindNode("poster") 
    m.description = m.top.FindNode("descriptionLabel")
    m.timeLabel = m.top.FindNode("timeLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.releaseLabel = m.top.FindNode("releaseLabel")
    m.uploadedLabel = m.top.FindNode("uploadedLabel")
    
    result = []
    for each button in ["Play"] 
        result.Push({title : button})
    end for
    m.buttons.content = ContentListToSimpleNode(result) 
end function

sub OnVisibleChange() ' invoked when DetailsScreen visibility is changed
    if m.top.visible = true
        m.buttons.SetFocus(true)
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub SetDetailsContent(content as Object)
    m.description.text = content.description
    m.poster.uri = content.hdPosterUrl
    m.timeLabel.text = "Duration: " + GetTime(content.length)
    m.titleLabel.text = content.title
    m.releaseLabel.text = "Released on: " + content.releaseDate
    m.uploadedLabel.text = "Uploaded on: " + content.uploadedDate
end sub

sub OnJumpToItem() ' invoked when jumpToItem field is populated
    content = m.top.content
    if content <> invalid and m.top.jumpToItem >= 0 and content.GetChildCount() > m.top.jumpToItem
        m.top.itemFocused = m.top.jumpToItem
    end if
end sub

sub OnItemFocusedChanged(event as Object)' invoked when another item is focused
    focusedItem = event.GetData()
    content = m.top.content.GetChild(focusedItem)
    SetDetailsContent(content)
end sub

function OnkeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press
        currentItem = m.top.itemFocused
        if key = "left"
            m.top.jumpToItem = currentItem - 1 
            result = true
        else if key = "right" 
            m.top.jumpToItem = currentItem + 1 
            result = true
        end if
    end if
    return result
end function