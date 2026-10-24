inherited frmBaixaInformaOrdProd: TfrmBaixaInformaOrdProd
  Width = 320
  Height = 167
  Caption = 'N'#186' da Ordem de Produ'#231#227'o  Industrial'
  ExplicitWidth = 320
  ExplicitHeight = 167
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 24
    Top = 37
    Width = 68
    Height = 14
    Caption = 'C'#243'digo da OP:'
  end
  inherited pnlBotoes: TPanel
    Top = 96
    Width = 314
    TabOrder = 2
    ExplicitTop = 96
    ExplicitWidth = 314
    inherited FlwBotoes: TFlowPanel
      Width = 310
      ExplicitWidth = 310
    end
    inherited btnSair: TBitBtnLocked
      Left = 234
      ExplicitLeft = 234
    end
  end
  inherited pnlStatus: TPanel
    Top = 122
    Width = 314
    TabOrder = 3
    ExplicitTop = 122
    ExplicitWidth = 314
    inherited pnlNomeForm: TPanel
      Left = 143
      ExplicitLeft = 143
    end
    inherited pnlInfo: TPanel
      Width = 143
      ExplicitWidth = 143
    end
  end
  object edDataOP: TMaskEditFocus [4]
    Tag = 99
    Left = 145
    Top = 32
    Width = 120
    Height = 22
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object edtNumOP: TEditFocus [5]
    Left = 102
    Top = 32
    Width = 41
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 3
    TabOrder = 0
    OnKeyPress = edtNumOPKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 528
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 112
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 408
    Top = 136
  end
end
