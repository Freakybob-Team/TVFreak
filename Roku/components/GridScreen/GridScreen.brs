
sub Init()
    m.rowList = m.top.FindNode("rowList")
    m.rowList.SetFocus(true)
    m.descriptionLabel = m.top.FindNode("descriptionLabel")
    m.titleLabel = m.top.FindNode("titleLabel")
    m.rowList.ObserveField("rowItemFocused", "OnItemFocused")
end sub

sub OnItemFocused()
    focusedIndex = m.rowList.rowItemFocused
    row = m.rowList.content.GetChild(focusedIndex[0])
    item = row.GetChild(focusedIndex[1])
    m.descriptionLabel.text = item.description
    m.titleLabel.text = item.title
    if item.length <> invalid
        m.titleLabel.text += " | " + GetTime(item.length)
    end if
end sub

function GetTime(length as Integer) as String
    minutes = (length \ 60).ToStr()
    seconds = length MOD 60
    if seconds < 10
       seconds = "0" + seconds.ToStr()
    else
       seconds = seconds.ToStr()
    end if
    return minutes + ":" + seconds
end function