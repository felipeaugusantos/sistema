inherited frmCadDiversos: TfrmCadDiversos
  Left = 214
  Top = 182
  Width = 809
  Height = 660
  Caption = 'Cadastro de Diversos'
  ExplicitWidth = 809
  ExplicitHeight = 660
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 570
    Width = 803
    Height = 45
    TabOrder = 1
    ExplicitTop = 548
    ExplicitWidth = 803
    ExplicitHeight = 45
    DesignSize = (
      803
      45)
    inherited FlwBotoes: TFlowPanel
      Width = 799
      Height = 41
      ExplicitTop = 2
      ExplicitWidth = 799
      ExplicitHeight = 41
      inherited btnIncluir: TBitBtnLocked
        Width = 108
        ExplicitWidth = 108
      end
      inherited btnGravar: TBitBtnLocked
        Left = 108
        Width = 108
        ExplicitLeft = 108
        ExplicitWidth = 108
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 216
        Width = 108
        ExplicitLeft = 216
        ExplicitWidth = 108
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 324
        Width = 108
        ExplicitLeft = 324
        ExplicitWidth = 108
      end
      inherited btnCancela: TBitBtnLocked
        Left = 432
        Width = 108
        ExplicitLeft = 432
        ExplicitWidth = 108
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 540
        Width = 108
        ExplicitLeft = 540
        ExplicitWidth = 108
      end
      object btnCadCli: TBitBtnLocked
        Left = 648
        Top = 0
        Width = 133
        Height = 20
        Caption = '[ F4 ] Cadastro de Clientes'
        TabOrder = 6
        OnClick = btnCadCliClick
      end
      object btnComAti: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 216
        Height = 20
        Hint = 
          'Esta rotina faz a manuten'#231#227'o coletiva do percentual de comiss'#227'o ' +
          'dos '#13#10'profissionais. Ela permite que possamos alterar o percentu' +
          'al de comiss'#227'o '#13#10'de todos os profissionais da mesma atividade em' +
          ' uma '#250'nica opera'#231#227'o.'
        Caption = '[ F5 ] Altera'#231#227'o Global Por Atividade'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = btnComAtiClick
      end
      object btnAtiGru: TBitBtnLocked
        Left = 216
        Top = 20
        Width = 216
        Height = 20
        Hint = 
          'Esta rotina permite cadastrar quais linhas/grupos os profissiona' +
          'is de uma '#13#10'determinada atividade ter'#227'o direito '#224' comiss'#227'o. Quan' +
          'do n'#227'o houver '#13#10'nenhuma linha/grupo vinculada a uma determinada ' +
          'atividade, o sistema '#13#10'entender'#225' que deve pagar comiss'#227'o sobre t' +
          'odas as linhas/grupos.'
        Caption = '[ F6 ] Comiss'#227'o por Atividade + Linha/Grupo'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnClick = btnAtiGruClick
      end
      object btnFaixa: TBitBtnLocked
        Left = 432
        Top = 20
        Width = 216
        Height = 20
        Hint = 
          'Esta rotina permite cadastrar as faixas de valores do documento ' +
          'de venda'#13#10'e os respectivos percentuais de comiss'#227'o que ser'#227'o pag' +
          'os ao profissional.'#13#10'Quando n'#227'o houver nenhuma faixa cadastrada,' +
          ' o sistema entender'#225' que'#13#10'deve pagar comiss'#227'o sobre o percentual' +
          ' de comiss'#227'o da tela principal'#13#10'do cadastro de diversos.'
        Caption = '[ F7 ] Comiss'#227'o por Faixa de Faturamento'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        Visible = False
        OnClick = btnFaixaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 650
      Top = 22
      Width = 133
      Height = 20
      ExplicitLeft = 650
      ExplicitTop = 22
      ExplicitWidth = 133
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 615
    Width = 803
    TabOrder = 3
    ExplicitTop = 593
    ExplicitWidth = 803
    inherited pnlNomeForm: TPanel
      Left = 615
      Width = 188
      ExplicitLeft = 615
      ExplicitWidth = 188
    end
    inherited pnlInfo: TPanel
      Width = 615
      ExplicitWidth = 615
    end
  end
  inherited pgcDados: TPageControl
    Width = 803
    Height = 570
    Visible = False
    ExplicitWidth = 803
    ExplicitHeight = 548
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 795
      ExplicitHeight = 516
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 803
    Height = 570
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 548
    DesignSize = (
      803
      570)
    object Label1: TLabel
      Left = 66
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 72
      Top = 62
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
    end
    object Label3: TLabel
      Left = 53
      Top = 110
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Endere'#231'o:'
    end
    object Label4: TLabel
      Left = 70
      Top = 134
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bairro:'
    end
    object Label5: TLabel
      Left = 435
      Top = 134
      Width = 99
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Nascimento:'
    end
    object Label6: TLabel
      Left = 66
      Top = 158
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object Label7: TLabel
      Left = 452
      Top = 158
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object Label9: TLabel
      Left = 546
      Top = 158
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'CEP:'
    end
    object Label12: TLabel
      Left = 32
      Top = 206
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desc. Fun'#231#227'o:'
    end
    object Label13: TLabel
      Left = 43
      Top = 230
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Telefone 01:'
    end
    object Label14: TLabel
      Left = 71
      Top = 301
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'E-Mail:'
    end
    object Label15: TLabel
      Left = 45
      Top = 278
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Home Page:'
    end
    object Label16: TLabel
      Left = 54
      Top = 324
      Width = 48
      Height = 14
      Alignment = taRightJustify
      Caption = 'Atividade:'
    end
    object Label8: TLabel
      Left = 33
      Top = 372
      Width = 69
      Height = 14
      Alignment = taRightJustify
      Caption = 'Observa'#231#245'es:'
    end
    object Label17: TLabel
      Left = 36
      Top = 86
      Width = 66
      Height = 14
      Alignment = taRightJustify
      Caption = 'Raz'#227'o Social:'
    end
    object Label19: TLabel
      Left = 6
      Top = 341
      Width = 96
      Height = 28
      Alignment = taRightJustify
      Caption = 'C'#243'd. do Profissional no Cad. Cliente:'
      WordWrap = True
    end
    object lbl1: TLabel
      Left = 259
      Top = 230
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Telefone 02:'
    end
    object lbl2: TLabel
      Left = 474
      Top = 230
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Celular:'
    end
    object lbl3: TLabel
      Left = 439
      Top = 206
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nro. Crea:'
    end
    object lblTipCom: TLabel
      Left = 438
      Top = 348
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo Com.:'
    end
    object lbl4: TLabel
      Left = 439
      Top = 301
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nro.PIS:'
    end
    object LabelCgcCpf1: TLabelCgcCpf
      Left = 32
      Top = 183
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = '1-CNPJ/2-CPF:'
      Pais = opcBrasil
    end
    object LabelRg1: TLabelRg
      Left = 464
      Top = 183
      Width = 24
      Height = 14
      Alignment = taRightJustify
      Caption = 'R.G.:'
      Pais = opcBrasil
    end
    object lbl5: TLabel
      Left = 202
      Top = 12
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
    end
    object lbl6: TColorLabel
      Left = 289
      Top = 12
      Width = 75
      Height = 14
      Caption = '(A)tivo (I)nativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label10: TLabel
      Left = 43
      Top = 493
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label11: TLabel
      Left = 435
      Top = 325
      Width = 53
      Height = 14
      Alignment = taRightJustify
      Caption = 'Insc.Estad:'
    end
    object lblNomeMae: TLabel
      Left = 34
      Top = 254
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome da M'#227'e:'
    end
    object lblOpeAlt: TLabel
      Left = 308
      Top = 37
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador:'
    end
    object Label18: TLabel
      Left = 22
      Top = 516
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Time de Futebol:'
    end
    object edtEstado: TEditFocus
      Left = 492
      Top = 154
      Width = 38
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 34
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodDiv: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 8
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_CODDIV'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNomDiv: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 58
      Width = 543
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_NOMDIV'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEndere: TDBEditFocus
      Left = 107
      Top = 106
      Width = 543
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_ENDERE'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBairro: TDBEditFocus
      Left = 107
      Top = 130
      Width = 323
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_BAIRRO'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaNas: TDBEditFocus
      Tag = 99
      Left = 538
      Top = 130
      Width = 112
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_DTANAS'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodCid: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 154
      Width = 42
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_CODCID'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 9
      OnKeyPress = dbeCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodCidChamaCadastro
    end
    object dbeNumCep: TDBEditFocus
      Tag = 99
      Left = 572
      Top = 154
      Width = 78
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_C_E_P_'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 10
      OnKeyPress = dbeNumCepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNumRg: TDBEditFocus
      Left = 492
      Top = 178
      Width = 158
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_NUMR_G'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 13
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesFun: TDBEditFocus
      Left = 107
      Top = 202
      Width = 323
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_DESFUN'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 14
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeFone01: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 226
      Width = 134
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_FONE01'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 16
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEmail: TDBEditFocus
      Left = 107
      Top = 297
      Width = 323
      Height = 22
      CharCase = ecLowerCase
      DataField = 'DIV_EMAIL_'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 20
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeHomPag: TDBEditFocus
      Left = 107
      Top = 274
      Width = 543
      Height = 22
      CharCase = ecLowerCase
      DataField = 'DIV_HOMEPA'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 19
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodAti: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 320
      Width = 55
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_CODATI'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 22
      OnKeyPress = dbeCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodAtiChamaCadastro
    end
    object dbeRazSoc: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 82
      Width = 543
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_RAZSOC'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtCidade: TEditFocus
      Left = 150
      Top = 154
      Width = 280
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 36
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtAtividade: TEditFocus
      Left = 164
      Top = 320
      Width = 266
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 35
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodCli: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 344
      Width = 55
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_CODCLI'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 24
      OnKeyPress = dbeCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodCliChamaCadastro
    end
    object edtNomCli: TEditFocus
      Left = 164
      Top = 344
      Width = 266
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 37
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeDIV_FONE01: TDBEditFocus
      Tag = 99
      Left = 323
      Top = 226
      Width = 134
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_FONE02'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 17
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDIV_FONE1: TDBEditFocus
      Tag = 99
      Left = 515
      Top = 226
      Width = 135
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_CELULA'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 18
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlDtaCad: TPanel
      Left = 20
      Top = 30
      Width = 277
      Height = 26
      BevelOuter = bvNone
      Enabled = False
      ParentColor = True
      TabOrder = 2
      object Label20: TLabel
        Left = 11
        Top = 7
        Width = 72
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data Cadastro:'
      end
      object lblDtaAlt: TLabel
        Left = 160
        Top = 7
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = #218'lt. Altera.:'
      end
      object dbeDtaCad: TDBEditFocus
        Tag = 99
        Left = 87
        Top = 3
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'DIV_DTACAD'
        DataSource = dtsCadDiv
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
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEDTAALT: TDBEditFocus
        Tag = 99
        Left = 216
        Top = 3
        Width = 60
        Height = 22
        CharCase = ecUpperCase
        DataField = 'DIV_DTAALT'
        DataSource = dtsCadDiv
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
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeNumCre: TDBEditFocus
      Left = 492
      Top = 202
      Width = 158
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_NUMCRE'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 15
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cbxTipCom: TComboBoxFocus
      Tag = 99
      Left = 492
      Top = 344
      Width = 158
      Height = 22
      Style = csDropDownList
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 25
      Items.Strings = (
        'CAD. DE PRODUTOS'
        'CAD. DE PROFISSIONAIS'
        'FAIXA DE FATURAMENTO'
        'CAD. DE CLIENTES')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object DBEditFocus1: TDBEditFocus
      Left = 492
      Top = 297
      Width = 158
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_NUMPIS'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 21
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeStatus: TDBEditFocus
      Tag = 99
      Left = 250
      Top = 8
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_STATUS'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeObserv: TDBMemoFocus
      Left = 107
      Top = 369
      Width = 543
      Height = 117
      BiDiMode = bdLeftToRight
      DataField = 'DIV_OBSERV'
      DataSource = dtsCadDiv
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentBiDiMode = False
      ScrollBars = ssVertical
      TabOrder = 26
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object pnlEmpDiv: TPanel
      Left = 654
      Top = 109
      Width = 132
      Height = 403
      TabOrder = 33
      object gpbEmpDiv: TGroupBox
        Left = 1
        Top = 1
        Width = 130
        Height = 401
        Align = alClient
        Caption = 'Empresa Identificadora:'
        Color = 16770261
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        object lblOpcoesSelecaoEmpresa: TLabel
          Left = 2
          Top = 385
          Width = 126
          Height = 14
          Cursor = crHandPoint
          Align = alBottom
          Caption = 'Op'#231#245'es de Sele'#231#227'o'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblOpcoesSelecaoEmpresaClick
          ExplicitWidth = 95
        end
        object clbEmpDiv: TCheckListBox
          Left = 2
          Top = 16
          Width = 126
          Height = 369
          Align = alClient
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemHeight = 14
          TabOrder = 0
        end
      end
    end
    object pnlPerCom: TPanel
      Left = 0
      Top = 537
      Width = 518
      Height = 25
      BevelOuter = bvNone
      Ctl3D = True
      ParentColor = True
      ParentCtl3D = False
      TabOrder = 30
      object lblPerCopPro: TLabel
        Left = 415
        Top = 4
        Width = 100
        Height = 14
        Alignment = taRightJustify
        Caption = 'Itens COM promo'#231#227'o'
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object lblPerCop: TLabel
        Left = 280
        Top = 4
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Comiss'#227'o (%):'
      end
      object lblPerComPro: TLabel
        Left = 167
        Top = 4
        Width = 98
        Height = 14
        Alignment = taRightJustify
        Caption = 'Itens SEM promo'#231#227'o'
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object lblPerCom: TLabel
        Left = 31
        Top = 4
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Comiss'#227'o (%):'
      end
      object dbePerCop: TDBEditFocus
        Tag = 99
        Left = 355
        Top = 0
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'DIV_PERCOP'
        DataSource = dtsCadDiv
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbePerCom: TDBEditFocus
        Tag = 99
        Left = 107
        Top = 0
        Width = 57
        Height = 22
        CharCase = ecUpperCase
        DataField = 'DIV_PERCOM'
        DataSource = dtsCadDiv
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
    object dbeNumCgc: TDBEditCgcCpf
      Tag = 99
      Left = 150
      Top = 178
      Width = 280
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_C_G_C_'
      DataSource = dtsCadDiv
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
      Tipo = C_G_C_
    end
    object dbeCgcCpf: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 178
      Width = 42
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_CGCCPF'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 11
      OnExit = dbeCgcCpfExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodFor: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 489
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_CODFOR'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 27
      OnKeyPress = dbeCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodForChamaCadastro
    end
    object edtNomFor: TEditFocus
      Left = 201
      Top = 489
      Width = 449
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 29
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pnlImgDiv: TPanel
      Left = 655
      Top = 8
      Width = 131
      Height = 95
      BevelInner = bvLowered
      BorderWidth = 2
      BorderStyle = bsSingle
      Color = clWhite
      DoubleBuffered = True
      ParentBackground = False
      ParentDoubleBuffered = False
      TabOrder = 32
      OnDblClick = imgDivDblClick
      object lblErrImg: TLabel
        Left = 4
        Top = 4
        Width = 119
        Height = 83
        Align = alClient
        Alignment = taCenter
        Caption = 
          'N'#227'o foi poss'#237'vel carregar a imagem. Verifique o formato do arqui' +
          'vo!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        Visible = False
        WordWrap = True
        ExplicitWidth = 118
        ExplicitHeight = 36
      end
      object imgDiv: TcxImage
        Left = 4
        Top = 4
        Align = alClient
        Properties.FitMode = ifmProportionalStretch
        Properties.PopupMenuLayout.MenuItems = []
        TabOrder = 0
        OnDblClick = imgDivDblClick
        Height = 83
        Width = 119
      end
    end
    object dbeNumIes: TDBEditFocus
      Tag = 99
      Left = 492
      Top = 321
      Width = 158
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_I_E_S_'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 23
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object chkCartaoProfissional: TDBCheckBox
      Tag = 99
      Left = 538
      Top = 540
      Width = 110
      Height = 16
      ParentCustomHint = False
      Caption = 'Cart'#227'o Profissional'
      DataField = 'DIV_CARPRO'
      DataSource = dtsCadDiv
      TabOrder = 31
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dbeNomeMae: TDBEditFocus
      Left = 107
      Top = 250
      Width = 543
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_NOMMAE'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 38
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeOpeAlt: TDBEditFocus
      Tag = 99
      Left = 363
      Top = 33
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_OPEALT'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
    end
    object edtOperador: TEditFocus
      Left = 399
      Top = 33
      Width = 251
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 40
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodTfu: TDBEditFocus
      Tag = 99
      Left = 107
      Top = 513
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'DIV_CODTFU'
      DataSource = dtsCadDiv
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 28
      OnKeyPress = dbeCodTfuKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
    end
    object edtNomTfu: TEditFocus
      Left = 201
      Top = 513
      Width = 449
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 39
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 752
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 16
    Top = 363
  end
  object dtsCadDiv: TDataSource
    Left = 48
    Top = 363
  end
  object popOpSele: TPopupMenu
    Left = 748
    Top = 156
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = MarcarTodos1Click
    end
    object DesmarcarTodos1: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = DesmarcarTodos1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InverterSeleo1: TMenuItem
      Caption = 'Inverter Sele'#231#227'o'
      OnClick = InverterSeleo1Click
    end
  end
end
