inherited frmMcaDetalhesBaixa: TfrmMcaDetalhesBaixa
  Width = 252
  Height = 252
  BorderIcons = [biSystemMenu]
  Caption = 'Detalhes da Baixa'
  Position = poScreenCenter
  ExplicitWidth = 252
  ExplicitHeight = 252
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 179
    Width = 246
    ExplicitTop = 158
    ExplicitWidth = 246
    inherited FlwBotoes: TFlowPanel
      Width = 242
      ExplicitWidth = 242
    end
    inherited btnSair: TBitBtnLocked
      Left = 163
      ExplicitLeft = 163
    end
  end
  inherited pnlStatus: TPanel
    Top = 207
    Width = 246
    ExplicitTop = 186
    ExplicitWidth = 246
    inherited pnlNomeForm: TPanel
      Left = 75
      ExplicitLeft = 75
    end
    inherited pnlInfo: TPanel
      Width = 75
      ExplicitWidth = 75
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 67
    Width = 246
    Height = 112
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitHeight = 91
    object lblValorTaxas: TLabel
      Left = 54
      Top = 14
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor de Taxas:'
    end
    object lblValorFrete: TLabel
      Left = 58
      Top = 37
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor de Frete:'
    end
    object lblAjustesCancelamentos: TLabel
      Left = 3
      Top = 83
      Width = 126
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ajustes e Cancelamentos:'
    end
    object lblCupomDesconto: TLabel
      Left = 29
      Top = 60
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cupom de Desconto:'
    end
    object btnSelChEmi: TBitBtnLocked
      Left = 187
      Top = 34
      Width = 25
      Height = 22
      Hint = 'Mostra lista de cheques emitidos'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object edtValorDeTaxas: TEditFocus
      Left = 134
      Top = 11
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValorDeFrete: TEditFocus
      Left = 134
      Top = 34
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValorDeAjustes: TEditFocus
      Left = 134
      Top = 80
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValorDeCupomDesconto: TEditFocus
      Left = 134
      Top = 57
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 246
    Height = 67
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblValorBruto: TLabel
      Left = 72
      Top = 15
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Bruto:'
    end
    object lblValorRecebido: TLabel
      Left = 53
      Top = 38
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Recebido:'
    end
    object edtValorBruto: TEditFocus
      Left = 134
      Top = 12
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValorRecebido: TEditFocus
      Left = 134
      Top = 35
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 280
    Top = 72
  end
end
