inherited frmPanelDadosECommerce: TfrmPanelDadosECommerce
  Left = 0
  Top = 0
  Width = 793
  Height = 650
  Align = alClient
  BorderStyle = bsNone
  Caption = ''
  Position = poDesigned
  ExplicitWidth = 793
  ExplicitHeight = 650
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 654
    Width = 799
    Height = 0
    Align = alNone
    BevelOuter = bvNone
    BorderWidth = 1
    Color = 16770261
    Visible = False
    ExplicitTop = 654
    ExplicitWidth = 799
    ExplicitHeight = 0
    DesignSize = (
      799
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 795
      ExplicitWidth = 795
    end
    inherited btnSair: TBitBtnLocked
      Left = 683
      Top = -29
      Width = 111
      Height = 25
      Caption = '(ESC) &Sair'
      Glyph.Data = {00000000}
      ExplicitLeft = 683
      ExplicitTop = -29
      ExplicitWidth = 111
      ExplicitHeight = 25
    end
  end
  inherited pnlStatus: TPanel
    Top = 552
    Width = 677
    Height = 0
    Align = alNone
    Visible = False
    ExplicitTop = 552
    ExplicitWidth = 677
    ExplicitHeight = 0
    inherited pnlNomeForm: TPanel
      Left = 506
      Height = 0
      ExplicitLeft = 506
      ExplicitHeight = 0
    end
    inherited pnlInfo: TPanel
      Width = 506
      Height = 0
      ExplicitWidth = 506
      ExplicitHeight = 0
    end
    inherited pnlBotoesTrace: TPanel
      Height = 0
      ExplicitHeight = 0
      inherited btnIniciarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
      inherited btnPausarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
      inherited btnSalvarTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
      inherited btnViewerTrace: TSpeedButton
        Height = 0
        ExplicitHeight = 0
      end
    end
  end
  object pnlDadosItem: TPanel [2]
    Left = 0
    Top = 0
    Width = 793
    Height = 650
    Align = alClient
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object pnlGeral: TPanel
      Left = 1
      Top = 1
      Width = 791
      Height = 618
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object lbl7: TLabel
        Left = 12
        Top = 3
        Width = 95
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Exporta'#231#227'o para E-Commerce:'
        WordWrap = True
      end
      object clblbl8: TColorLabel
        Left = 186
        Top = 9
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object lbl9: TLabel
        Left = 52
        Top = 127
        Width = 55
        Height = 28
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o '#13#10'do Produto:'
      end
      object lbl10: TLabel
        Left = 60
        Top = 196
        Width = 47
        Height = 28
        Alignment = taRightJustify
        Caption = 'Dados '#13#10'T'#233'cnicos:'
      end
      object lbl11: TLabel
        Left = 29
        Top = 360
        Width = 77
        Height = 14
        Alignment = taRightJustify
        Caption = 'URL da imagem:'
      end
      object lbl1: TLabel
        Left = 22
        Top = 33
        Width = 85
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome do Produto:'
      end
      object lbl2: TLabel
        Left = 59
        Top = 59
        Width = 48
        Height = 14
        Alignment = taRightJustify
        Caption = 'Aplica'#231#227'o'
      end
      object lbl3: TLabel
        Left = 64
        Top = 273
        Width = 43
        Height = 28
        Alignment = taRightJustify
        Caption = 'Itens'#13#10'Inclusos:'
      end
      object lbl4: TLabel
        Left = 75
        Top = 516
        Width = 32
        Height = 14
        Caption = 'Altura:'
      end
      object lbl5: TLabel
        Left = 240
        Top = 516
        Width = 41
        Height = 14
        Caption = 'Largura:'
      end
      object lbl6: TLabel
        Left = 419
        Top = 516
        Width = 67
        Height = 14
        Caption = 'Profundidade:'
      end
      object lbl12: TLabel
        Left = 375
        Top = 516
        Width = 15
        Height = 14
        Caption = 'Cm'
      end
      object lbl13: TLabel
        Left = 203
        Top = 516
        Width = 15
        Height = 14
        Caption = 'Cm'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl14: TLabel
        Left = 578
        Top = 516
        Width = 15
        Height = 14
        Caption = 'Cm'
      end
      object Label1: TLabel
        Left = 52
        Top = 541
        Width = 55
        Height = 14
        Caption = 'Categorias:'
      end
      object lblDestaq: TLabel
        Left = 12
        Top = 563
        Width = 95
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Destaque:'
        WordWrap = True
      end
      object clbDestaq: TColorLabel
        Left = 175
        Top = 564
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object lblPesoIt: TLabel
        Left = 615
        Top = 516
        Width = 56
        Height = 14
        Caption = 'Peso Bruto:'
      end
      object ColorLabel1: TColorLabel
        Left = 432
        Top = 564
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object Label3: TLabel
        Left = 211
        Top = 563
        Width = 150
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Atualiza pre'#231'os no site?'
        WordWrap = True
      end
      object lblExpApp: TLabel
        Left = 239
        Top = 2
        Width = 95
        Height = 25
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Exporta'#231#227'o APP Venda Assistida'
        WordWrap = True
      end
      object clbExpApp: TColorLabel
        Left = 402
        Top = 10
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object lblCroDoc: TLabel
        Left = 504
        Top = 564
        Width = 130
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Produto em Cross Docking:'
        WordWrap = True
      end
      object clbCroDoc: TColorLabel
        Left = 704
        Top = 564
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object lblExpB2B: TLabel
        Left = 5
        Top = 586
        Width = 100
        Height = 14
        Alignment = taRightJustify
        Caption = 'Exporta para o B2B?'
      end
      object clbExpB2B: TColorLabel
        Left = 176
        Top = 586
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object lblUrlDescri: TLabel
        Left = 29
        Top = 339
        Width = 75
        Height = 14
        Alignment = taRightJustify
        Caption = 'URL Descri'#231#227'o:'
      end
      object shpEXPSIT: TShape
        Left = 173
        Top = 6
        Width = 7
        Height = 22
        Hint = 'Usu'#225'rio sem acesso para alterar esse valor'
        Brush.Color = clGreen
        Pen.Color = clGreen
        Pen.Style = psInsideFrame
        Pen.Width = 0
      end
      object dbeExpSit: TDBEditFocus
        Tag = 99
        Left = 110
        Top = 6
        Width = 63
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_EXPSIT'
        DataSource = dtsCadIte
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object mmoDesSit: TMemoFocus
        Left = 110
        Top = 122
        Width = 654
        Height = 70
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<BR>'
      end
      object mmoDadTec: TMemoFocus
        Left = 110
        Top = 193
        Width = 654
        Height = 70
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<BR>'
      end
      object edtNomIte: TEditFocus
        Tag = 99
        Left = 110
        Top = 29
        Width = 654
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 200
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object mmoAplIte: TMemoFocus
        Tag = 99
        Left = 110
        Top = 52
        Width = 654
        Height = 70
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<BR>'
      end
      object mmoIteIncluso: TMemoFocus
        Left = 110
        Top = 264
        Width = 654
        Height = 70
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<BR>'
      end
      object edtExpAlt: TEditFocus
        Tag = 99
        Left = 110
        Top = 513
        Width = 90
        Height = 22
        Margins.Left = 4
        Margins.Top = 1
        Alignment = taRightJustify
        TabOrder = 12
        OnExit = edtExpAltExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtExpLar: TEditFocus
        Tag = 99
        Left = 282
        Top = 513
        Width = 90
        Height = 22
        Margins.Left = 4
        Margins.Top = 1
        Alignment = taRightJustify
        TabOrder = 13
        OnExit = edtExpLarExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtExpPro: TEditFocus
        Tag = 99
        Left = 486
        Top = 513
        Width = 90
        Height = 22
        Margins.Left = 4
        Margins.Top = 1
        Alignment = taRightJustify
        TabOrder = 14
        OnExit = edtExpProExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtCodCat: TEditFocus
        Tag = 99
        Left = 110
        Top = 536
        Width = 654
        Height = 22
        HelpType = htKeyword
        Alignment = taLeftJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 16
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDestaq: TEditFocus
        Tag = 99
        Left = 110
        Top = 559
        Width = 63
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 200
        TabOrder = 17
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPesoIt: TEditFocus
        Tag = 99
        Left = 674
        Top = 513
        Width = 90
        Height = 22
        Margins.Left = 4
        Margins.Top = 1
        Alignment = taRightJustify
        TabOrder = 15
        OnExit = edtPesoItExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,####0.0000'
      end
      object edtAtzPre: TEditFocus
        Tag = 99
        Left = 365
        Top = 559
        Width = 63
        Height = 22
        Hint = 
          'Ao setar a op'#231#227'o como '#39'N'#39', a integra'#231#227'o deixa de atualizar os pr' +
          'e'#231'os dos produtos, enviando somente estoque e dados do produto.'
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 200
        ParentShowHint = False
        ShowHint = True
        TabOrder = 18
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeExpApp: TDBEditFocus
        Tag = 99
        Left = 337
        Top = 6
        Width = 63
        Height = 22
        CharCase = ecUpperCase
        DataField = 'ITE_EXPAPP'
        DataSource = dtsCadIte
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfabetico
      end
      object edtCroDoc: TEditFocus
        Tag = 99
        Left = 637
        Top = 559
        Width = 63
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 200
        TabOrder = 19
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtExpB2B: TEditFocus
        Tag = 99
        Left = 110
        Top = 582
        Width = 63
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 20
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 1
        TipoTexto = ttAlfabetico
      end
      object cxgUrl: TcxGrid
        Left = 110
        Top = 406
        Width = 652
        Height = 104
        TabOrder = 11
        object cxgUrlView: TcxGridDBTableView
          OnKeyDown = cxgUrlViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object cxgUrlDescricao: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'URL_DESCRI'
            Options.Editing = False
            Width = 119
          end
          object cxgUrls: TcxGridDBColumn
            Caption = 'URL'
            DataBinding.FieldName = 'URL_ENDERE'
            Options.Editing = False
            Width = 443
          end
          object cxgUrlPrincipal: TcxGridDBColumn
            Caption = 'Principal'
            DataBinding.FieldName = 'URL_PRINCI'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            Properties.OnChange = cxgUrlPrincipalPropertiesChange
          end
        end
        object cxgUrlLevel: TcxGridLevel
          GridView = cxgUrlView
        end
      end
      object edtImgSit: TEditFocus
        Tag = 99
        Left = 110
        Top = 359
        Width = 654
        Height = 22
        HelpType = htKeyword
        Alignment = taLeftJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 255
        ParentFont = False
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtUrlDesc: TEditFocus
        Tag = 99
        Left = 110
        Top = 336
        Width = 211
        Height = 22
        HelpType = htKeyword
        Alignment = taLeftJustify
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 255
        ParentFont = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object btnCanUrl: TBitBtnLocked
        Left = 183
        Top = 382
        Width = 74
        Height = 23
        Caption = 'C&ancelar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
          015603015603FF00FF0000820000820000820000820000820000820000820000
          820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
          27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
          30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
          FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
          0082000082000082000082000082000082000082000082000082FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
          00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
          0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
          50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
          5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
          8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 10
        OnClick = btnCanUrlClick
      end
      object btnAdiUrl: TBitBtnLocked
        Left = 110
        Top = 382
        Width = 74
        Height = 23
        Caption = '&Adicionar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
          609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
          D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
          9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
          95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
          8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
          A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
          A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
          E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
          B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
          ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
          E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
          BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
          27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
          EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
          C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
          C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
          8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
          CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
          D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
          FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
          CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
          68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 9
        OnClick = btnAdiUrlClick
      end
    end
    object pnlMOEXSI7: TPanel
      Left = 1
      Top = 619
      Width = 791
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Label2: TLabel
        Left = 15
        Top = 3
        Width = 95
        Height = 14
        Caption = 'Desconto para Site:'
      end
      object Label4: TLabel
        Left = 373
        Top = 4
        Width = 104
        Height = 14
        Caption = 'Valor Unit'#225'rio L'#237'quido:'
      end
      object lblTabela: TLabel
        Left = 359
        Top = 4
        Width = 6
        Height = 14
        Caption = '_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPrecoTab: TLabel
        Left = 235
        Top = 4
        Width = 123
        Height = 14
        Caption = 'Tabela Pre'#231'o Exporta'#231#227'o:'
      end
      object edtDesSit: TEditFocus
        Tag = 99
        Left = 110
        Top = 0
        Width = 110
        Height = 22
        Margins.Left = 4
        Margins.Top = 1
        Alignment = taRightJustify
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        EditFormat = '#,##0.00'
      end
      object edtVlrLiq: TCurrencyEditFocus
        Tag = 99
        Left = 484
        Top = 1
        Margins.Left = 4
        Margins.Top = 1
        TabStop = False
        Enabled = False
        StyleFocused.Color = clInfoBk
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 110
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 528
    Top = 40
  end
  object dtsCadIte: TDataSource
    Left = 560
    Top = 88
  end
end
