inherited frmConsultaServicosAutocenterTecSeat: TfrmConsultaServicosAutocenterTecSeat
  Width = 329
  Height = 120
  BorderIcons = []
  Caption = 'Avalia'#231#227'o de Satisfa'#231#227'o de Atendimento'
  Position = poMainFormCenter
  ExplicitWidth = 329
  ExplicitHeight = 120
  PixelsPerInch = 96
  TextHeight = 14
  object lblInfo: TLabel [0]
    Left = 16
    Top = 16
    Width = 248
    Height = 16
    Caption = 'Teclado de Satisfa'#231#227'o: Avalia'#231#227'o Pendente'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    StyleElements = [seClient, seBorder]
  end
  inherited pnlBotoes: TPanel
    Top = 47
    Width = 323
    ExplicitTop = 47
    ExplicitWidth = 323
    inherited FlwBotoes: TFlowPanel
      Width = 319
      ExplicitWidth = 319
    end
    inherited btnSair: TBitBtnLocked
      Left = 232
      Width = 85
      Caption = '&Continuar'
      ExplicitLeft = 232
      ExplicitWidth = 85
    end
  end
  inherited pnlStatus: TPanel
    Top = 75
    Width = 323
    ExplicitTop = 75
    ExplicitWidth = 323
    inherited pnlNomeForm: TPanel
      Left = 113
      Width = 210
      ExplicitLeft = 113
      ExplicitWidth = 210
    end
    inherited pnlInfo: TPanel
      Width = 113
      ExplicitWidth = 113
    end
  end
end
