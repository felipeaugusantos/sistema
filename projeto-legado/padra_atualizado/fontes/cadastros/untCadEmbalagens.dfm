inherited frmCadEmbalagens: TfrmCadEmbalagens
  Width = 709
  Height = 600
  Align = alClient
  BorderStyle = bsNone
  Caption = ''
  Position = poDefault
  ExplicitWidth = 709
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 572
    Width = 709
    Caption = 'Pressione [ DELETE ] para excluir o c'#243'digo de barras'
    Font.Color = clWhite
    ParentFont = False
    TabOrder = 2
    Visible = False
    ExplicitTop = 572
    ExplicitWidth = 709
    DesignSize = (
      709
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 705
      ExplicitWidth = 705
      object btnSelecionar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 172
        Height = 22
        Caption = '[F10] Selecionar Quantidade'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000090000
          000D0000000F0000000F0000000F0000000F0000000F0000000F0000000F0000
          000F0000000F00000010000000100000000F0000000A000000021D5A42C0287D
          5AFF277D5AFF277C5AFF277C59FF277B59FF277B58FF277A58FF267A58FF2678
          57FF267A56FF267856FF267755FF257756FF1B563DC1000000092B825FFF53C8
          A2FF51C7A0FF50C7A0FF4EC69FFF4DC59DFF4CC59DFF4AC49BFF49C39BFF47C3
          99FF45C298FF45C198FF43C096FF42C095FF277B59FF0000000D2C8664FF5DCC
          AAFF43C398FF42C299FF42C298FF43C298FF65CFADFF74D5B6FF4CC59DFF40C0
          95FF3EC095FF3EBF94FF3DBF94FF4BC49CFF297F5CFF0000000E2F8B68FF67D1
          B0FF48C69EFF48C59CFF47C59CFF5FCDABFF25825DFF00673BFF51BA96FF44C3
          9AFF43C399FF43C298FF42C298FF54C9A4FF2B8360FF0000000D31906DFF71D5
          B8FF4DC9A3FF4DC9A1FF60CFADFF3B9372FF87AF9DFFB1CFC1FF26875FFF53CA
          A5FF48C69EFF47C59DFF47C59DFF5DCEABFF2D8865FF0000000C339671FF7ADA
          BFFF52CCA7FF60D1AFFF4BA183FF699782FFF8F1EEFFF9F3EEFF357F5DFF5CBD
          9DFF4EC9A2FF4CC9A2FF4CC8A1FF67D2B2FF2F8C69FF0000000B359A76FF83DE
          C6FF59D0ADFF5AB094FF4F826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1C74
          4FFF69D5B4FF53CDA7FF52CCA6FF72D7B9FF32926EFF0000000B39A07CFF8CE2
          CBFF5FD4B3FF0D6742FFD2D2CBFF6A8F77FF136A43FF73967EFFF1E8E3FF72A2
          8BFF4CA384FF6AD9BAFF5AD2AFFF7BDBC0FF339773FF0000000A3AA681FF97E9
          D5FF69DEBFFF52BC9DFF0B6942FF389B79FF66DABAFF349773FF73967EFFF0EA
          E7FF4F886CFF60B89BFF67DABAFF87E2CAFF359C78FF000000093FAD88FF9FEC
          DAFF6DE1C3FF6DE1C3FF6DE0C2FF6CDFC1FF6BE0C1FF6BDFC0FF2C8966FF698E
          76FFE6E1DCFF176B47FF5FD1B2FF90E7D1FF3CA481FF0000000842B28DFFA5EE
          DDFF70E4C7FF70E4C6FF70E3C6FF6FE3C5FF6FE2C5FF6EE2C4FF6EE2C4FF3C9E
          7DFF1F6D4AFF2D8965FF6CE0C2FF97EAD6FF3DAA86FF0000000744B691FFAAEF
          E0FF73E6C9FF73E6C9FF72E5C9FF72E5C8FF71E5C8FF71E5C8FF71E4C7FF71E4
          C7FF64D3B5FF6DDFC2FF6FE3C6FF9EECDAFF41AF8BFF0000000746B994FFAEF1
          E2FF74E8CBFF74E7CBFF74E7CBFF74E7CAFF74E6CAFF73E6CAFF73E6CAFF73E6
          C9FF73E5C9FF72E5C9FF72E5C8FFA4EEDDFF42B38EFF0000000647BC97FFC5F4
          EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4
          EBFFC5F4EBFFC5F4EBFFC5F4EBFFC5F4EBFF44B792FF00000005348B70BF47BC
          97FF47BC97FF47BC97FF47BC97FF47BC97FF47BC97FF47BC97FF47BB97FF47BB
          97FF47BB96FF46BB96FF47BA95FF45BA94FF338A6EC000000003}
        TabOrder = 0
        Visible = False
        OnClick = btnSelecionarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 626
      Font.Color = clWhite
      Font.Height = -11
      ParentFont = False
      Visible = False
      ExplicitLeft = 626
    end
  end
  inherited pnlStatus: TPanel
    Top = 556
    Width = 709
    TabOrder = 3
    ExplicitTop = 556
    ExplicitWidth = 709
    inherited pnlNomeForm: TPanel
      Left = 538
      ExplicitLeft = 538
    end
    inherited pnlInfo: TPanel
      Width = 538
      ExplicitWidth = 538
    end
  end
  object pnlEmbala: TPanel [2]
    Left = 0
    Top = 30
    Width = 709
    Height = 318
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object pnlVendas: TPanel
      Left = 0
      Top = 141
      Width = 709
      Height = 72
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 1
      object lblPreVen: TLabel
        Left = 23
        Top = 12
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Caption = 'Pre'#231'o de Venda:'
      end
      object lblDescri: TLabel
        Left = 25
        Top = 34
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o Emb.:'
      end
      object lblAviso: TLabel
        Left = 344
        Top = 56
        Width = 303
        Height = 14
        Caption = '**Valor Total do Item no Faturamento = Prc.Venda * Qtde'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblAvisoTabPre: TLabel
        Left = 9
        Top = 56
        Width = 307
        Height = 14
        Caption = '**Tabela de Pre'#231'o = (F) Considera tabela do Faturamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTabPer: TLabel
        Left = 180
        Top = 12
        Width = 77
        Height = 14
        Caption = 'N'#227'o Permitido'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        Visible = False
      end
      object edtPreven: TEditFocus
        Tag = 99
        Left = 107
        Top = 7
        Width = 150
        Height = 22
        Alignment = taRightJustify
        TabOrder = 1
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtDescri: TEditFocus
        Tag = 99
        Left = 107
        Top = 29
        Width = 542
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 70
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object cmbTabPre: TComboBoxFocus
        Tag = 99
        Left = 108
        Top = 7
        Width = 66
        Height = 22
        Style = csDropDownList
        TabOrder = 0
        OnChange = cmbTabPreChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 709
      Height = 141
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 0
      object Label168: TLabel
        Left = 16
        Top = 30
        Width = 87
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo de Barras:'
      end
      object Label169: TLabel
        Left = 45
        Top = 54
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Quantidade:'
      end
      object lblCliFor: TLabel
        Left = 44
        Top = 117
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object lblDtaCadGS1: TLabel
        Left = 257
        Top = 6
        Width = 125
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data do cadastro na GS1:'
        Visible = False
      end
      object lblDtaAtuGS1: TLabel
        Left = 459
        Top = 6
        Width = 167
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data da '#250'ltima atualiza'#231#227'o na GS1:'
        Visible = False
      end
      object lblStatusGTIN: TLabel
        Left = 44
        Top = 93
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Status GTIN:'
        Visible = False
      end
      object lblProCadGS1: TLabel
        Left = 16
        Top = 6
        Width = 140
        Height = 14
        Alignment = taRightJustify
        Caption = 'Produto cadastrado na GS1?'
        Visible = False
      end
      object lblProCadGS1Color: TColorLabel
        Left = 187
        Top = 6
        Width = 58
        Height = 14
        Caption = '(S)im (N)'#227'o '
        Visible = False
        CorDestaque = clRed
      end
      object edtCodbar: TEditFocus
        Tag = 99
        Left = 107
        Top = 26
        Width = 150
        Height = 22
        Alignment = taLeftJustify
        MaxLength = 20
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 20
        TipoTexto = ttAlfanumerico
      end
      object chkPrinci: TCheckBox
        Left = 285
        Top = 24
        Width = 216
        Height = 17
        Caption = 'C'#243'digo de barras principal do produto'
        TabOrder = 2
        OnClick = chkPrinciClick
      end
      object chkCompra: TCheckBox
        Tag = 99
        Left = 285
        Top = 40
        Width = 217
        Height = 17
        Caption = 'C'#243'digo de barras principal para compras'
        TabOrder = 3
      end
      object chkBarAut: TCheckBox
        Left = 285
        Top = 73
        Width = 321
        Height = 17
        Caption = 'Gerar C'#243'digo de barras automaticamente (quando em branco)'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object chkExbFat: TCheckBox
        Tag = 99
        Left = 285
        Top = 56
        Width = 319
        Height = 17
        Caption = 'Exibir no Faturamento'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 107
        Top = 113
        Width = 96
        Height = 22
        Alignment = taRightJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 9
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
      object edtNomFor: TEditFocus
        Left = 203
        Top = 113
        Width = 446
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtEmbala: TEditFocus
        Tag = 99
        Left = 107
        Top = 49
        Width = 150
        Height = 22
        Alignment = taRightJustify
        MaxLength = 18
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object btnCadAtuGS1CNP: TBitBtnLocked
        Left = 284
        Top = 89
        Width = 418
        Height = 23
        Caption = 
          'Cadastrar / Atualizar c'#243'digo de barras na GS1 / CNP - Cadastro N' +
          'acional de Produtos'
        TabOrder = 6
        Visible = False
        WordWrap = True
        OnClick = btnCadAtuGS1CNPClick
      end
      object edtDtaCadGS1: TEditFocus
        Tag = 99
        Left = 385
        Top = 2
        Width = 69
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        MaxLength = 18
        TabOrder = 10
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object edtDtaAtuGS1: TEditFocus
        Tag = 99
        Left = 629
        Top = 2
        Width = 69
        Height = 22
        Alignment = taRightJustify
        Enabled = False
        MaxLength = 18
        TabOrder = 11
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object cmbStatusGTIN: TComboBoxFocus
        Tag = 99
        Left = 107
        Top = 89
        Width = 97
        Height = 22
        Style = csDropDownList
        TabOrder = 7
        Visible = False
        Items.Strings = (
          'ACTIVE'
          'INACTIVE'
          'REACTIVATED'
          'SUSPENDED')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtProCadGS1: TEditFocus
        Tag = 99
        Left = 161
        Top = 2
        Width = 22
        Height = 22
        Alignment = taCenter
        Enabled = False
        MaxLength = 18
        TabOrder = 12
        Text = 'N'
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
      object chkEanTrb: TCheckBox
        Tag = 99
        Left = 107
        Top = 71
        Width = 150
        Height = 17
        Caption = 'C'#243'digo de barras tribut'#225'vel'
        TabOrder = 13
        Visible = False
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 293
      Width = 709
      Height = 25
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 3
      object btnAdiBar: TBitBtnLocked
        Left = 1
        Top = 1
        Width = 74
        Height = 23
        Align = alLeft
        Caption = '&Adicionar'
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
        TabOrder = 0
        OnClick = btnAdiBarClick
      end
      object btnCanBar: TBitBtnLocked
        Left = 75
        Top = 1
        Width = 74
        Height = 23
        Align = alLeft
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
        TabOrder = 1
        OnClick = btnCanBarClick
      end
    end
    object pnlWMS: TPanel
      Left = 0
      Top = 213
      Width = 709
      Height = 80
      Align = alTop
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 2
      object Label1: TLabel
        Left = 45
        Top = 11
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Altura (cm):'
      end
      object Label2: TLabel
        Left = 200
        Top = 11
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Largura (cm) :'
      end
      object Label3: TLabel
        Left = 358
        Top = 11
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Profundidade (cm) :'
      end
      object Label4: TLabel
        Left = 24
        Top = 58
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Peso Bruto (kg):'
      end
      object Label5: TLabel
        Left = 200
        Top = 58
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Peso L'#237'q. (kg):'
      end
      object Label6: TLabel
        Left = 68
        Top = 35
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Lastro:'
      end
      object Label7: TLabel
        Left = 221
        Top = 35
        Width = 48
        Height = 14
        Alignment = taRightJustify
        Caption = 'Camadas:'
      end
      object Label8: TLabel
        Left = 359
        Top = 35
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empilhamento M'#225'x.:'
      end
      object edtAltura: TEditFocus
        Tag = 99
        Left = 108
        Top = 6
        Width = 75
        Height = 22
        Alignment = taRightJustify
        MaxLength = 18
        TabOrder = 0
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtLargur: TEditFocus
        Tag = 99
        Left = 270
        Top = 6
        Width = 75
        Height = 22
        Alignment = taRightJustify
        MaxLength = 18
        TabOrder = 1
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtProfun: TEditFocus
        Tag = 99
        Left = 458
        Top = 6
        Width = 75
        Height = 22
        Alignment = taRightJustify
        MaxLength = 18
        TabOrder = 2
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtPesoBR: TEditFocus
        Tag = 99
        Left = 108
        Top = 53
        Width = 75
        Height = 22
        Alignment = taRightJustify
        MaxLength = 18
        TabOrder = 6
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtPesoLQ: TEditFocus
        Tag = 99
        Left = 270
        Top = 53
        Width = 75
        Height = 22
        Alignment = taRightJustify
        MaxLength = 18
        TabOrder = 7
        Text = '0,00'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtLastro: TEditFocus
        Tag = 99
        Left = 108
        Top = 30
        Width = 75
        Height = 22
        Alignment = taRightJustify
        MaxLength = 18
        TabOrder = 3
        Text = '0'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
      object edtCamada: TEditFocus
        Tag = 99
        Left = 270
        Top = 30
        Width = 75
        Height = 22
        Alignment = taRightJustify
        MaxLength = 18
        TabOrder = 4
        Text = '0'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
      object edtEmpMax: TEditFocus
        Tag = 99
        Left = 458
        Top = 30
        Width = 75
        Height = 22
        Alignment = taRightJustify
        MaxLength = 18
        TabOrder = 5
        Text = '0'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttInteiro
      end
    end
  end
  object cxgEmbala: TcxGridCitel [3]
    Left = 0
    Top = 348
    Width = 709
    Height = 208
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgEmbalaView: TcxGridDBTableViewCitel
      OnKeyDown = cxgEmbalaViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgEmbalaCodBar: TcxGridDBColumn
        AlternateCaption = 'cxgEmbalaCodBar'
        Caption = 'C'#243'digo Barras'
        DataBinding.FieldName = 'BAR_CODBAR'
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 105
      end
      object cxgEmbalaStatus: TcxGridDBColumn
        Caption = 'Status do GTIN'
        DataBinding.FieldName = 'BAR_STGTIN'
        Visible = False
        Options.Editing = False
        Width = 80
      end
      object cxgEmbalaDescri: TcxGridDBColumn
        AlternateCaption = 'cxgEmbalaDescri'
        Caption = 'Descri'#231#227'o Embalagem'
        DataBinding.FieldName = 'BAR_DESCRI'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 116
      end
      object cxgEmbalaEmbala: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'BAR_EMBALA'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 66
      end
      object cxgEmbalaPreVen: TcxGridDBColumn
        Caption = 'Pre'#231'o de Venda'
        DataBinding.FieldName = 'BAR_PREVEN'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 90
      end
      object cxgEmbalaPrinci: TcxGridDBColumn
        Caption = 'Principal'
        DataBinding.FieldName = 'BAR_PRINCI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Properties.OnChange = cxgEmbalaPrinciPropertiesChange
        HeaderAlignmentHorz = taCenter
        Width = 55
      end
      object cxgEmbalaCompra: TcxGridDBColumn
        Caption = 'Principal Compras'
        DataBinding.FieldName = 'BAR_COMPRA'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Properties.OnChange = cxgEmbalaCompraPropertiesChange
        HeaderAlignmentHorz = taCenter
        Width = 102
      end
      object cxgEmbalaMASTER: TcxGridDBColumn
        Caption = 'Embalagem Master'
        DataBinding.FieldName = 'BAR_MASTER'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = cxgEmbalaMASTERPropertiesChange
        HeaderAlignmentHorz = taCenter
        Width = 106
      end
      object cxgEmbalaExbFat: TcxGridDBColumn
        Caption = 'Exibir Faturamento'
        DataBinding.FieldName = 'BAR_EXBFAT'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 106
      end
      object cxgEmbalaCODFOR: TcxGridDBColumn
        Caption = 'Fornecedor'
        DataBinding.FieldName = 'BAR_CODFOR'
        Options.Editing = False
        Width = 63
      end
      object cxgEmbalaFOR_NOMFOR: TcxGridDBColumn
        Caption = 'Nome do Fornecedor'
        DataBinding.FieldName = 'FOR_NOMFOR'
        OnGetDisplayText = cxgEmbalaFOR_NOMFORGetDisplayText
        Options.Editing = False
        Width = 241
      end
      object cxgEmbalaViewBAR_ALTURA: TcxGridDBColumn
        Caption = 'Altura'
        DataBinding.FieldName = 'BAR_ALTURA'
      end
      object cxgEmbalaViewBAR_LARGUR: TcxGridDBColumn
        Caption = 'Largura'
        DataBinding.FieldName = 'BAR_LARGUR'
      end
      object cxgEmbalaViewBAR_PROFUN: TcxGridDBColumn
        Caption = 'Profundidade'
        DataBinding.FieldName = 'BAR_PROFUN'
        Width = 74
      end
      object cxgEmbalaViewBAR_LASTRO: TcxGridDBColumn
        Caption = 'Lastro'
        DataBinding.FieldName = 'BAR_LASTRO'
      end
      object cxgEmbalaViewBAR_CAMADA: TcxGridDBColumn
        Caption = 'Camada'
        DataBinding.FieldName = 'BAR_CAMADA'
      end
      object cxgEmbalaViewBAR_EMPMAX: TcxGridDBColumn
        Caption = 'Empilhamento M'#225'x.'
        DataBinding.FieldName = 'BAR_EMPMAX'
        Width = 99
      end
      object cxgEmbalaViewBAR_PESOBR: TcxGridDBColumn
        Caption = 'Peso Bruto'
        DataBinding.FieldName = 'BAR_PESOBR'
      end
      object cxgEmbalaViewBAR_PESOLQ: TcxGridDBColumn
        Caption = 'Peso L'#237'quido'
        DataBinding.FieldName = 'BAR_PESOLQ'
        Width = 67
      end
      object cxgEmbalaViewBAR_EANTRB: TcxGridDBColumn
        Caption = 'EAN Trib.'
        DataBinding.FieldName = 'BAR_EANTRB'
        Visible = False
        Options.Editing = False
        Width = 60
      end
    end
    object cxgEmbalaLevel1: TcxGridLevel
      GridView = cxgEmbalaView
    end
  end
  object pnlTitulo: TPanel [4]
    Left = 0
    Top = 0
    Width = 709
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 2
    Caption = 'Embalagens do Produto'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 4
    object shpAcesso: TShape
      Left = 2
      Top = 2
      Width = 10
      Height = 26
      Align = alLeft
      Visible = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 328
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 352
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 72
    Top = 336
  end
end
