module Main exposing (borderColor, main)

import Browser exposing (Document)
import Css
import Css.Global
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Json.Decode as JD
import Style as S
import SyntaxHighlight
import View.Button as Button
import View.Button.Big as BigButton
import View.Collapsible as Collapsible
import View.ProductCard as ProductCard
import View.ProductCard.Grid as ProductCardGrid
import View.ProductCard.Image as ProductCardImage
import View.ProductCard.Swatch as ProductCardSwatch exposing (Swatch)



--------------------------------------------------------
-- TYPES --
--------------------------------------------------------


type alias Model =
    { openCollapsibles : List CollapsibleExample
    , selectedBagColorOption : BagColorOption
    , selectedPhoneCaseColorOption : PhoneCaseColorOption
    , selectedWalletColorOption : WalletColorOption
    }


type Component
    = Component__Button
    | Component__Collapsible
    | Component__ProductCard


type CollapsibleExample
    = CE__Text
    | CE__Filter


type Product
    = Product__PhoneCase
    | Product__Bag
    | Product__Wallet


type Msg
    = ClickedCollapsible CollapsibleExample
    | ClickedAddToCart
    | ClickedHello
    | ClickedBagColorOption BagColorOption
    | ClickedPhoneCaseColorOption PhoneCaseColorOption
    | ClickedWalletColorOption WalletColorOption


type BagColorOption
    = BCO__Maroon
    | BCO__Teal


type PhoneCaseColorOption
    = PCCO__Red
    | PCCO__Blue
    | PCCO__Green


type WalletColorOption
    = WCO__Gray
    | WCO__Brown



--------------------------------------------------------
-- INIT --
--------------------------------------------------------


init : JD.Value -> ( Model, Cmd Msg )
init json =
    let
        model : Model
        model =
            { openCollapsibles = []
            , selectedBagColorOption = BCO__Teal
            , selectedPhoneCaseColorOption = PCCO__Red
            , selectedWalletColorOption = WCO__Gray
            }
    in
    ( model, Cmd.none )



--------------------------------------------------------
-- HELPERS --
--------------------------------------------------------


allComponents : List Component
allComponents =
    [ Component__Button
    , Component__Collapsible
    , Component__ProductCard
    ]


allCollapsibleExamples : List CollapsibleExample
allCollapsibleExamples =
    [ CE__Text
    , CE__Filter
    ]


allProducts : List Product
allProducts =
    [ Product__PhoneCase
    , Product__Bag
    , Product__Wallet
    ]



--------------------------------------------------------
-- UPDATE --
--------------------------------------------------------


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedCollapsible example ->
            ( { model
                | openCollapsibles =
                    if List.member example model.openCollapsibles then
                        List.filter ((/=) example) model.openCollapsibles

                    else
                        example :: model.openCollapsibles
              }
            , Cmd.none
            )

        ClickedAddToCart ->
            ( model, Cmd.none )

        ClickedHello ->
            ( model, Cmd.none )

        ClickedBagColorOption bagColorOption ->
            ( { model | selectedBagColorOption = bagColorOption }
            , Cmd.none
            )

        ClickedPhoneCaseColorOption phoneCaseColorOption ->
            ( { model | selectedPhoneCaseColorOption = phoneCaseColorOption }
            , Cmd.none
            )

        ClickedWalletColorOption walletColorOption ->
            ( { model | selectedWalletColorOption = walletColorOption }
            , Cmd.none
            )



--------------------------------------------------------
-- VIEW --
--------------------------------------------------------


document : Model -> Document Msg
document model =
    { title = "Bellroy Components Examples"
    , body = List.map Html.toUnstyled <| view model
    }


globalStyles : Html Msg
globalStyles =
    Css.Global.global
        ([ Css.Global.body
            [ S.m0
            , S.p4
            , S.col
            , S.g4
            ]
         , Css.Global.everything
            [ Css.fontFamilies
                [ "GTUltra"
                , "Lato"
                , "\"Noto Sans\""
                , "\"Noto Sans JP\""
                , "\"Noto Sans KR\""
                , "\"Noto Sans SC\""
                , "\"Noto Sans TC\""
                , "\"ui - sans - serif\""
                , "\"system - ui\""
                , "\"sans - serif\""
                , "\"Apple Color Emoji\""
                , "\"Segoe UI Emoji\""
                , "\"Segoe UI Symbol\""
                , "\"Noto Color Emoji\""
                ]
            ]
         ]
            ++ ProductCard.globalStyles
        )


