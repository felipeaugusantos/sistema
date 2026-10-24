inherited frmImendesOpcoesRecriacaoConsulta: TfrmImendesOpcoesRecriacaoConsulta
  Width = 351
  Height = 196
  Caption = 'Op'#231'oes'
  ExplicitWidth = 351
  ExplicitHeight = 196
  PixelsPerInch = 96
  TextHeight = 14
  object lblArqBas: TLabel [0]
    Left = 0
    Top = 0
    Width = 345
    Height = 14
    Align = alTop
    Caption = 'Arquivo Base: '
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 79
  end
  inherited pnlBotoes: TPanel
    Top = 125
    Width = 345
    ExplicitTop = 125
    ExplicitWidth = 345
    inherited FlwBotoes: TFlowPanel
      Width = 341
      ExplicitWidth = 341
    end
    inherited btnSair: TBitBtnLocked
      Left = 265
      ExplicitLeft = 265
    end
  end
  inherited pnlStatus: TPanel
    Top = 151
    Width = 345
    ExplicitTop = 151
    ExplicitWidth = 345
    inherited pnlNomeForm: TPanel
      Left = 174
      ExplicitLeft = 174
    end
    inherited pnlInfo: TPanel
      Width = 174
      ExplicitWidth = 174
    end
  end
  object rdgOpcao: TRadioGroup [3]
    Left = 0
    Top = 14
    Width = 345
    Height = 111
    Align = alClient
    Caption = 'Reprocessar:'
    Items.Strings = (
      'Itens com Retorno Parcial'
      'Itens com Diverg'#234'ncias '
      'Itens com C'#243'd.Barras V'#225'lido N'#227'o Encontrados na Imendes'
      'Itens com C'#243'd.Barras Inv'#225'lidos'
      'Todos os itens')
    TabOrder = 2
  end
end
