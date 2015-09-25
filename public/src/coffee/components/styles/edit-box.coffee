module.exports =
  notEditing :
    height : "0px"
    transition : "all 0.5s ease"
    overflow : "hidden"
    margin : "30px 0 0 0"

  editing :
    height : "400px"
    transition : "all 0.5s ease"
    overflow : "hidden"
    margin : "30px 0 0 0"

  titleEditor :
    width : "95%"
    width : "calc(100% - 30px)"
    padding : "10px"
    fontSize : "90%"
    borderRadius : "5px"
    border : "none"
    background : "#EAE5DE"
    color : "#45828E"

    ":focus" :
      border : "solid 2px #39AEC6"

  textEditor :
    margin : "30px 0 0 0"
    width : "95%"
    width : "calc(100% - 30px)"
    padding : "10px"
    fontSize : "90%"
    borderRadius : "5px"
    border : "none"
    background : "#EAE5DE"
    height : "260px"
    resize : "none"
    color : "#45828E"

    ":focus" :
      border : "solid 2px #39AEC6"

