inherited frmDigCategoriaArquivo: TfrmDigCategoriaArquivo
  Width = 430
  Height = 159
  Caption = 'Categoria Arquivamento de Documento'
  ExplicitWidth = 430
  ExplicitHeight = 159
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 14
    Top = 21
    Width = 74
    Height = 14
    Caption = 'Nova Categoria'
  end
  inherited pnlBotoes: TPanel
    Top = 87
    Width = 424
    TabOrder = 1
    ExplicitTop = 87
    ExplicitWidth = 424
    inherited btnSair: TBitBtnLocked
      Left = 341
      ExplicitLeft = 341
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 4
      ExplicitLeft = 4
    end
  end
  inherited pnlStatus: TPanel
    Top = 115
    Width = 424
    TabOrder = 2
    ExplicitTop = 115
    ExplicitWidth = 424
    inherited pnlNomeForm: TPanel
      Left = 253
      ExplicitLeft = 253
    end
    inherited pnlInfo: TPanel
      Width = 253
      ExplicitWidth = 253
    end
  end
  object edtCategoria: TEditFocus [4]
    Tag = 99
    Left = 14
    Top = 35
    Width = 390
    Height = 22
    Alignment = taLeftJustify
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 456
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 440
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 16
  end
end
