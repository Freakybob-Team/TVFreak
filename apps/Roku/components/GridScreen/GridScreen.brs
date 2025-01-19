
sub Init()
    m.rowList = m.top.FindNode("rowList")
    m.rowList.SetFocus(true)
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    m.top.ObserveField("visible", "onVisibleChange")
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
    row = m.rowList.content.GetChild(focusedIndex[0])
    item = row.GetChild(focusedIndex[1])
    m.descriptionLabel.text = item.description
    m.titleLabel.text = item.title
    if item.length <> invalid
        m.titleLabel.text += " | " + GetTime(item.length)
    end if
end sub