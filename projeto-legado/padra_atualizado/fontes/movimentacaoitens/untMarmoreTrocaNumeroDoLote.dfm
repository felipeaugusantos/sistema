inherited frmMarmoreTrocaNumeroDoLote: TfrmMarmoreTrocaNumeroDoLote
  Width = 370
  Height = 130
  Caption = 'Troca N'#250'mero do Lote'
  Position = poMainFormCenter
  ExplicitWidth = 370
  ExplicitHeight = 130
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 8
    Top = 7
    Width = 60
    Height = 14
    Caption = 'Lote Original'
  end
  object Label2: TLabel [1]
    Left = 17
    Top = 31
    Width = 49
    Height = 14
    Caption = 'Novo Lote'
  end
  object btnTrocar: TSpeedButton [2]
    Left = 267
    Top = 29
    Width = 89
    Height = 22
    Caption = '&Trocar'
    OnClick = btnTrocarClick
  end
  inherited pnlBotoes: TPanel
    Top = 57
    Width = 364
    ExplicitTop = 57
    ExplicitWidth = 364
    inherited FlwBotoes: TFlowPanel
      Width = 360
      ExplicitWidth = 360
    end
    inherited btnSair: TBitBtnLocked
      Left = 281
      ExplicitLeft = 281
    end
  end
  inherited pnlStatus: TPanel
    Top = 85
    Width = 364
    ExplicitTop = 85
    ExplicitWidth = 364
    inherited pnlNomeForm: TPanel
      Left = 193
      ExplicitLeft = 193
    end
    inherited pnlInfo: TPanel
      Width = 193
      ExplicitWidth = 193
    end
  end
  object edtLoteOriginal: TEditFocus [5]
    Left = 71
    Top = 4
    Width = 194
    Height = 22
    Alignment = taLeftJustify
    Enabled = False
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtLoteNovo: TEditFocus [6]
    Left = 71
    Top = 28
    Width = 194
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    MaxLength = 30
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object DataSource1: TDataSource
    Left = 144
    Top = 52
  end
end
