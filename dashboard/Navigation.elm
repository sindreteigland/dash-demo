module Navigation exposing (..)


type NavigationMsg
    = MoveNext
    | MovePrevious
    | JumpNextRow
    | JumpPreviousRow
    | EnterModule
    | ExitModule


type Boundary
    = NoWrap
    | NoVerticalWrap
    | NoHorizontalWrap
    | Wrap


type alias NavigationMap =
    { arrowLeft : NavigationMsg
    , arrowUp : NavigationMsg
    , arrowRight : NavigationMsg
    , arrowDown : NavigationMsg
    , enter : NavigationMsg
    , back : NavigationMsg
    }


defaultNavigator : NavigationMap
defaultNavigator =
    { arrowLeft = MovePrevious
    , arrowUp = JumpPreviousRow
    , arrowRight = MoveNext
    , arrowDown = JumpNextRow
    , enter = MoveNext
    , back = ExitModule
    }


toolbarNavigator : NavigationMap
toolbarNavigator =
    { arrowLeft = ExitModule
    , arrowUp = MovePrevious
    , arrowRight = EnterModule
    , arrowDown = MoveNext
    , enter = EnterModule
    , back = MoveNext
    }


convertInputToCommand code navigationMap =
    if code == 39 then
        --arrow right
        navigationMap.arrowRight
    else if code == 38 then
        --arrow up
        navigationMap.arrowUp
    else if code == 37 then
        -- arrow left
        navigationMap.arrowLeft
    else if code == 40 then
        --arrow down
        navigationMap.arrowDown
    else if code == 13 then
        --enter
        navigationMap.enter
    else if code == 8 || code == 27 then
        -- 8 = backspace | 27 = esc
        navigationMap.back
    else
        navigationMap.arrowRight


navigator model command =
    case command of
        MoveNext ->
            { model | position = model.position + 1 }

        MovePrevious ->
            { model | position = model.position - 1 }

        JumpNextRow ->
            { model | position = model.position + model.currentPage.gridSize }

        JumpPreviousRow ->
            { model | position = model.position - model.currentPage.gridSize }

        EnterModule ->
            { model | navigationPath = List.append model.navigationPath [ ( "mainGrid", 0 ) ], navigator = defaultNavigator }

        ExitModule ->
            { model | navigationPath = List.drop 1 model.navigationPath, navigator = toolbarNavigator }
