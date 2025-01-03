
sub Init()
    m.top.functionName = "GetContent"
end sub

sub GetContent()
    ' request the content feed from the API
    xfer = CreateObject("roURLTransfer")
    xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    xfer.SetURL("https://jonathanbduval.com/roku/feeds/roku-developers-feed-v1.json")
    rsp = xfer.GetToString()
    rootChildren = []
    rows = {}

    json = ParseJson(rsp)
    if json <> invalid
        for each category in json
            value = json.Lookup(category)
            if Type(value) = "roArray"
                if category <> "series"
                    row = {}
                    row.title = category
                    row.children = []
                    for each item in value
                        itemData = GetItemData(item)
                        row.children.Push(itemData)
                    end for
                    rootChildren.Push(row)
                end if
            end if
        end for
        contentNode = CreateObject("roSGNode", "ContentNode")
        contentNode.Update({
            children: rootChildren
        }, true)
        m.top.content = contentNode
    end if
end sub

function GetItemData(video as Object) as Object
    item = {}
    if video.longDescription <> invalid
        item.description = video.longDescription
    else
        item.description = video.shortDescription
    end if
    item.hdPosterURL = video.thumbnail
    item.title = video.title
    item.releaseDate = video.releaseDate
    item.id = video.id
    if video.content <> invalid
        item.length = video.content.duration
    end if
    return item
end function