inherited frmRomaneioLoteSeparacaoBusca: TfrmRomaneioLoteSeparacaoBusca
  Left = 203
  Top = 293
  Width = 227
  Height = 113
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poMainFormCenter
  ExplicitWidth = 227
  ExplicitHeight = 113
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 221
    TabOrder = 3
    ExplicitTop = 69
    ExplicitWidth = 221
  end
  inherited pgcDados: TPageControl
    Top = 304
    Width = 65
    Height = 33
    Align = alNone
    TabOrder = 1
    Visible = False
    ExplicitTop = 304
    ExplicitWidth = 65
    ExplicitHeight = 33
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 57
      ExplicitHeight = 1
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 221
    Height = 69
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 0
    object lblDocum: TLabel
      Left = 8
      Top = 15
      Width = 74
      Height = 14
      AutoSize = False
      Caption = 'N'#186' Documento'
    end
    object Label1: TLabel
      Left = 157
      Top = 15
      Width = 39
      Height = 14
      AutoSize = False
      Caption = 'Esp'#233'cie'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 8
      Top = 28
      Width = 144
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 157
      Top = 28
      Width = 38
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 7
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 69
    Width = 221
    TabOrder = 2
    ExplicitTop = 69
    ExplicitWidth = 221
    inherited pnlNomeForm: TPanel
      Left = 50
      ExplicitLeft = 50
    end
    inherited pnlInfo: TPanel
      Width = 50
      ExplicitWidth = 50
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 77
    Top = 53
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 45
    Top = 53
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 13
    Top = 53
  end
end
