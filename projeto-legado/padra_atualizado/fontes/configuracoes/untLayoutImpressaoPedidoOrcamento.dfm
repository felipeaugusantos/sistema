inherited frmLayoutImpressaoPedidoOrcamento: TfrmLayoutImpressaoPedidoOrcamento
  Caption = 'frmLayoutImpressaoPedidoOrcamento'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    inherited FlwBotoes: TFlowPanel
      ExplicitWidth = 765
    end
  end
  inherited pgcDados: TPageControl
    Top = 175
    Height = 285
    ExplicitHeight = 460
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 428
    end
  end
  inherited pnlStatus: TPanel
    ExplicitTop = 460
    inherited pnlInfo: TPanel
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 769
    Height = 175
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    ExplicitLeft = 1
    ExplicitTop = -6
    object lblCodigo: TLabel
      Left = 24
      Top = 39
      Width = 98
      Height = 14
      Caption = 'C'#243'digo editor layout:'
    end
    object Label2: TLabel
      Left = 70
      Top = 16
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 7
      Top = 61
      Width = 115
      Height = 14
      Alignment = taRightJustify
      Caption = 'Condi'#231#227'o Where (SQL):'
    end
    object btnInserir: TBitBtnLocked
      Left = 608
      Top = 140
      Width = 75
      Height = 25
      Caption = '&Inserir'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnInserirClick
    end
    object edtDescri: TEditFocus
      Tag = 99
      Left = 125
      Top = 10
      Width = 477
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 255
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 255
      TipoTexto = ttAlfanumerico
    end
    object memWhere: TMemo
      Tag = 99
      Left = 125
      Top = 56
      Width = 477
      Height = 109
      TabOrder = 2
      OnEnter = memWhereEnter
      OnKeyPress = memWhereKeyPress
    end
    object edtCodLay: TEditFocus
      Tag = 99
      Left = 125
      Top = 33
      Width = 477
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 6
      TabOrder = 1
      OnExit = edtCodLayExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 6
      TipoTexto = ttNumerico
    end
  end
  object grdLayImp: TDBGridCitel [5]
    Left = 0
    Top = 175
    Width = 769
    Height = 285
    Align = alClient
    DataSource = dtsLayImp
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDblClick = grdLayImpDblClick
    OnKeyDown = grdLayImpKeyDown
    CorZebra = clMoneyGreen
    Zebra = True
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DOR_CODLAY'
        Title.Caption = 'C'#243'd. Layout'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DOR_DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 650
        Visible = True
      end>
  end
  object cdsLayImp: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 544
    Top = 224
  end
  object dspLayImp: TUniDataSetProvider
    Options = []
    Left = 472
    Top = 224
  end
  object dtsLayImp: TDataSource
    Left = 384
    Top = 232
  end
  object UniQuery1: TUniQuery
    Constraints = <>
    Left = 384
    Top = 360
  end
end
