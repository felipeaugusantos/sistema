inherited frmSelItensCodBar: TfrmSelItensCodBar
  Width = 295
  Height = 140
  Caption = 'Buscar Itens pelo C'#243'digo de Barras'
  ExplicitWidth = 295
  ExplicitHeight = 140
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 69
    Width = 289
    TabOrder = 1
    ExplicitTop = 69
    ExplicitWidth = 289
    inherited FlwBotoes: TFlowPanel
      Width = 285
      ExplicitWidth = 285
      inherited btnConfirma: TBitBtnLocked
        Caption = '&Adicionar'
        OnClick = nil
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 206
      Caption = '&Sair'
      ExplicitLeft = 206
    end
  end
  inherited pnlStatus: TPanel
    Top = 95
    Width = 289
    TabOrder = 2
    ExplicitTop = 95
    ExplicitWidth = 289
    inherited pnlNomeForm: TPanel
      Left = 118
      ExplicitLeft = 118
    end
    inherited pnlInfo: TPanel
      Width = 118
      ExplicitWidth = 118
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 289
    Height = 69
    Align = alClient
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblCodBar: TLabel
      Left = 9
      Top = 12
      Width = 87
      Height = 14
      Caption = 'C'#243'digo de Barras:'
    end
    object lblQntd: TLabel
      Left = 41
      Top = 35
      Width = 55
      Height = 14
      Caption = 'Quantidade'
    end
    object edtCodBar: TEditFocus
      Tag = 99
      Left = 102
      Top = 9
      Width = 109
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 30
      NumbersOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 30
      TipoTexto = ttNumerico
    end
    object edtQntd: TEditFocus
      Tag = 99
      Left = 102
      Top = 32
      Width = 109
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 4
      TabOrder = 1
      Text = '0001'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttInteiro
    end
  end
end