view : Model -> List (Html Msg)
view model =
    [ globalStyles
    , Html.div
        [ Attr.css
            [ S.col ]
        ]
        [ Html.span
            [ Attr.css
                [ S.textXl ]
            ]
            [ Html.text "Bellroy Components Examples - Chad Stearns"
            ]
        , Html.a
            [ Attr.href "https://github.com/Chadtech/component-examples"
            , Attr.css
                [ S.textXl ]
            ]
            [ Html.text "See the source Code here" ]
        ]
    , intro
    ]
        ++ List.map (componentView model) allComponents


intro : Html Msg
intro =
    Html.div
        [ Attr.css
            [ S.row
            ]
        ]
        [ Html.div
            [ Attr.css
                [ maxWidth
                , S.whitespacePreWrap
                ]
            ]
            [ Html.text introText ]
        ]


maxWidth : Css.Style
maxWidth =
    S.maxW320


introText : String
introText =
    """Making components is tricky. The reason to make re-usable components, is to unite parts of your software under one common code source, so that changes made to the component are reflected at all the places it is used.

I think this is counter-intuitive to many people. It is intuitive that if two things are the same (two buttons, for example), they should use the same code. This is true only to the extent that we expect the buttons to change together through out the life span of the project. If two buttons are identical, but we know that one button will evolve over time in ways that will interfere with the implementation details of the other, they should not be based on a re-usable component. Conversely, if two things are not the same, but maybe share one important attribute, such as their width, they should be based on re-usable code. That way, if we need to change the width, all things that share that width will change together, regardless as to whether those things are in any sense "the same".

Furthermore, this question of "do these things change together" applies not only to the decision of whether to make something a re-usable component, but which parts should be re-usable. Modals, for example, are all similar in their placement on the screen, their general layout, and their behavior of closing when clicked outside of. But beyond that, they are pretty different, and might have wildly different content in the body of the modal. Given these details, I like to make modal components re-use code for the container of the modal, but leave the body of the internal content of a modal pretty open and loosely defined with few requirements."""


componentView : Model -> Component -> Html Msg
componentView model component =
    let
        codeSample : String
        codeSample =
            case component of
                Component__Button ->
                    buttonCodeExample

                Component__Collapsible ->
                    collapsibleCodeExample

                Component__ProductCard ->
                    productCardExample

        codeHtml : Html Msg
        codeHtml =
            case SyntaxHighlight.elm codeSample of
                Ok code ->
                    SyntaxHighlight.toBlockHtml (Just 10) code
                        |> Html.fromUnstyled

                Err _ ->
                    Html.text "Error"

        componentName : String
        componentName =
            case component of
                Component__Button ->
                    "Button"

                Component__Collapsible ->
                    "Collapsible"

                Component__ProductCard ->
                    "Product Card"

        description : String
        description =
            case component of
                Component__Button ->
                    "I decided to make Button and BigButton separate modules. They are superficially very similar, but I found the small implementation details of the two different enough that I did not want to over complicate a single Button module meant to support both kinds of buttons. I did however, make a View.Button.Common` module that contains their similar parts, such as their colors, common styling, and variants (primary, secondary)."

                Component__Collapsible ->
                    "To users, it looks like the collapsible UI element contains the things that collapse and expand. As a developer, this makes it tempting to make the Collapsible module take in the content that will expand and collapse as an argument. But there are some issues I forsee with that, and in the meantime, I think the alternative implementation is pretty nice. "

                Component__ProductCard ->
                    "These kinds of components are really dangerous in my experience. They have a lot of details. Every time a detail is added, the module gets more complicated and fragile. To mitigate these risks, I have learned the \"bag of tools\" approach to API design. That means, rather than exposing a single function that takes a lot of individual details as parameters; instead expose lots of small functions that the user can use together. It may be the case that the small functions are used together in very standard and predictable ways, which in some ways translates to more boilerplate at the call-site, but that is a worthwhile trade off in my opinion."
    in
    Html.div
        [ Attr.css
            [ S.col
            , S.g2
            ]
        ]
        [ Html.div
            [ Attr.css
                [ S.textLg ]
            ]
            [ Html.text componentName ]
        , Html.div
            [ Attr.css
                [ maxWidth ]
            ]
            [ Html.text description ]
        , Html.div
            [ Attr.css
                [ S.row
                , S.g4
                ]
            ]
            [ Html.div
                [ Attr.css
                    [ S.flex1
                    , S.border
                    , S.p2
                    , Css.fontFamilies [ "monospace" ]
                    ]
                ]
                [ SyntaxHighlight.useTheme SyntaxHighlight.gitHub
                    |> Html.fromUnstyled
                , codeHtml
                ]
            , componentExampleView model component
            ]
        ]


