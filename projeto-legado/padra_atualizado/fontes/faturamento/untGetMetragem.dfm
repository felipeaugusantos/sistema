inherited frmGetMetragem: TfrmGetMetragem
  Left = 0
  Top = 0
  Width = 652
  Height = 84
  BorderIcons = [biSystemMenu]
  Caption = 'Metragem'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  Position = poMainFormCenter
  ExplicitWidth = 652
  ExplicitHeight = 84
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 56
    Width = 646
    ExplicitTop = 54
    ExplicitWidth = 652
  end
  inherited pgcDados: TPageControl
    Width = 646
    Height = 56
    TabOrder = 3
    ExplicitWidth = 652
    ExplicitHeight = 54
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 27
      ExplicitWidth = 644
      ExplicitHeight = 23
    end
  end
  object pnlQtdMadeira: TPanel [3]
    Left = 0
    Top = 0
    Width = 646
    Height = 56
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BorderWidth = 5
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    ExplicitWidth = 652
    ExplicitHeight = 54
    object lblComPec: TLabel
      Left = 149
      Top = 21
      Width = 49
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Comprim.:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblLarPec: TLabel
      Left = 266
      Top = 21
      Width = 49
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Largura:'
    end
    object lblEspPec: TLabel
      Left = 381
      Top = 21
      Width = 53
      Height = 13
      Alignment = taRightJustify
      Caption = 'Espessura:'
    end
    object lblQtdMadeira: TLabel
      Left = 14
      Top = 21
      Width = 57
      Height = 13
      Alignment = taRightJustify
      Caption = 'Qtd. Pe'#231'as:'
    end
    object Label1: TLabel
      Left = 526
      Top = 21
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object edtComPec: TEditFocus
      Tag = 99
      Left = 200
      Top = 16
      Width = 58
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtLarPec: TEditFocus
      Tag = 99
      Left = 316
      Top = 16
      Width = 58
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtEspPec: TEditFocus
      Tag = 99
      Left = 437
      Top = 16
      Width = 74
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdPec: TEditFocus
      Tag = 99
      Left = 73
      Top = 16
      Width = 65
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValTot: TEditFocus
      Tag = 99
      Left = 557
      Top = 16
      Width = 74
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = clMoneyGreen
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  inherited pnlStatus: TPanel
    Top = 56
    Width = 646
    Height = 0
    Visible = False
    ExplicitTop = 54
    ExplicitWidth = 652
    ExplicitHeight = 0
    inherited pnlNomeForm: TPanel
      Left = 475
      Height = 0
      ExplicitLeft = 481
      ExplicitHeight = 0
    end
    inherited pnlInfo: TPanel
      Width = 475
      Height = 0
      ExplicitWidth = 481
      ExplicitHeight = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 48
  end
end
