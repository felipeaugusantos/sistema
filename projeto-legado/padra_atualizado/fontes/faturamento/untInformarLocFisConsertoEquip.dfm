inherited frmInformarLocFisConsertoEquip: TfrmInformarLocFisConsertoEquip
  Width = 443
  Height = 112
  Caption = 'Localiza'#231#227'o F'#237'sica do Equipamento'
  ExplicitWidth = 443
  ExplicitHeight = 112
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 41
    Width = 437
    inherited FlwBotoes: TFlowPanel
      Width = 433
    end
    inherited btnSair: TBitBtnLocked
      Left = 354
    end
  end
  inherited pnlStatus: TPanel
    Top = 67
    Width = 437
    inherited pnlNomeForm: TPanel
      Left = 266
    end
    inherited pnlInfo: TPanel
      Width = 266
    end
  end
  object pnlLocFis: TPanel [2]
    Left = 0
    Top = 0
    Width = 437
    Height = 41
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlLocFis'
    TabOrder = 2
    ExplicitWidth = 483
    ExplicitHeight = 40
    object lblLocFis: TLabel
      Left = 12
      Top = 12
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Loc. F'#237'sica:'
    end
    object edtLocFis: TEditFocus
      Left = 69
      Top = 9
      Width = 345
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = clWhite
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesLoc: TEditFocus
      Left = 119
      Top = 9
      Width = 295
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodLoc: TEditFocus
      Tag = 99
      Left = 69
      Top = 9
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = clWhite
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 2
      OnKeyPress = edtCodLocKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 320
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 0
  end
end