buttonCodeExample : String
buttonCodeExample =
    """import View.Button as Button
import View.Button.Big as BigButton


buttons : List (Html Msg)
buttons =
    [ Html.div
        [ Attr.css
            [ S.row
            , S.g4
            ]
        ]
        [ Button.primary "Hello" ClickedHello
            |> Button.disable False
            |> Button.toHtml
        , Button.primary "Hi" ClickedHello
            |> Button.toHtml
        , Button.secondary "Show more +" ClickedShowMore
            |> Button.toHtml
        ]
    , Html.div
        [ Attr.css
            [ S.w64
            ]
        ]
        [ BigButton.primary "ADD TO CART" ClickedAddToCart
            |> BigButton.toHtml
        ]
    ]
"""
        |> String.replace "    " "\t"


collapsibleCodeExample : String
collapsibleCodeExample =
    """import View.Collapsible as Collapsible
    
html = 
    let 
        collapsibleHtml : Html Msg
        collapsibleHtml =
            Collapsible.simple
                "TEXT"
                { isOpen = isOpen }
                ClickedTextCollapsible
                |> Collapsible.toHtml

        content : List (Html Msg)
        content =
            if isOpen then
                [ Html.text "Peekaboo" ]

            else
                []
    in 
    Html.div
        [ Attr.css
            [ S.borderT
            , borderColor
            , S.p2
            ]
        ]
        (collapsible :: content)
    
"""
        |> String.replace "    " "\t"


productCardExample : String
productCardExample =
    """import View.ProductCard as ProductCard
import View.ProductCard.Grid as ProductCardGrid
import View.ProductCard.Image as ProductCardImage
import View.ProductCard.Swatch as ProductCardSwatch exposing (Swatch)


bagCard : Model -> Html Msg
bagCard model =
    let
        bagColorView : BagColorOption -> Swatch Msg
        bagColorView bagColorOption =
            ProductCardSwatch.color
                { rgb =
                    case bagColorOption of
                        Maroon ->
                            ( 128, 0, 0 )

                        Teal ->
                            ( 0, 165, 200 )
                , selected = bagColorOption == model.selectedBagColorOption
                , onClick = ClickedBagColorOption bagColorOption
                }
    in
    ProductCard.view
        (ProductCard.default
            |> ProductCard.withHoverOverChip ProductCard.showInsideChip
        )
        [ ProductCardImage.simple
            imageUrl
            |> ProductCardImage.withChip ProductCard.newChip
            |> ProductCardImage.toHtml
        , ProductCard.titleView "Cinch Minipack"
        , ProductCard.priceView "$89"
        , ProductCard.swatchesView
            (List.map
                bagColorView
                [ Maroon
                , Teal
                ]
            )
        ]
    """
        |> String.replace "    " "\t"


componentExampleView : Model -> Component -> Html Msg
componentExampleView model component =
    Html.div
        [ Attr.css
            [ S.flex1
            , S.g4
            , S.col
            ]
        ]
        (case component of
            Component__Button ->
                [ Html.div
                    [ Attr.css
                        [ S.row
                        , S.g4
                        ]
                    ]
                    [ Button.primary "Hello" ClickedHello
                        |> Button.disable False
                        |> Button.toHtml
                    , Button.primary "Hi" ClickedHello
                        |> Button.toHtml
                    , Button.secondary "Show more +" ClickedHello
                        |> Button.toHtml
                    ]
                , Html.div
                    [ Attr.css
                        [ S.w64
                        ]
                    ]
                    [ BigButton.primary "ADD TO CART" ClickedAddToCart
                        |> BigButton.toHtml
                    ]
                ]

            Component__Collapsible ->
                [ Html.div
                    [ Attr.css
                        [ S.borderB
                        , borderColor
                        ]
                    ]
                    (List.map (collapsibleExampleView model.openCollapsibles) allCollapsibleExamples)
                ]

            Component__ProductCard ->
                [ ProductCardGrid.view
                    (List.map (productView model) <|
                        List.concat <|
                            List.repeat 4 allProducts
                    )
                ]
        )


