inherited frmFatBaixaEntregaFuturaSimpl: TfrmFatBaixaEntregaFuturaSimpl
  Width = 1087
  Height = 599
  BorderStyle = bsSingle
  Caption = 'Baixa de Entrega Futura Simplificada'
  ExplicitWidth = 1087
  ExplicitHeight = 599
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 526
    Width = 1081
    TabOrder = 4
    ExplicitTop = 526
    ExplicitWidth = 1081
    inherited FlwBotoes: TFlowPanel
      Width = 1077
      ExplicitWidth = 1077
      inherited btnMudaOrdem: TBitBtnLocked
        TabOrder = 1
        Visible = False
      end
      inherited btnPesquisar: TBitBtnLocked
        TabOrder = 0
        Visible = False
      end
      object btnConfirma: TBitBtnLocked
        Left = 231
        Top = 0
        Width = 170
        Height = 22
        Caption = '[F10] &Selecionar para Baixa'
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
        OnClick = btnConfirmaClick
      end
      object btnEnderecosEntrega: TBitBtnLocked
        Left = 401
        Top = 0
        Width = 169
        Height = 22
        Caption = '[ F12 ] Endere'#231'os de  Entrega'
        TabOrder = 3
        OnClick = btnEnderecosEntregaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 998
      Caption = 'Cancelar'
      ExplicitLeft = 998
    end
  end
  inherited pnlStatus: TPanel
    Top = 554
    Width = 1081
    TabOrder = 5
    ExplicitTop = 554
    ExplicitWidth = 1081
    inherited pnlNomeForm: TPanel
      Left = 910
      ExplicitLeft = 910
    end
    inherited pnlInfo: TPanel
      Width = 910
      ExplicitWidth = 910
    end
  end
  inherited pnlHeader: TPanel
    Width = 1081
    Height = 113
    TabOrder = 0
    ExplicitWidth = 1081
    ExplicitHeight = 113
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
      Width = 5
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
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
    object lbl2: TLabel
      Left = 4
      Top = 57
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha/Grupo:'
    end
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
    object Label4: TLabel
      Left = 30
      Top = 85
      Width = 36
      Height = 14
      Caption = 'Cidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblRegiao: TLabel
      Left = 392
      Top = 85
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Regi'#227'o:'
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
      TipoTexto = ttNumerico
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
      TipoTexto = ttAlfabetico
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
      TabOrder = 5
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
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
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
    object edtCodCidade: TEditFocus
      Tag = 99
      Left = 67
      Top = 81
      Width = 48
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
      TabOrder = 9
      OnKeyPress = edtCodCidadeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesCidade: TEditFocus
      Left = 117
      Top = 81
      Width = 240
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Left = 360
      Top = 81
      Width = 28
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnConsulta: TBitBtnLocked
      Left = 790
      Top = 81
      Width = 91
      Height = 22
      Caption = '&Pesquisar'
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
      TabOrder = 14
      OnClick = btnConsultaClick
    end
    object edtCodRegiao: TEditFocus
      Tag = 99
      Left = 429
      Top = 81
      Width = 70
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 12
      OnKeyPress = edtCodRegiaoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomeRegiao: TEditFocus
      Left = 500
      Top = 81
      Width = 284
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
  end
  inherited pnlTail: TPanel
    Top = 504
    Width = 1081
    Height = 22
    ExplicitTop = 504
    ExplicitWidth = 1081
    ExplicitHeight = 22
    object shpSepImpLegenda: TShape
      Left = 16
      Top = 5
      Width = 14
      Height = 14
      Brush.Color = clLime
    end
    object lblSepImpLegenda: TLabel
      Left = 33
      Top = 5
      Width = 246
      Height = 14
      Caption = 'Todos os documentos tiveram separa'#231#227'o impressa'
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 153
    Width = 1081
    Height = 351
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'DET_DTAFUT'
        Title.Caption = 'Dt. Entrega'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLI_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 350
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CID_NOMCID'
        Title.Caption = 'Cidade'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REG_DESREG'
        Title.Caption = 'Regi'#227'o'
        Width = 202
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTD_ITENS'
        Title.Caption = 'Qt. de Itens Distintos'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTITEDOC'
        Title.Caption = 'Qtd. Itens Total'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'SEP_QTDITE'
        Title.Caption = 'Qt. Itens Separados'
        Visible = False
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 113
    Width = 1081
    TabOrder = 1
    ExplicitTop = 113
    ExplicitWidth = 1081
  end
end
