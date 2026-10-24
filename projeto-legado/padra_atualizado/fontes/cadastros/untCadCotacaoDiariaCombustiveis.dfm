inherited frmCadCotacaoDiariaCombustiveis: TfrmCadCotacaoDiariaCombustiveis
  Width = 521
  Height = 276
  Caption = 'Cota'#231#227'o Di'#225'ria de Combust'#237'veis'
  OnDestroy = FormDestroy
  ExplicitWidth = 521
  ExplicitHeight = 276
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 203
    Width = 515
    ExplicitTop = 203
    ExplicitWidth = 515
    inherited FlwBotoes: TFlowPanel
      Width = 511
      ExplicitTop = 2
      ExplicitWidth = 511
    end
    inherited btnSair: TBitBtnLocked
      Left = 434
      ExplicitLeft = 434
    end
  end
  inherited pnlStatus: TPanel
    Top = 231
    Width = 515
    ExplicitTop = 231
    ExplicitWidth = 515
    inherited pnlNomeForm: TPanel
      Left = 168
      ExplicitLeft = 168
    end
    inherited pnlInfo: TPanel
      Width = 168
      ExplicitWidth = 168
    end
  end
  inherited pgcDados: TPageControl
    Width = 515
    Height = 203
    ExplicitWidth = 515
    ExplicitHeight = 203
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 507
      ExplicitHeight = 171
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 515
    Height = 203
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 511
      Height = 45
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 0
      object Label1: TLabel
        Left = 15
        Top = 19
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data:'
      end
      object dbeDtaCot: TDBEditFocus
        Tag = 99
        Left = 49
        Top = 12
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CMB_DTACOT'
        DataSource = dtsCadCmb
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 47
      Width = 511
      Height = 154
      Align = alClient
      BevelOuter = bvNone
      Color = 16770261
      TabOrder = 1
      object Label4: TLabel
        Left = 15
        Top = 45
        Width = 42
        Height = 14
        Caption = 'Gasolina'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 15
        Top = 71
        Width = 29
        Height = 14
        Caption = 'Etanol'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 15
        Top = 124
        Width = 51
        Height = 14
        Caption = 'Diesel S10'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 15
        Top = 97
        Width = 29
        Height = 14
        Caption = 'Diesel'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 15
        Top = 12
        Width = 81
        Height = 14
        Caption = 'COMBUST'#205'VEIS'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 118
        Top = 12
        Width = 50
        Height = 14
        Caption = 'VALORES'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbeVlrGas: TDBEditFocus
        Tag = 99
        Left = 118
        Top = 37
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CMB_VLRGAS'
        DataSource = dtsCadCmb
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeVlrEta: TDBEditFocus
        Tag = 99
        Left = 118
        Top = 65
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CMB_VLRETA'
        DataSource = dtsCadCmb
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeVlrS10: TDBEditFocus
        Tag = 99
        Left = 118
        Top = 118
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CMB_VLRS10'
        DataSource = dtsCadCmb
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeVlrDie: TDBEditFocus
        Tag = 99
        Left = 118
        Top = 91
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CMB_VLRDIE'
        DataSource = dtsCadCmb
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 152
  end
  object dtsCadCmb: TDataSource
    Left = 352
    Top = 88
  end
end
