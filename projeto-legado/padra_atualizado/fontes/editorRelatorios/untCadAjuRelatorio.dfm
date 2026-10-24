inherited frmCadAjuRelatorio: TfrmCadAjuRelatorio
  Width = 656
  Height = 255
  Caption = 'Cadastro de Ajuda do Relat'#243'rio'
  ExplicitWidth = 656
  ExplicitHeight = 255
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 185
    Width = 650
    Height = 25
    ExplicitTop = 185
    ExplicitWidth = 650
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 646
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 646
      ExplicitHeight = 21
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 570
      Height = 20
      ExplicitLeft = 570
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 210
    Width = 650
    ExplicitTop = 210
    ExplicitWidth = 650
    inherited pnlNomeForm: TPanel
      Left = 303
      ExplicitLeft = 303
    end
    inherited pnlInfo: TPanel
      Width = 303
      ExplicitWidth = 303
    end
  end
  inherited pgcDados: TPageControl
    Width = 650
    Height = 185
    ExplicitWidth = 650
    ExplicitHeight = 185
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 642
      ExplicitHeight = 153
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 650
    Height = 185
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 650
      Height = 193
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 0
      object Label1: TLabel
        Left = 26
        Top = 15
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 11
        Top = 39
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object Aba: TLabel
        Left = 198
        Top = 62
        Width = 23
        Height = 14
        Caption = 'Aba:'
      end
      object Label4: TLabel
        Left = 39
        Top = 62
        Width = 23
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo:'
      end
      object Label5: TLabel
        Left = 270
        Top = 62
        Width = 52
        Height = 14
        Caption = 'Nome Aba:'
      end
      object Label3: TLabel
        Left = 13
        Top = 87
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Conte'#250'do:'
      end
      object dbeCodigo: TDBEditFocus
        Tag = 99
        Left = 65
        Top = 11
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REL_CODAJU'
        DataSource = dtsAjuRel
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDescri: TDBEditFocus
        Tag = 99
        Left = 65
        Top = 35
        Width = 568
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REL_DESCRI'
        DataSource = dtsAjuRel
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNumAba: TDBEditFocus
        Tag = 99
        Left = 225
        Top = 59
        Width = 33
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REL_NUMABA'
        DataSource = dtsAjuRel
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDesAba: TDBEditFocus
        Tag = 99
        Left = 328
        Top = 59
        Width = 222
        Height = 22
        CharCase = ecUpperCase
        DataField = 'REL_DESABA'
        DataSource = dtsAjuRel
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeTipAju: TDBComboBoxFocus
        Tag = 99
        Left = 65
        Top = 59
        Width = 120
        Height = 22
        Style = csDropDownList
        DataField = 'REL_TIPAJU'
        DataSource = dtsAjuRel
        Items.Strings = (
          'CAMPOS'
          'F'#211'RMULAS'
          'VARI'#193'VEIS')
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object dbeTxtAju: TMemo
        Left = 65
        Top = 83
        Width = 568
        Height = 78
        TabOrder = 6
      end
      object dbePreAba: TDBCheckBox
        Left = 556
        Top = 62
        Width = 75
        Height = 17
        Caption = 'Fonte pr'#233'?'
        DataField = 'REL_PREABA'
        DataSource = dtsAjuRel
        TabOrder = 5
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 288
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 816
    Top = 272
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 568
    Top = 280
  end
  object dtsAjuRel: TDataSource
    Left = 760
    Top = 176
  end
  object dtsUtiRel: TDataSource
    Left = 952
    Top = 160
  end
  object dtsUtiTem: TDataSource
    Left = 952
    Top = 232
  end
  object dtsUtiIns: TDataSource
    Left = 952
    Top = 304
  end
end
