object fraDadosFechamentoPedidoTransportadoraFrame: TfraDadosFechamentoPedidoTransportadoraFrame
  Left = 0
  Top = 0
  Width = 497
  Height = 253
  VertScrollBar.Range = 45
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 497
    Height = 253
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlTransportadora: TGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 0
      Width = 493
      Height = 251
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Caption = 'Transportadora:'
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      object pnlTransportadoraFrete: TPanel
        Left = 2
        Top = 15
        Width = 489
        Height = 162
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblValFre: TLabel
          Left = 33
          Top = 29
          Width = 72
          Height = 13
          Alignment = taRightJustify
          Caption = 'Valor do Frete:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblQtdTra: TLabel
          Left = 31
          Top = 75
          Width = 71
          Height = 13
          Alignment = taRightJustify
          Caption = 'Volume (Qtd.):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblEspVol: TLabel
          Left = 189
          Top = 75
          Width = 94
          Height = 13
          Alignment = taRightJustify
          Caption = 'Esp'#233'cie (Cx., Pct.):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object btnCalcVolume: TSpeedButton
          Left = 160
          Top = 70
          Width = 24
          Height = 22
          Hint = 'Calcular a quantidade de volumes'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
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
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCalcVolumeClick
        end
        object btnCalcFreSug: TSpeedButton
          Left = 147
          Top = 24
          Width = 24
          Height = 22
          Hint = 'Carregar o valor do frete sugest'#227'o'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
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
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btnCalcFreSugClick
        end
        object Label2: TLabel
          Left = 26
          Top = 6
          Width = 79
          Height = 13
          Alignment = taRightJustify
          Caption = 'Transportadora:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblValFreCot: TLabel
          Left = 37
          Top = 50
          Width = 68
          Height = 13
          Alignment = taRightJustify
          Caption = 'Frete Cotado:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object edtValFre: TEditFocus
          Tag = 99
          Left = 108
          Top = 24
          Width = 40
          Height = 21
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 7
          ParentFont = False
          TabOrder = 1
          OnChange = edtValFreChange
          OnEnter = edtValFreEnter
          OnExit = edtValFreExit
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
          Left = 108
          Top = 70
          Width = 52
          Height = 21
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ParentFont = False
          TabOrder = 4
          OnKeyPress = edtQtdTraKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtEspVol: TEditFocus
          Tag = 99
          Left = 286
          Top = 70
          Width = 57
          Height = 21
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentFont = False
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnCalcularFrete: TBitBtnLocked
          Left = 175
          Top = 24
          Width = 151
          Height = 21
          Caption = 'Calcular Frete'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object edtCodTra: TEditFocus
          Tag = 99
          Left = 108
          Top = 1
          Width = 40
          Height = 21
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtCodTraKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomTra: TEditFocus
          Left = 149
          Top = 1
          Width = 336
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
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
        object edtValFreCot: TEditFocus
          Tag = 99
          Left = 108
          Top = 47
          Width = 62
          Height = 21
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 10
          ParentFont = False
          TabOrder = 2
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
        object pnlTransportadoraFreteAux: TPanel
          Left = 0
          Top = 115
          Width = 489
          Height = 47
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 8
          object Label23: TLabel
            Left = 309
            Top = 5
            Width = 93
            Height = 13
            Alignment = taRightJustify
            Caption = 'Despesa acess'#243'ria:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 18
            Top = 5
            Width = 87
            Height = 13
            Alignment = taRightJustify
            Caption = 'Frete para Conta:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 5
            Top = 28
            Width = 99
            Height = 13
            Alignment = taRightJustify
            Caption = 'N'#250'mero do Registro:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object btnDespesasFaturamento: TBitBtnLocked
            Left = 464
            Top = 0
            Width = 21
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
            TabOrder = 0
            Visible = False
            OnClick = btnDespesasFaturamentoClick
          end
          object cmbTipFre: TComboBoxFocus
            Tag = 99
            Left = 108
            Top = 1
            Width = 194
            Height = 21
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtDesAce: TEditFocus
            Tag = 99
            Left = 403
            Top = 1
            Width = 62
            Height = 21
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 7
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtNumReg: TEditFocus
            Tag = 99
            Left = 108
            Top = 24
            Width = 294
            Height = 21
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 80
            ParentFont = False
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 80
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlVolumeSepExc: TPanel
          Left = 0
          Top = 92
          Width = 489
          Height = 23
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 7
          object lblQtdTraSepExc: TLabel
            Left = 8
            Top = 6
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
            Left = 169
            Top = 6
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
            Left = 108
            Top = 1
            Width = 52
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
            Left = 291
            Top = 1
            Width = 52
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
      end
      object pnlTraRedesp: TPanel
        Left = 2
        Top = 200
        Width = 489
        Height = 23
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        object Label9: TLabel
          Left = 1
          Top = 4
          Width = 103
          Height = 13
          Alignment = taRightJustify
          Caption = 'Transp. Redespacho:'
        end
        object edtTraRedCod: TEditFocus
          Tag = 99
          Left = 108
          Top = 1
          Width = 40
          Height = 21
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtTraRedCodKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtTraRedNom: TEditFocus
          Left = 149
          Top = 1
          Width = 336
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
      end
      object pnlPeso: TPanel
        Left = 2
        Top = 223
        Width = 489
        Height = 26
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
        object lbl3: TLabel
          Left = 42
          Top = 6
          Width = 63
          Height = 13
          Alignment = taRightJustify
          Caption = 'Peso L'#237'quido:'
        end
        object lbl4: TLabel
          Left = 189
          Top = 6
          Width = 56
          Height = 13
          Alignment = taRightJustify
          Caption = 'Peso Bruto:'
        end
        object lblEdiPes: TLabel
          Left = 331
          Top = -1
          Width = 150
          Height = 26
          Cursor = crHandPoint
          Alignment = taCenter
          Caption = 'Caso deseje informar peso por produto, clique aqui'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          WordWrap = True
          OnClick = lblEdiPesClick
        end
        object edtPesLiq: TEditFocus
          Tag = 99
          Left = 108
          Top = 1
          Width = 73
          Height = 21
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 9
          TabOrder = 0
          OnExit = edtPesLiqExit
          OnKeyPress = edtPesLiqKeyPress
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
          Left = 248
          Top = 1
          Width = 70
          Height = 21
          Alignment = taRightJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 9
          TabOrder = 1
          OnExit = edtPesLiqExit
          OnKeyPress = edtPesLiqKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,###0.000'
        end
      end
      object pnlRota: TPanel
        Left = 2
        Top = 177
        Width = 489
        Height = 23
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object lblRota: TLabel
          Left = 56
          Top = 6
          Width = 49
          Height = 13
          Alignment = taRightJustify
          Caption = 'Seq.Rota:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtCodRot: TEditFocus
          Tag = 99
          Left = 108
          Top = 0
          Width = 63
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnKeyPress = edtCodRotKeyPress
          OnKeyUp = edtCodRotKeyUp
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
      end
    end
  end
  object tmrHideHints: TTimer
    OnTimer = tmrHideHintsTimer
    Left = 336
    Top = 112
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -13
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 376
    Top = 112
  end
end
