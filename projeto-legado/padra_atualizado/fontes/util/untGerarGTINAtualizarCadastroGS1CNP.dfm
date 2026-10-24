inherited frmGerarGTINAtualizarCadastroGS1CNP: TfrmGerarGTINAtualizarCadastroGS1CNP
  Width = 900
  Height = 554
  Caption = 'Gera'#231#227'o de GTIN / Atualiza'#231#227'o de cadastro pela GS1/CNP'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 900
  ExplicitHeight = 554
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 456
    Width = 894
    Height = 53
    Enabled = True
    Visible = True
    ExplicitTop = 456
    ExplicitWidth = 894
    ExplicitHeight = 53
    object Shape4: TShape [0]
      Left = 12
      Top = 5
      Width = 15
      Height = 15
      Brush.Color = clGreen
    end
    object Label11: TLabel [1]
      Left = 30
      Top = 6
      Width = 43
      Height = 14
      Caption = 'Sucesso'
    end
    object Shape1: TShape [2]
      Left = 99
      Top = 5
      Width = 15
      Height = 15
      Brush.Color = clRed
    end
    object Shape2: TShape [3]
      Left = 217
      Top = 5
      Width = 15
      Height = 15
      Brush.Color = clYellow
    end
    object Label12: TLabel [4]
      Left = 117
      Top = 6
      Width = 75
      Height = 14
      Caption = 'Inconsist'#234'ncias'
    end
    object Label13: TLabel [5]
      Left = 235
      Top = 6
      Width = 31
      Height = 14
      Caption = 'Inativo'
    end
    object Shape3: TShape [6]
      Left = 298
      Top = 5
      Width = 15
      Height = 15
    end
    object Label14: TLabel [7]
      Left = 316
      Top = 6
      Width = 95
      Height = 14
      Caption = 'N'#227'o foi processado'
    end
    inherited FlwBotoes: TFlowPanel
      TabOrder = 5
    end
    inherited btnSair: TBitBtnLocked
      Left = 815
      Top = 2
      Height = 49
      Align = alRight
      TabOrder = 4
      ExplicitLeft = 815
      ExplicitTop = 2
      ExplicitHeight = 49
    end
    object btnEnviar: TBitBtnLocked
      Left = 2
      Top = 28
      Width = 195
      Height = 22
      Caption = '[F10] - Enviar cadastro / atualiza'#231#227'o'
      TabOrder = 0
      TabStop = False
      OnClick = btnEnviarClick
    end
    object btnMarcar: TBitBtnLocked
      Left = 197
      Top = 28
      Width = 153
      Height = 22
      Caption = '[ F2 ] - Marcar Todos'
      TabOrder = 1
      TabStop = False
      OnClick = btnMarcarClick
    end
    object btnDesmarcar: TBitBtnLocked
      Left = 349
      Top = 28
      Width = 140
      Height = 22
      Caption = '[ F3 ] Desmarcar Todos'
      TabOrder = 2
      TabStop = False
      OnClick = btnDesmarcarClick
    end
    object btnCadProduto: TBitBtnLocked
      Left = 488
      Top = 28
      Width = 145
      Height = 22
      Caption = '[ F8 ] Cadastro de Produto'
      TabOrder = 3
      TabStop = False
      OnClick = btnCadProdutoClick
    end
  end
  inherited pgcDados: TPageControl
    Top = 193
    Width = 894
    Height = 248
    ExplicitTop = 193
    ExplicitWidth = 894
    ExplicitHeight = 248
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 886
      ExplicitHeight = 216
    end
  end
  inherited pnlStatus: TPanel
    Top = 509
    Width = 894
    ExplicitTop = 509
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 723
      ExplicitLeft = 723
    end
    inherited pnlInfo: TPanel
      Width = 723
      ExplicitWidth = 723
    end
  end
  object pnlFiltro: TPanel [4]
    Left = 0
    Top = 0
    Width = 894
    Height = 193
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label1: TLabel
      Left = 31
      Top = 102
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object Label2: TLabel
      Left = 47
      Top = 80
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label6: TLabel
      Left = 66
      Top = 146
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
    end
    object Label50: TLabel
      Left = 33
      Top = 170
      Width = 137
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto cadastrado na GS1:'
    end
    object Label8: TLabel
      Left = 40
      Top = 124
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object ColorLabel2: TColorLabel
      Left = 208
      Top = 170
      Width = 58
      Height = 14
      Caption = '(S)im (N)'#227'o '
      CorDestaque = clRed
    end
    object mskLinGru: TMaskEditFocus
      Tag = 99
      Left = 101
      Top = 98
      Width = 48
      Height = 22
      CharCase = ecUpperCase
      EditMask = '999.999;0;_'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 4
      Text = ''
      OnKeyPress = mskLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 149
      Top = 98
      Width = 423
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 101
      Top = 76
      Width = 471
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnKeyPress = edtDesIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodMar: TEditFocus
      Tag = 99
      Left = 101
      Top = 142
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 8
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
      Left = 170
      Top = 142
      Width = 402
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
    object edtProCadGS1: TEditFocus
      Tag = 99
      Left = 173
      Top = 166
      Width = 29
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 10
      Text = 'N'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 101
      Top = 120
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 6
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
      Left = 170
      Top = 120
      Width = 402
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object grbDataCadastro: TGroupBox
      Left = 31
      Top = 2
      Width = 178
      Height = 67
      Caption = 'Data de cadastro'
      TabOrder = 0
      object Label3: TLabel
        Left = 16
        Top = 18
        Width = 26
        Height = 14
        Caption = 'Inicial'
      end
      object Label4: TLabel
        Left = 90
        Top = 18
        Width = 22
        Height = 14
        Caption = 'Final'
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 16
        Top = 33
        Width = 68
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        Left = 91
        Top = 33
        Width = 70
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object grbDataCadastroGS1: TGroupBox
      Left = 211
      Top = 2
      Width = 174
      Height = 67
      Caption = 'Data de cadastro na GS1'
      TabOrder = 1
      object Label5: TLabel
        Left = 15
        Top = 18
        Width = 26
        Height = 14
        Caption = 'Inicial'
      end
      object Label7: TLabel
        Left = 89
        Top = 18
        Width = 22
        Height = 14
        Caption = 'Final'
      end
      object mskDtaIniCadGS1: TMaskEditFocus
        Tag = 99
        Left = 15
        Top = 33
        Width = 68
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFinCadGS1: TMaskEditFocus
        Tag = 99
        Left = 90
        Top = 33
        Width = 70
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object grbDataUltimaAtualizacaoGS1: TGroupBox
      Left = 386
      Top = 2
      Width = 186
      Height = 67
      Caption = 'Data de ultima atualiza'#231#227'o na GS1'
      TabOrder = 2
      object Label9: TLabel
        Left = 20
        Top = 18
        Width = 26
        Height = 14
        Caption = 'Inicial'
      end
      object Label10: TLabel
        Left = 94
        Top = 18
        Width = 22
        Height = 14
        Caption = 'Final'
      end
      object mskDtaIniAtuGS1: TMaskEditFocus
        Tag = 99
        Left = 20
        Top = 33
        Width = 68
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskDtaFinAtuGS1: TMaskEditFocus
        Tag = 99
        Left = 95
        Top = 33
        Width = 70
        Height = 22
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object btnAdicionar: TBitBtnLocked
      Left = 403
      Top = 166
      Width = 85
      Height = 22
      Caption = '&Confirma'
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
      Left = 488
      Top = 166
      Width = 85
      Height = 22
      Caption = 'C&ancelar'
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
    object rdgOpcoesServicos: TRadioGroup
      Left = 696
      Top = 80
      Width = 194
      Height = 105
      Caption = 'Definir rotina que ser'#225' executada'
      ItemIndex = 2
      Items.Strings = (
        'Cadastro'
        'Cadastro com GTIN'
        'Atualiza'#231#227'o')
      TabOrder = 13
    end
  end
  object pnlGrid: TPanel [5]
    Left = 0
    Top = 193
    Width = 894
    Height = 248
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object cxgProdutos: TcxGrid
      Left = 0
      Top = 0
      Width = 894
      Height = 248
      Align = alClient
      TabOrder = 0
      object cxgProdutosDBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsProdutos
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object SELECIONADO: TcxGridDBColumn
          Caption = 'Selecionado'
          DataBinding.FieldName = 'SELECIONADO'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          MinWidth = 75
          Styles.Header = cxStyle1
        end
        object STATUS: TcxGridDBColumn
          Caption = 'Status'
          DataBinding.FieldName = 'STATUS'
          OnCustomDrawCell = STATUSCustomDrawCell
          MinWidth = 60
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object ITE_CADGS1: TcxGridDBColumn
          Caption = 'Cad. GS1'
          DataBinding.FieldName = 'ITE_CADGS1'
          MinWidth = 70
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 80
        end
        object ITE_DTCGS1: TcxGridDBColumn
          Caption = 'Data Cad. GS1'
          DataBinding.FieldName = 'ITE_DTCGS1'
          MinWidth = 90
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 110
        end
        object ITE_DTAGS1: TcxGridDBColumn
          Caption = 'Data Atual. GS1'
          DataBinding.FieldName = 'ITE_DTAGS1'
          MinWidth = 95
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 110
        end
        object ITE_CODITE: TcxGridDBColumn
          Caption = 'C'#243'd. Item'
          DataBinding.FieldName = 'ITE_CODITE'
          MinWidth = 70
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 80
        end
        object ITE_DESITE: TcxGridDBColumn
          Caption = 'Descri'#231#227'o Item'
          DataBinding.FieldName = 'ITE_DESITE'
          MinWidth = 250
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 400
        end
        object ITE_CODGPC: TcxGridDBColumn
          Caption = 'C'#243'd. GPC'
          DataBinding.FieldName = 'ITE_CODGPC'
          MinWidth = 70
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 120
        end
        object GPC_DESGPC: TcxGridDBColumn
          Caption = 'Descri'#231#227'o GPC'
          DataBinding.FieldName = 'GPC_DESGPC'
          MinWidth = 150
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 300
        end
        object ITE_CLAIPI: TcxGridDBColumn
          Caption = 'NCM'
          DataBinding.FieldName = 'ITE_CLAIPI'
          MinWidth = 70
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 150
        end
        object ITE_CDCEST: TcxGridDBColumn
          Caption = 'CEST'
          DataBinding.FieldName = 'ITE_CDCEST'
          MinWidth = 70
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 150
        end
        object ITE_CODMAR: TcxGridDBColumn
          Caption = 'C'#243'd Marca'
          DataBinding.FieldName = 'ITE_CODMAR'
          MinWidth = 70
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 100
        end
        object MAR_DESMAR: TcxGridDBColumn
          Caption = 'Descri'#231#227'o Marca'
          DataBinding.FieldName = 'MAR_DESMAR'
          MinWidth = 120
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 200
        end
        object ITE_CODUNI: TcxGridDBColumn
          Caption = 'C'#243'd. Unidade'
          DataBinding.FieldName = 'ITE_CODUNI'
          MinWidth = 70
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 180
        end
        object UNI_DESUNI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o Unidade'
          DataBinding.FieldName = 'UNI_DESUNI'
          MinWidth = 110
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 300
        end
        object UNI_CODUNG: TcxGridDBColumn
          Caption = 'C'#243'd Unidade GS1'
          DataBinding.FieldName = 'UNI_CODUNG'
          MinWidth = 100
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 300
        end
        object ITE_PESOIT: TcxGridDBColumn
          Caption = 'Peso Bruto'
          DataBinding.FieldName = 'ITE_PESOIT'
          MinWidth = 100
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 250
        end
        object ITE_PESLIQ: TcxGridDBColumn
          Caption = 'Peso L'#237'quido'
          DataBinding.FieldName = 'ITE_PESLIQ'
          MinWidth = 100
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 270
        end
        object ITE_IMGURL: TcxGridDBColumn
          Caption = 'Imagem Url'
          DataBinding.FieldName = 'ITE_IMGURL'
          MinWidth = 500
          Options.Editing = False
          Styles.Header = cxStyle1
          Width = 500
        end
        object ITE_TEMPRO: TcxGridDBColumn
          Caption = 'Tempo m'#237'nimo ap'#243's produ'#231#227'o'
          DataBinding.FieldName = 'ITE_TEMPRO'
          MinWidth = 100
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object ITE_DTALAN: TcxGridDBColumn
          Caption = 'Data de lan'#231'amento'
          DataBinding.FieldName = 'ITE_DTALAN'
          MinWidth = 100
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object BAR_CODBAR_1: TcxGridDBColumn
          Caption = 'C'#243'digo de Barras'
          DataBinding.FieldName = 'BAR_CODBAR_1'
          MinWidth = 110
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object BAR_STGTIN_1: TcxGridDBColumn
          Caption = 'Status do GTIN'
          DataBinding.FieldName = 'BAR_STGTIN_1'
          MinWidth = 90
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object BAR_CODBAR_2: TcxGridDBColumn
          Caption = 'C'#243'digo de Barras'
          DataBinding.FieldName = 'BAR_CODBAR_2'
          MinWidth = 110
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object BAR_STGTIN_2: TcxGridDBColumn
          Caption = 'Status do GTIN'
          DataBinding.FieldName = 'BAR_STGTIN_2'
          MinWidth = 90
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object BAR_CODBAR_3: TcxGridDBColumn
          Caption = 'C'#243'digo de Barras'
          DataBinding.FieldName = 'BAR_CODBAR_3'
          MinWidth = 110
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object BAR_STGTIN_3: TcxGridDBColumn
          Caption = 'Status do GTIN'
          DataBinding.FieldName = 'BAR_STGTIN_3'
          MinWidth = 90
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object BAR_CODBAR_4: TcxGridDBColumn
          Caption = 'C'#243'digo de Barras'
          DataBinding.FieldName = 'BAR_CODBAR_4'
          MinWidth = 110
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object BAR_STGTIN_4: TcxGridDBColumn
          Caption = 'Status do GTIN'
          DataBinding.FieldName = 'BAR_STGTIN_4'
          MinWidth = 90
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object BAR_CODBAR_5: TcxGridDBColumn
          Caption = 'C'#243'digo de Barras'
          DataBinding.FieldName = 'BAR_CODBAR_5'
          MinWidth = 110
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object BAR_STGTIN_5: TcxGridDBColumn
          Caption = 'Status do GTIN'
          DataBinding.FieldName = 'BAR_STGTIN_5'
          MinWidth = 90
          Options.Editing = False
          Styles.Header = cxStyle1
        end
        object INCONSISTENCIAS: TcxGridDBColumn
          Caption = 'Inconsist'#234'ncias'
          DataBinding.FieldName = 'INCONSISTENCIAS'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Caption = 'Visualizar'
              Default = True
              Hint = 'Inconsist'#234'ncias'
              Kind = bkEllipsis
            end>
          Properties.ReadOnly = True
          Properties.ViewStyle = vsButtonsOnly
          Properties.OnButtonClick = INCONSISTENCIASPropertiesButtonClick
          MinWidth = 100
          Options.ShowEditButtons = isebAlways
          Styles.Header = cxStyle1
          Width = 200
        end
      end
      object cxgProdutosLevel1: TcxGridLevel
        GridView = cxgProdutosDBTableView1
      end
    end
  end
  object prbProgresso: TProgressBar [6]
    Left = 0
    Top = 441
    Width = 894
    Height = 15
    Align = alBottom
    Smooth = True
    TabOrder = 6
    Visible = False
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object dtsProdutos: TDataSource
    Left = 616
    Top = 24
  end
end
