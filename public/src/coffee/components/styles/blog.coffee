module.exports =
  container :
    height : "100%"
    display : "box"
    flexDirection : "row"
    boxOrient : "horizontal"
    '@media (max-width : 768px)':
      flexDirection : "column"
      boxOrient : "vertical"

  content :
    flex : 1
    boxFlex : 1
    textShadow : "-1px 1px 0 rgba(255, 255, 255, 1)"
    color : "#45828E"
    '@media (min-width : 769px)':
      overflowY : "auto"
      maxHeight : "100%"

  articles :
    maxWidth : "800px"
    wordBreak : "break-all"
    padding : "20px 30px 100px 30px"


