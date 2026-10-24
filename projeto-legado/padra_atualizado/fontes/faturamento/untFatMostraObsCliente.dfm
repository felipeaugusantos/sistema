inherited frmFatMostraObsCliente: TfrmFatMostraObsCliente
  Left = 232
  Top = 250
  Width = 610
  Height = 215
  BorderIcons = [biSystemMenu]
  Caption = 'Observa'#231#245'es do Cliente'
  Position = poMainFormCenter
  ExplicitWidth = 610
  ExplicitHeight = 215
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 170
    Width = 604
    TabOrder = 4
    ExplicitTop = 170
    ExplicitWidth = 604
    inherited FlwBotoes: TFlowPanel
      Width = 600
      ExplicitTop = 2
      ExplicitWidth = 600
    end
    inherited btnSair: TBitBtnLocked
      Left = 360
      ExplicitLeft = 360
    end
  end
  inherited pgcDados: TPageControl
    Top = 140
    Width = 604
    Height = 30
    TabOrder = 2
    ExplicitTop = 140
    ExplicitWidth = 604
    ExplicitHeight = 30
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 596
      ExplicitHeight = 20
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 604
    Height = 140
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 8
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#245'es:'
    end
    object memFixo: TMemoFocus
      Left = 80
      Top = 8
      Width = 513
      Height = 60
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Lines.Strings = (
        'memFixo')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
      Texto = 'memFixo'
    end
    object memObserv: TMemoFocus
      Left = 80
      Top = 70
      Width = 513
      Height = 60
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Lines.Strings = (
        'memFixo')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
      OnKeyDown = memObservKeyDown
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
      Texto = 'memFixo'
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 140
    Width = 604
    Height = 30
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object btnFechar: TBitBtnLocked
      Left = 523
      Top = 1
      Width = 80
      Height = 28
      Align = alRight
      Caption = '[ Esc ] Fechar'
      TabOrder = 1
      OnClick = btnSairClick
    end
    object btnAlterar: TBitBtnLocked
      Left = 1
      Top = 1
      Width = 80
      Height = 28
      Align = alLeft
      Caption = '[ F2 ] Alterar'
      TabOrder = 0
      OnClick = btnAlterarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 170
    Width = 604
    TabOrder = 3
    ExplicitTop = 170
    ExplicitWidth = 604
    inherited pnlNomeForm: TPanel
      Left = 418
      Width = 186
      ExplicitLeft = 418
      ExplicitWidth = 186
    end
    inherited pnlInfo: TPanel
      Width = 418
      Caption = 'Pressione < ESC> para sair...'
      ExplicitWidth = 418
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 512
    Top = 88
  end
end
