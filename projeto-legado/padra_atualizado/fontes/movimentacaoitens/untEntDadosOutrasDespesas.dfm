inherited frmEntDadosOutrasDespesas: TfrmEntDadosOutrasDespesas
  Width = 740
  Height = 750
  Caption = 'Outras Despesas'
  OnDestroy = FormDestroy
  ExplicitWidth = 740
  ExplicitHeight = 750
  PixelsPerInch = 96
  TextHeight = 14
  object Label62: TLabel [0]
    Left = 188
    Top = 7
    Width = 65
    Height = 14
    Alignment = taRightJustify
    Caption = 'Imprime Lista:'
  end
  object ColorLabel3: TColorLabel [1]
    Left = 320
    Top = 7
    Width = 55
    Height = 14
    Caption = '(S)im (N)'#227'o'
    CorDestaque = clRed
  end
  object pnlOutras: TPanel [2]
    Left = 0
    Top = 169
    Width = 734
    Height = 259
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    ExplicitTop = 166
    object lblCliFor: TLabel
      Left = 74
      Top = 4
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label7: TLabel
      Left = 11
      Top = 141
      Width = 122
      Height = 14
      Alignment = taRightJustify
      Caption = 'Condi'#231#227'o de  Pagamento:'
    end
    object Label31: TLabel
      Left = 89
      Top = 96
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label2: TLabel
      Left = 30
      Top = 167
      Width = 103
      Height = 14
      Alignment = taRightJustify
      Caption = 'Obs. Contas a Pagar:'
    end
    object ColorLabel1: TColorLabel
      Left = 163
      Top = 28
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object Label3: TLabel
      Left = 92
      Top = 28
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Veio NF?'
    end
    object ColorLabel2: TColorLabel
      Left = 346
      Top = 27
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object Label4: TLabel
      Left = 255
      Top = 28
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'Veio Boleto?'
    end
    object Label5: TLabel
      Left = 84
      Top = 51
      Width = 51
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dep'#243'sito?:'
    end
    object ColorLabel5: TColorLabel
      Left = 163
      Top = 51
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object lblConta: TLabel
      Left = 227
      Top = 51
      Width = 31
      Height = 14
      Alignment = taRightJustify
      Caption = 'Conta:'
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 137
      Top = 0
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 200
      Top = 0
      Width = 509
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
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 137
      Top = 137
      Width = 560
      Height = 22
      CharCase = ecUpperCase
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      TabOrder = 9
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object btnAdicionar: TBitBtnLocked
      Left = 488
      Top = 235
      Width = 111
      Height = 22
      Caption = 'Con&firma'
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
      OnClick = btnAdicionarClick
    end
    object btnCancelaItem: TBitBtnLocked
      Left = 600
      Top = 235
      Width = 111
      Height = 22
      Caption = 'Ca&ncelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 12
      OnClick = btnCancelaItemClick
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 137
      Top = 92
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 7
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPor: TEditFocus
      Left = 200
      Top = 92
      Width = 509
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
    inline fraCentroCusto: TfraCentroCustoEditFocus
      Left = 43
      Top = 114
      Width = 685
      Height = 22
      TabOrder = 8
      ExplicitLeft = 43
      ExplicitTop = 114
      ExplicitWidth = 685
      inherited lblEventos: TLabel
        Left = 1
        Top = 6
        Width = 87
        Height = 14
        ExplicitLeft = 1
        ExplicitTop = 6
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited edtCodEve: TEditFocus
        Width = 62
        Height = 22
        TabOrder = 1
        ExplicitWidth = 62
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 157
        Width = 509
        Height = 22
        TabOrder = 0
        ExplicitLeft = 157
        ExplicitWidth = 509
        ExplicitHeight = 22
      end
    end
    object MemObsCta: TMemo
      Left = 137
      Top = 160
      Width = 337
      Height = 73
      TabOrder = 10
    end
    inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
      Left = 50
      Top = 69
      Width = 661
      Height = 22
      TabOrder = 6
      ExplicitLeft = 50
      ExplicitTop = 69
      ExplicitWidth = 661
      inherited lblPlaContas: TLabel
        Top = 5
        Width = 81
        Height = 14
        ExplicitTop = 5
        ExplicitWidth = 81
        ExplicitHeight = 14
      end
      inherited edtDesCta: TEditFocus
        Left = 150
        Width = 509
        Height = 22
        ExplicitLeft = 150
        ExplicitWidth = 509
        ExplicitHeight = 22
      end
      inherited MskCodCta: TMaskEdit
        Left = 87
        Width = 62
        Height = 22
        OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
        ExplicitLeft = 87
        ExplicitWidth = 62
        ExplicitHeight = 22
      end
    end
    object edtVeioNF: TEditFocus
      Tag = 99
      Left = 137
      Top = 23
      Width = 25
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 1
      Text = 'N'
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtVeioBO: TEditFocus
      Tag = 99
      Left = 320
      Top = 23
      Width = 25
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 2
      Text = 'N'
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 1
      TipoTexto = ttAlfabetico
    end
    object edtDeposi: TEditFocus
      Tag = 99
      Left = 137
      Top = 46
      Width = 25
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      OnExit = edtDeposiExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cbxBcoFor: TComboBoxFocus
      Left = 264
      Top = 46
      Width = 377
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnChange = cbxBcoForChange
      OnDropDown = cbxBcoForDropDown
      OnEnter = cbxBcoForEnter
      OnExit = cbxBcoForExit
      OnKeyUp = cbxBcoForKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object chkGraFin: TCheckBox
      Left = 407
      Top = 26
      Width = 112
      Height = 17
      Caption = 'Gravar Financeiro'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object pnlValOut: TPanel [3]
    Left = 0
    Top = 137
    Width = 734
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label16: TLabel
      Left = 105
      Top = 14
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object edtValOut: TEditFocus
      Tag = 99
      Left = 137
      Top = 9
      Width = 62
      Height = 22
      Alignment = taRightJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object chkRpaDespFrete: TCheckBox
      Left = 205
      Top = 0
      Width = 504
      Height = 17
      Caption = 'Lan'#231'amento de RPA para compor frete dos produtos'
      TabOrder = 1
      OnClick = chkRpaDespFreteClick
    end
    object chkDesAdi: TCheckBox
      Left = 205
      Top = 15
      Width = 504
      Height = 17
      Caption = 'Descontos Adicionais (Boleto) (-):'
      TabOrder = 2
      OnClick = chkDesAdiClick
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 67
    Width = 734
    Height = 70
    Align = alTop
    TabOrder = 1
    object Label6: TLabel
      Left = 44
      Top = 4
      Width = 519
      Height = 14
      Caption = 
        'Os lan'#231'amentos ser'#227'o rateados de acordo com o '#250'ltimo Tipo de Rat' +
        'eio selecionado, com exce'#231#227'o dos RPA.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object rdgTipoRateio: TRadioGroup
      Left = 43
      Top = 17
      Width = 520
      Height = 49
      Caption = 'Tipo de Rateio'
      Columns = 2
      Items.Strings = (
        'Valor do Item'
        'Peso do Item'
        'Quantidade do Item'
        'Informar manualmente os percentuais por produto')
      TabOrder = 0
    end
  end
  object mmoAjuda: TMemo [5]
    Left = 0
    Top = 0
    Width = 734
    Height = 67
    TabStop = False
    Align = alTop
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      
        'Nesta tela, deve ser informado o valor de outras despesas realiz' +
        'adas para aquisi'#231#227'o, transporte ou armazenamento dos '
      
        'produtos constantes nesta nota fiscal, cujo valor n'#227'o foi inform' +
        'ado nem na pr'#243'pria nota fiscal, nem por conhecimento de '
      
        'frete, nem pela GNRE. Esta despesa ser'#225' lan'#231'ada no contas a paga' +
        'r, em aberto, separadamente do valor da nota fiscal'
      'das mercadorias.')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    StyleElements = [seFont, seBorder]
  end
  object dbgDados: TDBGridCitel [6]
    Left = 0
    Top = 428
    Width = 734
    Height = 225
    Align = alClient
    BorderStyle = bsNone
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 5
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDblClick = dbgDadosDblClick
    OnKeyDown = dbgDadosKeyDown
    OnKeyPress = dbgDadosKeyPress
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODFOR'
        Title.Caption = 'Fornecedor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMFOR'
        Title.Caption = '    '
        Width = 242
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODCTA'
        Title.Caption = 'Plano de Contas'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODEVE'
        Title.Caption = 'Ctr. Custos'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCTA'
        Title.Caption = '    '
        Width = 186
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VEIOBO'
        Title.Alignment = taCenter
        Title.Caption = 'Veio Boleto?'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VEIONF'
        Title.Alignment = taCenter
        Title.Caption = 'Veio NF?'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALOUT'
        Title.Caption = 'Valor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODPOR'
        ReadOnly = True
        Title.Caption = 'C'#243'd. Portador'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMPOR'
        ReadOnly = True
        Title.Caption = 'Portador'
        Width = 337
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GERFIN'
        Title.Caption = 'Gravar Financeiro'
        Width = 91
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RPAFRE'
        Title.Caption = 'Rpa'
        Visible = True
      end>
  end
  inherited pnlBotoes: TPanel
    Top = 653
    Width = 734
    Height = 52
    TabOrder = 6
    ExplicitTop = 653
    ExplicitWidth = 734
    ExplicitHeight = 52
    object lblTotal: TLabel [0]
      Left = 446
      Top = 6
      Width = 226
      Height = 20
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total 0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel [1]
      Left = 285
      Top = 9
      Width = 109
      Height = 15
      Caption = '[DEL] - Deletar Item'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Top = 27
      Width = 730
      Height = 23
      Align = alBottom
      ExplicitTop = 27
      ExplicitWidth = 730
      ExplicitHeight = 23
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 651
      Top = 27
      ExplicitLeft = 651
      ExplicitTop = 27
    end
  end
  inherited pnlStatus: TPanel
    Top = 705
    Width = 734
    TabOrder = 4
    ExplicitTop = 705
    ExplicitWidth = 734
    inherited pnlNomeForm: TPanel
      Left = 563
      ExplicitLeft = 563
    end
    inherited pnlInfo: TPanel
      Width = 563
      ExplicitWidth = 563
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 48
    Top = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 80
    Top = 344
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 16
    Top = 344
  end
  object ds1: TDataSource
    Left = 112
    Top = 344
  end
end
