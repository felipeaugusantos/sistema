inherited frmTefCitelCancelamentoTransacao: TfrmTefCitelCancelamentoTransacao
  Width = 774
  Height = 238
  BorderIcons = []
  Caption = 'Cancelamento Transa'#231#227'o TEF'
  Position = poScreenCenter
  ExplicitWidth = 774
  ExplicitHeight = 238
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 186
    Width = 768
    Height = 7
    Visible = False
    ExplicitTop = 186
    ExplicitWidth = 768
    ExplicitHeight = 7
    inherited FlwBotoes: TFlowPanel
      Width = 764
      Height = 3
      ExplicitWidth = 764
      ExplicitHeight = 3
    end
    inherited btnSair: TBitBtnLocked
      Left = 688
      Top = -18
      ExplicitLeft = 688
      ExplicitTop = -18
    end
  end
  inherited pnlStatus: TPanel
    Top = 193
    Width = 768
    ExplicitTop = 193
    ExplicitWidth = 768
    inherited pnlNomeForm: TPanel
      Left = 597
      ExplicitLeft = 597
    end
    inherited pnlInfo: TPanel
      Width = 597
      ExplicitWidth = 597
    end
  end
  object pnOperacao: TPanel [2]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 762
    Height = 41
    Align = alTop
    Caption = 'CANCELAMENTO DE TRANSA'#199#195'O TEF'
    Font.Charset = ANSI_CHARSET
    Font.Color = 204
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object pnMensTef: TPanel [3]
    Left = 0
    Top = 151
    Width = 768
    Height = 35
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object lbMensTef: TcxLabel
      Left = 1
      Top = 1
      Align = alClient
      Caption = 'Aguarde...'
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clRed
      Style.Font.Height = -15
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Properties.WordWrap = True
      Transparent = True
      Width = 766
      AnchorX = 384
      AnchorY = 18
    end
  end
  object pnDadosInfo: TPanel [4]
    Left = 0
    Top = 47
    Width = 768
    Height = 104
    Align = alClient
    TabOrder = 4
    object lblTipoTransacao: TcxLabel
      Left = 8
      Top = 6
      Caption = 'Tipo Transa'#231#227'o: '
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 16
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object lblDataTransacao: TcxLabel
      Left = 8
      Top = 30
      Caption = 'Data Transa'#231#227'o: '
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 16
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object lblValorTransacao: TcxLabel
      Left = 8
      Top = 54
      Caption = 'Valor Transa'#231#227'o: '
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 16
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
    object lblBandeira: TcxLabel
      Left = 8
      Top = 78
      Caption = 'Bandeira: '
      ParentFont = False
      Style.Font.Charset = ANSI_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = 16
      Style.Font.Name = 'Arial'
      Style.Font.Pitch = fpVariable
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Transparent = True
    end
  end
  object tmrAtualizaMsg: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrAtualizaMsgTimer
    Left = 672
    Top = 16
  end
  object tmrMostrarDados: TTimer
    Enabled = False
    Interval = 200
    OnTimer = tmrMostrarDadosTimer
    Left = 672
    Top = 63
  end
end
