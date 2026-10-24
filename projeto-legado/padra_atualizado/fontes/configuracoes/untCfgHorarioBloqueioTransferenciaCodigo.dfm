inherited frmCfgHorarioBloqueioTransferenciaCodigo: TfrmCfgHorarioBloqueioTransferenciaCodigo
  Width = 398
  Height = 147
  Caption = 'Transfer'#234'ncia de C'#243'digo - Per'#237'odo que N'#227'o '#233' Permitida Execu'#231#227'o '
  ExplicitWidth = 398
  ExplicitHeight = 147
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 76
    Width = 392
    ExplicitTop = 76
    ExplicitWidth = 392
    inherited FlwBotoes: TFlowPanel
      Width = 388
      ExplicitWidth = 388
    end
    inherited btnSair: TBitBtnLocked
      Left = 312
      ExplicitLeft = 312
    end
  end
  inherited pnlStatus: TPanel
    Top = 102
    Width = 392
    ExplicitTop = 102
    ExplicitWidth = 392
    inherited pnlNomeForm: TPanel
      Left = 221
      ExplicitLeft = 221
    end
    inherited pnlInfo: TPanel
      Width = 221
      ExplicitWidth = 221
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 392
    Height = 76
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 172
      Top = 12
      Width = 77
      Height = 15
      Caption = 'Hor'#225'rio Final: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 15
      Top = 12
      Width = 79
      Height = 15
      Caption = 'Hor'#225'rio Inicial:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 48
      Width = 386
      Height = 28
      Align = alBottom
      AutoSize = False
      Caption = 
        'No per'#237'odo compreendido entre o hor'#225'rio inicial e o hor'#225'rio fina' +
        'l, n'#227'o ser'#225' permitida a execu'#231#227'o de rotinas de transfer'#234'ncia de ' +
        'c'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      ExplicitLeft = 0
      ExplicitWidth = 392
    end
    object HroInicial: TcxTimeEdit
      Tag = 99
      Left = 95
      Top = 9
      Properties.Alignment.Horz = taRightJustify
      Properties.SpinButtons.Visible = False
      Properties.TimeFormat = tfHourMin
      TabOrder = 0
      Width = 50
    end
    object HroFim: TcxTimeEdit
      Tag = 99
      Left = 255
      Top = 9
      Properties.Alignment.Horz = taRightJustify
      Properties.SpinButtons.Visible = False
      Properties.TimeFormat = tfHourMin
      TabOrder = 1
      Width = 50
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 128
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 0
  end
end
