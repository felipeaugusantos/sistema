inherited frmRedeCardMemoInfoImportacao: TfrmRedeCardMemoInfoImportacao
  Width = 870
  Height = 487
  Caption = ''
  Position = poScreenCenter
  ExplicitWidth = 870
  ExplicitHeight = 487
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 414
    Width = 864
    TabOrder = 1
    ExplicitTop = 414
    ExplicitWidth = 864
    inherited FlwBotoes: TFlowPanel
      Width = 860
      ExplicitWidth = 860
    end
    inherited btnSair: TBitBtnLocked
      Left = 784
      ExplicitLeft = 784
    end
  end
  inherited pnlStatus: TPanel
    Top = 442
    Width = 864
    TabOrder = 2
    ExplicitTop = 442
    ExplicitWidth = 864
    inherited pnlNomeForm: TPanel
      Left = 693
      ExplicitLeft = 693
    end
    inherited pnlInfo: TPanel
      Width = 693
      ExplicitWidth = 693
    end
  end
  object edtInfo: TcxMemo [2]
    Left = 0
    Top = 41
    Align = alClient
    ParentFont = False
    Properties.ReadOnly = True
    Properties.ScrollBars = ssVertical
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clBlack
    Style.Font.Height = -15
    Style.Font.Name = 'Arial'
    Style.Font.Pitch = fpVariable
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 0
    Height = 373
    Width = 864
  end
  object pnlTitulo: TPanel [3]
    Left = 0
    Top = 0
    Width = 864
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblTitulo: TLabel
      Left = 0
      Top = 0
      Width = 864
      Height = 41
      Align = alClient
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      StyleElements = [seClient, seBorder]
      ExplicitWidth = 3
      ExplicitHeight = 14
    end
  end
end
