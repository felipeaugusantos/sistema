inherited frmCadGruOperadorNovo: TfrmCadGruOperadorNovo
  Width = 680
  Height = 373
  Caption = 'Cadastro de Grupo de Usu'#225'rio'
  ExplicitWidth = 680
  ExplicitHeight = 373
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 303
    Width = 674
    Height = 25
    TabOrder = 2
    ExplicitTop = 303
    ExplicitWidth = 674
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 600
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 670
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 76
        Height = 21
        Spacing = 2
        ExplicitWidth = 76
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 76
        Width = 77
        Height = 21
        Spacing = 2
        ExplicitLeft = 76
        ExplicitWidth = 77
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 153
        Width = 77
        Height = 21
        Spacing = 2
        ExplicitLeft = 153
        ExplicitWidth = 77
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 230
        Width = 93
        Height = 21
        Caption = '&Excluir Grupo'
        Spacing = 2
        ExplicitLeft = 230
        ExplicitWidth = 93
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 323
        Width = 78
        Height = 21
        Spacing = 2
        ExplicitLeft = 323
        ExplicitWidth = 78
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 401
        Width = 78
        Height = 21
        Spacing = 2
        ExplicitLeft = 401
        ExplicitWidth = 78
        ExplicitHeight = 21
      end
      object btnExcluirOperador: TBitBtnLocked
        Left = 479
        Top = 0
        Width = 109
        Height = 21
        Hint = 'Remove Operador do Grupo'
        Caption = 'Excluir &Operador'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF9632099932089932089C32099C32099C32099C31079C
          30079A3309983309FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF953209973106
          C23B13ED4631F65039F75F41F7664CF75542EE4630B23A18953108FF00FFFF00
          FFFF00FFFF00FFFF00FF9332099A3108CF3D19F3573DFB734EFA6541FBAD9CFA
          B7B0EF452EBF3D2195330BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9E320B
          DC4725FE7552FF7048FF7757FFE9E5FFE9E5F46447B1391A92320BFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF9A340DCC4C28FC7042F2663FD4A195E1F3F2FE
          CCBBFF7752C14B27923009FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          DE52237A2F2830235316296D213270533B52CE512AC14819FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0D1E7D00229803228C011C8700
          1374181B64FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          000A290A3EBB0D3BAA0D3CAA0D3AA90C3AAA012297FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF000000092766145CEF104ECC0F49C10F47BF11
          4DC50F43B5FF00FF0000BE0000BEFF00FF0000BE0000BEFF00FFFF00FF000000
          07275A145BCE114AAB0F48BB0E41B21357D01354D0FF00FF0000BE0000BE0000
          BE0000BE0000BEFF00FFFF00FF0101010507080003070A2D571D7DEE1A70ED1C
          7AF6155FE7FF00FFFF00FF0000BE0000BE0000BEFF00FFFF00FFFF00FF242220
          242220221E18071F3A1673C9208BEF1E86E90D36A4FF00FF0000BE0000BE0000
          BE0000BE0000BEFF00FFFF00FFFF00FF2725235A5959514E4C2529320A172807
          1120FF00FFFF00FF0000BE0000BEFF00FF0000BE0000BEFF00FFFF00FFFF00FF
          FF00FF7877757877756B655F1F1A16FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentShowHint = False
        ShowHint = True
        Spacing = 2
        TabOrder = 6
        OnClick = btnExcluirOperadorClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 602
      Width = 70
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 593
      ExplicitWidth = 70
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 674
    Height = 303
    TabOrder = 1
    ExplicitWidth = 674
    ExplicitHeight = 303
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 666
      ExplicitHeight = 271
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 674
    Height = 303
    Align = alClient
    ParentColor = True
    TabOrder = 3
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 672
      Height = 79
      Align = alTop
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      object Label3: TLabel
        Left = 32
        Top = 19
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object lblDescricao: TLabel
        Left = 16
        Top = 46
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object dbeCodGpo: TDBEditFocus
        Tag = 99
        Left = 70
        Top = 15
        Width = 57
        Height = 22
        DataField = 'GPO_CODGPO'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 70
        Top = 43
        Width = 427
        Height = 22
        CharCase = ecUpperCase
        DataField = 'GPO_DESCRI'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 50
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clPurple
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlOperadores: TPanel
      Left = 1
      Top = 80
      Width = 672
      Height = 222
      Align = alClient
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
      object Label1: TLabel
        Left = 19
        Top = 20
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador:'
      end
      object cxgOpeGpo: TcxGrid
        Left = 1
        Top = 59
        Width = 670
        Height = 162
        Align = alBottom
        Enabled = False
        TabOrder = 2
        TabStop = False
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgOpeGpoDBTableView1: TcxGridDBTableView
          OnKeyDown = cxgOpeGpoDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsOpeGpo
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxsWhite
          Styles.ContentOdd = cxsGreen
          object cxgOpeGpoDBTableView1Column1: TcxGridDBColumn
            Caption = 'Login'
            DataBinding.FieldName = 'OPE_CODOPE'
            Width = 69
          end
          object cxgOpeGpoDBTableView1Column2: TcxGridDBColumn
            Caption = 'Nome do Operador'
            DataBinding.FieldName = 'OPE_NOMOPE'
            Width = 426
          end
        end
        object cxgOpeGpoLevel1: TcxGridLevel
          GridView = cxgOpeGpoDBTableView1
        end
      end
      object edtDesVendedor: TEditFocus
        Left = 146
        Top = 16
        Width = 351
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodVendedor: TEditFocus
        Tag = 99
        Left = 70
        Top = 16
        Width = 75
        Height = 22
        HelpType = htKeyword
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodVendedorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 328
    Width = 674
    TabOrder = 0
    ExplicitTop = 328
    ExplicitWidth = 674
    inherited pnlNomeForm: TPanel
      Left = 485
      Width = 189
      ExplicitLeft = 485
      ExplicitWidth = 189
    end
    inherited pnlInfo: TPanel
      Width = 485
      ExplicitWidth = 485
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 264
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 264
  end
  object dtsOpeGpo: TDataSource
    DataSet = cdsOpeGpo
    Left = 280
    Top = 232
  end
  object cdsOpeGpo: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspOpeGpo'
    Left = 248
    Top = 232
  end
  object dspOpeGpo: TUniDataSetProvider
    Options = []
    Left = 216
    Top = 232
  end
  object dtsTabela: TDataSource
    Left = 376
    Top = 8
  end
  object cxStyleRepository: TcxStyleRepository
    PixelsPerInch = 96
    object cxsWhite: TcxStyle
      AssignedValues = [svColor]
      Color = clWhite
    end
    object cxsGreen: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
