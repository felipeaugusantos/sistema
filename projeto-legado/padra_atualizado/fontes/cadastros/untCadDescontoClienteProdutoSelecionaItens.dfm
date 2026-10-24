inherited frmCadDescontoClienteProdutoSelecionaItens: TfrmCadDescontoClienteProdutoSelecionaItens
  Height = 590
  Caption = 'Cadastro de Desconto Cliente / Produtos - Curva ABC Produtos'
  ExplicitHeight = 590
  PixelsPerInch = 96
  TextHeight = 14
  object pbProgresso: TGauge [0]
    Left = 0
    Top = 491
    Width = 717
    Height = 16
    Align = alBottom
    ForeColor = clBlue
    Progress = 100
    Visible = False
    ExplicitLeft = 8
    ExplicitTop = 492
    ExplicitWidth = 725
  end
  inherited pnlBotoes: TPanel
    Top = 507
    TabOrder = 1
    ExplicitTop = 507
    inherited FlwBotoes: TFlowPanel
      Width = 622
      ExplicitWidth = 622
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 0
        Height = 24
        Align = alLeft
        Visible = False
        ExplicitWidth = 0
        ExplicitHeight = 24
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 0
        Width = 0
        Height = 24
        Align = alLeft
        Visible = False
        ExplicitLeft = 0
        ExplicitWidth = 0
        ExplicitHeight = 24
      end
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 123
        Height = 24
        Align = alLeft
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 123
        Top = 0
        Width = 127
        Height = 24
        Align = alLeft
        Caption = '[ F6 ] Marca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 250
        Top = 0
        Width = 146
        Height = 24
        Align = alLeft
        Caption = '[ F7 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 624
      Top = 2
      Width = 91
      Height = 24
      Align = alRight
      ExplicitLeft = 624
      ExplicitTop = 2
      ExplicitWidth = 91
      ExplicitHeight = 24
    end
  end
  inherited pnlHeader: TPanel
    Height = 150
    ExplicitHeight = 150
    object Label2: TLabel
      Left = 13
      Top = 12
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Faturamento de:'
    end
    object Label3: TLabel
      Left = 166
      Top = 12
      Width = 6
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object Label1: TLabel
      Left = 56
      Top = 36
      Width = 35
      Height = 14
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 58
      Top = 58
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object lbl2: TLabel
      Left = 29
      Top = 82
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha/Grupo:'
    end
    object lbl3: TLabel
      Left = 32
      Top = 104
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object lbl4: TLabel
      Left = 10
      Top = 128
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#237'vel do Produto:'
    end
    object clb1: TColorLabel
      Left = 122
      Top = 128
      Width = 117
      Height = 14
      Caption = '(A), (B),  (C) ou (T)odos'
      CorDestaque = clRed
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 93
      Top = 7
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 178
      Top = 7
      Width = 65
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 93
      Top = 30
      Width = 65
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
      TabOrder = 2
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 159
      Top = 30
      Width = 359
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 93
      Top = 76
      Width = 63
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 6
      Text = ''
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 93
      Top = 53
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 6
      TabOrder = 4
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtDesMar: TEditFocus
      Left = 159
      Top = 53
      Width = 359
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesGru: TEditFocus
      Left = 159
      Top = 76
      Width = 359
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 93
      Top = 99
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 9
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object edtDesFor: TEditFocus
      Left = 159
      Top = 99
      Width = 359
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNvlGir: TEditFocus
      Tag = 99
      Left = 93
      Top = 122
      Width = 26
      Height = 22
      Alignment = taCenter
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 10
      Text = 'T'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object btnCarregarItens: TBitBtnLocked
      Left = 390
      Top = 122
      Width = 128
      Height = 22
      Caption = '&Carregar Produtos'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 11
      OnClick = btnCarregarItensClick
    end
  end
  inherited pnlTail: TPanel
    Top = 371
    Height = 120
    Visible = True
    ExplicitTop = 371
    ExplicitHeight = 120
    object dbgAnalitico: TDBGridCitel
      Left = 0
      Top = 0
      Width = 717
      Height = 89
      Align = alClient
      DataSource = dtsAnalitico
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CODEMP'
          Title.Caption = 'Emp.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMEMP'
          Title.Caption = 'Nome Empresa'
          Width = 159
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'QTDITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtd.Venda'
          Width = 66
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TOTITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr.Faturam.'
          Width = 80
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PERREP'
          Title.Alignment = taRightJustify
          Title.Caption = '% Rep.'
          Width = 40
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'TOTCUS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr.Custo'
          Width = 80
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'SALEST'
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtd.Estoque'
          Width = 70
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VALEST'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr.Estoque'
          Width = 81
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ESTMIN'
          Title.Alignment = taRightJustify
          Title.Caption = 'Est.Minimo'
          Width = 70
          Visible = True
        end>
    end
    object pnl1: TPanel
      Left = 0
      Top = 89
      Width = 717
      Height = 31
      Align = alBottom
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object lbl5: TLabel
        Left = 154
        Top = 11
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'TOTAIS:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtQtdVen: TEditFocus
        Left = 200
        Top = 6
        Width = 68
        Height = 20
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtTotVen: TEditFocus
        Left = 267
        Top = 6
        Width = 82
        Height = 20
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtPerRep: TEditFocus
        Left = 348
        Top = 6
        Width = 43
        Height = 20
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = '100%'
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtTotCus: TEditFocus
        Left = 390
        Top = 6
        Width = 83
        Height = 20
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtSalEst: TEditFocus
        Left = 472
        Top = 6
        Width = 71
        Height = 20
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtValEst: TEditFocus
        Left = 542
        Top = 6
        Width = 84
        Height = 20
        TabStop = False
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Color = 16768952
        Ctl3D = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 190
    Height = 150
    Options = [dgTitles, dgIndicator, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 309
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REFERE'
        Title.Caption = 'Refer'#234'ncia'
        Width = 140
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SIGUNI'
        Title.Alignment = taCenter
        Title.Caption = 'UN'
        Width = 32
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TOTITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total'
        Width = 90
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PERREP'
        Title.Alignment = taRightJustify
        Title.Caption = '% Rep.'
        Width = 52
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 150
    ExplicitTop = 150
  end
  object pnl2: TPanel [7]
    Left = 0
    Top = 340
    Width = 717
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 6
    object lbl6: TLabel
      Left = 504
      Top = 11
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'TOTAIS:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtTotVenGer: TEditFocus
      Left = 549
      Top = 6
      Width = 92
      Height = 20
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
      NormalColor = 16768952
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edt3: TEditFocus
      Left = 640
      Top = 6
      Width = 55
      Height = 20
      TabStop = False
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Ctl3D = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = '100%'
      NormalColor = 16768952
      FocusColor = clMoneyGreen
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 535
    TabOrder = 0
    ExplicitTop = 535
    inherited pnlNomeForm: TPanel
      Left = 392
      Width = 325
      ExplicitLeft = 392
      ExplicitWidth = 325
    end
    inherited pnlInfo: TPanel
      Width = 392
      ExplicitWidth = 392
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 656
    Top = 56
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 24
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 560
    Top = 56
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 592
    Top = 56
  end
  inherited dtsConsulta: TDataSource
    Left = 624
    Top = 56
  end
  object dtsAnalitico: TDataSource
    Left = 312
    Top = 312
  end
end
