inherited frmInfAdicionaisICMS: TfrmInfAdicionaisICMS
  Width = 1024
  Height = 673
  Caption = 'Informa'#231#245'es Adcionais ICMS'
  Position = poMainFormCenter
  ExplicitWidth = 1024
  ExplicitHeight = 673
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter2: TSplitter [0]
    Left = 0
    Top = 192
    Width = 1018
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 192
  end
  object Splitter1: TSplitter [1]
    Left = 0
    Top = 381
    Width = 1018
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 1
    ExplicitTop = 15
    ExplicitWidth = 176
  end
  inherited pnlBotoes: TPanel
    Top = 600
    Width = 1018
    ExplicitTop = 600
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 938
      ExplicitLeft = 938
    end
  end
  inherited pnlStatus: TPanel
    Top = 628
    Width = 1018
    ExplicitTop = 628
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlConvenio: TPanel [4]
    Left = 0
    Top = 195
    Width = 1018
    Height = 186
    Align = alClient
    TabOrder = 2
    ExplicitTop = 197
    ExplicitHeight = 192
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 1016
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'Conv'#234'nio'
      ExplicitWidth = 45
    end
    object memConvenio: TMemo
      Left = 1
      Top = 15
      Width = 1016
      Height = 170
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object pnlAmparoLegal: TPanel [5]
    Left = 0
    Top = 0
    Width = 1018
    Height = 192
    Align = alTop
    TabOrder = 3
    ExplicitTop = 408
    object Label4: TLabel
      Left = 1
      Top = 1
      Width = 1016
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'Amparo Legal: '
      ExplicitWidth = 73
    end
    object memAmparoLegal: TMemo
      Left = 1
      Top = 15
      Width = 1016
      Height = 176
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object pnlProtocolo: TPanel [6]
    Left = 0
    Top = 384
    Width = 1018
    Height = 216
    Align = alBottom
    TabOrder = 4
    ExplicitTop = 192
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 1016
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'Protocolo:'
      ExplicitWidth = 48
    end
    object memprotocolo: TMemo
      Left = 1
      Top = 15
      Width = 1016
      Height = 200
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
