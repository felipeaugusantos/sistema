inherited frmCtrDetalhesBaixa: TfrmCtrDetalhesBaixa
  Width = 237
  Height = 363
  BorderIcons = [biSystemMenu]
  Caption = 'Detalhes da baixa'
  Position = poMainFormCenter
  ExplicitWidth = 237
  ExplicitHeight = 363
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 290
    Width = 231
    ExplicitTop = 254
    ExplicitWidth = 231
    inherited FlwBotoes: TFlowPanel
      Width = 227
      ExplicitWidth = 227
    end
    inherited btnSair: TBitBtnLocked
      Left = 148
      ExplicitLeft = 148
    end
  end
  inherited pnlStatus: TPanel
    Top = 318
    Width = 231
    ExplicitTop = 282
    ExplicitWidth = 231
    inherited pnlNomeForm: TPanel
      Left = 60
      ExplicitLeft = 60
    end
    inherited pnlInfo: TPanel
      Width = 60
      ExplicitWidth = 60
    end
  end
  object pnlGeral: TPanel [2]
    Left = 0
    Top = 0
    Width = 231
    Height = 117
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitTop = 8
    object Label22: TLabel
      Left = 19
      Top = 15
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor Recebido:'
    end
    object Label5: TLabel
      Left = 65
      Top = 39
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Juros:'
    end
    object Label7: TLabel
      Left = 46
      Top = 63
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto:'
    end
    object lblValCob: TLabel
      Left = 14
      Top = 87
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desp. Cobran'#231'a:'
    end
    object edtValRec: TEditFocus
      Left = 108
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
    object edtValJur: TEditFocus
      Left = 108
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
    object edtValDes: TEditFocus
      Left = 108
      Top = 60
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
    object edtValCob: TEditFocus
      Left = 108
      Top = 84
      Width = 89
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 117
    Width = 231
    Height = 173
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 102
    ExplicitHeight = 185
    object Label2: TLabel
      Left = 53
      Top = 19
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dinheiro:'
    end
    object Label3: TLabel
      Left = 18
      Top = 43
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque '#224' Vista:'
    end
    object Label1: TLabel
      Left = 29
      Top = 67
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cheque - Pr'#233':'
    end
    object Label4: TLabel
      Left = 60
      Top = 91
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cart'#227'o:'
    end
    object Label6: TLabel
      Left = 27
      Top = 115
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ordem Pagto.:'
    end
    object Label11: TLabel
      Left = 23
      Top = 139
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Financiamento:'
    end
    object btnSelChAvi: TBitBtnLocked
      Left = 198
      Top = 39
      Width = 24
      Height = 21
      Hint = 'Mostra lista de cheques a vista'
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
      TabOrder = 0
      OnClick = btnSelChAviClick
    end
    object btnSelChPre: TBitBtnLocked
      Left = 198
      Top = 63
      Width = 23
      Height = 21
      Hint = 'Mostra lista de cheques pr'#233'-datados'
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
      TabOrder = 1
      OnClick = btnSelChPreClick
    end
    object btnSelCartao: TBitBtnLocked
      Left = 198
      Top = 87
      Width = 24
      Height = 21
      Hint = 'Mostra lista de cart'#245'es'
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
      OnClick = btnSelCartaoClick
    end
    object edtDinheiro: TEditFocus
      Left = 108
      Top = 15
      Width = 89
      Height = 22
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
    object edtChequeAVista: TEditFocus
      Left = 108
      Top = 39
      Width = 89
      Height = 22
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
    object edtChequePre: TEditFocus
      Left = 108
      Top = 63
      Width = 89
      Height = 22
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
    object edtCartao: TEditFocus
      Left = 108
      Top = 87
      Width = 89
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtOrdemPgto: TEditFocus
      Left = 108
      Top = 111
      Width = 89
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFinanciamento: TEditFocus
      Left = 108
      Top = 135
      Width = 89
      Height = 22
      Alignment = taRightJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 492
    Top = 188
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 572
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 452
    Top = 120
  end
end
