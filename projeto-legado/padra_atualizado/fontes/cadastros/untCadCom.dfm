inherited frmCadCom: TfrmCadCom
  Left = 326
  Top = 371
  Width = 535
  Height = 189
  Caption = 'Cadastro de Faixas de Comiss'#227'o'
  ExplicitWidth = 535
  ExplicitHeight = 189
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 119
    Width = 529
    Height = 25
    TabOrder = 2
    ExplicitTop = 119
    ExplicitWidth = 529
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 525
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 525
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 455
      Width = 72
      Height = 21
      Align = alRight
      ExplicitLeft = 455
      ExplicitWidth = 72
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 529
    Height = 119
    TabOrder = 0
    ExplicitWidth = 529
    ExplicitHeight = 116
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 521
      ExplicitHeight = 84
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 529
    Height = 119
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 1
    ExplicitHeight = 116
    object pnlTopo: TPanel
      Left = 2
      Top = 2
      Width = 525
      Height = 39
      Align = alTop
      Color = 16770261
      TabOrder = 0
      object lblCodigo: TLabel
        Left = 21
        Top = 13
        Width = 36
        Height = 14
        Caption = 'C'#243'digo:'
      end
      object lblDescricao: TLabel
        Left = 128
        Top = 13
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 59
        Top = 9
        Width = 59
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_CODCOM'
        DataSource = dtsCadCom
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
        Left = 182
        Top = 9
        Width = 331
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_DESCOM'
        DataSource = dtsCadCom
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlComissoes: TPanel
      Left = 2
      Top = 72
      Width = 525
      Height = 45
      Align = alClient
      Color = 16770261
      TabOrder = 2
      ExplicitHeight = 42
      object Label1: TLabel
        Left = 17
        Top = 13
        Width = 40
        Height = 14
        Caption = '% Inicio:'
      end
      object Label2: TLabel
        Left = 125
        Top = 13
        Width = 32
        Height = 14
        Caption = '% Fim:'
      end
      object Label3: TLabel
        Left = 371
        Top = 13
        Width = 80
        Height = 14
        Caption = '% Com. a prazo:'
      end
      object lbl2: TLabel
        Left = 228
        Top = 13
        Width = 75
        Height = 14
        Caption = '% Com. a vista:'
      end
      object dbePerIni: TDBEditFocus
        Tag = 99
        Left = 59
        Top = 9
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_PERINI'
        DataSource = dtsCadCom
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbePerFin: TDBEditFocus
        Tag = 99
        Left = 159
        Top = 9
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_PERFIN'
        DataSource = dtsCadCom
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeComPra: TDBEditFocus
        Tag = 99
        Left = 453
        Top = 9
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_PERCOP'
        DataSource = dtsCadCom
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeComVis: TDBEditFocus
        Tag = 99
        Left = 305
        Top = 9
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'COM_PERCOM'
        DataSource = dtsCadCom
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlTipVen: TPanel
      Left = 2
      Top = 41
      Width = 525
      Height = 31
      Align = alTop
      Color = 16770261
      TabOrder = 1
      object lbl1: TLabel
        Left = 6
        Top = 9
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tip. Vend.:'
      end
      object dbeTipVen: TDBLookupComboBoxFocus
        Tag = 99
        Left = 59
        Top = 5
        Width = 190
        Height = 22
        DataField = 'COM_TIPVEN'
        DataSource = dtsCadCom
        KeyField = 'CodTip'
        ListField = 'DesTip'
        ListSource = dtsListTipVen
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 144
    Width = 529
    TabOrder = 3
    ExplicitTop = 144
    ExplicitWidth = 529
    inherited pnlNomeForm: TPanel
      Left = 344
      Width = 185
      TabOrder = 1
      ExplicitLeft = 344
      ExplicitWidth = 185
    end
    inherited pnlInfo: TPanel
      Width = 344
      TabOrder = 0
      ExplicitWidth = 182
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 8
  end
  object dtsCadCom: TDataSource
    Left = 376
    Top = 8
  end
  object dtsListTipVen: TDataSource
    DataSet = cdsListTipVen
    Left = 248
    Top = 45
  end
  object cdsListTipVen: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 45
    object cdsListTipVenTipVen: TStringField
      FieldName = 'CodTip'
      Size = 1
    end
    object cdsListTipVenDesTip: TStringField
      FieldName = 'DesTip'
      Size = 30
    end
  end
end
