inherited frmFatBaixaEntregaFutura: TfrmFatBaixaEntregaFutura
  Left = 138
  Top = 196
  Width = 1227
  Height = 561
  BorderStyle = bsSingle
  Caption = 'Baixa de Entrega Futura'
  Position = poMainFormCenter
  ExplicitLeft = -85
  ExplicitWidth = 1227
  ExplicitHeight = 561
  PixelsPerInch = 96
  TextHeight = 14
  object lblInformacao: TLabel [0]
    Left = 0
    Top = 343
    Width = 1221
    Height = 24
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 'AGUARDE PROCESSANDO REGISTROS...'
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Verdana'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    Visible = False
    ExplicitTop = 344
    ExplicitWidth = 792
  end
  object pgbProgresso: TcxProgressBar [1]
    Left = 0
    Top = 367
    Align = alBottom
    Properties.PeakValue = 30.000000000000000000
    TabOrder = 7
    Visible = False
    ExplicitTop = 368
    Width = 1221
  end
  inherited pnlBotoes: TPanel
    Top = 466
    Width = 1221
    Height = 50
    TabOrder = 2
    TabStop = True
    ExplicitTop = 466
    ExplicitWidth = 1221
    ExplicitHeight = 50
    inherited FlwBotoes: TFlowPanel
      Width = 1217
      Height = 46
      ExplicitWidth = 1217
      ExplicitHeight = 46
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 124
        TabStop = False
        Visible = False
        ExplicitWidth = 124
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 124
        Width = 122
        TabStop = False
        Visible = False
        ExplicitLeft = 124
        ExplicitWidth = 122
      end
      object btnGravar: TBitBtnLocked
        Left = 246
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 2
        OnClick = btnGravarClick
      end
      object btnEndEnt: TBitBtnLocked
        Left = 376
        Top = 0
        Width = 180
        Height = 22
        Caption = '[ F2 ] Endere'#231'o Entrega para baixa '
        TabOrder = 3
        OnClick = btnEndEntClick
      end
      object btnAlteraMotivo: TBitBtnLocked
        Left = 556
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F4 ] Alterar o Motivo'
        TabOrder = 4
        OnClick = btnAlteraMotivoClick
      end
      object btnBaixaSimplificada: TBitBtnLocked
        Left = 686
        Top = 0
        Width = 130
        Height = 22
        Caption = '[ F3 ] Baixa Simplificada'
        TabOrder = 5
        OnClick = btnBaixaSimplificadaClick
      end
      object btnLimpaSeparacao: TBitBtnLocked
        Left = 816
        Top = 0
        Width = 180
        Height = 22
        Caption = '[ F9 ] Desfazer Separa'#231#227'o'
        TabOrder = 6
        Visible = False
        OnClick = btnLimpaSeparacaoClick
      end
      object btnEstLoj: TBitBtnLocked
        Left = 996
        Top = 0
        Width = 130
        Height = 22
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        Caption = '[F11] Estoque Lojas'
        TabOrder = 7
        OnClick = btnEstLojClick
      end
      object btnEndEntDoc: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 320
        Height = 22
        Caption = '[ F8 ] Altera'#231#227'o de Endere'#231'o de Entrega por documento'
        TabOrder = 8
        OnClick = btnEndEntDocClick
      end
      object btnImpSep: TBitBtnLocked
        Left = 320
        Top = 22
        Width = 180
        Height = 22
        Caption = '[ F10 ] Imprimir Separa'#231#227'o'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
          8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
          93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
          9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
          678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
          8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
          E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
          8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
          EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
          C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
          C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
          D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
          9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
          B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
          BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
          C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
          C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
          AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 9
        Visible = False
        OnClick = btnImpSepClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 500
        Top = 22
        Width = 180
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
        TabOrder = 10
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 680
        Top = 22
        Width = 180
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
        TabOrder = 12
        OnClick = btnDesmarcaTodosClick
      end
      object btnFrete: TBitBtnLocked
        Left = 860
        Top = 22
        Width = 76
        Height = 22
        Caption = '[F12] Frete'
        TabOrder = 11
        OnClick = btnFreteClick
      end
      object btnImpRelatorio: TBitBtnLocked
        Left = 936
        Top = 22
        Width = 152
        Height = 22
        Caption = '[ Alt + F8 ] Imprimir Relat'#243'rio'
        TabOrder = 13
        OnClick = btnImpRelatorioClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1096
      Top = 24
      Width = 112
      Caption = '&Cancelar e Sair'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      ExplicitLeft = 1096
      ExplicitTop = 24
      ExplicitWidth = 112
    end
  end
  inherited pnlStatus: TPanel
    Top = 516
    Width = 1221
    TabOrder = 3
    ExplicitTop = 516
    ExplicitWidth = 1221
    inherited pnlNomeForm: TPanel
      Left = 1050
      ExplicitLeft = 1050
    end
    inherited pnlInfo: TPanel
      Width = 1050
      ExplicitWidth = 1050
    end
  end
  inherited pnlHeader: TPanel
    Width = 1221
    Height = 99
    TabOrder = 0
    ExplicitWidth = 1221
    ExplicitHeight = 99
    object Label1: TLabel
      Left = 392
      Top = 57
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
    object Label2: TLabel
      Left = 392
      Top = 21
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = 'Previs'#227'o de entrega:'
    end
    object Label3: TLabel
      Left = 567
      Top = 22
      Width = 6
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object lbl2: TLabel
      Left = 5
      Top = 57
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha/Grupo:'
    end
    object lblDocFat: TLabel
      Left = 651
      Top = 3
      Width = 79
      Height = 14
      Caption = 'N'#186' Doc. Ent. Fut.'
    end
    object lblEspFat: TLabel
      Left = 749
      Top = 3
      Width = 21
      Height = 14
      Caption = 'Esp.'
    end
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 429
      Top = 53
      Width = 70
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
      TabOrder = 7
      OnEnter = edtCodClienteEnter
      OnKeyPress = edtCodClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 500
      Top = 53
      Width = 284
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbMotivo: TGroupBox
      Left = 5
      Top = 0
      Width = 383
      Height = 47
      Caption = 'Motivos'
      TabOrder = 0
      object lblCliBus: TLabel
        Left = 223
        Top = 27
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente vai retirar?'
      end
      object chkFalta: TCheckBox
        Left = 8
        Top = 12
        Width = 89
        Height = 17
        Caption = 'Falta produto'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object chkPrevisao: TCheckBox
        Left = 103
        Top = 12
        Width = 121
        Height = 17
        Caption = 'Previs'#227'o de entrega'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object cmbCliBus: TComboBoxFocus
        Tag = 99
        Left = 312
        Top = 19
        Width = 65
        Height = 22
        Style = csDropDownList
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ItemIndex = 0
        ParentFont = False
        TabOrder = 3
        Text = 'N'#195'O'
        Items.Strings = (
          'N'#195'O'
          'SIM'
          'TODOS')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object chkAguarda: TCheckBox
        Left = 8
        Top = 28
        Width = 120
        Height = 17
        Caption = 'Aguardando cliente'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 498
      Top = 17
      Width = 66
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
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 577
      Top = 17
      Width = 66
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 67
      Top = 53
      Width = 48
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
    object edtDesGru: TEditFocus
      Left = 117
      Top = 53
      Width = 271
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkSepImp: TCheckBox
      Left = 800
      Top = 13
      Width = 134
      Height = 32
      Caption = 'Apenas itens j'#225' separados'
      TabOrder = 5
      Visible = False
      WordWrap = True
    end
    object edtDocFat: TEditFocus
      Tag = 99
      Left = 651
      Top = 17
      Width = 96
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttAlfanumerico
    end
    object edtEspFat: TEditFocus
      Tag = 99
      Left = 749
      Top = 17
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfanumerico
    end
    object chkExibirProdQtdeEntregarPreenchida: TCheckBox
      Left = 5
      Top = 78
      Width = 375
      Height = 17
      Caption = 
        'Exibir somente os produtos que tem quantidade para entregar pree' +
        'nchida'
      Enabled = False
      TabOrder = 10
      OnClick = chkExibirProdQtdeEntregarPreenchidaClick
    end
  end
  inherited pnlTail: TPanel
    Top = 433
    Width = 1221
    Height = 33
    TabOrder = 4
    Visible = True
    ExplicitTop = 433
    ExplicitWidth = 1221
    ExplicitHeight = 33
    object Label4: TLabel
      Left = 663
      Top = 10
      Width = 105
      Height = 14
      Caption = 'Peso Total a Entregar:'
    end
    object lblCodIte: TLabel
      Left = 4
      Top = 10
      Width = 36
      Height = 14
      Caption = 'C'#243'digo:'
      Visible = False
    end
    object lblQtdIte: TLabel
      Left = 170
      Top = 10
      Width = 58
      Height = 14
      Caption = 'Quantidade:'
      Visible = False
    end
    object btnQtdIte: TSpeedButton
      Left = 308
      Top = 6
      Width = 141
      Height = 22
      Caption = '[F1] Alterar quantidade'
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
        CCCCCC6060400000FF0000FF0000C000007C606050CCCCCCC0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CCCCCC6060400000FF0000FF0000C000
        007C606050CCCCCCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        CCCCCC5A5A3A0000FF0000FF0000CC000086545444CCCCCCC0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C6C6C69A9A9A2626068B8B6B5E5E461A
        1A0ADEDEDEC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        CCCCCC7E7E7EC5C5C5FFFFFFF9F9F9282828DADADAC0C0C0CCBCBCC6BEBEC0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C6C6C6828282BBBBBBFFFFFFFFFFFFFFFFFFB6
        B6B6404040D8C8C83CEBEB94CCCCCCBCBCC0C0C0C0C0C0C0C0C0C0C0C0CACACA
        4E4E4EFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF2A2A2ADAD2D2A0C8C81CFFFFA0C8
        C8D8B8B8C0C0C0C0C0C0C0C0C0D4D4D45A5A5AFFFFFFDBDBDBFFFFFFFFFFFFFF
        FFFF5454549A8A8A4CEBEB86EDED00FFFF18F7F7E4B4B4C0C0C0CCCCCC303030
        FFFFFFFFFFFF787878FFFFFFFFFFFFFFFFFFCECECE484040A6D6D674F3F346FF
        FF00FFFF18F7F7D2CACAD4D4D48080807070704C4C4CF5F5F5FFFFFFFFFFFFFF
        FFFFC4C4C45444445AF1F164DBDB7CD3D300FFFF00FFFFDB0C0C4848484A4A4A
        949494787878CBCBCBFFFFFFC3C3C3383838D8D8D854444460EFEF22F1F100FF
        FF00FFFF00FFFFAC9C9CCCCCCCCCCCCCCECECE808080181818D0D0D078787824
        2424DCDCDC4E4646A6D6D680EFEF4CFFFF00FFFFA8C8C8CAC2C2C0C0C0C0C0C0
        C8C8C8808080282828D8D8D8808080282828E8E8E848383858EFEF32FFFF0EF5
        F5A2CACACCBCBCC0C0C0C0C0C0C0C0C0C8C8C88282822C2C2CD8D8D888888832
        3232404040DED6D69ACACA5EFDFDDCB4B4C6BEBEC0C0C0C0C0C0C0C0C0C0C0C0
        CACACA646464000000F0F0F0161616383838DADADACCBCBC36EDEDD6B6B6C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CACACAE0E0E03C3C3CDCDCDCCE
        CECEC0C0C0C0C0C0CCBCBCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
      Visible = False
      OnClick = btnQtdIteClick
    end
    object Label6: TLabel
      Left = 865
      Top = 3
      Width = 549
      Height = 14
      Caption = 
        '(*): Saldo do produto desconsiderando o saldo reservado de entre' +
        'ga futura - Nesta coluna, o saldo reservado em'
    end
    object Label8: TLabel
      Left = 883
      Top = 16
      Width = 251
      Height = 14
      Caption = 'entrega futura n'#227'o deve debitar do saldo dispon'#237'vel.'
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 44
      Top = 6
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 15
      TabOrder = 1
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 232
      Top = 6
      Width = 73
      Height = 22
      Alignment = taRightJustify
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 2
      Text = '1,00'
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
    object edtTotalPeso: TEditFocus
      Left = 774
      Top = 6
      Width = 85
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Left = -2
    Top = 135
    Width = 339
    Height = 90
    Align = alNone
    DataSource = nil
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 8
    Visible = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DET_MOTFUT'
        Title.Caption = 'Mot.'
        Width = 22
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_CLIBUS'
        Title.Caption = 'C.Ret.'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAFUT'
        Title.Caption = 'Dt.Entrega'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_DTAENT'
        Title.Caption = 'Dt.Venda'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NUMDOC'
        Title.Caption = 'Documento'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 25
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODEMP'
        Title.Caption = 'Emp.'
        Width = 26
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CODFAB'
        Title.Caption = 'C'#243'd.F'#225'brica'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_DESCRI'
        Title.Caption = 'Descri'#231#227'o do Item'
        Width = 160
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_UNITAR'
        ReadOnly = True
        Title.Caption = 'Vlr. Unit'#225'rio'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_SALDOS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo F'#237'sico (*)'
        Width = 90
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_SALDIS'
        Title.Caption = 'Saldo Dispon'#237'vel'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_NUMLOT'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qt.Vendida'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDENT'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qt.Entregue'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDJDV'
        Title.Caption = 'Qt. Devolvida'
        Width = 79
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_QTDPEN'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qt.Pendente'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'SEP_QTDIMP'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qt.Impressa'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PENSEP'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qt.Pendente'
        Width = 65
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'DET_QTDAEN'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qt.Entregar'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDDEV'
        Title.Caption = 'Qt. Baixar/Devolver'
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_LOCFIS'
        ReadOnly = True
        Title.Caption = 'Loc. F'#237'sica'
        Width = 150
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 99
    Width = 1221
    TabOrder = 1
    ExplicitTop = 99
    ExplicitWidth = 1221
    inherited lblPesquisa: TLabel
      Top = 12
      ExplicitTop = 12
    end
    inherited lblNomeCampo: TLabel
      Top = 12
      ExplicitTop = 12
    end
  end
  object pnlLegendExp: TPanel [8]
    Left = 0
    Top = 411
    Width = 1221
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    Visible = False
    object shp1: TShape
      Left = 569
      Top = 8
      Width = 14
      Height = 14
      Brush.Color = clYellow
    end
    object shp2: TShape
      Left = 459
      Top = 8
      Width = 14
      Height = 14
      Brush.Color = clWindow
    end
    object shp3: TShape
      Left = 719
      Top = 8
      Width = 14
      Height = 14
      Brush.Color = clLime
    end
    object lbl3: TLabel
      Left = 477
      Top = 8
      Width = 72
      Height = 14
      Caption = 'N'#227'o expedidos'
    end
    object lbl4: TLabel
      Left = 588
      Top = 8
      Width = 114
      Height = 14
      Caption = 'Expedidos parcialmente'
    end
    object lbl5: TLabel
      Left = 736
      Top = 8
      Width = 105
      Height = 14
      Caption = 'Expedidos totalmente '
    end
    object Label5: TLabel
      Left = 1
      Top = 8
      Width = 148
      Height = 14
      Caption = '[ ENTER ] - Desmarcar sele'#231#227'o'
    end
  end
  object pnlLegendSep: TPanel [9]
    Left = 0
    Top = 389
    Width = 1221
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    Visible = False
    object shp6: TShape
      Left = 719
      Top = 8
      Width = 14
      Height = 14
      Brush.Color = clLime
    end
    object lbl7: TLabel
      Left = 736
      Top = 8
      Width = 100
      Height = 14
      Caption = 'Separa'#231#227'o impressa'
    end
    object shp4: TShape
      Left = 569
      Top = 8
      Width = 14
      Height = 14
      Brush.Color = clBlue
    end
    object lbl1: TLabel
      Left = 588
      Top = 8
      Width = 106
      Height = 14
      Caption = 'Quantidade Informada'
    end
  end
  object dbgDadosItens: TcxGrid [10]
    Left = 0
    Top = 139
    Width = 1221
    Height = 204
    Align = alClient
    TabOrder = 9
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgvDadosItens: TcxGridDBTableView
      OnDblClick = dbgvDadosItensDblClick
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = dbgvDadosItensCustomDrawCell
      OnEditKeyPress = dbgvDadosItensEditKeyPress
      DataController.DataSource = dtsConsulta
      DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem Registros>'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfAlwaysVisible
      OptionsView.GroupSummaryLayout = gslAlignWithColumnsAndDistribute
      Styles.Footer = cxstylFooter
      Styles.Group = cxstylGrupo
      object dbgvDadosItensDET_MOTFUT: TcxGridDBColumn
        Caption = 'Mot.'
        DataBinding.FieldName = 'DET_MOTFUT'
        Options.AutoWidthSizable = False
        Width = 26
      end
      object dbgvDadosItensDET_CLIBUS: TcxGridDBColumn
        Caption = 'C.Ret.'
        DataBinding.FieldName = 'DET_CLIBUS'
        Options.AutoWidthSizable = False
        Width = 38
      end
      object dbgvDadosItensDTAFUT: TcxGridDBColumn
        Caption = 'Dt.Entrega'
        DataBinding.FieldName = 'DTAFUT'
        Options.AutoWidthSizable = False
      end
      object dbgvDadosItensGER_DTAENT: TcxGridDBColumn
        Caption = 'Dt. Venda'
        DataBinding.FieldName = 'GER_DTAENT'
        Options.AutoWidthSizable = False
      end
      object dbgvDadosItensGER_NUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'GER_NUMDOC'
        Options.AutoWidthSizable = False
        Width = 120
      end
      object dbgvDadosItensGER_ESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'GER_ESPDOC'
        Options.AutoWidthSizable = False
        Width = 32
      end
      object dbgvDadosItensGER_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'GER_CODEMP'
        Options.AutoWidthSizable = False
        Width = 32
      end
      object dbgvDadosItensPEDVEN: TcxGridDBColumn
        Caption = 'Pedido de Venda'
        DataBinding.FieldName = 'PEDVEN'
        Width = 130
      end
      object dbgvDadosItensVENDEDOR: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'VENDEDOR'
        Options.AutoWidthSizable = False
        Width = 136
      end
      object dbgvDadosItensDET_CODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'DET_CODITE'
        Options.AutoWidthSizable = False
      end
      object dbgvDadosItensITE_CODFAB: TcxGridDBColumn
        Caption = 'C'#243'd.F'#225'brica'
        DataBinding.FieldName = 'ITE_CODFAB'
      end
      object dbgvDadosItensDET_DESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DET_DESCRI'
        Options.AutoWidthSizable = False
        Width = 174
      end
      object dbgvDadosItensDET_REFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'DET_REFERE'
        Width = 100
      end
      object dbgvDadosItensITE_SALDOS: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'ITE_SALDOS'
        HeaderAlignmentHorz = taRightJustify
        Options.AutoWidthSizable = False
        Width = 96
      end
      object dbgvDadosItensITE_SALDIS: TcxGridDBColumn
        Caption = 'Saldo Dispon'#237'vel'
        DataBinding.FieldName = 'ITE_SALDIS'
        HeaderAlignmentHorz = taRightJustify
        Width = 96
      end
      object dbgvDadosItensDET_NUMLOT: TcxGridDBColumn
        DataBinding.FieldName = 'DET_NUMLOT'
        Visible = False
        Options.AutoWidthSizable = False
      end
      object dbgvDadosItensDET_QTDITE: TcxGridDBColumn
        Caption = 'Qt. Vendida'
        DataBinding.FieldName = 'DET_QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Options.AutoWidthSizable = False
      end
      object dbgvDadosItensQTDENT: TcxGridDBColumn
        Caption = 'Qt. Entregue'
        DataBinding.FieldName = 'QTDENT'
        HeaderAlignmentHorz = taRightJustify
        Options.AutoWidthSizable = False
        Width = 72
      end
      object dbgvDadosItensQTDJDV: TcxGridDBColumn
        Caption = 'Qt. Devolvida'
        DataBinding.FieldName = 'QTDJDV'
        HeaderAlignmentHorz = taRightJustify
        Options.AutoWidthSizable = False
        Width = 76
      end
      object dbgvDadosItensDET_QTDPEN: TcxGridDBColumn
        Caption = 'Qt. Pendente'
        DataBinding.FieldName = 'DET_QTDPEN'
        HeaderAlignmentHorz = taRightJustify
        Options.AutoWidthSizable = False
        Width = 76
      end
      object dbgvDadosItensSEP_QTDIMP: TcxGridDBColumn
        Caption = 'Qt.Impressa'
        DataBinding.FieldName = 'SEP_QTDIMP'
        HeaderAlignmentHorz = taRightJustify
        Options.AutoWidthSizable = False
        Width = 70
      end
      object dbgvDadosItensPENSEP: TcxGridDBColumn
        Caption = 'Qt. Pendente'
        DataBinding.FieldName = 'PENSEP'
        HeaderAlignmentHorz = taRightJustify
        Options.AutoWidthSizable = False
        Width = 74
      end
      object dbgvDadosItensDET_QTDAEN: TcxGridDBColumn
        Caption = 'Qt. Entregar'
        DataBinding.FieldName = 'DET_QTDAEN'
        HeaderAlignmentHorz = taRightJustify
        Options.AutoWidthSizable = False
        Width = 74
      end
      object dbgvDadosItensQTDDEV: TcxGridDBColumn
        Caption = 'Qt. Baixar/Devolver'
        DataBinding.FieldName = 'QTDDEV'
        HeaderAlignmentHorz = taRightJustify
        Options.AutoWidthSizable = False
        Width = 150
      end
      object dbgvDadosItensDET_COMPLE: TcxGridDBColumn
        Caption = 'Ambiente'
        DataBinding.FieldName = 'DET_COMPLE'
        Visible = False
        Options.AutoWidthSizable = False
      end
      object dbgvDadosItensDET_QTDENT: TcxGridDBColumn
        DataBinding.FieldName = 'DET_QTDENT'
        Visible = False
        Options.AutoWidthSizable = False
      end
      object dbgvDadosItensQTDFUT: TcxGridDBColumn
        DataBinding.FieldName = 'QTDFUT'
        Visible = False
        Options.AutoWidthSizable = False
      end
      object dbgvDadosItensDET_LOCFIS: TcxGridDBColumn
        Caption = 'Loc. F'#237'sica'
        DataBinding.FieldName = 'DET_LOCFIS'
        Width = 150
      end
    end
    object dbglDadosTintas: TcxGridLevel
      GridView = dbgvDadosItens
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
    Top = 208
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 216
  end
  inherited qryConsulta: TUniQuery
    Left = 144
    Top = 216
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 184
    Top = 216
  end
  inherited cdsConsulta: TUniClientDataSet
    AggregatesActive = True
    AfterOpen = cdsConsultaAfterOpen
    BeforePost = cdsConsultaBeforePost
    AfterPost = cdsConsultaAfterPost
    AfterCancel = cdsConsultaAfterCancel
    Left = 224
    Top = 216
  end
  inherited dtsConsulta: TDataSource
    OnStateChange = dtsConsultaStateChange
    Left = 264
    Top = 216
  end
  object tmrInformacao: TTimer
    Interval = 500
    OnTimer = tmrInformacaoTimer
    Left = 488
    Top = 208
  end
  object cxstylrpstryGrupo: TcxStyleRepository
    Left = 288
    Top = 40
    PixelsPerInch = 96
    object cxstylGrupo: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxstylFooter: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
