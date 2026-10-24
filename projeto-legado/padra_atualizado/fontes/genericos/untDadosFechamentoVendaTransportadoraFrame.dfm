object fraDadosFechamentoVendaTransportadoraFrame: TfraDadosFechamentoVendaTransportadoraFrame
  Left = 0
  Top = 0
  Width = 710
  Height = 196
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 710
    Height = 196
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblValorDoFrete: TLabel
      Left = 30
      Top = 7
      Width = 72
      Height = 13
      Alignment = taRightJustify
      Caption = 'Valor do Frete:'
    end
    object lblFretePorConta: TLabel
      Left = 221
      Top = 7
      Width = 75
      Height = 13
      Alignment = taRightJustify
      Caption = 'Frete p/ Conta:'
    end
    object lblQuantidade: TLabel
      Left = 42
      Top = 76
      Width = 60
      Height = 13
      Alignment = taRightJustify
      Caption = 'Quantidade:'
    end
    object lblEspecie: TLabel
      Left = 62
      Top = 53
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object lblMarca: TLabel
      Left = 231
      Top = 53
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object lblPesoBruto: TLabel
      Left = 563
      Top = 53
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Caption = 'Peso Bruto:'
    end
    object lblPesoLiquido: TLabel
      Left = 402
      Top = 53
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = 'Peso L'#237'quido:'
    end
    object lblDespAcessoria: TLabel
      Left = 539
      Top = 7
      Width = 80
      Height = 13
      Alignment = taRightJustify
      Caption = 'Desp. acess'#243'ria:'
    end
    object btnCalcFreSug: TSpeedButton
      Left = 168
      Top = 3
      Width = 24
      Height = 22
      Hint = 'Carregar o valor do frete sugest'#227'o'
      Flat = True
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000330B0000330B00000001000000010000BD4D0100CB57
        0000CC5A2A00A4676900D2851A00E7AC1D00E89B2700CF8E6800FF00FF00F3BB
        9F00FFCFA500FFD6B500FFDFC300FEEBD800FFEFDE0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000080808080808
        0808080808080808080808080808080808080808080808080808080101010101
        0101010101010101010805090909090909090909090909090901050C09090B09
        090A09090B09090A0901050D02000B01000A01000A01000A0901050D09090C09
        090B09090A09090A0901050D02000D01000B01000A01000A0901050D0D0D0D0D
        0C0B0B0B0B0A0A0A0901050D0707070707070707070B0A0A0901050D030E0E0E
        0E0E0E0E070B0B0A0901050D0303030303030303030C0B0B0901050D0D0D0D0D
        0D0D0D0D0D0D0D0C090108060606060606060606060606060408080808080808
        0808080808080808080808080808080808080808080808080808}
      ParentShowHint = False
      ShowHint = True
    end
    object btnCalcVolume: TSpeedButton
      Left = 168
      Top = 72
      Width = 24
      Height = 22
      Hint = 'Calcular a quantidade de volumes'
      Flat = True
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000330B0000330B00000001000000010000BD4D0100CB57
        0000CC5A2A00A4676900D2851A00E7AC1D00E89B2700CF8E6800FF00FF00F3BB
        9F00FFCFA500FFD6B500FFDFC300FEEBD800FFEFDE0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000080808080808
        0808080808080808080808080808080808080808080808080808080101010101
        0101010101010101010805090909090909090909090909090901050C09090B09
        090A09090B09090A0901050D02000B01000A01000A01000A0901050D09090C09
        090B09090A09090A0901050D02000D01000B01000A01000A0901050D0D0D0D0D
        0C0B0B0B0B0A0A0A0901050D0707070707070707070B0A0A0901050D030E0E0E
        0E0E0E0E070B0B0A0901050D0303030303030303030C0B0B0901050D0D0D0D0D
        0D0D0D0D0D0D0D0C090108060606060606060606060606060408080808080808
        0808080808080808080808080808080808080808080808080808}
      ParentShowHint = False
      ShowHint = True
    end
    object lblNumeracao: TLabel
      Left = 206
      Top = 76
      Width = 58
      Height = 13
      Alignment = taRightJustify
      Caption = 'Numera'#231#227'o:'
    end
    object lblEdiPes: TLabel
      Left = 439
      Top = 69
      Width = 245
      Height = 13
      Cursor = crHandPoint
      Caption = 'Caso deseje informar peso por produto, clique aqui'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object lblValFreCot: TLabel
      Left = 34
      Top = 29
      Width = 68
      Height = 13
      Alignment = taRightJustify
      Caption = 'Frete Cotado:'
      Visible = False
    end
    object lblOutros: TLabel
      Left = 582
      Top = 29
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Outros:'
    end
    object edtValFre: TEditFocus
      Tag = 99
      Left = 105
      Top = 3
      Width = 62
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdTra: TEditFocus
      Tag = 99
      Left = 105
      Top = 72
      Width = 62
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtEspTra: TEditFocus
      Tag = 99
      Left = 105
      Top = 49
      Width = 62
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMarTra: TEditFocus
      Tag = 99
      Left = 266
      Top = 49
      Width = 127
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttAlfanumerico
    end
    object edtPesLiq: TEditFocus
      Tag = 99
      Left = 467
      Top = 49
      Width = 81
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,###0.000'
    end
    object edtPesBru: TEditFocus
      Tag = 99
      Left = 622
      Top = 49
      Width = 62
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 9
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,###0.000'
    end
    object edtDesAce: TEditFocus
      Tag = 99
      Left = 622
      Top = 3
      Width = 62
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object chkEntUrg: TCheckBox
      Left = 458
      Top = 6
      Width = 63
      Height = 17
      Caption = 'Urgente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object cmbTipFre: TComboBoxFocus
      Tag = 99
      Left = 299
      Top = 3
      Width = 136
      Height = 21
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object btnDespesasFaturamento: TBitBtnLocked
      Left = 684
      Top = 2
      Width = 23
      Height = 23
      Hint = 'Despesas para Faturamento'
      Glyph.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D0020000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        9E9E9EADADADAFAFAFABAAABACAFABB2AEAEA5AAACB2AEAFB2AFB0A8ACABA4A6
        A5FFFFFFFFFFFF000000FFFFFFF2F2F2A0A0A0BFBFBFAFAFAFD2CFD0B1B6B5B0
        ADAFD8D8D5C5AA9ECCA294E3D1CBA3A1A2FFFEFEFFFFFF000000FFFFFFF3F3F3
        A2A2A2A4A4A4939393BFBEBC989B9E949298CFCAC3B6866EBB8062D3BAADA4A4
        A6FFFEFFFFFFFF000000FFFFFFF4F4F49F9F9FC4C4C4B5B5B5D2D2D1BDBBBDB7
        B4B9DEDCD4BC8871BB8565D1BEACA2A7A5FEFEFFFFFFFF000000FFFFFFF4F4F4
        A4A4A49B9B9B8A8A89B6B7B79791918B898AC3C5BDB5826FBA7A5DD6BAAAA6A5
        A1FFFEFFFFFFFF000000FFFFFFF4F4F49E9E9ECFCFCFC2C2C2DAD6D8CDCAC4B9
        C3C6E0DED699BFF582B9F7C4DDF1A49FA3FDFFFFFFFFFF000000FFFFFFF4F4F4
        A3A3A39A9A9A8A8A8AB6B9B6909195918787B8BFC70974ED0064FF70AEF1ACA3
        A5FFFFFEFFFFFF000000FFFFFFF4F4F4A0A0A0CCCBCBBDBEBED4D6D9CCC6BFBC
        BEBED5DBDFA6BEDA9BB7D6CDDBE5AAA1A0FFFFFFFFFFFF000000FFFFFFF4F4F4
        A3A2A39A999A888788B6B4BD8E9193818986BFC0BB99908E8C8885B5BDC0A4A1
        A8FEFFFFFFFFFF000000FFFFFFF4F4F49F9F9FE2E2E3D5D4D6E6E4E1D6D5D9D9
        D2D5E4E4E8D4D4D3D6D1CFE8ECEBA8A09FFFFFFFFFFFFF000000FFFFFFF5F5F6
        9A9E974C741B598E2B5E8E2965952F6B9937709C4378A15179A85960813DABAA
        AAFFFEFFFFFFFF000000FFFFFFF6F5F7949891648F298ACA3983CB498BD44E92
        DA579ADF61A4E971BFFA89799F56A4A3AFFFFFFFFFFFFF000000FFFFFFF4F4F5
        9FA29B5A7537567D23587B20577C1E577C1D577B1D557A1D4C781863803CAEAF
        A8FFFEFFFFFFFF000000FFFFFFFBFBFB757775B6B9B5AFB2AFB0B0B5B0B1B3B0
        B1B4B0B2B1B0B2B2AFAEB5B8B7B3837F7FFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFBFAFBFBFAFCFBFBFBFBFAFBFBFAFBFBFBFBFBFBFBFBFAFBFAF9FBFFFF
        FFFFFFFFFFFFFF000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Visible = False
    end
    object edtNumera: TEditFocus
      Tag = 99
      Left = 266
      Top = 72
      Width = 127
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 14
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 14
      TipoTexto = ttAlfanumerico
    end
    object edtValFreCot: TEditFocus
      Tag = 99
      Left = 105
      Top = 26
      Width = 62
      Height = 21
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 5
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object pnlDadosAux: TPanel
      Left = 0
      Top = 118
      Width = 710
      Height = 52
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 13
      object lblNumConhecimento: TLabel
        Left = 184
        Top = 29
        Width = 72
        Height = 13
        Caption = 'Num. Conhec.:'
      end
      object lblPlacaVeiculo: TLabel
        Left = 36
        Top = 29
        Width = 65
        Height = 13
        Alignment = taRightJustify
        Caption = 'Placa Ve'#237'culo:'
      end
      object lblTransportadora: TLabel
        Left = 23
        Top = 5
        Width = 79
        Height = 13
        Alignment = taRightJustify
        Caption = 'Transportadora:'
      end
      object chkEst_Dv: TCheckBox
        Left = 399
        Top = 29
        Width = 249
        Height = 17
        Caption = 'Estorno de Nota Fiscal n'#227'o cancelada no prazo'
        TabOrder = 5
      end
      object edtCodTra: TEditFocus
        Tag = 99
        Left = 105
        Top = 1
        Width = 62
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNConhe: TEditFocus
        Tag = 99
        Left = 257
        Top = 25
        Width = 62
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtNomTra: TEditFocus
        Left = 168
        Top = 1
        Width = 225
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object mskPlaFat: TMaskEditFocus
        Tag = 99
        Left = 105
        Top = 25
        Width = 63
        Height = 22
        AutoSelect = False
        AutoSize = False
        EditMask = 'aaa-9a99;0; '
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 3
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object chkRetornoPorRecusa: TCheckBox
        Left = 399
        Top = 3
        Width = 249
        Height = 17
        Caption = 'Nota Fiscal de Retorno por Recusa ?'
        TabOrder = 2
        Visible = False
      end
    end
    object pnlVolumeSepExc: TPanel
      Left = 0
      Top = 95
      Width = 710
      Height = 23
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 12
      object lblQtdTraSepExc: TLabel
        Left = 8
        Top = 4
        Width = 94
        Height = 13
        Alignment = taRightJustify
        Caption = 'Vol. Sep. Exclusiva:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblQtdTraSepNExc: TLabel
        Left = 180
        Top = 4
        Width = 116
        Height = 13
        Alignment = taRightJustify
        Caption = 'Vol. Sep. N'#227'o Exclusiva:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtQtdTraSepExc: TEditFocus
        Left = 105
        Top = 1
        Width = 62
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtQtdTraSepNExc: TEditFocus
        Left = 299
        Top = 1
        Width = 62
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object pnlTraRedesp: TPanel
      Left = 0
      Top = 170
      Width = 710
      Height = 26
      Align = alBottom
      ParentColor = True
      TabOrder = 14
      object Label21: TLabel
        Left = 1
        Top = 5
        Width = 100
        Height = 13
        Caption = 'Transp.Redespacho:'
      end
      object edtTraRedNom: TEditFocus
        Left = 168
        Top = 2
        Width = 445
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtTraRedCod: TEditFocus
        Tag = 99
        Left = 105
        Top = 2
        Width = 62
        Height = 21
        Alignment = taLeftJustify
        MaxLength = 5
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
    end
    object edtOutros: TEditFocus
      Tag = 99
      Left = 622
      Top = 25
      Width = 62
      Height = 21
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnHlpDes: TBitBtnLocked
      Left = 684
      Top = 24
      Width = 23
      Height = 23
      Hint = 'Clique aqui para exibir a instru'#231#227'o sobre esta rotina.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000800000010000000100000
        0008000000010000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
        0B60000000070000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
        27EA0000000E0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
        30EC0000000D0000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
        1A51000000050000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000600000011000000140000
        000A000000020000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000670503AA999532EFF4528
        187A000000070000000100000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
        4AF724150D490000000800000002000000000000000000000000000000000000
        0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
        9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
        000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
        AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
        00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
        76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
        000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
        70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
        000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
        C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
        0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
        77E570533B9A17100A2500000002000000000000000000000000000000000000
        0000000000000000000000000000000000010000000100000002000000030000
        0002000000020000000100000000000000000000000000000000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
    end
  end
end
