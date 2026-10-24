inherited frmConfirmaPreco: TfrmConfirmaPreco
  Width = 500
  Height = 275
  Caption = 'Tabela de Pre'#231'o'
  ExplicitWidth = 500
  ExplicitHeight = 275
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 204
    Width = 494
    BevelInner = bvNone
    ExplicitTop = 204
    ExplicitWidth = 494
    inherited FlwBotoes: TFlowPanel
      Left = 1
      Top = 1
      Width = 415
      Height = 24
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 415
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 416
      Height = 24
      Align = alRight
      ExplicitLeft = 416
      ExplicitHeight = 24
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 20
    Width = 494
    Height = 184
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object rdgOpcao: TRadioGroup
      Left = 1
      Top = 1
      Width = 480
      Height = 78
      BiDiMode = bdLeftToRight
      Caption = 'Op'#231#227'o'
      Columns = 2
      Items.Strings = (
        'Sem Pre'#231'o'
        'Com Pre'#231'o')
      ParentBiDiMode = False
      TabOrder = 0
      OnClick = rdgOpcaoClick
    end
    object gpbTabela: TGroupBox
      Left = 1
      Top = 85
      Width = 480
      Height = 95
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 24
        Width = 81
        Height = 14
        Caption = 'Escolha a Tabela'
      end
      object cbTabela: TComboBoxFocus
        Tag = 99
        Left = 8
        Top = 40
        Width = 145
        Height = 22
        Style = csOwnerDrawFixed
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        Items.Strings = (
          'TABELA 1'
          'TABELA 2'
          'TABELA 3'
          'TABELA 4'
          'TABELA 5'
          'TABELA 6'
          'TABELA 7')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object chkPrePro: TCheckBox
        Left = 8
        Top = 68
        Width = 425
        Height = 17
        Caption = 'Considerar pre'#231'o de promo'#231#227'o '
        TabOrder = 1
        Visible = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 230
    Width = 494
    ExplicitTop = 230
    ExplicitWidth = 494
    inherited pnlNomeForm: TPanel
      Left = 323
      ExplicitLeft = 323
    end
    inherited pnlInfo: TPanel
      Width = 323
      ExplicitWidth = 323
    end
  end
  object pnlLayDescri: TPanel [4]
    Left = 0
    Top = 0
    Width = 494
    Height = 20
    Align = alTop
    TabOrder = 4
    Visible = False
  end
end
