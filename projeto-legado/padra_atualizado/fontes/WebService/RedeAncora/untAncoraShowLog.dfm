inherited frmAncoraShowLog: TfrmAncoraShowLog
  Width = 1017
  Height = 558
  Caption = 'Log de comunica'#231#227'o com a Rede '#194'ncora Service'
  Position = poMainFormCenter
  ExplicitWidth = 1017
  ExplicitHeight = 558
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 485
    Width = 1011
    ExplicitTop = 485
    ExplicitWidth = 1011
    inherited FlwBotoes: TFlowPanel
      Width = 1007
      ExplicitTop = 2
      ExplicitWidth = 1007
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 931
      ExplicitLeft = 931
    end
  end
  inherited pnlStatus: TPanel
    Top = 513
    Width = 1011
    ExplicitTop = 513
    ExplicitWidth = 1011
    inherited pnlNomeForm: TPanel
      Left = 840
      ExplicitLeft = 840
    end
    inherited pnlInfo: TPanel
      Width = 840
      ExplicitWidth = 840
    end
  end
  object mmLog: TMemo [3]
    Left = 0
    Top = 46
    Width = 1011
    Height = 439
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
    WordWrap = False
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 0
    Width = 1011
    Height = 46
    Align = alTop
    TabOrder = 4
    object lblMensagem: TLabel
      Left = 24
      Top = 16
      Width = 557
      Height = 14
      Caption = 
        'Ocorreram erros na comunica'#231#227'o com a Rede '#194'ncora Service. Verifi' +
        'que abaixo o log de comunica'#231#227'o.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
