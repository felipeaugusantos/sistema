inherited frmContatosWhatsappIntegracao: TfrmContatosWhatsappIntegracao
  Width = 1029
  Height = 662
  Caption = 'Integra'#231#227'o Whatsapp - Cria'#231#227'o e Atualiza'#231#227'o de Contatos'
  OnDestroy = FormDestroy
  ExplicitTop = -114
  ExplicitWidth = 1029
  ExplicitHeight = 662
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 591
    Width = 1023
    TabOrder = 3
    ExplicitTop = 591
    ExplicitWidth = 1023
    inherited FlwBotoes: TFlowPanel
      Width = 1019
      ExplicitWidth = 1019
      inherited btnConfirma: TBitBtnLocked
        Width = 233
        Caption = '[ F10 ] Enviar Contatos para Whatsapp'
        ModalResult = 0
        ExplicitWidth = 233
      end
      object btnCadCli: TBitBtnLocked
        Left = 233
        Top = 0
        Width = 148
        Height = 22
        Caption = '[ F8 ] Cadastro de Clientes'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnCadCliClick
      end
      object btnCadOpe: TBitBtnLocked
        Left = 381
        Top = 0
        Width = 168
        Height = 22
        Caption = '[ F9 ] Cadastro de Operadores'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnCadOpeClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 549
        Top = 0
        Width = 124
        Height = 22
        Caption = '[Ctrl + F3] Marca Todos'
        TabOrder = 3
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 673
        Top = 0
        Width = 141
        Height = 22
        Caption = '[Ctrl + F4] Desmarca Todos'
        TabOrder = 4
        OnClick = btnDesmarcaTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 940
      ExplicitLeft = 940
    end
  end
  inherited pnlStatus: TPanel
    Top = 617
    Width = 1023
    TabOrder = 4
    ExplicitTop = 617
    ExplicitWidth = 1023
    inherited pnlNomeForm: TPanel
      Left = 852
      ExplicitLeft = 852
    end
    inherited pnlInfo: TPanel
      Width = 852
      ExplicitWidth = 852
    end
  end
  object gpbFiltros: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 1023
    Height = 211
    Align = alTop
    Caption = 'Filtros'
    TabOrder = 0
    object Label6: TLabel
      Left = 187
      Top = 23
      Width = 10
      Height = 14
      Alignment = taCenter
      AutoSize = False
      Caption = 'a'
    end
    object lblDtaCad: TLabel
      Left = 40
      Top = 22
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Cadastro:'
    end
    object lblCidade: TLabel
      Left = 76
      Top = 69
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object lblVendedor: TLabel
      Left = 62
      Top = 92
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object lblRepresentante: TLabel
      Left = 38
      Top = 114
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Representante:'
    end
    object lblRegiao: TLabel
      Left = 76
      Top = 138
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Regi'#227'o:'
    end
    object lblCliente: TLabel
      Left = 77
      Top = 46
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object lblSubRegiao: TLabel
      Left = 390
      Top = 138
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sub-Regi'#227'o:'
    end
    object lblCodEmp: TLabel
      Left = 67
      Top = 162
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object lblPessoa: TLabel
      Left = 73
      Top = 182
      Width = 39
      Height = 14
      Caption = 'Pessoa:'
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 117
      Top = 19
      Width = 63
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 202
      Top = 19
      Width = 65
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 117
      Top = 65
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 4
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomCid: TEditFocus
      Left = 183
      Top = 65
      Width = 498
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
    object edtUF: TEditFocus
      Left = 680
      Top = 65
      Width = 37
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 117
      Top = 88
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 7
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 183
      Top = 88
      Width = 534
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
    object edtNomRep: TEditFocus
      Left = 183
      Top = 111
      Width = 534
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
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
    object edtCodRep: TEditFocus
      Tag = 99
      Left = 117
      Top = 111
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 9
      OnKeyPress = edtCodRepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtCodReg: TEditFocus
      Tag = 99
      Left = 117
      Top = 134
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 11
      OnKeyPress = edtCodRegKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomReg: TEditFocus
      Left = 183
      Top = 134
      Width = 200
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
      Left = 117
      Top = 42
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 2
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
      Left = 183
      Top = 42
      Width = 534
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtNomSub: TEditFocus
      Left = 517
      Top = 134
      Width = 200
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
    object edtCodSub: TEditFocus
      Tag = 99
      Left = 451
      Top = 134
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 13
      OnKeyPress = edtCodSubKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 117
      Top = 157
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 15
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 183
      Top = 157
      Width = 534
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnFiltrar: TBitBtnLocked
      Left = 600
      Top = 182
      Width = 117
      Height = 22
      Caption = '&Carregar Clientes'
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
      TabOrder = 17
      OnClick = btnFiltrarClick
    end
    object rdbTodos: TRadioButton
      Tag = 99
      Left = 119
      Top = 182
      Width = 64
      Height = 17
      Caption = 'Todos'
      Checked = True
      TabOrder = 18
      TabStop = True
    end
    object rdbFisica: TRadioButton
      Tag = 99
      Left = 189
      Top = 182
      Width = 64
      Height = 17
      Caption = 'F'#237'sica'
      TabOrder = 19
    end
    object rdbJuridica: TRadioButton
      Tag = 99
      Left = 259
      Top = 182
      Width = 64
      Height = 17
      Caption = 'Jur'#237'dica'
      TabOrder = 20
    end
  end
  object gpbOpcoes: TGroupBox [3]
    Left = 0
    Top = 211
    Width = 1023
    Height = 46
    Align = alTop
    Caption = 'Op'#231#245'es de Envio'
    TabOrder = 1
    object chkAgente: TCheckBox
      Left = 23
      Top = 21
      Width = 161
      Height = 17
      Caption = 'Enviar agente preferencial'
      TabOrder = 0
      OnClick = chkAgenteClick
    end
  end
  object cxgContatos: TcxGridCitel [4]
    Left = 0
    Top = 257
    Width = 1023
    Height = 334
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgClientesDBTableView: TcxGridDBTableViewCitel
      OnDblClick = cxgClientesDBTableViewDblClick
      OnKeyDown = cxgClientesDBTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgClientesDBTableViewCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'CTT_CODCLI'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ExpandButtonsForEmptyDetails = False
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgClientesMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object cxgClientesCODCLI: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CTT_CODCLI'
        Width = 70
      end
      object cxgClientesNOMCTT: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CTT_NOMCTT'
        Width = 328
      end
      object cxgClientesCELULA: TcxGridDBColumn
        Caption = 'Whatsapp'
        DataBinding.FieldName = 'CTT_CELULA'
        Width = 90
      end
      object cxgClientesVENDED: TcxGridDBColumn
        Caption = 'Agente Preferencial'
        DataBinding.FieldName = 'CTT_VENDED'
        Visible = False
        Width = 213
      end
      object cxgClientesSITUAC: TcxGridDBColumn
        Caption = 'Situa'#231#227'o'
        DataBinding.FieldName = 'SITUACAO'
        Width = 517
      end
    end
    object cxgContatosClientesDBTableView: TcxGridDBTableViewCitel
      OnDblClick = cxgContatosClientesDBTableViewDblClick
      OnKeyDown = cxgContatosClientesDBTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgContatosClientesDBTableViewCustomDrawCell
      DataController.DetailKeyFieldNames = 'CTT_CODCLI'
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'AUTOINCREM'
      DataController.MasterKeyFieldNames = 'CTT_CODCLI'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgContatosMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
      object cxgContatosAUTINC: TcxGridDBColumn
        DataBinding.FieldName = 'AUTOINCREM'
        Visible = False
      end
      object cxgContatosCODCLI: TcxGridDBColumn
        DataBinding.FieldName = 'CTT_CODCLI'
        Visible = False
      end
      object cxgContatosNOMCTT: TcxGridDBColumn
        Caption = 'Contato'
        DataBinding.FieldName = 'CTT_NOMCTT'
        Width = 600
      end
      object cxgContatosCELULA: TcxGridDBColumn
        Caption = 'Whatsapp'
        DataBinding.FieldName = 'CTT_CELULA'
        Width = 200
      end
      object cxgContatosVENDED: TcxGridDBColumn
        Caption = 'Agente Preferencial'
        DataBinding.FieldName = 'CTT_VENDED'
        Visible = False
      end
      object cxgContatosSITUAC: TcxGridDBColumn
        Caption = 'Situa'#231#227'o'
        DataBinding.FieldName = 'SITUACAO'
      end
    end
    object cxgClientes: TcxGridLevel
      GridView = cxgClientesDBTableView
      object cxgContatosClientes: TcxGridLevel
        GridView = cxgContatosClientesDBTableView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 968
    Top = 88
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 920
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 848
    Top = 48
  end
end
