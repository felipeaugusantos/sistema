inherited frmCadCfgTerminalTef: TfrmCadCfgTerminalTef
  Width = 800
  Height = 607
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Terminais TEF'
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 607
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 562
    Width = 794
    ExplicitTop = 562
    ExplicitWidth = 794
    inherited FlwBotoes: TFlowPanel
      Width = 790
      ExplicitWidth = 790
    end
  end
  inherited pnlStatus: TPanel
    Top = 562
    Width = 794
    ExplicitTop = 562
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited pgcDados: TPageControl
    Left = 47
    Top = 466
    Height = 68
    Align = alNone
    ExplicitLeft = 47
    ExplicitTop = 466
    ExplicitHeight = 68
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 36
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 562
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object btnConfirmar: TBitBtnLocked
      Left = 474
      Top = 207
      Width = 85
      Height = 26
      Cursor = crHandPoint
      Caption = '&Confirmar'
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
      TabOrder = 1
      OnClick = btnConfirmarClick
    end
    object cxGridTerminais: TcxGridCitel
      Left = 2
      Top = 239
      Width = 790
      Height = 321
      Align = alBottom
      TabOrder = 3
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridTerminaisDBTableViewCitel1: TcxGridDBTableViewCitel
        OnKeyDown = cxGridTerminaisDBTableViewCitel1KeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dsTerminaisTef
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object cxGridTerminaisTFC_CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CODEMP'
          Width = 52
        end
        object cxGridTerminaisTFC_EMPTIP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'EMPTIP'
          Width = 52
        end
        object cxGridTerminaisTFC_NUMLOJ: TcxGridDBColumn
          Caption = 'C'#243'digo Loja'
          DataBinding.FieldName = 'NUMLOJ'
          Width = 73
        end
        object cxGridTerminaisTFC_NUMTER: TcxGridDBColumn
          Caption = 'N'#186' Terminal'
          DataBinding.FieldName = 'NUMTER'
          Options.Sorting = False
          SortIndex = 0
          SortOrder = soDescending
          Width = 76
        end
        object cxGridTerminaisTFC_NUM_IP: TcxGridDBColumn
          Caption = 'IP Servidor TEF'
          DataBinding.FieldName = 'NUM_IP'
          Width = 130
        end
        object cxGridTerminaisTFC_MACADD: TcxGridDBColumn
          Caption = 'Endere'#231'o Mac'
          DataBinding.FieldName = 'MACADD'
          Width = 132
        end
        object cxGridTerminaisTFC_LOC_IP: TcxGridDBColumn
          Caption = 'IP M'#225'quina'
          DataBinding.FieldName = 'LOC_IP'
        end
        object cxGridTerminaisTFC_NOMMAQ: TcxGridDBColumn
          Caption = 'Nome M'#225'quina'
          DataBinding.FieldName = 'NOMMAQ'
          Width = 131
        end
        object cxGridTerminaisTFC_NOMUSU: TcxGridDBColumn
          Caption = 'Usu'#225'rio M'#225'quina'
          DataBinding.FieldName = 'NOMUSU'
          Width = 170
        end
        object cxGridTerminaisTFC_PATIMP: TcxGridDBColumn
          Caption = 'Impressora'
          DataBinding.FieldName = 'PATIMP'
          Width = 400
        end
        object cxGridTerminaisTFC_PINPOR: TcxGridDBColumn
          Caption = 'Porta Pin Pad'
          DataBinding.FieldName = 'PINPOR'
          Width = 80
        end
        object cxGridTerminaisTFC_PINFAB: TcxGridDBColumn
          Caption = 'Fabricante Pin Pad'
          DataBinding.FieldName = 'PINFAB'
          Width = 400
        end
        object cxGridTerminaisTFC_TSALES: TcxGridDBColumn
          Caption = 'N'#250'mero S'#233'rie Smart POS (Sales)'
          DataBinding.FieldName = 'TSALES'
          Visible = False
          VisibleForCustomization = False
          Width = 175
        end
        object cxGridTerminaisTFC_TKSALE: TcxGridDBColumn
          Caption = 'Token VPN M-Sitef'
          DataBinding.FieldName = 'TKSALE'
          Visible = False
          VisibleForCustomization = False
          Width = 175
        end
      end
      object cxGridTerminaisLevel1: TcxGridLevel
        GridView = cxGridTerminaisDBTableViewCitel1
      end
    end
    object btnConsultaInfo: TBitBtnLocked
      Left = 2
      Top = 207
      Width = 241
      Height = 26
      Cursor = crHandPoint
      Caption = '&Recupera informa'#231#245'es da esta'#231#227'o logada'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000090000
        000E000000100000001000000010000000100000001000000011000000110000
        0011000000110000001100000011000000100000000B0000000377544AC1A474
        66FFA47465FFA47465FFA37364FFA37264FFA27263FFA27263FFA27162FFA271
        62FFA17062FFA17061FFA17061FFA17061FF735046C30000000AAC7E71FFF8F1
        EEFFF8F0EDFFF8F1ECFFF8F0ECFFF8F0ECFFF5EDE9FFF2EAE6FFF5EDE9FFF8EF
        EBFFF7EFEBFFF7EFEBFFF7EFEBFFF7F0EBFFA8796AFF0000000FAD8172FFF8F2
        EFFFF6EDE8FFF7EDE8FFF6ECE8FFF4EBE6FFE6DBD6FFA87A62FFE7DCD8FFF5EB
        E6FFF6EDE7FFF6ECE8FFF6ECE8FFF8F0ECFFA97B6BFF00000010AF8375FFF9F2
        EFFFF6ECE8FFF6EDE9FFF6ECE7FFEDE5E0FFAD836EFFC58A51FFB08975FFEDE4
        E0FFF6ECE7FFF6ECE8FFF6ECE8FFF8F1EDFFAA7C6DFF0000000FB18577FFF9F3
        F0FFF7EDE9FFF7EDE8FFF3EAE5FFCDB3A8FFAC6E41FFF7C67AFFA96B40FFCDB6
        ABFFF1E8E4FFF7EDE8FFF6EDE9FFF9F1EDFFAB7E6FFF0000000EB2887AFFF9F4
        F0FFF7EEE9FFF5EBE7FFE4D8D1FFA06544FFEFBE79FFF9CA82FFEDBB78FF9F63
        42FFE3D7D2FFF4EBE7FFF7EEE9FFF8F1EEFFAD8072FF0000000EB48A7CFFF9F4
        F1FFF7EEEAFFF4EBE7FFC69E83FFB47C54FFB47B53FFFACF88FFB37851FFB277
        4FFFC3987EFFF2E9E5FFF7EEE9FFF9F2EFFFAF8274FF0000000DB68D7FFFFAF4
        F2FFF7EEEAFFF6EDE9FFF2E9E5FFE9E1DDFFB77F57FFFDD48EFFB1744CFFE8DF
        DBFFF1E7E4FFF6EDE9FFF7EEEAFFF9F2EFFFB08476FF0000000CB88F82FFFAF5
        F2FFF7EEEAFFF7EEEBFFF7EEEAFFF0E7E5FFBA845CFFFEEAC1FFB2774FFFEFE7
        E3FFF7EEEAFFF7EFEAFFF7EEEAFFF9F3F0FFB28679FF0000000CB99184FFFAF5
        F3FFF8EFEBFFF7EFEAFFF7EFEBFFF2EAE6FFCB9E76FFCB9E76FFCB9E76FFF2E8
        E5FFF7EFEAFFF7EEEAFFF7EFEBFFFAF4F1FFB3897BFF0000000BBB9387FFFAF6
        F4FFF7EFEBFFF7EEEBFFF8EFEBFFF6EDEAFFF2EAE6FFF1E9E5FFF2EAE6FFF6ED
        EAFFF7EFEBFFF7EFEBFFF7EEEBFFFAF3F2FFB58B7DFF0000000AD4A477FFD8B1
        8BFFD2A373FFD1A372FFD1A272FFD1A170FFD0A070FFD09F6FFFCF9F6EFFCE9E
        6DFFCF9D6CFFCE9C6BFFCE9C6AFFD3A77CFFCE9764FF00000009D4A678FFEED7
        B6FFE2BB87FFE2BA86FFE2B985FFE2BA85FFE2BA85FFE1B984FFE1B984FFE1B8
        84FFE1B883FFE1B883FFE0B783FFEBD0AAFFCE9864FF00000009D4A679FFF1DC
        BCFFF0DCBCFFF0DBBCFFF0DBBCFFF0DCBBFFEFDABBFFEFDABBFFEFDABAFFEFDA
        B9FFEFD8B9FFEFD9B8FFEFD8B6FFEED5B1FFCE9865FF000000089E7B5AC0D4A6
        79FFD4A577FFD4A476FFD3A375FFD3A272FFD2A071FFD1A06FFFD09F6FFFD09D
        6DFFD09C6CFFD09B6AFFCF9B68FFCF9A67FF99714BC200000005}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnConsultaInfoClick
    end
    object btnCancelar: TBitBtnLocked
      Left = 561
      Top = 207
      Width = 85
      Height = 26
      Cursor = crHandPoint
      Caption = 'C&ancelar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        200000000000000400000000000000000000000000000000000000000000131C
        3C471E2B5F700000000000000000000000000000000000000000000000000000
        00000000000000000000000000001F2D6375131C3C4700000000131C3C474260
        D0F64463D8FF1F2D617300000000000000000000000000000000000000000000
        00000000000000000000202E65774463D8FF4260D1F7131C3C472130687B4463
        D8FF4463D8FF4463D8FF1F2D6173000000000000000000000000000000000000
        000000000000202E65774463D8FF4463D8FF4463D8FF212F677A000000002231
        6C7F4463D8FF4463D8FF4463D8FF1F2D61730000000000000000000000000000
        0000202E65774463D8FF4463D8FF4463D8FF22316B7E00000000000000000000
        000022316C7F4463D8FF4463D8FF4463D8FF1F2D61730000000000000000202E
        65774463D8FF4463D8FF4463D8FF22316B7E0000000000000000000000000000
        00000000000022316C7F4463D8FF4463D8FF4463D8FF1F2D6173202E65774463
        D8FF4463D8FF4463D8FF22316B7E000000000000000000000000000000000000
        0000000000000000000022316C7F4463D8FF4463D8FF4463D8FF4463D8FF4463
        D8FF4463D8FF22316B7E00000000000000000000000000000000000000000000
        000000000000000000000000000022316C7F4463D8FF4463D8FF4463D8FF4463
        D8FF22316B7E0000000000000000000000000000000000000000000000000000
        0000000000000000000000000000202E65774463D8FF4463D8FF4463D8FF4463
        D8FF1F2D62740000000000000000000000000000000000000000000000000000
        00000000000000000000202E65774463D8FF4463D8FF4463D8FF4463D8FF4463
        D8FF4463D8FF1F2D627400000000000000000000000000000000000000000000
        000000000000202E65774463D8FF4463D8FF4463D8FF22316B7E22316C7F4463
        D8FF4463D8FF4463D8FF1F2D6274000000000000000000000000000000000000
        0000202E65774463D8FF4463D8FF4463D8FF21316A7D00000000000000002231
        6C7F4463D8FF4463D8FF4463D8FF1F2D6274000000000000000000000000202E
        65774463D8FF4463D8FF4463D8FF21316A7D0000000000000000000000000000
        000022316C7F4463D8FF4463D8FF4463D8FF1F2D6274000000001F2D63754463
        D8FF4463D8FF4463D8FF21316A7D000000000000000000000000000000000000
        00000000000022316C7F4463D8FF4463D8FF4463D8FF1E2C6172151E414D4261
        D3F94463D8FF21316A7D00000000000000000000000000000000000000000000
        0000000000000000000022316C7F4463D8FF4261D3F9151E424E00000000151E
        414D212F677A0000000000000000000000000000000000000000000000000000
        00000000000000000000000000002130687B151E414D00000000}
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnNovo: TBitBtnLocked
      Left = 387
      Top = 207
      Width = 85
      Height = 26
      Cursor = crHandPoint
      Caption = '&Novo'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        000000000000000000000000000000000000000000000000000000000000B882
        4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
        4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF0000000000000000B882
        4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
        4DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFF00000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000B8824DFFB8824DFF0000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 4
      OnClick = btnNovoClick
    end
    object btnFechar: TBitBtnLocked
      Left = 649
      Top = 207
      Width = 85
      Height = 26
      Caption = '&Fechar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
      TabOrder = 5
      OnClick = btnFecharClick
    end
    object btnVersaoDll: TBitBtnLocked
      Left = 245
      Top = 207
      Width = 140
      Height = 26
      Caption = '&Vers'#227'o Biblioteca TEF'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333CCCCC33
        33333FFFF77777FFFFFFCCCCCC808CCCCCC3777777F7F777777F008888070888
        8003777777777777777F0F0770F7F0770F0373F33337F333337370FFFFF7FFFF
        F07337F33337F33337F370FFFB99FBFFF07337F33377F33337F330FFBF99BFBF
        F033373F337733333733370BFBF7FBFB0733337F333FF3337F33370FBF98BFBF
        0733337F3377FF337F333B0BFB990BFB03333373FF777FFF73333FB000B99000
        B33333377737777733333BFBFBFB99FBF33333333FF377F333333FBF99BF99BF
        B333333377F377F3333333FB99FB99FB3333333377FF77333333333FB9999FB3
        333333333777733333333333FBFBFB3333333333333333333333}
      NumGlyphs = 2
      TabOrder = 6
      OnClick = btnVersaoDllClick
    end
    object pcConfiguracoes: TPageControl
      Left = 2
      Top = 2
      Width = 790
      Height = 205
      ActivePage = tsTef
      Align = alTop
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Style = tsFlatButtons
      TabOrder = 7
      object tsTef: TTabSheet
        Caption = 'TEF'
        object lblNumLoja: TLabel
          Left = 11
          Top = 8
          Width = 56
          Height = 14
          Caption = 'C'#243'digo Loja'
        end
        object lblNumTer: TLabel
          Left = 11
          Top = 48
          Width = 57
          Height = 14
          Caption = 'N'#186' Terminal:'
        end
        object lblServidorTef: TLabel
          Left = 11
          Top = 90
          Width = 76
          Height = 14
          Alignment = taRightJustify
          Caption = 'IP Servidor TEF:'
        end
        object lblImpressora: TLabel
          Left = 11
          Top = 128
          Width = 101
          Height = 14
          Alignment = taRightJustify
          Caption = 'Caminho Impressora:'
        end
        object lblEmpresa: TLabel
          Left = 291
          Top = 122
          Width = 45
          Height = 14
          Caption = 'Empresa:'
        end
        object lblNomMaq: TLabel
          Left = 291
          Top = 48
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome da M'#225'quina'
        end
        object lblIpMaquina: TLabel
          Left = 503
          Top = 48
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'IP M'#225'quina:'
        end
        object lblMacAdd: TLabel
          Left = 291
          Top = 8
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Endere'#231'o MAC'
        end
        object lblTerminalSales: TLabel
          Left = 382
          Top = 8
          Width = 181
          Height = 14
          Caption = 'N'#250'mero S'#233'rie Smart POS (Citel Sales)'
        end
        object lblNomUsu: TLabel
          Left = 291
          Top = 90
          Width = 83
          Height = 14
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio Maquina:'
        end
        object lblTokenMsitef: TLabel
          Left = 395
          Top = 48
          Width = 89
          Height = 14
          Caption = 'Token VPN M-Sitef'
        end
        object lblAdquirente: TLabel
          Left = 508
          Top = 90
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Adquirente'
          Visible = False
        end
        object edtNumLoja: TEditFocus
          Tag = 99
          Left = 11
          Top = 23
          Width = 201
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 8
          TipoTexto = ttAlfanumerico
        end
        object edtNumTer: TEditFocus
          Tag = 99
          Left = 11
          Top = 63
          Width = 201
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 8
          TipoTexto = ttAlfanumerico
        end
        object edtIpServ: TEditFocus
          Tag = 99
          Left = 11
          Top = 103
          Width = 201
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 30
          TipoTexto = ttAlfanumerico
        end
        object btnLocImp: TBitBtnLocked
          Left = 10
          Top = 144
          Width = 42
          Height = 25
          Hint = 'Selecionar Impressora'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000020000000A0000000F000000110000001100000011000000100000
            000B000000030000000000000000000000000000000000000000000000090000
            000E000000168A6559C3BF8D7BFFBF8D7BFFC08D7BFFBF8D7BFFC08D7BFF8A65
            58C500000019000000100000000A0000000200000000000000007B5143C0A76E
            5BFFA06855FFC2917FFFF7F0ECFFF7EFECFFF7F0EBFFF6EFEBFFF6EFEAFFC291
            7FFF875746FF8B5948FF623F33C20000000A0000000000000000BB7E6BFFECD9
            CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFF8F1EDFFC495
            83FFE2CCBCFFE6D1C1FFB67764FF0000000E0000000000000000BE8571FFF1E5
            DAFFEBDACFFF794734FF794734FF784734FF784734FF784734FF784734FF7847
            34FFECDACEFFEBDBCFFFBA7C69FF0000000D0000000000000000C28B78FFF5EE
            E7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7DDFFF2E7
            DEFFF2E7DDFFF2E5DEFFBD836FFF0000000C0000000000000000C7937FFFFAF4
            F1FFCDBEB9FF72564AFF624338FF614036FF604035FF5F3F34FF5E3E33FF414C
            3AFF315F45FF0D482AFF2F5538FF0621137A0001000300000000CC9986FFFDFA
            FAFF806256FF745043FF744F43FF744E43FF734E42FF6F4D41FF265034FF1376
            4BFF1AAC73FF52E1BAFF19AD73FF13764BFF0C4026C901030209BB9080E9F5EB
            E6FF7D5C4DFF946E5EFFFAF6F3FFF0E6E0FFF0E5DFFF7D9D88FF218058FF28CD
            90FF27CD8FFF035A2AFF28CD90FF27CD8FFF22835AFF092F1C8434292444A681
            72CC886857FF9B7565FFFBF8F6FFF2E8E3FFF1E8E1FF317654FF30C18DFF32D4
            9BFF33D49BFF57C4A0FF42D9A6FF33D49BFF31C18DFF115837DE000000010000
            00030000000CC59685FFFCFAF9FFF3EBE6FFF4EAE5FF1C744CFF55DDB0FF3EDA
            A6FF3EDAA6FF02451DFF60C4A4FF3EDAA6FF56DDB1FF166E46F9000000000000
            000000000008C89B89FFFDFCFBFFF5EDE8FFF4EDE8FF368B64FF8EDEC4FF4BE1
            B2FF79ECCBFF89F0D4FF013C18FF4BE1B2FF8BDDC3FF176B47DE000000000000
            000000000006CA9E8DFFFEFDFDFFFEFDFCFFFEFCFCFF91C4ADFF51A986FFACF5
            E0FF1D6341FF013413FF267250FFACF5E0FF57AE8BFF0E412B7B000000000000
            00000000000498786BC1CDA291FFCCA18FFFCCA090FFCAA08EFF49946CFF50AF
            89FFA7E2CFFFCAF8ECFFA7E2CFFF50AE89FF176C49C000020103000000000000
            0000000000010000000300000005000000050000000600000006000201090F43
            2D741A7852CC219465FC1A7852CC0F432E720002010300000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = btnLocImpClick
        end
        object edtImpressora: TEditFocus
          Tag = 99
          Left = 58
          Top = 146
          Width = 598
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 30
          TipoTexto = ttAlfanumerico
        end
        object edtCodEmp: TEditFocus
          Tag = 99
          Left = 291
          Top = 137
          Width = 72
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtNomEmp: TEditFocus
          Left = 369
          Top = 137
          Width = 287
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 8
          Text = 'TODOS'
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomUsu: TEditFocus
          Tag = 99
          Left = 291
          Top = 103
          Width = 365
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = clBtnFace
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 50
          ReadOnly = True
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 50
          TipoTexto = ttAlfanumerico
        end
        object edtNomMaq: TEditFocus
          Tag = 99
          Left = 291
          Top = 63
          Width = 206
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = clBtnFace
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          ReadOnly = True
          TabOrder = 10
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttAlfanumerico
        end
        object edtIpMaquina: TEditFocus
          Tag = 99
          Left = 503
          Top = 63
          Width = 153
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 30
          ReadOnly = True
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 30
          TipoTexto = ttAlfanumerico
        end
        object edtMacAdd: TEditFocus
          Tag = 99
          Left = 291
          Top = 23
          Width = 365
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = clBtnFace
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          ReadOnly = True
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttAlfanumerico
        end
        object cmbPortaComTef: TComboBoxFocus
          Left = 11
          Top = 103
          Width = 145
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 3
          Visible = False
          OnClick = cmbPortaComTefClick
          Items.Strings = (
            ''
            'AUTO'
            'COM1'
            'COM2'
            'COM3'
            'COM4'
            'COM5'
            'COM6'
            'COM7'
            'COM8'
            'COM9'
            'COM10'
            'COM11'
            'COM12'
            'COM13'
            'COM14'
            'COM15'
            'COM16'
            'COM17'
            'COM18'
            'COM19'
            'COM20')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object edtTerminalSales: TEditFocus
          Tag = 99
          Left = 382
          Top = 23
          Width = 365
          Height = 22
          Alignment = taLeftJustify
          Color = clBtnFace
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 32
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 32
          TipoTexto = ttAlfanumerico
        end
        object rgOpcaoSales: TRadioGroup
          Left = 291
          Top = 91
          Width = 184
          Height = 37
          Caption = 'Tipo Terminal Citel Sales'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'M-Sitef'
            'Rede Flex')
          TabOrder = 14
          Visible = False
          OnClick = rgOpcaoSalesClick
        end
        object edtTokenMsitef: TEditFocus
          Tag = 99
          Left = 395
          Top = 63
          Width = 206
          Height = 22
          Alignment = taLeftJustify
          Color = clBtnFace
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 128
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 128
          TipoTexto = ttAlfanumerico
        end
        object cmbAdquirente: TComboBoxFocus
          Left = 508
          Top = 103
          Width = 147
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 15
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object tsPinPad: TTabSheet
        Caption = 'PIN Pad'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label4: TLabel
          Left = 11
          Top = 8
          Width = 108
          Height = 14
          Caption = 'Porta de Comunica'#231#227'o'
        end
        object Label5: TLabel
          Left = 11
          Top = 48
          Width = 125
          Height = 14
          Caption = 'DLL Comunica'#231#227'o Pin Pad'
        end
        object lbAvisoPinPad: TLabel
          Left = 11
          Top = 91
          Width = 335
          Height = 19
          Caption = 'Configura'#231#227'o para acesso direto ao Pin Pad'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object lbAvisoPinPad2: TLabel
          Left = 11
          Top = 113
          Width = 604
          Height = 19
          Caption = 
            'Para configurar a porta do Pin Pad do Tef continue usando o arqu' +
            'ivo ClisiTef.ini'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object cbPortaPinPad: TComboBoxFocus
          Left = 11
          Top = 23
          Width = 174
          Height = 22
          Style = csOwnerDrawFixed
          TabOrder = 0
          OnClick = cbPortaPinPadClick
          Items.Strings = (
            ' '
            'COM1'
            'COM2'
            'COM3'
            'COM4'
            'COM5'
            'COM6'
            'COM7'
            'COM8'
            'COM9'
            'COM10'
            'COM11'
            'COM12'
            'COM13'
            'COM14'
            'COM15'
            'COM16'
            'COM17'
            'COM18'
            'COM19'
            'COM20')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object cbFabricantePinPad: TComboBoxFocus
          Left = 11
          Top = 63
          Width = 174
          Height = 22
          Style = csOwnerDrawFixed
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
    end
    object btnCopiarNomMaq: TBitBtnLocked
      Left = 245
      Top = 207
      Width = 125
      Height = 26
      Caption = 'Copiar &Legado'
      NumGlyphs = 2
      TabOrder = 8
      Visible = False
      OnClick = btnCopiarNomMaqClick
    end
  end
  object dsTerminaisTef: TDataSource
    DataSet = CdsTerminaisTef
    Left = 696
    Top = 392
  end
  object CdsTerminaisTef: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 640
    Top = 392
    object CdsTerminaisTefAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object CdsTerminaisTefNUMTER: TStringField
      FieldName = 'NUMTER'
      Size = 8
    end
    object CdsTerminaisTefNUMLOJ: TStringField
      FieldName = 'NUMLOJ'
      Size = 8
    end
    object CdsTerminaisTefMACADD: TStringField
      FieldName = 'MACADD'
    end
    object CdsTerminaisTefNOMUSU: TStringField
      FieldName = 'NOMUSU'
      Size = 50
    end
    object CdsTerminaisTefNOMMAQ: TStringField
      FieldName = 'NOMMAQ'
    end
    object CdsTerminaisTefCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object CdsTerminaisTefNUM_IP: TStringField
      FieldName = 'NUM_IP'
      Size = 30
    end
    object CdsTerminaisTefPATIMP: TStringField
      FieldName = 'PATIMP'
      Size = 200
    end
    object CdsTerminaisTefLOC_IP: TStringField
      FieldName = 'LOC_IP'
      Size = 30
    end
    object CdsTerminaisTefEMPTIP: TStringField
      FieldName = 'EMPTIP'
      Size = 3
    end
    object CdsTerminaisTefPINPOR: TStringField
      FieldName = 'PINPOR'
      Size = 6
    end
    object CdsTerminaisTefPINFAB: TStringField
      FieldName = 'PINFAB'
      Size = 35
    end
    object CdsTerminaisTefCOMTEF: TStringField
      FieldName = 'COMTEF'
      Size = 5
    end
    object CdsTerminaisTefTSALES: TStringField
      FieldName = 'TSALES'
      Size = 32
    end
    object CdsTerminaisTefTKSALE: TStringField
      FieldName = 'TKSALE'
      Size = 128
    end
    object CdsTerminaisTefTIPTEF: TStringField
      FieldName = 'TIPTEF'
      Size = 1
    end
    object CdsTerminaisTefADQUIR: TStringField
      FieldName = 'ADQUIR'
    end
  end
end
