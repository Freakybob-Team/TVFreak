
sub Init()
    m.top.functionName = "GetContent"
    m.scene = m.top.getScene()
end sub

sub GetContent()
    try
        feed = "https://tvfreak.freakybob.site/Feeds/roku-channel-feed.json"
        print "Loading feed:", feed
        xfer = CreateObject("roURLTransfer")
        xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
        xfer.SetURL(feed) ' set feed here
        print "Successfully loaded the feed!"
    catch e
        print "Error:",e.message
        print "Failed to load feed! Exiting the app."
        m.scene.errorMessage = "An error has occurred: " + e.message
        m.scene.issueMessage = "If this issue keeps happening, please report this to Freakybob-Team or mpax235."
        'm.loadingIndicator.visible = true
        'm.errorMessage.visible = true
        return
    end try

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
    item.uploadedDate = video.uploadedDate
    item.id = video.id
    if video.content <> invalid
        item.length = video.content.duration
        item.url = video.content.videos[0].url
        item.streamFormat = video.content.videos[0].videoType
    end if
    return item
end function