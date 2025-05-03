
sub Init()
    m.rowList = m.top.FindNode("rowList")
    m.rowList.SetFocus(true)
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    m.top.ObserveField("visible", "onVisibleChange")
    m.top.ObserveField("rowItemFocused", "OnItemFocused")
    m.top.SetFocus(true)
    m.titleLabel = m.top.FindNode("titleLabel")
    m.rowList.ObserveField("rowItemFocused", "OnItemFocused")
end sub

sub OnVisibleChange() ' invoked when GridScreen change visibility
    if m.top.visible = true
        m.rowList.SetFocus(true)
    end if
end sub

sub OnItemFocused() ' invoked when another item is focused
    focusedIndex = m.rowList.rowItemFocused
    rowIndex = focusedIndex[0]
    item = m.rowList.content.GetChild(rowIndex).GetChild(focusedIndex[1])

    m.descriptionLabel.text = item.description
    m.titleLabel.text = item.title
    
    if item.length <> invalid
        m.titleLabel.text += " | " + GetTime(item.length)
    end if
end sub

function OnKeyEvent(key as String, press as Boolean) as boolean
    if press
        focusedIndex = m.rowList.rowItemFocused
        rowIndex = focusedIndex[0]

        if rowIndex = 0 and key = "up" then
            parentScene = m.top.getScene()
            tvfreakHome = parentScene.tvfreakHome
            tvfreakHome.SetFocus(true)
            return true
        end if

        if key = "down" then
            gridScreen = m.top
            gridScreen.SetFocus(true)
            return true
        end if
    end if
    return false
end function
        