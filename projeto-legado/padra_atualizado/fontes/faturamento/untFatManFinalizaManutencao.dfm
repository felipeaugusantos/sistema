inherited frmFatManFinalizaManutencao: TfrmFatManFinalizaManutencao
  Width = 439
  Height = 141
  Caption = 'Finalizar Manuten'#231#227'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 439
  ExplicitHeight = 141
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 70
    Width = 433
    ExplicitTop = 70
    ExplicitWidth = 433
    inherited FlwBotoes: TFlowPanel
      Width = 429
      ExplicitWidth = 429
    end
    inherited btnSair: TBitBtnLocked
      Left = 350
      ExplicitLeft = 350
    end
  end
  inherited pnlStatus: TPanel
    Top = 96
    Width = 433
    ExplicitTop = 96
    ExplicitWidth = 433
    inherited pnlNomeForm: TPanel
      Left = 262
      ExplicitLeft = 262
    end
    inherited pnlInfo: TPanel
      Width = 262
      ExplicitWidth = 262
    end
  end
  object pnlDigitador: TPanel [2]
    Left = 0
    Top = 0
    Width = 433
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      433
      35)
    object lblDigita: TLabel
      Left = 41
      Top = 9
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object edtNomOpe: TEditFocus
      Left = 135
      Top = 6
      Width = 280
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodOpe: TEditFocus
      Tag = 99
      Left = 89
      Top = 6
      Width = 45
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDtaManutencao: TPanel [3]
    Left = 0
    Top = 35
    Width = 433
    Height = 35
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 7
      Width = 82
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Finaliza'#231#227'o:'
    end
    object mskFinMan: TMaskEditFocus
      Tag = 99
      Left = 89
      Top = 4
      Width = 77
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 240
    Top = 0
  end
end
