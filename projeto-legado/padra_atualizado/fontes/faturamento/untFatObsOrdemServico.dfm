inherited frmFatObsOrdemServico: TfrmFatObsOrdemServico
  Left = 318
  Top = 274
  Width = 610
  Height = 210
  Caption = 'Observa'#231#245'es da Ordem de Servi'#231'o'
  Position = poScreenCenter
  ExplicitWidth = 610
  ExplicitHeight = 210
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 165
    Width = 604
    ExplicitTop = 165
    ExplicitWidth = 604
    DesignSize = (
      604
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 600
      ExplicitTop = 2
      ExplicitWidth = 600
    end
  end
  inherited pgcDados: TPageControl
    Top = 139
    Width = 604
    Height = 26
    ExplicitTop = 137
    ExplicitWidth = 604
    ExplicitHeight = 28
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 596
      ExplicitHeight = 18
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 604
    Height = 139
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 5
      Top = 8
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#245'es:'
    end
    object memObserv: TMemoFocus
      Left = 80
      Top = 8
      Width = 513
      Height = 122
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 139
    Width = 604
    Height = 26
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitTop = 137
    ExplicitHeight = 28
    object btnFechar: TBitBtnLocked
      Left = 523
      Top = 1
      Width = 80
      Height = 24
      Align = alRight
      Caption = '[ Esc ] Fechar'
      TabOrder = 0
      OnClick = btnSairClick
      ExplicitLeft = 518
      ExplicitTop = 3
      ExplicitHeight = 22
    end
    object btnAlterar: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 80
      Height = 24
      Align = alLeft
      Caption = '[ F2 ] Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
      ExplicitLeft = 4
      ExplicitTop = 3
      ExplicitHeight = 22
    end
  end
  inherited pnlStatus: TPanel
    Top = 165
    Width = 604
    ExplicitTop = 165
    ExplicitWidth = 604
    inherited pnlNomeForm: TPanel
      Left = 433
      ExplicitLeft = 433
    end
    inherited pnlInfo: TPanel
      Width = 433
      ExplicitWidth = 433
    end
  end
end
