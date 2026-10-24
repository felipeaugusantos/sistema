inherited frmConsultaCxGridTablet: TfrmConsultaCxGridTablet
  Caption = 'Consulta Tablet'
  ClientHeight = 596
  ClientWidth = 998
  Font.Charset = ANSI_CHARSET
  Font.Height = -16
  Font.Name = 'Arial'
  ExplicitWidth = 1014
  ExplicitHeight = 634
  PixelsPerInch = 96
  TextHeight = 18
  inherited pnlBotoes: TPanel
    Top = 546
    Width = 998
    Height = 50
    ExplicitTop = -50
    ExplicitWidth = 116
    ExplicitHeight = 50
    inherited Label1: TLabel
      Left = 266
      Top = 18
      Visible = False
      ExplicitLeft = 266
      ExplicitTop = 18
    end
    inherited btnSair: TBitBtnLocked
      Left = 874
      Width = 120
      Height = 38
      Font.Charset = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = -8
      ExplicitWidth = 120
      ExplicitHeight = 38
    end
    inherited btnConfirma: TBitBtnLocked
      Width = 120
      Height = 38
      Font.Charset = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 120
      ExplicitHeight = 38
    end
    inherited btnPadrao: TBitBtnLocked
      Left = 126
      Width = 180
      Height = 38
      Font.Charset = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 126
      ExplicitWidth = 180
      ExplicitHeight = 38
    end
    inherited btnCancel: TBitBtnLocked
      Left = 307
      Width = 180
      Height = 38
      Font.Charset = ANSI_CHARSET
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 307
      ExplicitWidth = 180
      ExplicitHeight = 38
    end
    inherited btnLimpar: TBitBtnLocked
      Left = 489
      Width = 180
      Height = 38
      ExplicitLeft = 489
      ExplicitWidth = 180
      ExplicitHeight = 38
    end
  end
  inherited prbProgresso: TProgressBar
    Top = 505
    Width = 998
    ExplicitTop = -91
    ExplicitWidth = 116
  end
  inherited pnlConsulta: TPanel
    Width = 998
    Height = 505
    ExplicitWidth = 116
    ExplicitHeight = 369
    inherited pgcRodape: TPageControl
      Top = 418
      Width = 998
      ExplicitTop = 282
      ExplicitWidth = 116
    end
    inherited cxConsulta: TcxGrid
      Width = 998
      Height = 418
      ExplicitWidth = 116
      ExplicitHeight = 282
    end
  end
  inherited pnlLegenda: TPanel
    Top = 521
    Width = 998
    Height = 25
    Font.Charset = ANSI_CHARSET
    Font.Height = -16
    Font.Name = 'Arial'
    ExplicitTop = -75
    ExplicitWidth = 116
    ExplicitHeight = 25
  end
  inherited cxsrConsulta: TcxStyleRepository
    PixelsPerInch = 96
  end
end
