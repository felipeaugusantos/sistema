inherited frmFatManutencaoManifestoEletronico: TfrmFatManutencaoManifestoEletronico
  Width = 920
  Height = 575
  Caption = 'Manuten'#231#227'o de Manifestos Emitidos'
  ExplicitWidth = 920
  ExplicitHeight = 575
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 492
    Width = 904
    ExplicitTop = 492
    ExplicitWidth = 904
    inherited FlwBotoes: TFlowPanel
      Width = 900
      ExplicitWidth = 900
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 130
        ExplicitWidth = 130
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 130
        Width = 130
        ExplicitLeft = 130
        ExplicitWidth = 130
      end
      object btnGravar: TBitBtnLocked
        Left = 260
        Top = 0
        Width = 225
        Height = 22
        Caption = '[ F10 ] Excluir documentos selecionados'
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
    end
    inherited btnSair: TBitBtnLocked
      Left = 823
      Top = 2
      ExplicitLeft = 823
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 520
    Width = 904
    ExplicitTop = 520
    ExplicitWidth = 904
    inherited pnlNomeForm: TPanel
      Left = 733
      ExplicitLeft = 733
    end
    inherited pnlInfo: TPanel
      Width = 733
      ExplicitWidth = 733
    end
  end
  inherited pnlHeader: TPanel
    Width = 904
    Height = 134
    ExplicitWidth = 904
    ExplicitHeight = 134
    object Label2: TLabel
      Left = 32
      Top = 67
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emiss'#227'o da NFe:'
    end
    object Label3: TLabel
      Left = 186
      Top = 71
      Width = 9
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object lblCodEmp: TLabel
      Left = 69
      Top = 115
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label1: TLabel
      Left = 19
      Top = 89
      Width = 93
      Height = 14
      Alignment = taRightJustify
      Caption = 'Emiss'#227'o manifesto:'
    end
    object Label4: TLabel
      Left = 188
      Top = 90
      Width = 7
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object lblNroDocumento: TLabel
      Left = 32
      Top = 46
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero da Nota:'
    end
    object Label6: TLabel
      Left = 235
      Top = 46
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie da nota'
    end
    object Label7: TLabel
      Left = 7
      Top = 18
      Width = 105
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero do Manifesto:'
    end
    object lblObs: TLabel
      Left = 609
      Top = 39
      Width = 202
      Height = 42
      Alignment = taCenter
      Caption = 
        'Obs.: Para incluir um novo documento em um manifesto, digite o n' +
        #250'mero do manifesto e clique em "Filtrar".'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object lblMensCarPos: TLabel
      Left = 372
      Top = 10
      Width = 416
      Height = 28
      Caption = 
        'Apenas retirada de produtos (somente para transporte pr'#243'prio e d' +
        'escarga dentro do estado do emissor).'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object rdgTipoDocumento: TcxRadioGroup
      Left = 230
      Top = 3
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
      TabOrder = 1
      OnClick = rdgTipoDocumentoClick
      Height = 35
      Width = 129
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 121
      Top = 63
      Width = 63
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 200
      Top = 63
      Width = 66
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 5
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNomEmp: TEditFocus
      Left = 194
      Top = 107
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 121
      Top = 107
      Width = 72
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 9
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object mskDtaIniMan: TMaskEditFocus
      Tag = 99
      Left = 121
      Top = 85
      Width = 63
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 6
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFinMan: TMaskEditFocus
      Tag = 99
      Left = 200
      Top = 85
      Width = 66
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 7
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNumNfe: TEditFocus
      Tag = 99
      Left = 121
      Top = 41
      Width = 100
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
      MaxLength = 12
      ParentFont = False
      TabOrder = 2
      OnChange = edtNumManChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 321
      Top = 41
      Width = 38
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
      MaxLength = 2
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtNumMan: TEditFocus
      Tag = 99
      Left = 121
      Top = 13
      Width = 100
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
      OnChange = edtNumManChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object btnAdicionar: TBitBtnLocked
      Left = 516
      Top = 107
      Width = 73
      Height = 22
      Caption = '&Filtrar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
        CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
        1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
        D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
        7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
        E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
        EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
        8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 11
      OnClick = btnAdicionarClick
    end
    object chkCarPos: TcxCheckBox
      Left = 272
      Top = 85
      Caption = 'Documentos n'#227'o Carregados - Apenas Retirada de Produtos.'
      TabOrder = 8
      OnClick = chkCarPosClick
    end
  end
  inherited pnlTail: TPanel
    Top = 444
    Width = 904
    TabOrder = 4
    Visible = True
    ExplicitTop = 444
    ExplicitWidth = 904
    object Label8: TLabel
      Left = 15
      Top = 7
      Width = 318
      Height = 14
      Caption = 'Percurso (informe as UFs separadas por v'#237'rgula (ex: MG, RJ, ES):'
    end
    object Label12: TLabel
      Left = 609
      Top = 16
      Width = 219
      Height = 28
      Alignment = taCenter
      Caption = 
        'Obs.: Para atualizar o percurso, basta digitar as UFs e clicar e' +
        'm "Atualizar Percurso".'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object edtPercurso: TEditFocus
      Left = 15
      Top = 24
      Width = 474
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
    object btnAtuPercurso: TBitBtnLocked
      Left = 496
      Top = 25
      Width = 105
      Height = 22
      Caption = 'Atualizar Percurso'
      TabOrder = 1
      OnClick = btnAtuPercursoClick
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 214
    Width = 904
    Height = 230
    TabStop = False
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 5
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMMAN'
        Title.Caption = 'Manif.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAMAN'
        Title.Caption = 'Dt. Manif.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMMOT'
        Title.Caption = 'Motorista'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMDOC'
        Title.Caption = 'Documento'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DTAENT'
        Title.Caption = 'Emiss'#227'o'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMCID'
        Title.Caption = 'Munic'#237'pio'
        Width = 134
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESTADO'
        Title.Caption = 'UF'
        Width = 24
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJDE'
        Title.Caption = 'Destinatario'
        Width = 89
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMDES'
        Title.Caption = 'Nome do destinat'#225'rio'
        Width = 135
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLRCON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vr. Documento'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ACEMAN'
        Title.Caption = 'MDFe'
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 174
    Width = 904
    TabOrder = 6
    ExplicitTop = 174
    ExplicitWidth = 904
  end
  object pnlInclusao: TPanel [6]
    Left = 0
    Top = 134
    Width = 904
    Height = 40
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    Visible = False
    object Label9: TLabel
      Left = 23
      Top = 7
      Width = 89
      Height = 14
      Caption = 'Chave de Acesso:'
    end
    object Label10: TLabel
      Left = 17
      Top = 21
      Width = 95
      Height = 14
      Caption = '("/" para pesquisar)'
    end
    object lblObs2: TLabel
      Left = 607
      Top = 4
      Width = 270
      Height = 30
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Obs.: Pressione [Delete] para remover os documentos que ainda n'#227 +
        'o est'#227'o no manifesto.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object edtChaveAcesso: TEditFocus
      Tag = 99
      Left = 121
      Top = 8
      Width = 386
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
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnKeyPress = edtChaveAcessoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 44
      TipoTexto = ttNumerico
    end
    object btnIncluir: TBitBtnLocked
      Left = 516
      Top = 8
      Width = 73
      Height = 22
      Caption = '&Incluir'
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
      TabOrder = 1
      OnClick = btnIncluirClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 272
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 584
    Top = 280
  end
  inherited qryConsulta: TUniQuery
    Top = 272
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 448
    Top = 40
  end
  inherited cdsConsulta: TUniClientDataSet
    AfterScroll = cdsConsultaAfterScroll
    Left = 488
    Top = 32
  end
  inherited dtsConsulta: TDataSource
    Top = 272
  end
end
