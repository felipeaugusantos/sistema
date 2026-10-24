inherited frmFatManifestoEletronico: TfrmFatManifestoEletronico
  Width = 896
  Height = 658
  Caption = 'Gera'#231#227'o de manifesto eletronico'
  ExplicitWidth = 896
  ExplicitHeight = 658
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 577
    Width = 880
    Height = 26
    TabOrder = 5
    ExplicitTop = 577
    ExplicitWidth = 880
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 799
      Height = 22
      ExplicitWidth = 799
      ExplicitHeight = 22
      inherited btnPesquisar: TBitBtnLocked
        Width = 102
        ExplicitWidth = 102
      end
      object btnGravar: TBitBtnLocked
        Left = 220
        Top = 0
        Width = 104
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
      object btnMarcaTodos: TBitBtnLocked
        Left = 324
        Top = 0
        Width = 123
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
        TabOrder = 3
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 447
        Top = 0
        Width = 141
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
        TabOrder = 4
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 801
      Top = 2
      Align = alRight
      ExplicitLeft = 801
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 603
    Width = 880
    TabOrder = 6
    ExplicitTop = 603
    ExplicitWidth = 880
    inherited pnlNomeForm: TPanel
      Left = 709
      ExplicitLeft = 709
    end
    inherited pnlInfo: TPanel
      Width = 709
      ExplicitWidth = 709
    end
  end
  inherited pnlHeader: TPanel
    Width = 880
    Height = 117
    TabOrder = 0
    ExplicitWidth = 880
    ExplicitHeight = 117
    object Label2: TLabel
      Left = 9
      Top = 13
      Width = 99
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emiss'#227'o documento:'
    end
    object Label3: TLabel
      Left = 184
      Top = 14
      Width = 6
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object lblCodEmp: TLabel
      Left = 63
      Top = 96
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object shpEmp: TShape
      Left = 110
      Top = 89
      Width = 5
      Height = 21
    end
    object Label5: TLabel
      Left = 60
      Top = 53
      Width = 50
      Height = 14
      Caption = 'Romaneio:'
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 115
      Top = 9
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
      Left = 194
      Top = 9
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
    object edtNomEmp: TEditFocus
      Left = 188
      Top = 88
      Width = 445
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 115
      Top = 88
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 7
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
    object chkCarPos: TcxCheckBox
      Left = 401
      Top = 5
      Caption = 
        'Apenas retirada de produtos (somente para transporte pr'#243'prio e d' +
        'escarga dentro do estado do emissor).'
      Properties.MultiLine = True
      TabOrder = 3
      OnClick = chkCarPosClick
      Width = 338
    end
    object rdgTipoDocumento: TcxRadioGroup
      Left = 266
      Top = 5
      Caption = 'Tipo de Documento'
      Properties.Columns = 2
      Properties.Items = <
        item
          Caption = 'NFe'
        end
        item
          Caption = 'Cte'
        end>
      ItemIndex = 0
      TabOrder = 2
      OnClick = rdgTipoDocumentoClick
      Height = 35
      Width = 129
    end
    object edtNumRom: TEditFocus
      Tag = 99
      Left = 115
      Top = 50
      Width = 74
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 4
      OnKeyPress = edtNumRomKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object pnlFiltroRotaRegiao: TPanel
      Left = 639
      Top = 86
      Width = 174
      Height = 27
      BevelOuter = bvNone
      TabOrder = 9
      object lblCodReg: TLabel
        Left = 3
        Top = 10
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Seq. Rota:'
      end
      object edtCodRot: TEditFocus
        Tag = 99
        Left = 55
        Top = 2
        Width = 59
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = edtCodRotKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
    end
    object rdgNotas: TRadioGroup
      Left = 196
      Top = 42
      Width = 261
      Height = 33
      Caption = 'Notas'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Pr'#243'prias'
        'Terceiros'
        'Todas')
      TabOrder = 5
      OnClick = rdgNotasClick
    end
    object grbOriDoc: TGroupBox
      Left = 463
      Top = 40
      Width = 185
      Height = 35
      Caption = 'Origem da Notas'
      TabOrder = 6
      object chkDocOriVen: TCheckBox
        Left = 7
        Top = 14
        Width = 58
        Height = 17
        Caption = 'Venda'
        TabOrder = 0
      end
      object chkDocOriDev: TCheckBox
        Left = 79
        Top = 14
        Width = 78
        Height = 17
        Caption = 'Devolu'#231#227'o'
        TabOrder = 1
      end
    end
  end
  inherited pnlTail: TPanel
    Top = 425
    Width = 443
    Height = 152
    Align = alLeft
    TabStop = True
    Visible = True
    ExplicitTop = 425
    ExplicitWidth = 443
    ExplicitHeight = 152
    object Label1: TLabel
      Left = 15
      Top = 7
      Width = 318
      Height = 14
      Caption = 'Percurso (informe as UFs separadas por v'#237'rgula (ex: MG, RJ, ES):'
    end
    object lblMunicipioDestino: TLabel
      Left = 15
      Top = 103
      Width = 83
      Height = 14
      Caption = 'Munic'#237'pio Destino'
    end
    object lblUFDestino: TLabel
      Left = 254
      Top = 103
      Width = 52
      Height = 14
      Caption = 'UF Destino'
    end
    object edtPercurso: TEditFocus
      Left = 15
      Top = 24
      Width = 426
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgInformacaoDeDestino: TRadioGroup
      Left = 13
      Top = 52
      Width = 426
      Height = 48
      Caption = 'Informa'#231#245'es sobre o Destino'
      ItemIndex = 0
      Items.Strings = (
        'Informado em cada NF atrav'#233's do endere'#231'o de entrega ou cadastro'
        'Destino '#250'nico')
      TabOrder = 1
      OnClick = rdgInformacaoDeDestinoClick
    end
    object edtCodCidDestino: TEditFocus
      Tag = 99
      Left = 15
      Top = 120
      Width = 44
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 2
      OnExit = edtCodCidDestinoExit
      OnKeyPress = edtCodCidDestinoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomCidDestino: TEditFocus
      Left = 61
      Top = 120
      Width = 192
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object edtUFDestino: TEditFocus
      Tag = 99
      Left = 254
      Top = 120
      Width = 80
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 100
      ReadOnly = True
      TabOrder = 4
      OnKeyPress = edtUFDestinoKeyPress
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
    Top = 157
    Width = 880
    Height = 268
    TabStop = False
    Align = alTop
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 2
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMDOC'
        Title.Caption = 'Documento'
        Width = 117
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAENT'
        Title.Caption = 'Emiss'#227'o'
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMCID'
        Title.Caption = 'Munic'#237'pio'
        Width = 153
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESTADO'
        Title.Caption = 'UF'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJDE'
        Title.Caption = 'Destinat'#225'rio'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMDES'
        Title.Caption = 'Nome do destinat'#225'rio'
        Width = 214
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor documento'
        Width = 114
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 117
    Width = 880
    TabOrder = 1
    ExplicitTop = 117
    ExplicitWidth = 880
  end
  object pnlInformacoes: TPanel [6]
    Left = 443
    Top = 425
    Width = 437
    Height = 152
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    TabStop = True
    object grbInformacoes: TGroupBox
      Left = 0
      Top = 0
      Width = 437
      Height = 152
      Align = alClient
      Caption = 'Informa'#231#245'es Adicionais de Interesse do Contribuinte'
      TabOrder = 0
      object memoInformacoes: TMemoFocus
        Left = 2
        Top = 16
        Width = 433
        Height = 134
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 544
    Top = 188
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 356
    Top = 188
  end
  inherited qryConsulta: TUniQuery
    Left = 112
    Top = 224
  end
  inherited dtsConsulta: TDataSource
    Left = 184
    Top = 240
  end
end
