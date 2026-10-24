inherited frmConsultaControleDeColeta: TfrmConsultaControleDeColeta
  Width = 1475
  Height = 740
  BorderStyle = bsSizeable
  Caption = 'Controle de Coleta de Compras'
  WindowState = wsMaximized
  ExplicitTop = -38
  ExplicitWidth = 1475
  ExplicitHeight = 740
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 657
    Width = 1459
    ExplicitTop = 657
    ExplicitWidth = 1459
    inherited FlwBotoes: TFlowPanel
      Width = 1455
      ExplicitWidth = 1455
      object btnAlterar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 105
        Height = 22
        Caption = '[F2] Alterar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
          CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
          A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
          7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
          820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
          A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
          81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
          860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
          A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
          93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
          C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
          BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
          A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
          D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
          D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
          B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
          9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
          DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
          55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
          E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
          6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
          926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnAlterarClick
      end
      object btnEntregaPedVen: TBitBtnLocked
        Left = 105
        Top = 0
        Width = 133
        Height = 22
        Caption = '[F3] Entrega Pedido Venda'
        TabOrder = 4
        OnClick = btnEntregaPedVenClick
      end
      object btnCSV: TBitBtnLocked
        Left = 238
        Top = 0
        Width = 112
        Height = 22
        Caption = '[F8] Exportar CSV'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          001200000012000000110000000C000000030000000000000000000000087B50
          43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
          59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
          5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
          ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
          62FFFDFBFAFFCEAF69FFBA8D2CFFB68B2AFFB3892AFFB18728FFAF8526FFAD82
          25FFAA7F24FFA77D22FFA67C21FFA57A20FFA2761FFF6C4F14AD0000000BB079
          66FFFDFBFBFFBD932FFFDBC292FFFAF5F4FFF9F5F3FFB3892AFFF8F2F1FFF7F2
          EFFFD2B98AFFAA7E23FFC4A86EFFF5EEEAFFC2A66CFFA1791FFF0000000AB37C
          69FFFEFCFBFFC09430FFFBF7F6FFBB8E2DFFB88D2BFFB58B2AFFB3872AFFAF85
          27FFF7F2EFFFAC8124FFE4D5BCFFCEB686FFE2D3BAFFA37A20FF00000009B67F
          6CFFFEFDFCFFC19531FFFBF8F7FFBC922EFFBA8D2CFFB68C2BFFD7C08EFFF9F4
          F1FFD4BC8CFFAD8225FFF6F1EEFFA97E22FFF6EEEAFFA37B21FF00000009B983
          71FFFEFDFCFFC29732FFFCF8F8FFC0932FFFBB912FFFBA8D2DFFFAF5F3FFB489
          2AFFB18728FFAF8526FFF7F1EFFFAA7F24FFF6F0ECFFA67C21FF00000008BC88
          77FFFEFEFDFFC69933FFDFC996FFFCF8F8FFFAF8F7FFBB912EFFDAC291FFFAF5
          F4FFF8F3F0FFB18728FFF8F2F0FFAC8225FFF6F0EDFFA77D22FF00000007BF8C
          7AFFFEFEFDFFD7B871FFC39932FFC29532FFC09431FFBC922FFFBB8E2DFFB88D
          2CFFB58B2AFFB38729FFB18628FFAE8325FFAC8124FF735618AD00000006C18F
          7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
          82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
          85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
          89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
          67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
          87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
          0002000000030000000400000004000000050000000500000005000000060000
          0006000000060000000600000005000000010000000000000000}
        TabOrder = 3
        OnClick = btnCSVClick
      end
      object btnMarcar: TBitBtnLocked
        Left = 350
        Top = 0
        Width = 113
        Height = 22
        Caption = '[F5] Marca/Desmarca'
        TabOrder = 5
        OnClick = btnMarcarClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 463
        Top = 0
        Width = 121
        Height = 22
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
        TabOrder = 0
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 584
        Top = 0
        Width = 144
        Height = 22
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
        TabOrder = 1
        OnClick = btnDesmarcaTodosClick
      end
      object btnBaixar: TBitBtnLocked
        Left = 728
        Top = 0
        Width = 120
        Height = 22
        Caption = '[F10] Baixar Marcados'
        TabOrder = 6
        OnClick = btnBaixarClick
      end
      object btnCancelaBaixa: TBitBtnLocked
        Left = 848
        Top = 0
        Width = 105
        Height = 22
        Caption = '[F11] Cancela Baixa'
        TabOrder = 7
        OnClick = btnCancelaBaixaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1396
      Top = 2
      Width = 61
      ExplicitLeft = 1396
      ExplicitTop = 2
      ExplicitWidth = 61
    end
  end
  inherited pnlStatus: TPanel
    Top = 685
    Width = 1459
    ExplicitTop = 685
    ExplicitWidth = 1459
    inherited pnlNomeForm: TPanel
      Left = 1288
      ExplicitLeft = 1288
    end
    inherited pnlInfo: TPanel
      Width = 1288
      ExplicitWidth = 1288
      object shpMultSel: TShape
        Left = 1270
        Top = 2
        Width = 16
        Height = 12
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 564
        ExplicitTop = 1
        ExplicitHeight = 14
      end
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1459
    Height = 161
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    object lblEmpresa: TLabel
      Left = 26
      Top = 11
      Width = 84
      Height = 14
      Caption = 'Empresa Destino:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 51
      Top = 35
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 48
      Top = 60
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha/Grupo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 77
      Top = 83
      Width = 33
      Height = 14
      Caption = 'Marca:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 75
      Top = 107
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
    object Label4: TLabel
      Left = 70
      Top = 131
      Width = 40
      Height = 14
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object rdgStatus: TRadioGroup
      Left = 580
      Top = 109
      Width = 249
      Height = 40
      Caption = 'Coletas'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Abertas'
        'Baixadas'
        'Todas')
      TabOrder = 7
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 113
      Top = 8
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 179
      Top = 8
      Width = 387
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 113
      Top = 32
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
      TabOrder = 1
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFor: TEditFocus
      Tag = 99
      Left = 179
      Top = 32
      Width = 387
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 10
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
      Left = 113
      Top = 56
      Width = 65
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
      TabOrder = 2
      Text = ''
      OnExit = mskLinGruExit
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtLinGru: TEditFocus
      Left = 179
      Top = 56
      Width = 387
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 113
      Top = 80
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      ParentFont = False
      TabOrder = 3
      OnExit = edtCodMarExit
      OnKeyPress = edtCodMarKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtDesMar: TEditFocus
      Left = 179
      Top = 80
      Width = 387
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 113
      Top = 104
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
      TabOrder = 4
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCli: TEditFocus
      Tag = 99
      Left = 179
      Top = 104
      Width = 387
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 113
      Top = 128
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 5
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesIte: TEditFocus
      Left = 179
      Top = 128
      Width = 387
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 14
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 580
      Top = 7
      Width = 325
      Height = 82
      Caption = 'Op'#231#227'o de data'
      TabOrder = 6
      object Label6: TLabel
        Left = 176
        Top = 43
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Final:'
      end
      object Label9: TLabel
        Left = 172
        Top = 19
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Inicial:'
      end
      object rdbEntregaCompra: TRadioButton
        Left = 16
        Top = 17
        Width = 154
        Height = 17
        Caption = 'Data de entrega da compra'
        TabOrder = 0
      end
      object rdbEntregaVenda: TRadioButton
        Left = 16
        Top = 32
        Width = 153
        Height = 17
        Caption = 'Data de entrega da venda'
        TabOrder = 1
      end
      object mskDtaFin: TcxDateEdit
        Tag = 99
        Left = 230
        Top = 40
        AutoSize = False
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          00120000001300000013000000120000000C000000030000000A81594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
          67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
          E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
          F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
          83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
          D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
          F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
          86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
          FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
          D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
          FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
          8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
          FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
          DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
          FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
          91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          00070000000800000008000000070000000500000001}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ShowTime = False
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 4
        Height = 22
        Width = 87
      end
      object mskDtaIni: TcxDateEdit
        Tag = 99
        Left = 230
        Top = 16
        AutoSize = False
        Properties.ButtonGlyph.SourceDPI = 96
        Properties.ButtonGlyph.Data = {
          424D360400000000000036000000280000001000000010000000010020000000
          000000000000C40E0000C40E00000000000000000000000000020000000A0000
          0010000000110000001100000011000000120000001200000012000000120000
          00120000001300000013000000120000000C000000030000000A81594CC2B47C
          69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
          67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
          F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
          E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
          F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
          83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
          F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
          D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
          F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
          86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
          FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
          D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
          FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
          8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
          FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
          DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
          FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
          91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
          FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
          F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
          ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
          DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
          EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
          DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
          EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
          E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
          C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
          B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
          0006000000060000000600000007000000070000000700000007000000070000
          00070000000800000008000000070000000500000001}
        Properties.ClearKey = 46
        Properties.DateButtons = []
        Properties.MinDate = 2.000000000000000000
        Properties.ShowTime = False
        Properties.ValidateOnEnter = False
        Properties.ValidationOptions = []
        StyleFocused.Color = clInfoBk
        TabOrder = 3
        Height = 22
        Width = 87
      end
      object rdbUltimaAlteracao: TRadioButton
        Left = 16
        Top = 47
        Width = 153
        Height = 17
        Caption = 'Data '#250'ltima altera'#231#227'o'
        TabOrder = 2
      end
      object rdgNaoFiltrar: TRadioButton
        Left = 16
        Top = 63
        Width = 153
        Height = 17
        Caption = 'N'#227'o filtrar por data'
        Checked = True
        TabOrder = 5
        TabStop = True
      end
    end
    object btnCarregar: TBitBtnLocked
      Left = 835
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Consultar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000070000
        000B0000000C0000000C0000000C0000000C0000000C0000000C0000000D0000
        000D0000000D0000000D0000000D0000000D0000000C0000000882594DBEB47C
        6AFFB37C69FFB37B6AFFB37B69FFB37B68FFB37B68FFB37A69FFB37A68FFB37A
        68FFB37A68FFB27968FFB37967FFB27967FFB27967FF7F574ABFB67F6DFFF9F2
        EEFFF9F2EEFFF9F2EDFFF9F1EDFFC69A8CFFF9F2ECFFF9F1EDFFF9F1ECFFF9F1
        ECFFC5998BFFF8F0EBFFF8F0EBFFF8F0EBFFF8F0EBFFB37B69FFB78170FFF9F3
        EFFFF7EEE9FFF8EEE8FFF8EEE9FFC79C8DFFF7EEE9FFF8EEE8FFF8EEE9FFF7EE
        E8FFC69A8BFFF8EEE8FFF7EDE8FFF7EEE8FFF9F1ECFFB57D6BFFBA8472FFFAF4
        F0FFF8EFEAFFF8F0EAFFF8EFE9FFC99D8FFFF8EFEAFFF8EFEAFFF7EEEAFFF8EF
        EAFFC89D8EFFF7EFE9FFF8EFE9FFF7EFE9FFF9F1EDFFB7806EFFBB8776FFCCA2
        95FFCAA193FFCBA193FFCAA193FFCAA192FFCBA192FFCAA091FFCA9F91FFCA9F
        91FFC99F91FFC99F90FFC99E90FFC99E8FFFC99F90FFB88371FFBD8A79FFFBF6
        F2FFF9F1ECFFF9F1ECFFF9F0EDFFCCA295FFF8F1ECFFF9F1EBFFF9F0ECFFF9F1
        ECFFCAA194FFF9F0ECFFF9F1EBFFF8F0EBFFF9F3F0FFBA8574FFC08E7CFFFBF6
        F3FFF9F2EEFFFAF2EEFFF9F1EDFFCEA697FFF9F1EDFFF9F1EDFFF9F2EDFFF9F2
        ECFFCDA496FFF9F1EDFFF9F1ECFFF9F1EDFFFBF5F1FFBC8977FFC29180FFFCF8
        F5FFF9F2EFFFFAF3EFFFFAF2EFFFCFA89AFFFAF3EEFFF9F2EEFFF9F2EEFFFAF3
        EEFFCEA799FFF9F2EEFFF9F2EEFFF9F2EDFFFBF5F2FFBF8C7AFFC88E5AFFD9AD
        80FFCE9964FFCD9763FFCD9660FFCD9460FFCB935EFFCA925DFFC9905BFFC88F
        5AFFC88E59FFC88D57FFC88C56FFC78B55FFD19D6CFFBB7943FFC98F5AFFF1DA
        B5FFE7C28DFFE7C18DFFE7C18CFFCD9660FFE6BF89FFE5BE89FFE5BD87FFE5BC
        87FFC98E59FFE4BA84FFE4BA83FFE4B983FFECCDA3FFBC7A44FFCA905CFFF1DB
        B8FFE8C28EFFE7C28DFFE7C18CFFCD9662FFE6BF8BFFE6BE89FFE5BD88FFE5BC
        87FFC98F5AFFE4BB86FFE4BB84FFE4BA83FFEDCEA5FFBD7B45FFCA915EFFF2DD
        B9FFF1DAB9FFF1DAB7FFF1D9B6FFD8AC7EFFF0D8B3FFF0D6B2FFF0D6B1FFEFD5
        AFFFD5A576FFEFD2ACFFEED2A9FFEDD1A9FFEDD1A8FFBE7B45FF976C47BECA91
        5DFFCA8F5BFFC88E5AFFC78C58FFC68B57FFC58955FFC48852FFC48651FFC284
        50FFC2834EFFC0814CFFC0804BFFBF7F49FFBE7D48FF8D5D34BF000000010000
        0002000000020000000200000002000000020000000200000002000000020000
        0003000000030000000300000003000000030000000300000002000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 8
      OnClick = btnCarregarClick
    end
  end
  object cxgColetas: TcxGrid [3]
    Left = 0
    Top = 161
    Width = 1459
    Height = 423
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 4
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvColetas: TcxGridDBBandedTableView
      OnKeyDown = cxvColetasKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxvColetasCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.OnChanged = cxvColetasDataControllerFilterChanged
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhuma coleta encontrada>'
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.ContentEven = cxStyle1
      Bands = <
        item
          Caption = 'Pedido de Compra'
          FixedKind = fkLeft
        end
        item
        end
        item
          Caption = 'Pedido de Venda'
        end
        item
          Caption = 'Produto'
        end
        item
          Caption = 'Coleta'
        end
        item
          Caption = 'Endere'#231'o de Entrega'
        end
        item
        end
        item
          Caption = 'Dados da Coleta'
        end>
      object cxvColetasCON_NUMPED: TcxGridDBBandedColumn
        AlternateCaption = 'N'#250'mero Pedido Compra'
        Caption = 'N'#250'mero'
        DataBinding.FieldName = 'CON_NUMPED'
        HeaderAlignmentHorz = taCenter
        SortIndex = 1
        SortOrder = soAscending
        Width = 83
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvColetasColumn2: TcxGridDBBandedColumn
        AlternateCaption = 'Data Entrega Pedido Compra'
        Caption = 'Data de Entrega'
        DataBinding.FieldName = 'ENTCOM'
        HeaderAlignmentHorz = taCenter
        SortIndex = 0
        SortOrder = soAscending
        Width = 65
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvColetasColumn3: TcxGridDBBandedColumn
        Caption = 'Faturado pelo Fornecedor'
        DataBinding.FieldName = 'FATFOR'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvColetasColumn4: TcxGridDBBandedColumn
        Caption = 'N'#250'mero da Nota'
        DataBinding.FieldName = 'NOTENT'
        Visible = False
        HeaderAlignmentHorz = taCenter
        SortIndex = 2
        SortOrder = soAscending
        Width = 120
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvColetasColumn5: TcxGridDBBandedColumn
        Caption = 'Data de Emiss'#227'o'
        DataBinding.FieldName = 'DTAEMI'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvColetasColumn6: TcxGridDBBandedColumn
        Caption = 'Documentos com Entrada Realizada'
        DataBinding.FieldName = 'ENTREA'
        HeaderAlignmentHorz = taCenter
        Width = 81
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvColetasColumn7: TcxGridDBBandedColumn
        Caption = 'Local da Mercadoria'
        DataBinding.FieldName = 'DESLOC'
        HeaderAlignmentHorz = taCenter
        Width = 135
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvColetasColumn8: TcxGridDBBandedColumn
        Caption = 'Ordem de Compra no Fornecedor'
        DataBinding.FieldName = 'ORDCON'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 102
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvColetasColumn9: TcxGridDBBandedColumn
        AlternateCaption = 'N'#250'mero Pedido Venda'
        Caption = 'N'#250'mero do Pedido'
        DataBinding.FieldName = 'PEDVEN'
        HeaderAlignmentHorz = taCenter
        Width = 120
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvColetasColumn10: TcxGridDBBandedColumn
        AlternateCaption = 'Data Entrega Pedido Venda'
        Caption = 'Data de Entrega'
        DataBinding.FieldName = 'ENTVEN'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvColetasColumn11: TcxGridDBBandedColumn
        Caption = 'Nome do Cliente'
        DataBinding.FieldName = 'NOMCLI'
        HeaderAlignmentHorz = taCenter
        Width = 185
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvColetasColumn12: TcxGridDBBandedColumn
        Caption = 'C'#243'digo do Produto'
        DataBinding.FieldName = 'CON_CODITE'
        HeaderAlignmentHorz = taCenter
        SortIndex = 3
        SortOrder = soAscending
        Width = 61
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvColetasColumn13: TcxGridDBBandedColumn
        Caption = 'Peso Bruto'
        DataBinding.FieldName = 'PESBRU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 3
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxvColetasColumn14: TcxGridDBBandedColumn
        Caption = 'Quantidade em Caixas'
        DataBinding.FieldName = 'QTDCAI'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 3
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvColetasColumn15: TcxGridDBBandedColumn
        Caption = 'Quantidade (unidades venda)'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 3
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvColetasColumn16: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o do Produto'
        DataBinding.FieldName = 'DESITE'
        HeaderAlignmentHorz = taCenter
        Width = 205
        Position.BandIndex = 3
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvColetasColumn17: TcxGridDBBandedColumn
        Caption = 'C'#243'dido de F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        HeaderAlignmentHorz = taCenter
        Width = 100
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvColetasColumn18: TcxGridDBBandedColumn
        Caption = 'Peso L'#237'quido'
        DataBinding.FieldName = 'PESLIQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 3
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxvColetasColumn19: TcxGridDBBandedColumn
        Caption = 'Endere'#231'o'
        DataBinding.FieldName = 'ENDENT'
        HeaderAlignmentHorz = taCenter
        Width = 239
        Position.BandIndex = 5
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvColetasColumn20: TcxGridDBBandedColumn
        Caption = 'Bairro'
        DataBinding.FieldName = 'BAIENT'
        HeaderAlignmentHorz = taCenter
        Width = 113
        Position.BandIndex = 5
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvColetasColumn21: TcxGridDBBandedColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'CIDENT'
        HeaderAlignmentHorz = taCenter
        Width = 216
        Position.BandIndex = 5
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvColetasColumn22: TcxGridDBBandedColumn
        Caption = 'Estado'
        DataBinding.FieldName = 'ESTENT'
        HeaderAlignmentHorz = taCenter
        Width = 43
        Position.BandIndex = 5
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvColetasColumn23: TcxGridDBBandedColumn
        Caption = 'Observa'#231#227'o do Pedido de Venda'
        DataBinding.FieldName = 'OBSVEN'
        HeaderAlignmentHorz = taCenter
        Width = 256
        Position.BandIndex = 6
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvColetasColumn24: TcxGridDBBandedColumn
        Caption = #218'ltima Altera'#231#227'o'
        DataBinding.FieldName = 'CON_ULTALT'
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 7
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvColetasColumn26: TcxGridDBBandedColumn
        AlternateCaption = 'Observa'#231#227'o da Coleta'
        Caption = 'Observa'#231#227'o'
        DataBinding.FieldName = 'CON_OBSERV'
        HeaderAlignmentHorz = taCenter
        Width = 180
        Position.BandIndex = 7
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvColetasColumn27: TcxGridDBBandedColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'NOMOPE'
        HeaderAlignmentHorz = taCenter
        Width = 88
        Position.BandIndex = 7
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvColetasColumn25: TcxGridDBBandedColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 7
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvColetasMarcad: TcxGridDBBandedColumn
        Caption = 'Selecionado'
        DataBinding.FieldName = 'MARCAD'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvColetasColumn1: TcxGridDBBandedColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'CON_CODEMP'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 30
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvColetasColumn28: TcxGridDBBandedColumn
        Caption = 'Emp. Des.'
        DataBinding.FieldName = 'CON_EMPDES'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 30
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvColetasColumn29: TcxGridDBBandedColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'REFERE'
        HeaderAlignmentHorz = taCenter
        Width = 102
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvColetasColumn30: TcxGridDBBandedColumn
        Caption = 'Previs'#227'o Fatumento F'#225'brica'
        DataBinding.FieldName = 'CON_PREFAT'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 65
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvColetasColumn31: TcxGridDBBandedColumn
        Caption = 'Quantidade Total Pedido'
        DataBinding.FieldName = 'QTDPED'
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 3
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxvColetasMARCA: TcxGridDBBandedColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'MARCA'
        HeaderAlignmentHorz = taCenter
        Width = 91
        Position.BandIndex = 3
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvColetasColumn32: TcxGridDBBandedColumn
        Caption = 'Quantidade Pendente Entrada'
        DataBinding.FieldName = 'QTDPEN'
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 3
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxvColetasColumn33: TcxGridDBBandedColumn
        Caption = 'Quantidade Baixada Requisi'#231#227'o'
        DataBinding.FieldName = 'QTDRBA'
        HeaderAlignmentHorz = taCenter
        Width = 80
        Position.BandIndex = 3
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxvColetasColumn34: TcxGridDBBandedColumn
        Caption = 'Produto Baixado no Pedido'
        DataBinding.FieldName = 'BAIXAD'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 57
        Position.BandIndex = 3
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxvColetasQTDPENCOL: TcxGridDBBandedColumn
        Caption = 'Quantidade Pendende Coleta'
        DataBinding.FieldName = 'QTDPENCOL'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvColetasCON_QTDCOL: TcxGridDBBandedColumn
        Caption = #218'ltima Quantidade Coletada'
        DataBinding.FieldName = 'ULTQTDCOL'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvColetasQTDDIS: TcxGridDBBandedColumn
        Caption = 'Quantidade Dispon'#237'vel'
        DataBinding.FieldName = 'QTDDIS'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
    end
    object cxgColetasLevel1: TcxGridLevel
      GridView = cxvColetas
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 584
    Width = 1459
    Height = 73
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 3
    object GroupBox2: TGroupBox
      Left = 2
      Top = 6
      Width = 511
      Height = 57
      Caption = 'Total selecionado'
      TabOrder = 0
      object Label5: TLabel
        Left = 14
        Top = 24
        Width = 56
        Height = 14
        Caption = 'Peso Bruto:'
      end
      object Label7: TLabel
        Left = 182
        Top = 24
        Width = 64
        Height = 14
        Caption = 'Peso L'#237'quido:'
      end
      object Label8: TLabel
        Left = 359
        Top = 24
        Width = 36
        Height = 14
        Caption = 'Metros:'
      end
      object dbeCodLoc: TDBEditFocus
        Tag = 99
        Left = 72
        Top = 21
        Width = 97
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        DataField = 'SUM_TOTBRU'
        DataSource = dtsConsulta
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus1: TDBEditFocus
        Tag = 99
        Left = 248
        Top = 21
        Width = 97
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        DataField = 'SUM_TOTLIQ'
        DataSource = dtsConsulta
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus2: TDBEditFocus
        Tag = 99
        Left = 397
        Top = 21
        Width = 97
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        DataField = 'SUM_TOTMET'
        DataSource = dtsConsulta
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 536
    Top = 376
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 360
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 752
    Top = 320
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 112
    Top = 344
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 14737632
    end
  end
  object dtsConsulta: TDataSource
    Left = 80
    Top = 440
  end
end
