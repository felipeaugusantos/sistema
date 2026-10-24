inherited frmConfigRibPreto: TfrmConfigRibPreto
  Top = 178
  VertScrollBar.Range = 0
  BorderStyle = bsNone
  Caption = 'frmConfigRibPreto'
  ClientHeight = 483
  ClientWidth = 648
  Position = poMainFormCenter
  ExplicitWidth = 648
  ExplicitHeight = 483
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 439
    Width = 648
    TabOrder = 1
    ExplicitTop = 439
    ExplicitWidth = 648
    DesignSize = (
      648
      28)
    inherited btnSair: TBitBtnLocked
      Left = 567
      TabOrder = 1
      ExplicitLeft = 567
    end
    object btnGravar: TBitBtnLocked
      Left = 5
      Top = 2
      Width = 88
      Height = 23
      Caption = '&Gravar'
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
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnConfigurar: TBitBtnLocked
      Left = 98
      Top = 2
      Width = 88
      Height = 23
      Anchors = [akRight, akBottom]
      Caption = '&Configurar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF108ABA1895C1066897FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF188CBA138FBD066A990982B213
        99CA1E9DC90B72A00A6D9A2B96BD2692BCFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF1D8FBA21A5D10999CE078ABC0EB7EB2FCBF61F90BB41B0D34CB4D4288E
        B6FF00FFFF00FFFF00FFFF00FF1073A01880AB35A1C96BD0EA37AFD423B8E60F
        CBFF23D0FF44C7ED5AB6D59CD8E677C0D80D72A1FF00FFFF00FFFF00FF45A7CB
        2F9CC539ACD77DE7FF74EAFF40DDFF15CFFF0DCCFF38D9FF5EE1FF63E5FF28BC
        E91C9DCE188EC0FF00FFFF00FF0878AF1190CB35B2E367D5F479EAFF56C6E141
        A5BD369EBA17B7E502C4FF01C1FE03C2FE03BAF205A0D8FF00FFFF00FF0D75A5
        1698D428A9E052CBF378B7C67F7E7E7F7E7E7F7E7E7F7E7E2DAACC00C5FF09C6
        FE0FC5FA0487BCFF00FFFF00FF0F79AA1598D51CA0DA40C1F07F7E7EE2DAD99E
        9F9F978B8BD8A4A17F7E7E3FD1F884EBFFA1EAFB2683ABFF00FFFF00FF0973A5
        0F86BF1597D32EB5EA7F7E7EE2D9D79D9E9E978B8BD1A1A07F7E7E62DCFA97E6
        F770BCD72F8FB4FF00FFFF00FFFF00FF056695108BC620AAE57F7E7EE2D9D79D
        9E9E978B8BD3A3A07F7E7E4AD8FC4DBBDE015E8EFF00FFFF00FFFF00FFFF00FF
        FF00FF086FA00576AC7F7E7EE6DDD99D9E9E978B8BD7A5A37F7E7E0F82B0117A
        A7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7EDDDAD999
        9A9A968A8ACCA3A37F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF7F7E7E9E9E9E898989817E7E9689897F7E7EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7ED8D7D7B6
        B7B78F8C8C9F8F8F7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF7F7E7EDDDCDCE3E2E2AAAAAA8C87877F7E7EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7E7F
        7E7E7F7E7E7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnConfigurarClick
    end
    object BtnManual: TBitBtnLocked
      Left = 191
      Top = 2
      Width = 88
      Height = 23
      Caption = '&Manual'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF1E74E82E72D65181CD5B76B3245FC4FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4A94F078A3DCB2BAC7D2
        C4BCE6BDA2F4AE76B7A6A33973D0FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        298FFF7AADEAFBDDB6FFE0B8FFE5BAFFDCB6ECB791E29B6AFDCEA2EEDED07AA2
        E0337BE1FF00FFFF00FFFF00FFFF00FF4282C8D6C7B2FFEFD3FEECD4FDE9D2F3
        D5BDE3A882ECB183FADFC4FFEFDEFFFBF0B9D2F3468EEEFF00FFFF00FF318FFF
        BD8E57FFE5B5FEF7EFFEF6EAFBEBDDEECBB3DE986CEFBE99FDECDAFFF6EEFFFB
        F8FFFFFFAEC6EA2578E7FF00FF2E84D488C474FFF8ECFFFBF7FFFBF6F9E7DBE7
        B89CE8AB80F6D8BFC5C1BBE3DFDBFEFEFDFFFFFEC6A7A94283DCFF00FF2B898E
        7CDC9FFFFFFFFFFEFCFEFCF9F3DBCBE2A782EAB38CFEEBDBF6F1EBC9CAC8D0D1
        CFF7F4F39893B53A91FBFF00FF1455D0CEDFF2FFFFFFFFFFFFFEFDFBEDD6CBE3
        AC87F5CEADE8E1DAFCF8F5FFFFFFEFEEEDB5D4F93A91FBFF00FF2C7EEA355DF3
        FFFFFFE1EFFFBADAFF98C7FF4BA0FF77ABEBDFE0E4DDD7CEC4C4C2E7E7E7FFFF
        FF71B2FF288CFFFF00FF2F8EFF53A1FF68AEFF73B3FFFF00FFFF00FFFF00FFFF
        00FF2D8DFFB1D6FFF1F1F0DFD9CED9E9FA3F97FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2D8DFFBFDDFF76B4
        FE2B8CFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF2D8DFFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 3
      OnClick = BtnManualClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 467
    Width = 648
    TabOrder = 2
    ExplicitTop = 467
    ExplicitWidth = 648
    inherited pnlNomeForm: TPanel
      Left = 477
      ExplicitLeft = 477
    end
    inherited pnlInfo: TPanel
      Width = 477
      ExplicitWidth = 477
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 648
    Height = 439
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 646
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Configura'#231#245'es - Banco Rib. Preto - 741 [ 400p ]'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 17
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object tabCarteira: TTabControl
      Left = 1
      Top = 23
      Width = 646
      Height = 415
      Align = alClient
      TabOrder = 0
      Tabs.Strings = (
        'Carteira &1'
        'Carteira &2'
        'Carteira &3'
        'Carteira &4'
        'Carteira &5')
      TabIndex = 0
      OnChange = tabCarteiraChange
      object lblDiasProt: TLabel
        Left = 3
        Top = 235
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade de Dias para Protesto:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblPathArquivosRem: TLabel
        Left = 3
        Top = 256
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Path para Arquivos de Remessa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblPathArquivosRet: TLabel
        Left = 3
        Top = 276
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Path para Arquivos de Retorno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblResp: TLabel
        Left = 3
        Top = 296
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Resp. por Emiss'#227'o de Boletos:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object ColorLabel1: TColorLabel
        Left = 196
        Top = 296
        Width = 92
        Height = 14
        Caption = '(E)mpresa (B)anco'
        CorDestaque = clRed
      end
      object lblCodCart: TLabel
        Left = 3
        Top = 52
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'C'#243'digo da Carteira:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        Transparent = True
      end
      object lblProNum: TLabel
        Left = 3
        Top = 32
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Pr'#243'ximo Num. Seq. Arq. Remessa:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 323
        Top = 93
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'DAC da Ag'#234'ncia Cobradora:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblCodAgenc: TLabel
        Left = 3
        Top = 93
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Ag'#234'ncia Cobradora (Sem D'#237'gito):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblIdentBanco: TLabel
        Left = 323
        Top = 52
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Identifica'#231#227'o no Banco (Contrato):'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        Transparent = True
      end
      object Label1: TLabel
        Left = 3
        Top = 136
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Observa'#231#227'o 1 :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 3
        Top = 157
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Observa'#231#227'o 2 :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 3
        Top = 178
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Observa'#231#227'o 3 :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 3
        Top = 199
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Observa'#231#227'o 4 :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 3
        Top = 218
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Observa'#231#227'o 5 :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 3
        Top = 115
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo da Instru'#231#227'o 1 :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 323
        Top = 115
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'C'#243'digo da Instru'#231#227'o 2 :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 3
        Top = 73
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'C'#243'digo da Empresa:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        Transparent = True
      end
      object Label10: TLabel
        Left = 3
        Top = 316
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Portador de Baixa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 3
        Top = 335
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Conta Baixa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 323
        Top = 235
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Quantidade de Dias para Cr'#233'dito:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 323
        Top = 73
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Uso do Banco:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        Transparent = True
      end
      object lbl1: TLabel
        Left = 3
        Top = 357
        Width = 168
        Height = 14
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Informa'#231#227'o Adicional:'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentBiDiMode = False
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        Transparent = True
      end
      object edtResp: TEditFocus
        Tag = 99
        Left = 173
        Top = 294
        Width = 19
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 1
        ParentFont = False
        TabOrder = 18
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      inline fraPathRetornoCXF: TfraDirectoryEditFocus
        Tag = 99
        Left = 173
        Top = 274
        Width = 460
        Height = 22
        TabOrder = 17
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        inherited edtDirectory: TEditFocus
        end
      end
      inline fraPathRemessaCXF: TfraDirectoryEditFocus
        Tag = 99
        Left = 173
        Top = 252
        Width = 460
        Height = 22
        TabOrder = 16
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        inherited edtDirectory: TEditFocus
        end
      end
      object edtDiasProt: TEditFocus
        Left = 173
        Top = 233
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 2
        TipoTexto = ttNumerico
      end
      object edtCodCar: TEditFocus
        Tag = 99
        Left = 173
        Top = 50
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
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
      object edtDigAgenciaCob: TEditFocus
        Left = 493
        Top = 91
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 1
        ParentFont = False
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtCodAgenciaCob: TEditFocus
        Left = 173
        Top = 91
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtIdentBanc: TEditFocus
        Left = 493
        Top = 50
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtProxNumArqRem: TEditFocus
        Tag = 99
        Left = 173
        Top = 30
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtObservacao1: TEditFocus
        Tag = 99
        Left = 173
        Top = 133
        Width = 460
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 9
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtObservacao2: TEditFocus
        Tag = 99
        Left = 173
        Top = 153
        Width = 460
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 10
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtObservacao3: TEditFocus
        Tag = 99
        Left = 173
        Top = 173
        Width = 460
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 11
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtObservacao4: TEditFocus
        Tag = 99
        Left = 173
        Top = 193
        Width = 460
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 12
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtObservacao5: TEditFocus
        Tag = 99
        Left = 173
        Top = 213
        Width = 460
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 13
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtInstrucao1: TEditFocus
        Tag = 99
        Left = 173
        Top = 112
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 2
        TipoTexto = ttNumerico
      end
      object edtInstrucao2: TEditFocus
        Tag = 99
        Left = 493
        Top = 112
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 8
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 2
        TipoTexto = ttNumerico
      end
      object edtCodEmpr: TEditFocus
        Left = 173
        Top = 71
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDesPor: TEditFocus
        Left = 235
        Top = 314
        Width = 398
        Height = 19
        TabStop = False
        Alignment = taLeftJustify
        AutoSize = False
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 21
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodPor: TEditFocus
        Tag = 99
        Left = 173
        Top = 314
        Width = 61
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        MaxLength = 5
        TabOrder = 19
        OnKeyPress = edtCodPorKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesCtaBai: TEditFocus
        Left = 235
        Top = 333
        Width = 398
        Height = 19
        TabStop = False
        Alignment = taLeftJustify
        AutoSize = False
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 22
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCtaBai: TEditFocus
        Tag = 99
        Left = 173
        Top = 333
        Width = 61
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        MaxLength = 7
        TabOrder = 20
        OnKeyPress = edtCtaBaiKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 7
        TipoTexto = ttNumerico
      end
      object edtDiasCred: TEditFocus
        Left = 493
        Top = 233
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtUsoBan: TEditFocus
        Left = 493
        Top = 71
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtInfAdi: TEditFocus
        Left = 173
        Top = 352
        Width = 140
        Height = 19
        Alignment = taLeftJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 23
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 10
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 496
    Top = 0
  end
end
