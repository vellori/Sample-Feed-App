Will add an excalidraw, but basically:

FeedAppKit contains some common code, including models
ArticleFeedKit: contains stuff for the initial screen, which is a List of all the element in the hardcoded rss feed
ArticleDetailKit: contains stuff for the detail screen, which is basically a bunch of text and a "open" button (browser)

Mocks are created via sourcery (yet to be used), need manual trigger
swiftlint is integrated via xcode plugin
swiftgen is used for assets, automatically executed on a build phase
