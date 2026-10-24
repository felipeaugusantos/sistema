object fraDadosFechamentoVendaTipoFaturamentoFrame: TfraDadosFechamentoVendaTipoFaturamentoFrame
  Left = 0
  Top = 0
  Width = 697
  Height = 31
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 697
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblTipoFaturamento: TLabel
      Left = 12
      Top = 9
      Width = 89
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tipo Faturamento:'
    end
    object lblDescontoPercentual: TLabel
      Left = 421
      Top = 9
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = '(%) Desconto:'
    end
    object lblDescontoEspecial: TLabel
      Left = 256
      Top = 9
      Width = 90
      Height = 13
      Alignment = taRightJustify
      Caption = 'Desconto Especial:'
    end
    object lblTotalGeral: TLabel
      Left = 545
      Top = 9
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Total Geral:'
    end
    object imgAlerta: TImage
      Left = 394
      Top = 7
      Width = 16
      Height = 16
      Picture.Data = {
        0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
        0000001008060000001FF3FF610000001974455874536F667477617265004164
        6F626520496D616765526561647971C9653C0000001B744558745469746C6500
        5761726E696E673B4E6F74696669636174696F6E3BB6E7798600000241494441
        54785EA58F5F48536118C64FC5A02E9288EE2BA8816585ABFC83DA28EBA6CB6A
        12CC300BA2024D27589A0CB4ADA4DC859995D36DD1A4CD5DA428E94636D7E98F
        D236D79A04DBB42E14664E735B46E982A7F73BD448362FA40F7E9C87F77D7EE7
        7C87F3EA8EFE179C475B98123A6BDC0F8F9410729657ECB91F1C4E8209439A82
        3CCA7162C9DE949F4D3975F7DD5D69129D57F76F1A69967E9E1E7D8C90CB00CA
        7E7D55665AAA2E37AC2958069DB5FCED7C63D0AAC6AF6F9F108F05101C508166
        3AB64BEABF6ECC4BC0AE6EABCF29766AE588935C76A51AE5443CE287B3ED349E
        37E4C8586799E368C84DD0A5906C1FAACF9D0FB98C589A0F407EE682C062D883
        A9B76DA0DD9CA952B2F55F871BACCB12A83CBE4D64AB3DC87B9F5409C28F4907
        2A2B140C217F9FE886C7580EEA0C49D337AFFBEB71D6EA03C2D57B15923A5E23
        A32F8F233A66C042B01BFA961B30102C477D3A7A491FF8A693A06E0D7304F759
        452667BEB8279B9E8B730107621F3B11713523EA6EC5F4700B43C8C2CCDB8E49
        BE15AC4B4E1673B93BA776A6F55CDE17F49A9588BE6F4778508159470D621F1E
        41A3563258A6592DC22FAAF0F58D1A23F74B418EBFF1C48E8D9CE57C86DE7E53
        8688CF84195B19A6FB4A05623E230E498F31584ECCBF0C5CC20C7F0BD6EB85E8
        3A97D1C1594A768527FA5588B8B59877DE436CCC44FF6AC3CFD028A2213F2253
        5E2C8CF70BBBB9572A84EDD730FBB21EC15E2598CBE98AC43DE6E274A4C27276
        AFC04AFB8E22F1538ECE16424CEC5E25E23F2E2722D6131B56097344BF0168AD
        F1039DB8E68C0000000049454E44AE426082}
      Visible = False
    end
    object edtTipFat: TEditFocus
      Left = 104
      Top = 5
      Width = 100
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clSilver
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPorDes: TEditFocus
      Left = 494
      Top = 5
      Width = 45
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clSilver
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesEsp: TEditFocus
      Left = 347
      Top = 5
      Width = 45
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clSilver
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtTotGer: TEditFocus
      Tag = 99
      Left = 603
      Top = 5
      Width = 81
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clSilver
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
end
