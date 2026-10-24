inherited frmExpBuscaChaveNFe: TfrmExpBuscaChaveNFe
  Width = 529
  Height = 137
  Caption = 'Busca por Chave de Acesso'
  ExplicitWidth = 529
  ExplicitHeight = 137
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 8
    Top = 22
    Width = 122
    Height = 18
    Caption = 'Chave de Acesso'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 68
    Width = 523
    ExplicitTop = 68
    ExplicitWidth = 523
    inherited btnSair: TBitBtnLocked
      Left = 440
      ExplicitLeft = 440
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 5
      ExplicitLeft = 5
    end
  end
  inherited pnlStatus: TPanel
    Top = 96
    Width = 523
    ExplicitTop = 96
    ExplicitWidth = 523
    inherited pnlNomeForm: TPanel
      Left = 352
      ExplicitLeft = 352
    end
    inherited pnlInfo: TPanel
      Width = 352
      ExplicitWidth = 352
    end
  end
  object edtChave: TEditFocus [3]
    Left = 136
    Top = 19
    Width = 370
    Height = 26
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    MaxLength = 44
    ParentFont = False
    TabOrder = 2
    OnChange = edtChaveChange
    OnKeyPress = edtChaveKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 44
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 48
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 168
    Top = 48
  end
end