productView : Model -> Product -> Html Msg
productView model product =
    case product of
        Product__PhoneCase ->
            let
                phoneCaseColorOption : PhoneCaseColorOption -> Swatch Msg
                phoneCaseColorOption colorOption =
                    ProductCardSwatch.color
                        { rgb =
                            case colorOption of
                                PCCO__Red ->
                                    ( 255, 0, 0 )

                                PCCO__Blue ->
                                    ( 0, 0, 255 )

                                PCCO__Green ->
                                    ( 0, 255, 0 )
                        , selected = colorOption == model.selectedPhoneCaseColorOption
                        , onClick = ClickedPhoneCaseColorOption colorOption
                        }
            in
            ProductCard.view
                (ProductCard.default
                    |> ProductCard.withHoverOverChip ProductCard.showInsideChip
                )
                [ ProductCardImage.simple
                    "https://bellroy-product-images.imgix.net/bellroy_dot_com_range_page_image/USD/PECA-BIC-502/0?auto=format&fit=max&w=640"
                    |> ProductCardImage.toHtml
                , ProductCard.titleView "Bio Phone Case"
                , ProductCard.priceView "$19"
                , ProductCard.swatchesView
                    (List.map
                        phoneCaseColorOption
                        [ PCCO__Red
                        , PCCO__Green
                        , PCCO__Blue
                        ]
                    )
                , ProductCard.descriptionView
                    "Slim protection from your iphone"
                ]

        Product__Bag ->
            let
                bagColorView : BagColorOption -> Swatch Msg
                bagColorView bagColorOption =
                    ProductCardSwatch.color
                        { rgb =
                            case bagColorOption of
                                BCO__Maroon ->
                                    ( 128, 0, 0 )

                                BCO__Teal ->
                                    ( 0, 165, 200 )
                        , selected = bagColorOption == model.selectedBagColorOption
                        , onClick = ClickedBagColorOption bagColorOption
                        }
            in
            ProductCard.view
                ProductCard.default
                [ ProductCardImage.simple
                    "https://bellroy-product-images.imgix.net/bellroy_dot_com_range_page_image/USD/BHRA-DNB-243/0?auto=format&fit=max&w=640"
                    |> ProductCardImage.withChip
                        ProductCard.newChip
                    |> ProductCardImage.toHtml
                , ProductCard.titleView "Cinch Minipack"
                , ProductCard.priceView "$89"
                , ProductCard.swatchesView
                    (List.map
                        bagColorView
                        [ BCO__Maroon
                        , BCO__Teal
                        ]
                    )
                ]

        Product__Wallet ->
            let
                walletColorView : WalletColorOption -> Swatch Msg
                walletColorView colorOption =
                    ProductCardSwatch.color
                        { rgb =
                            case colorOption of
                                WCO__Gray ->
                                    ( 128, 128, 128 )

                                WCO__Brown ->
                                    ( 165, 42, 42 )
                        , selected = colorOption == model.selectedWalletColorOption
                        , onClick = ClickedWalletColorOption colorOption
                        }
            in
            ProductCard.view
                (ProductCard.default
                    |> ProductCard.asDark
                )
                [ ProductCardImage.simple
                    "https://bellroy-product-images.imgix.net/bellroy_dot_com_range_page_image/USD/WXSA-RVN-317/0?auto=format&fit=max&w=640"
                    |> ProductCardImage.toHtml
                , ProductCard.titleView "Cinch Minipack"
                , ProductCard.priceView "$89"
                , ProductCard.swatchesView
                    (List.map
                        walletColorView
                        [ WCO__Gray
                        , WCO__Brown
                        ]
                    )
                ]


collapsibleExampleView : List CollapsibleExample -> CollapsibleExample -> Html Msg
collapsibleExampleView openCollapsibles example =
    let
        msg : Msg
        msg =
            ClickedCollapsible example

        isOpen : Bool
        isOpen =
            List.member example openCollapsibles

        label : String
        label =
            case example of
                CE__Text ->
                    "TEXT"

                CE__Filter ->
                    "FILTER"

        collapsible : Html Msg
        collapsible =
            Collapsible.simple
                label
                { isOpen = isOpen }
                msg
                |> Collapsible.toHtml

        content : List (Html Msg)
        content =
            if isOpen then
                case example of
                    CE__Filter ->
                        let
                            filterView : String -> Html msg
                            filterView text =
                                Html.div
                                    [ Attr.css
                                        [ S.g4
                                        , S.row
                                        , S.itemsCenter
                                        ]
                                    ]
                                    [ Html.input
                                        [ Attr.type_ "checkbox" ]
                                        []
                                    , Html.text text
                                    ]
                        in
                        [ Html.div
                            [ Attr.css
                                [ S.g2
                                , S.py2
                                , S.col
                                ]
                            ]
                            (List.map
                                filterView
                                [ "10+ cards"
                                , "5 - 10 cards"
                                , "<5 cards"
                                , "Flat bills"
                                ]
                            )
                        ]

                    CE__Text ->
                        [ Html.text "Peekaboo" ]

            else
                []
    in
    Html.div
        [ Attr.css
            [ S.borderT
            , borderColor
            , S.p2
            ]
        ]
        (collapsible :: content)


borderColor : Css.Style
borderColor =
    Css.borderColor <| Css.rgb 219 219 219



--------------------------------------------------------
-- SUBSCRIPTIONS --
--------------------------------------------------------


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



--------------------------------------------------------
-- MAIN --
--------------------------------------------------------


main : Program JD.Value Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = document
        }
