inherited frmMostraObsFornecedor: TfrmMostraObsFornecedor
  Width = 606
  Height = 210
  Caption = 'Observa'#231#245'es do Fornecedor'
  Position = poMainFormCenter
  ExplicitWidth = 606
  ExplicitHeight = 210
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 131
    Width = 600
    ExplicitTop = 131
    ExplicitWidth = 600
  end
  inherited pgcDados: TPageControl
    Top = 392
    Height = 69
    Align = alNone
    ExplicitTop = 392
    ExplicitHeight = 69
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 761
      ExplicitHeight = 37
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 131
    Width = 600
    Height = 35
    Align = alBottom
    ParentColor = True
    TabOrder = 3
    DesignSize = (
      600
      35)
    object btnAlterar: TBitBtnLocked
      Left = 5
      Top = 5
      Width = 80
      Height = 22
      Caption = '[ F2 ] Alterar'
      TabOrder = 0
      OnClick = btnAlterarClick
    end
    object btnFechar: TBitBtnLocked
      Left = 513
      Top = 5
      Width = 80
      Height = 22
      Anchors = [akRight, akBottom]
      Caption = '[ Esc ] Fechar'
      TabOrder = 1
      OnClick = btnSairClick
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 0
    Width = 600
    Height = 131
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label1: TLabel
      Left = 4
      Top = 8
      Width = 143
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#245'es do Fornecedor:'
    end
    object memObserv: TMemoFocus
      Left = 3
      Top = 23
      Width = 588
      Height = 98
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
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
  end
  inherited pnlStatus: TPanel
    Top = 166
    Width = 600
    Color = 16770261
    ExplicitTop = 166
    ExplicitWidth = 600
    inherited pnlNomeForm: TPanel
      Left = 429
      ExplicitLeft = 429
    end
    inherited pnlInfo: TPanel
      Width = 429
      ExplicitWidth = 429
    end
  end
end
