sideMenuWidthOnPC = "300px"

module.exports =
  sideMenu :
    background : "#A5ECFA"
    width : sideMenuWidthOnPC
    flex : "0 side-menu-width"
    boxFlex : 0
    padding : "40px 0 0 0"
    '@media (max-width : 768px)':
      width : "100%"
      flex : "0 100%"

  logo :
    width : "120px"
    height : "auto"
    opacity : "0.2"
    display : "block"
    margin : "0px auto 0 auto"

  loading :
    margin : "100px auto 0 150px"
    display : "block"
    width : "30px"

