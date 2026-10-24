inherited frmDetalheHistoricos: TfrmDetalheHistoricos
  Width = 422
  Height = 184
  BorderIcons = [biSystemMenu]
  Caption = 'Hist'#243'rico da Baixa'
  Position = poMainFormCenter
  ExplicitWidth = 422
  ExplicitHeight = 184
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 111
    Width = 416
    Visible = False
    ExplicitTop = 134
    ExplicitWidth = 435
    inherited FlwBotoes: TFlowPanel
      Width = 412
      ExplicitWidth = 431
    end
    inherited btnSair: TBitBtnLocked
      Left = 333
      ExplicitLeft = 352
    end
  end
  inherited pnlStatus: TPanel
    Top = 139
    Width = 416
    ExplicitTop = 162
    ExplicitWidth = 435
    inherited pnlNomeForm: TPanel
      Left = 245
      ExplicitLeft = 264
    end
    inherited pnlInfo: TPanel
      Width = 245
      ExplicitWidth = 264
    end
  end
  object pnlHistorico: TPanel [3]
    Left = 0
    Top = 0
    Width = 416
    Height = 111
    Align = alClient
    Color = 16770261
    ParentBackground = False
    ShowCaption = False
    TabOrder = 3
    ExplicitWidth = 435
    ExplicitHeight = 134
    object mmoHistorico: TMemoFocus
      Left = 1
      Top = 1
      Width = 414
      Height = 109
      Align = alClient
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      OnKeyDown = mmoHistoricoKeyDown
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
      ExplicitWidth = 433
      ExplicitHeight = 132
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 252
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 136
    Top = 96
  end
end
