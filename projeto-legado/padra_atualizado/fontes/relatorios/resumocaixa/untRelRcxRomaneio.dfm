inherited frmRelRcxRomaneio: TfrmRelRcxRomaneio
  Left = 375
  Top = 347
  Width = 301
  Height = 265
  Caption = 'Relat'#243'rio de Romaneio'
  ExplicitWidth = 301
  ExplicitHeight = 265
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 193
    Width = 295
    ExplicitTop = 193
    ExplicitWidth = 295
    inherited btnSair: TBitBtnLocked
      Left = 212
      ExplicitLeft = 212
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 79
      ExplicitLeft = 79
    end
  end
  inherited pnlDados: TPanel
    Width = 295
    Height = 193
    ExplicitWidth = 295
    ExplicitHeight = 193
    object Label12: TLabel [0]
      Left = 14
      Top = 7
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel [1]
      Left = 14
      Top = 49
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [2]
      Left = 14
      Top = 90
      Width = 47
      Height = 14
      Caption = 'Romaneio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDesDtaIni: TLabel [3]
      Left = 105
      Top = 29
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel [4]
      Left = 105
      Top = 72
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 15
      Top = 132
      TabOrder = 3
      ExplicitLeft = 15
      ExplicitTop = 132
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 21
      Width = 86
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 63
      Width = 88
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtRomaneio: TEditFocus
      Tag = 99
      Left = 15
      Top = 104
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtRomaneioKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 221
    Width = 295
    ExplicitTop = 221
    ExplicitWidth = 295
    inherited pnlNomeForm: TPanel
      Left = 124
      ExplicitLeft = 124
    end
    inherited pnlInfo: TPanel
      Width = 124
      ExplicitWidth = 124
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 168
    Top = 120
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 200
    Top = 120
  end
end
