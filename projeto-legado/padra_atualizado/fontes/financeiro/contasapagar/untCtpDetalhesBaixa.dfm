inherited frmCtpDetalhesBaixa: TfrmCtpDetalhesBaixa
  Width = 236
  Height = 351
  BorderIcons = [biSystemMenu]
  Caption = 'Detalhes da Baixa'
  Position = poScreenCenter
  ExplicitWidth = 236
  ExplicitHeight = 351
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 278
    Width = 230
    ExplicitTop = 252
    ExplicitWidth = 230
    inherited FlwBotoes: TFlowPanel
      Width = 226
      ExplicitWidth = 226
    end
    inherited btnSair: TBitBtnLocked
      Left = 147
      ExplicitLeft = 147
    end
  end
  inherited pnlStatus: TPanel
    Top = 306
    Width = 230
    ExplicitTop = 280
    ExplicitWidth = 230
    inherited pnlNomeForm: TPanel
      Left = 59
      ExplicitLeft = 59
    end
    inherited pnlInfo: TPanel
      Width = 59
      ExplicitWidth = 59
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 230
    Height = 166
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label22: TLabel
      Left = 37
      Top = 15
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Pago:'
    end
    object Label5: TLabel
      Left = 62
      Top = 39
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Juros:'
    end
    object Label7: TLabel
      Left = 43
      Top = 87
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto:'
    end
    object Label9: TLabel
      Left = 6
      Top = 111
      Width = 86
      Height = 14
      Alignment = taRightJustify
      Caption = 'Outras Entidades:'
    end
    object Label4: TLabel
      Left = 54
      Top = 135
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendor:'
    end
    object lblMulta: TLabel
      Left = 64
      Top = 63
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Multa:'
    end
    object edtValorPago: TEditFocus
      Left = 105
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
    object edtValorJuros: TEditFocus
      Left = 105
      Top = 36
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
    object edtValorDesconto: TEditFocus
      Left = 105
      Top = 84
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtOutrasEntidades: TEditFocus
      Left = 105
      Top = 108
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
    object edtVendor: TEditFocus
      Left = 105
      Top = 132
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
    object edtValorMulta: TEditFocus
      Left = 105
      Top = 60
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 166
    Width = 230
    Height = 112
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 184
    object Label2: TLabel
      Left = 50
      Top = 14
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dinheiro:'
    end
    object Label3: TLabel
      Left = 16
      Top = 38
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque Emitido:'
    end
    object Label1: TLabel
      Left = 4
      Top = 62
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque Terceiros:'
    end
    object Label6: TLabel
      Left = 47
      Top = 86
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dep'#243'sito:'
    end
    object btnSelChEmi: TBitBtnLocked
      Left = 195
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
      OnClick = btnSelChEmiClick
    end
    object btnSelChTer: TBitBtnLocked
      Left = 195
      Top = 58
      Width = 25
      Height = 22
      Hint = 'Mostra lista de cheques de terceiros'
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
      TabOrder = 4
      OnClick = btnSelChTerClick
    end
    object edtDinheiro: TEditFocus
      Left = 105
      Top = 10
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
    object edtChequeEmitido: TEditFocus
      Left = 105
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
    object edtChequeTerceiros: TEditFocus
      Left = 105
      Top = 58
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
    object edtDeposito: TEditFocus
      Left = 105
      Top = 82
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 304
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 336
    Top = 128
  end
end
