object fraDadosFechamentoPedidoFrame: TfraDadosFechamentoPedidoFrame
  Left = 0
  Top = 0
  Width = 497
  Height = 523
  VertScrollBar.Range = 45
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 497
    Height = 523
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlBombeamento: TGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 0
      Width = 493
      Height = 63
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Dados do Bombeamento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Visible = False
      object lblTotalBombeamento: TLabel
        Left = 366
        Top = 38
        Width = 55
        Height = 13
        Alignment = taRightJustify
        Caption = 'Valor Total:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblQtdBombeamento: TLabel
        Left = 47
        Top = 39
        Width = 60
        Height = 13
        Alignment = taRightJustify
        Caption = 'Quantidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblPrecoBombeamento: TLabel
        Left = 226
        Top = 39
        Width = 31
        Height = 13
        Alignment = taRightJustify
        Caption = 'Pre'#231'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtTotBom: TEditFocus
        Tag = 99
        Left = 423
        Top = 33
        Width = 64
        Height = 21
        TabStop = False
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
        ReadOnly = True
        TabOrder = 0
        OnExit = edtQtdBomExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtQtdBom: TEditFocus
        Tag = 99
        Left = 110
        Top = 34
        Width = 64
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        OnExit = edtQtdBomExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtPrcBom: TEditFocus
        Tag = 99
        Left = 259
        Top = 34
        Width = 64
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
        OnExit = edtQtdBomExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object chkTaxMin: TCheckBox
        Left = 110
        Top = 17
        Width = 132
        Height = 17
        Caption = 'Cobrar Taxa M'#237'nima'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = chkTaxMinClick
      end
    end
    object pnlOutrasInformacoes: TGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 63
      Width = 493
      Height = 319
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Outras Informa'#231#245'es:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object lblValidade: TLabel
        Left = 246
        Top = 42
        Width = 44
        Height = 13
        Alignment = taRightJustify
        Caption = 'Validade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object chkPedExp: TCheckBox
        Tag = 99
        Left = 45
        Top = 44
        Width = 176
        Height = 17
        Caption = 'Liberar para expedi'#231#227'o faturar?'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 2
        OnClick = chkAgrIteClick
      end
      object btnPedCmp: TBitBtnLocked
        Left = 403
        Top = 12
        Width = 84
        Height = 45
        Caption = '&Pedidos '#13#10'de Compra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          F2010000424DF201000000000000F20000002800000010000000100000000100
          08000000000000010000340B0000340B00002F0000002F000000EA8F3100B66A
          5000AB735800C07B5800EAA15800FFB65800AB6A6000B67B6000C08460006A6A
          6A00A16A6A00A1736A00C0846A006AFF6A00A17B7300B68F7B00F4C07B00B68F
          8400F4C08400F4CA8400B6988F00C0988F00F4CA8F00B6AB9800F4CA9800D4AB
          A100D4B6A100E0B6A100EAB6A100EAC0A100F4D4A100FFD4A100EAC0AB00F4D4
          AB00F4E0B600E0C0C000E0CAC000E0CACA00F4E0CA00FFEACA00FFEAD400FFF4
          E000FFF4EA00FFF4F400FFFFF400FF00FF00FFFFFF002D2D0A0A0A0A0A0A0A0A
          0A0A0A0A0A2D2D2D112722211E181612101010130A2D2D2D1127090909090909
          090909120A2D2D2D14290D0D0D0D0D0D0D0D0D120A2D2D2D14290D0D0D0D0D0D
          0D0D0D100A2D2D2D142C090909090909090909120A2D2D2D1A2E0D0D0D0D0D0D
          0D0D0D0D0A2D2D2D1A2E0D0D0D0D0D0D0D0D0D0D0A2D2D2D1A2E090909090909
          0909091E0A2D2D2D192E0D0D0D0D0D0D0D0D0D1E0A2D2D2D1A2E0D0D0D0D0D0D
          0D0D0D170A2D2D2D1B2E09090909092A260F0E0B0A2D2D2D1B2E0D0D0D0D0D0D
          23020400012D2D2D202E0D0D0D0D0D0D240705032D2D2D2D1B2B2A2A2A2A2A2A
          23070C2D2D2D2D2D1B1D1D1D1D1B1B1D19062D2D2D2D}
        ParentFont = False
        TabOrder = 5
        TabStop = False
        OnClick = btnPedCmpClick
      end
      object pnlGerPen: TPanel
        Left = 234
        Top = 12
        Width = 167
        Height = 24
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
        object lbl2: TLabel
          Left = 2
          Top = 5
          Width = 83
          Height = 13
          Alignment = taRightJustify
          Caption = 'Gerar Pendencia:'
        end
        object ColorLabel6: TColorLabel
          Left = 109
          Top = 5
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object edtGerPen: TEditFocus
          Tag = 99
          Left = 87
          Top = 1
          Width = 19
          Height = 21
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 1
          TabOrder = 0
          Text = 'S'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlContato: TPanel
        Left = 2
        Top = 134
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
        TabOrder = 7
        object lblCliCtt: TLabel
          Left = 26
          Top = 3
          Width = 79
          Height = 13
          Alignment = taRightJustify
          Caption = 'Contato Cliente:'
        end
        object edtCliCtt: TEditFocus
          Left = 108
          Top = 0
          Width = 331
          Height = 21
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object btnPesquisarContato: TBitBtnLocked
          Left = 441
          Top = -1
          Width = 22
          Height = 22
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000265EB219376EF52C130E67000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000033571C2008EECFF009AF4FF1F4B80FF000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000010108468AD82BA7F5FF16C0FFFF00A0F3FF01356EAA000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            01010C579EE268C4F8FF6BD4FFFF279CE6FF0434679E00000000000000000000
            000000000000000000000000000000000000000000000000000000000000186A
            B1DBA4E3FEFFB5EEFFFF4CAAE7FF01386C9A0000000000000000000000000000
            000001000002270F0F86482727BD65443FD1482728C12C10107B57464F9D359E
            E8FFBDF5FFFF77C4EFFF003E779C000000000000000000000000000000001207
            073A7B5554FCDFD3CBFFFFFFF7FFFFFFE7FFFFFEDBFFD6BB9EFF90584DFF817B
            8EFF1794E4FF014B7F95000000000000000000000000000000000904041B8865
            65FFFFFFFFFFFFFFFFFFFDF8E8FFFAF2DCFFF8EDCFFFFFF1CFFFF6DEBAFF9F59
            45FF1A21305A00000000000000000000000000000000000000003F24249BF6EF
            EAFFFFFFFFFFFEFBF5FFFBF7E8FFF9F4DAFFF5EBCCFFE6CEACFFF3DAB8FFE2BD
            99FF513134A60000000000000000000000000000000000000000886A68F4FFFF
            FFFFFDFBF1FFFCF8EEFFFAF3E1FFFCF5E3FFF7F0D7FFF0DFC1FFE7C9A9FFF0D1
            ABFF946A61EC0806060F00000000000000000000000000000000907471F7FFFF
            FCFFF9F2E1FFFAF3DEFFFAF7E5FFFAF1DCFFF1DFC0FFEDD9BAFFECD8B9FFEDCA
            A5FFAF8679FF1510122800000000000000000000000000000000957974F9FFFF
            EBFFF9EED5FFFAF1D7FFF9F2DAFFF2E3C6FFFEFBF9FFFFFFF0FFEFDFC0FFE9C6
            9EFFA57A70F40F0C0D1A00000000000000000000000000000000604646B0F7EA
            C8FFF9EBCCFFEFDCBEFFF4E4C7FFF0E1C5FFFDFCECFFFAF5DDFFEFDCBCFFDFB0
            87FF816565CB000000000000000000000000000000000000000021181A43BA99
            8CFFFDECC4FFEDD4B0FFE5CAA8FFEFDBBFFFF2E3C4FFF2DEBCFFEABF93FFBB8E
            7DFF2E2729470000000000000000000000000000000000000000000000003A2A
            316BBE9A8DFFE6C7A5FFEFCBA3FFECC8A2FFE8BE94FFDCAA86FFBE9585FF433A
            3C64000000000000000000000000000000000000000000000000000000000000
            0000201A1C366D5758A3B3958DF9B7948AF3B6968DF7776563AB1F1C1E2E0000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 1
          TabStop = False
          OnClick = btnPesquisarContatoClick
        end
        object btnAdicionarContato: TBitBtnLocked
          Left = 463
          Top = -1
          Width = 22
          Height = 22
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000100010E1A06261D350C4D1D340C4C0E19
            0625000100010000000000000000000000000000000000000000000000000000
            000000000000000000001F390D53559A23DC68BD2AFF6AC12BFF6BC12CFF68BC
            2AFF559720DA1E360C4F00000000000000000000000000000000000000000000
            000000010001396917976BC22BFF71CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC
            2EFF71CC2EFF6BC12BFF38651792000100010000000000000000000000000000
            00003056137B6EC72DFF71CC2EFF71CC2EFF71CC2EFF69BE2BFF69BF2BFF71CC
            2EFF71CC2EFF71CC2EFF6EC62DFF2D501273000000000000000000000000070D
            031369BF2AFC71CC2EFF71CC2EFF71CC2EFF71CC2EFFC4DEACFFC2DDA9FF71CC
            2EFF71CC2EFF71CC2EFF71CC2EFF68BB28FA060B021000000000000000003560
            158471CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFFC4DEACFFC2DDA9FF71CC
            2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFF3158147B0000000000000000559C
            23CE71CC2EFF71CC2EFF6CC22CFF6CC22CFF6CC22CFFC4DDACFFC1DCA9FF6CC2
            2CFF6CC22CFF6CC22CFF71CC2EFF71CC2EFF549722C900000000000000005EAD
            27E171CC2EFF71CC2EFFC0D9A8FFC0D9A8FFC0D9A8FFE2E9D6FFE0E8D5FFC0D9
            A8FFC0D9A8FFC0D9A8FF71CC2EFF71CC2EFF5EAA24DD00000000000000005DA8
            25D971CC2EFF71CC2EFFC8E4AEFFC8E4AEFFC8E4AEFFE2EAD7FFE2EAD7FFC8E4
            AEFFC8E4AEFFC8E4AEFF71CC2EFF71CC2EFF5AA425D400000000000000004780
            1DA771CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFFC4DEACFFC2DDA9FF71CC
            2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFF447C1CA000000000000000001728
            0A3371CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFFC4DEACFFC2DDA9FF71CC
            2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFF1424082D00000000000000000000
            0000529721C171CC2EFF71CC2EFF71CC2EFF71CC2EFFC6E2ADFFC4E1AAFF71CC
            2EFF71CC2EFF71CC2EFF71CC2EFF519321BA0000000000000000000000000000
            00000910041461B429E271CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC
            2EFF71CC2EFF71CC2EFF62B226DF080E03110000000000000000000000000000
            000000000000091004144F8F20B571CC2EFF71CC2EFF71CC2EFF71CC2EFF71CC
            2EFF71CC2EFF4E8D20B1080E0312000000000000000000000000000000000000
            000000000000000000000000000015260930396617804A851EA648831EA53866
            177F1425082E0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 2
          TabStop = False
          OnClick = btnAdicionarContatoClick
        end
      end
      object pnlTipAte: TPanel
        Left = 2
        Top = 203
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
        TabOrder = 10
        object lblTipAte: TLabel
          Left = 20
          Top = 5
          Width = 85
          Height = 13
          Caption = 'Tipo de Atendim.:'
        end
        object edtDesTpa: TEditFocus
          Left = 172
          Top = 0
          Width = 313
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
        object edtCodTpa: TEditFocus
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
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtCodTpaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlPorPed: TPanel
        Left = 2
        Top = 226
        Width = 489
        Height = 22
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
        TabOrder = 11
        object lbl7: TLabel
          Left = 4
          Top = 6
          Width = 165
          Height = 13
          Alignment = taRightJustify
          Caption = 'Portador Contas Receber/Boletos:'
        end
        object edtPorPed: TEditFocus
          Tag = 99
          Left = 172
          Top = 0
          Width = 55
          Height = 21
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtPorPedKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomPorPed: TEditFocus
          Left = 228
          Top = 0
          Width = 257
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
      end
      object pnlOpcoesPV: TPanel
        Left = 2
        Top = 157
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
        TabOrder = 8
        object Label6: TLabel
          Left = 47
          Top = 5
          Width = 58
          Height = 14
          Caption = 'Finalidade:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cmbFinalidade: TComboBoxFocus
          Left = 108
          Top = 0
          Width = 231
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnClick = cmbFinalidadeClick
          Items.Strings = (
            'Pedido para Nota Fiscal'
            'Pedido para Cupom Fiscal')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object chkEntUrg: TCheckBox
        Left = 45
        Top = 29
        Width = 176
        Height = 17
        Caption = 'Urgente?'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = chkEntUrgClick
      end
      object chkAgrIte: TCheckBox
        Tag = 99
        Left = 45
        Top = 14
        Width = 176
        Height = 17
        Caption = 'Agrupar itens por caracter'#237'sticas?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Visible = False
        OnClick = chkAgrIteClick
      end
      object pnlProjeto: TPanel
        Left = 2
        Top = 180
        Width = 489
        Height = 23
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 9
        object Label12: TLabel
          Left = 15
          Top = 4
          Width = 90
          Height = 13
          Caption = 'Projeto do Cliente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtCodPrj: TEditFocus
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
          MaxLength = 6
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtCodPrjKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttAlfanumerico
        end
        object edtDesPrj: TEditFocus
          Left = 172
          Top = 0
          Width = 313
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
      end
      object edtValidade: TMaskEditFocus
        Tag = 99
        Left = 292
        Top = 36
        Width = 83
        Height = 21
        EditMask = '99/99/9999;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 4
        Text = '  /  /    '
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object pnlTipOpe: TPanel
        Left = 2
        Top = 62
        Width = 489
        Height = 72
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
        TabOrder = 6
        object lblTipOpe: TLabel
          Left = 16
          Top = 5
          Width = 89
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tipo de Opera'#231#227'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object cblTipOpe2: TColorLabel
          Left = 323
          Top = 5
          Width = 80
          Height = 14
          Caption = '(C)onta e Ordem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object cblTipOpe: TColorLabel
          Left = 130
          Top = 5
          Width = 40
          Height = 14
          Caption = '(V)enda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object cblTipOpe1: TColorLabel
          Left = 173
          Top = 5
          Width = 65
          Height = 14
          Caption = '(B)onifica'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object cblTipOpe4: TColorLabel
          Left = 242
          Top = 5
          Width = 78
          Height = 14
          Caption = '(D)emonstra'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object cblTipOpe3: TColorLabel
          Left = 407
          Top = 5
          Width = 59
          Height = 14
          Caption = '(A) Amostra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object cblTipOpe5: TColorLabel
          Left = 129
          Top = 19
          Width = 85
          Height = 14
          Caption = '(U) Uso/Consumo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object cblTipOpe6: TColorLabel
          Left = 218
          Top = 19
          Width = 224
          Height = 14
          Caption = '(E) Venda para fins de exporta'#231#227'o CFOP x501'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object cblTipOpe7: TColorLabel
          Left = 129
          Top = 32
          Width = 153
          Height = 14
          Caption = '(R) Remessa de Conta e Ordem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object edtTipOpe: TEditFocus
          Tag = 99
          Left = 108
          Top = 1
          Width = 19
          Height = 21
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 1
          ParentFont = False
          TabOrder = 0
          Text = 'V'
          OnChange = edtTipOpeChange
          OnExit = edtTipOpeExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object pnlClienteTipoOperacao: TPanel
          Left = 0
          Top = 45
          Width = 489
          Height = 27
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object lblCliTop: TLabel
            Left = 22
            Top = 8
            Width = 83
            Height = 13
            Alignment = taRightJustify
            Caption = 'Cliente Remessa:'
          end
          object edtCliTop: TEditFocus
            Tag = 99
            Left = 108
            Top = 5
            Width = 63
            Height = 21
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 8
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnExit = edtCliTopExit
            OnKeyPress = edtCliTopKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object edtNclTop: TEditFocus
            Left = 172
            Top = 5
            Width = 247
            Height = 21
            TabStop = False
            Alignment = taLeftJustify
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
          object btnItensPedidoRemessa: TBitBtnLocked
            Left = 420
            Top = 1
            Width = 65
            Height = 25
            Caption = 'Itens Ped.'
            TabOrder = 2
            OnClick = btnItensPedidoRemessaClick
          end
        end
      end
      object pnlCategoria: TPanel
        Left = 2
        Top = 248
        Width = 489
        Height = 23
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 12
        object lblCategoria: TLabel
          Left = 54
          Top = 6
          Width = 51
          Height = 13
          Caption = 'Categoria:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtCodCategoria: TEditFocus
          Tag = 99
          AlignWithMargins = True
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
          MaxLength = 6
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtCodCategoriaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttAlfanumerico
        end
        object edtDesCat: TEditFocus
          Left = 172
          Top = 0
          Width = 313
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
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
      object pnlEventos: TPanel
        Left = 2
        Top = 271
        Width = 489
        Height = 23
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 13
        object lblEventos: TLabel
          Left = 22
          Top = 4
          Width = 83
          Height = 13
          Caption = 'Centro de Custo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtDesEvento: TEditFocus
          Left = 172
          Top = 0
          Width = 313
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
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
        object edtCodEvento: TEditFocus
          Tag = 99
          AlignWithMargins = True
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
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtCodEventoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlEmpFat: TPanel
        Left = 2
        Top = 294
        Width = 489
        Height = 23
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 14
        object lblEmpFat: TLabel
          Left = 12
          Top = 5
          Width = 93
          Height = 13
          Caption = 'Emp. Faturamento:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtCodEmpFat: TEditFocus
          Tag = 99
          AlignWithMargins = True
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
          MaxLength = 3
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtCodEmpFatKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesEmpFat: TEditFocus
          Left = 172
          Top = 0
          Width = 313
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
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
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
    end
    object pnlTipoDeFaturamento: TGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 382
      Width = 493
      Height = 47
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Tipo de Faturamento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object lblTipFat: TColorLabel
        Left = 150
        Top = 18
        Width = 320
        Height = 14
        AutoSize = False
        Caption = '(A) - Nota Fiscal    (B) - FF    (C) - Cupom Fiscal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object lblPdvAlt: TLabel
        Left = 55
        Top = 35
        Width = 199
        Height = 12
        Alignment = taCenter
        Caption = 'Utilize o PDVCitel para confirma'#231#227'o em Cupom'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
        WordWrap = True
      end
      object Label11: TLabel
        Left = 83
        Top = 20
        Width = 24
        Height = 13
        Alignment = taRightJustify
        Caption = 'Tipo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtTipFat: TEditFocus
        Tag = 99
        Left = 110
        Top = 15
        Width = 33
        Height = 21
        Alignment = taCenter
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 1
        ParentFont = False
        TabOrder = 0
        OnChange = edtTipFatChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object pnlFinalizacaoDoPedido: TGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 429
      Width = 493
      Height = 44
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Finaliza'#231#227'o do Pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Visible = False
      object lblFinPed: TLabel
        AlignWithMargins = True
        Left = 18
        Top = 18
        Width = 234
        Height = 24
        Margins.Left = 16
        Align = alLeft
        Caption = 'Finalizar o pedido e gerar pedidos para as lojas?'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 14
      end
      object pnlFinaliza: TPanel
        Left = 255
        Top = 15
        Width = 236
        Height = 27
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object ColorLabel5: TColorLabel
          Left = 27
          Top = 5
          Width = 58
          Height = 14
          Caption = '(S)im  (N)'#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object edtFinaliza: TEditFocus
          Tag = 99
          Left = 3
          Top = 0
          Width = 21
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 1
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object gpbRetornarContatoCliente: TGroupBox
      AlignWithMargins = True
      Left = 2
      Top = 473
      Width = 493
      Height = 44
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Retornar contato ao cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Visible = False
      object Panel2: TPanel
        Left = 2
        Top = 15
        Width = 489
        Height = 27
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lblDataRetorno: TLabel
          Left = 7
          Top = 9
          Width = 25
          Height = 14
          Caption = 'Data:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblHoraRetorno: TLabel
          Left = 108
          Top = 9
          Width = 26
          Height = 14
          Caption = 'Hora:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object mskDataRetorno: TMaskEditFocus
          Tag = 99
          Left = 36
          Top = 1
          Width = 64
          Height = 21
          EditMask = '!99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 0
          Text = '  /  /    '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object mskHoraRetorno: TMaskEditFocus
          Tag = 99
          Left = 137
          Top = 1
          Width = 64
          Height = 21
          EditMask = '!99:99;1;_'
          MaxLength = 5
          TabOrder = 1
          Text = '  :  '
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
    end
  end
end
