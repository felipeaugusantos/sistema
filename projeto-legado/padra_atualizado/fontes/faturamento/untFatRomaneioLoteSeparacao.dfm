inherited frmFatRomaneioLoteSeparacao: TfrmFatRomaneioLoteSeparacao
  Width = 1063
  Height = 681
  Caption = 'Lote de Separa'#231#227'o para Romaneios'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1063
  ExplicitHeight = 681
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 590
    Width = 1057
    Height = 23
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 590
    ExplicitWidth = 1057
    ExplicitHeight = 23
    inherited FlwBotoes: TFlowPanel
      Left = 798
      Top = 0
      Width = 166
      Height = 23
      TabOrder = 7
      ExplicitLeft = 798
      ExplicitTop = 0
      ExplicitWidth = 166
      ExplicitHeight = 23
      object btnAlterarDataEntrega: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 129
        Height = 23
        Align = alLeft
        Caption = '[F11] Alterar Dt Entrega'
        TabOrder = 0
        OnClick = btnAlterarDataEntregaClick
      end
    end
    object btnConfirma: TBitBtnLocked [1]
      Left = 0
      Top = 0
      Width = 111
      Height = 23
      Align = alLeft
      Caption = '[F10] Gravar'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnDefRota: TBitBtnLocked [2]
      Left = 691
      Top = 0
      Width = 107
      Height = 23
      Align = alLeft
      Caption = '[F9] Definir Rota'
      TabOrder = 6
      OnClick = btnDefRotaClick
    end
    inherited btnSair: TBitBtnLocked
      Left = 964
      Top = 0
      Width = 93
      Height = 23
      Align = alRight
      TabOrder = 8
      ExplicitLeft = 964
      ExplicitTop = 0
      ExplicitWidth = 93
      ExplicitHeight = 23
    end
    object btnDesmarTodos: TBitBtnLocked
      Left = 573
      Top = 0
      Width = 118
      Height = 23
      Align = alLeft
      Caption = '[F8] Desmarcar Todos'
      TabOrder = 5
      OnClick = btnDesmarTodosClick
    end
    object btnMarTodos: TBitBtnLocked
      Left = 463
      Top = 0
      Width = 110
      Height = 23
      Align = alLeft
      Caption = '[F7] Marcar Todos'
      TabOrder = 4
      OnClick = btnMarTodosClick
    end
    object btnExcluir: TBitBtnLocked
      Left = 218
      Top = 0
      Width = 147
      Height = 23
      Align = alLeft
      Caption = '[F5] Excluir Lote Separa'#231#227'o'
      TabOrder = 2
      OnClick = btnExcluirClick
    end
    object btnImprimir: TBitBtnLocked
      Left = 365
      Top = 0
      Width = 98
      Height = 23
      Align = alLeft
      Caption = '[F6] Reimpress'#227'o'
      TabOrder = 3
      OnClick = btnImprimirClick
    end
    object btnObservacoes: TBitBtnLocked
      Left = 111
      Top = 0
      Width = 107
      Height = 23
      Align = alLeft
      Caption = '[F2] Observa'#231#245'es'
      TabOrder = 1
      OnClick = btnObservacoesClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 636
    Width = 1057
    TabOrder = 4
    ExplicitTop = 636
    ExplicitWidth = 1057
    inherited pnlNomeForm: TPanel
      Left = 886
      ExplicitLeft = 886
    end
    inherited pnlInfo: TPanel
      Width = 886
      ExplicitWidth = 886
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 1057
    Height = 215
    Align = alTop
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 41
      Top = 57
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' do Lote:'
    end
    object pnlFiltros: TPanel
      Left = 8
      Top = 77
      Width = 625
      Height = 138
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Label3: TLabel
        Left = 47
        Top = 27
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cidade:'
      end
      object Label2: TLabel
        Left = 33
        Top = 93
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object lblCodEmp: TLabel
        Left = 38
        Top = 116
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object Label4: TLabel
        Left = 44
        Top = 5
        Width = 39
        Height = 14
        Alignment = taRightJustify
        Caption = 'Per'#237'odo:'
      end
      object Label6: TLabel
        Left = 319
        Top = 5
        Width = 8
        Height = 14
        Alignment = taCenter
        AutoSize = False
        Caption = 'a'
      end
      object lbl1: TLabel
        Left = 47
        Top = 49
        Width = 36
        Height = 14
        Alignment = taRightJustify
        Caption = 'Regi'#227'o:'
      end
      object Label13: TLabel
        Left = 5
        Top = 71
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'Transportadora:'
      end
      object lblCodRot: TLabel
        Left = 522
        Top = 48
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Rota:'
      end
      object edtCodCid: TEditFocus
        Tag = 99
        Left = 89
        Top = 23
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 4
        OnExit = edtCodCidExit
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
        Left = 155
        Top = 23
        Width = 460
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
      object edtNomVen: TEditFocus
        Left = 155
        Top = 89
        Width = 460
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
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 89
        Top = 89
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 7
        OnExit = edtCodVenExit
        OnKeyPress = edtCodVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 249
        Top = 1
        Width = 64
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
        TabOrder = 2
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object mskDtaFin: TMaskEditFocus
        Tag = 99
        Left = 334
        Top = 1
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
        TabOrder = 3
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtCodReg: TEditFocus
        Tag = 99
        Left = 89
        Top = 45
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 5
        OnExit = edtCodRegExit
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
        Left = 155
        Top = 45
        Width = 360
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object rdbEntrada: TRadioButton
        Left = 89
        Top = 4
        Width = 76
        Height = 17
        Caption = 'de Entrada'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rdbEntrega: TRadioButton
        Left = 168
        Top = 4
        Width = 76
        Height = 17
        Caption = 'de Entrega'
        TabOrder = 1
      end
      object edtCodTra: TEditFocus
        Tag = 99
        Left = 89
        Top = 67
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 6
        OnExit = edtCodTraExit
        OnKeyPress = edtCodTraKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesTra: TEditFocus
        Left = 155
        Top = 67
        Width = 460
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
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 89
        Top = 111
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 8
        OnExit = edtCodEmpExit
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
        Left = 155
        Top = 111
        Width = 460
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
      object edtCodRot: TEditFocus
        Tag = 99
        Left = 549
        Top = 45
        Width = 66
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 14
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
    object edtNumLot: TEditFocus
      Tag = 99
      Left = 99
      Top = 53
      Width = 110
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnExit = edtNumLotExit
      OnKeyPress = edtNumLotKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object btnFiltrar: TBitBtnLocked
      Left = 627
      Top = 162
      Width = 85
      Height = 22
      Caption = '&Consultar'
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
      TabOrder = 4
      OnClick = btnFiltrarClick
    end
    object btnCancelar: TBitBtnLocked
      Left = 627
      Top = 185
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
      TabOrder = 5
      OnClick = btnCancelarClick
    end
    object chbDocumentos: TCheckBox
      Left = 224
      Top = 55
      Width = 257
      Height = 17
      Caption = 'Incluir documentos sem Lote de Separa'#231#227'o'
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 1
      OnClick = chbDocumentosClick
    end
    object rdgDoc: TRadioGroup
      Left = 20
      Top = 4
      Width = 351
      Height = 40
      Caption = 'Documentos'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Vendas'
        'Transfer'#234'ncias'
        'Todos')
      TabOrder = 6
    end
    object rdgEmpresa: TRadioGroup
      Left = 627
      Top = 101
      Width = 185
      Height = 57
      Caption = 'Empresa'
      ItemIndex = 1
      Items.Strings = (
        'Da emiss'#227'o pedido'
        'De faturamento')
      TabOrder = 3
    end
    object chbDocumentosFatParcial: TCheckBox
      Left = 461
      Top = 54
      Width = 188
      Height = 17
      Caption = 'Listar pedido faturado parcialmente'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object ckbPedLotSep: TCheckBox
      Left = 657
      Top = 54
      Width = 203
      Height = 17
      Caption = 'Listar pedidos com lote de separa'#231#227'o'
      TabOrder = 8
    end
  end
  object cxgDocumentos: TcxGridCitel [3]
    Left = 0
    Top = 215
    Width = 1057
    Height = 194
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDocumentosTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxgDocumentosTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgDocumentosTableViewCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
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
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgSEQUEN: TcxGridDBColumn
        DataBinding.FieldName = 'SEQUEN'
        Visible = False
      end
      object cxgMARDES: TcxGridDBColumn
        Caption = 'Selecionado'
        DataBinding.FieldName = 'MARDES'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = imglIconesGrid
        Properties.Items = <
          item
            Value = 'D'
          end
          item
            Description = 'Parcial'
            ImageIndex = 0
            Value = 'P'
          end
          item
            Description = 'Total'
            ImageIndex = 1
            Value = 'M'
          end>
        Width = 86
      end
      object cxgSEPIMP: TcxGridDBColumn
        Caption = 'Sep.'
        DataBinding.FieldName = 'SEPIMP'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = imglIconesGrid
        Properties.Items = <
          item
            Value = 'N'
          end
          item
            ImageIndex = 2
            Value = 'S'
          end>
        Width = 31
      end
      object cxgDTAENT: TcxGridDBColumn
        Caption = 'Dt. Entrada'
        DataBinding.FieldName = 'DTAENT'
      end
      object cxgHORENT: TcxGridDBColumn
        Caption = 'Hora'
        DataBinding.FieldName = 'HORENT'
      end
      object cxgDTENTR: TcxGridDBColumn
        Caption = 'Dt. Entrega'
        DataBinding.FieldName = 'DTENTR'
      end
      object cxgNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
      end
      object cxgESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'ESPDOC'
      end
      object cxgSERIE_: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'SERIE_'
      end
      object cxgCODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'CODEMP'
      end
      object cxgNUMFAT: TcxGridDBColumn
        Caption = 'Doc.Faturamento'
        DataBinding.FieldName = 'NUMFAT'
        Width = 90
      end
      object cxgTOTFAT: TcxGridDBColumn
        Caption = 'Vlr. Faturado'
        DataBinding.FieldName = 'TOTFAT'
        Width = 72
      end
      object cxgCODCLI: TcxGridDBColumn
        Caption = 'Cod.Cliente'
        DataBinding.FieldName = 'CODCLI'
        Visible = False
      end
      object cxgNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
      end
      object cxgDESREG: TcxGridDBColumn
        Caption = 'Regi'#227'o'
        DataBinding.FieldName = 'DESREG'
      end
      object cxgNOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'NOMCID'
      end
      object cxgCEPENT: TcxGridDBColumn
        Caption = 'CEP Entrega'
        DataBinding.FieldName = 'CEPENT'
        OnGetDataText = cxgCEPENTGetDataText
      end
      object cxgBAIENT: TcxGridDBColumn
        Caption = 'Bairro'
        DataBinding.FieldName = 'BAIENT'
      end
      object cxgENDENT: TcxGridDBColumn
        Caption = 'Endere'#231'o'
        DataBinding.FieldName = 'ENDENT'
      end
      object cxgPESBRU: TcxGridDBColumn
        Caption = 'Peso Total'
        DataBinding.FieldName = 'PESBRU'
      end
      object cxgDESFPG: TcxGridDBColumn
        Caption = 'Forma de Pagamento'
        DataBinding.FieldName = 'DESFPG'
        Width = 97
      end
      object cxgNOMTRA: TcxGridDBColumn
        Caption = 'Transportadora'
        DataBinding.FieldName = 'NOMTRA'
      end
      object cxgVLRCON: TcxGridDBColumn
        Caption = 'Vr. do Documento'
        DataBinding.FieldName = 'VLRCON'
      end
      object cxgCODVEN: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'CODVEN'
      end
      object cxgNOMOPE: TcxGridDBColumn
        Caption = 'Nome Vendedor'
        DataBinding.FieldName = 'NOMOPE'
        Width = 203
      end
      object cxgESTCLI: TcxGridDBColumn
        Caption = 'UF Cliente'
        DataBinding.FieldName = 'UFCLIE'
        Width = 62
      end
      object cxgESTADO: TcxGridDBColumn
        Caption = 'UF Vendedor'
        DataBinding.FieldName = 'UFVEND'
        Width = 82
      end
      object cxgAUTINC: TcxGridDBColumn
        DataBinding.FieldName = 'AUTINC'
        Visible = False
        VisibleForCustomization = False
        VisibleForEditForm = bTrue
      end
      object cxgSALDOC: TcxGridDBColumn
        Caption = 'Status de Saldo'
        DataBinding.FieldName = 'SALDOC'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Images = imglIconesGrid
        Properties.Items = <
          item
            Description = 
              'Todos os itens do documento tem saldo maior que a quantidade a s' +
              'eparar'
            Value = 0
          end
          item
            Description = 
              'Documento cont'#233'm itens com saldo menor que a quantidade a separa' +
              'r'
            ImageIndex = 3
            Value = 1
          end>
        Properties.ShowDescriptions = False
        Visible = False
        Options.Editing = False
        Width = 82
      end
      object cxgVOLUME: TcxGridDBColumn
        Caption = 'Volume Documento'
        DataBinding.FieldName = 'VOLUME'
        Width = 100
      end
      object cxgCATEGO: TcxGridDBColumn
        Caption = 'Categoria'
        DataBinding.FieldName = 'CATEGO'
      end
      object cxgREDLOJ: TcxGridDBColumn
        Caption = 'Rede de Lojas'
        DataBinding.FieldName = 'REDLOJ'
      end
      object cxgVLRITE: TcxGridDBColumn
        Caption = 'Vr. Produtos'
        DataBinding.FieldName = 'VLRITE'
        Visible = False
        Width = 81
      end
    end
    object cxgDocumentosLevel: TcxGridLevel
      GridView = cxgDocumentosTableView
    end
  end
  object pnlRodape: TPanel [4]
    Left = 0
    Top = 424
    Width = 1057
    Height = 53
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object pnlBotoesItens: TPanel
      Left = 1
      Top = 30
      Width = 1055
      Height = 22
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        1055
        22)
      object lblValorTotalProdutosSel: TLabel
        Left = 877
        Top = -2
        Width = 74
        Height = 24
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Vr. Produtos Total Sel.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 12
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object lblValorTotalProdutos: TLabel
        Left = 683
        Top = 4
        Width = 88
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Vr. Produtos Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblValorTotalFaturado: TLabel
        Left = 477
        Top = 4
        Width = 99
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Valor Total Faturado:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object btnLocProx: TBitBtnLocked
        Left = 113
        Top = 0
        Width = 123
        Height = 22
        Align = alLeft
        Caption = '[ F4 ] Localiza Pr'#243'xima'
        TabOrder = 0
        OnClick = btnLocProxClick
      end
      object btnIniBus: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 113
        Height = 22
        Align = alLeft
        Caption = '[ F3 ] Inicia Busca'
        TabOrder = 1
        OnClick = btnIniBusClick
      end
      object edtValorTotalProdutosSel: TEditFocus
        Left = 953
        Top = 0
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValorTotalProdutos: TEditFocus
        Left = 772
        Top = 0
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValorTotalFaturado: TEditFocus
        Left = 578
        Top = 0
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlLegendaItens: TPanel
      Left = 1
      Top = 1
      Width = 1055
      Height = 29
      Align = alClient
      Alignment = taRightJustify
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        1055
        29)
      object lblVolTot: TLabel
        Left = 9
        Top = 7
        Width = 41
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Vol. Tot.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblVolSel: TLabel
        Left = 107
        Top = 7
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Vol. Sel.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblQtdDoc: TLabel
        Left = 206
        Top = 7
        Width = 51
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Qtde Doc.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblQtdSel: TLabel
        Left = 314
        Top = 7
        Width = 47
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Qtde Sel.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 558
        Top = 7
        Width = 73
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Peso Total Sel.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 878
        Top = 7
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Valor Total Sel.:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblPesoTot: TLabel
        Left = 418
        Top = 7
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Peso Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object lblValorTotal: TLabel
        Left = 718
        Top = 7
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Valor Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object edtVolTot: TEditFocus
        Left = 51
        Top = 4
        Width = 50
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        Text = '0,000'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtVolSel: TEditFocus
        Left = 150
        Top = 4
        Width = 50
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        Text = '0,000'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdDoc: TEditFocus
        Left = 258
        Top = 4
        Width = 50
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        Text = '0'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdSel: TEditFocus
        Left = 362
        Top = 4
        Width = 50
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        Text = '0'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotPes: TEditFocus
        Left = 631
        Top = 4
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 4
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTotVal: TEditFocus
        Left = 953
        Top = 4
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 5
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPesoTot: TEditFocus
        Left = 472
        Top = 4
        Width = 80
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValorTotal: TEditFocus
        Left = 772
        Top = 4
        Width = 100
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 7
        Text = '0,00'
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object Panel2: TPanel [5]
    Left = 0
    Top = 574
    Width = 1057
    Height = 16
    Align = alBottom
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    ShowCaption = False
    TabOrder = 5
    object lblMarca: TLabel
      Left = 3
      Top = 1
      Width = 207
      Height = 14
      Caption = '[ENTER] Marca / Desmarca Documento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object lblMarcaParc: TLabel
      Left = 216
      Top = 1
      Width = 228
      Height = 14
      Caption = '[ESPA'#199'O] Marca Documento Parcialmente'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
  end
  object pnlCamposRodape: TPanel [6]
    Left = 0
    Top = 477
    Width = 1057
    Height = 97
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 7
    object pnlMsgPed: TPanel
      Tag = 999
      Left = 0
      Top = 48
      Width = 1057
      Height = 24
      Hint = 'Mensagens do Pedido'
      Align = alTop
      TabOrder = 0
      Visible = False
      object Label9: TLabel
        Left = 10
        Top = 4
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'Mensagens Pedido:'
        WordWrap = True
      end
      object edtMsgPed: TEditFocus
        Left = 112
        Top = 1
        Width = 933
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 100
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlMsgExp: TPanel
      Tag = 999
      Left = 0
      Top = 72
      Width = 1057
      Height = 24
      Hint = 'Mensagens da Expedi'#231#227'o'
      Align = alTop
      TabOrder = 1
      Visible = False
      object Label10: TLabel
        Left = 9
        Top = 4
        Width = 95
        Height = 14
        Alignment = taRightJustify
        Caption = 'Mensagens Exped.:'
        WordWrap = True
      end
      object edtMsgExp: TEditFocus
        Left = 112
        Top = 1
        Width = 933
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 100
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
    end
    object pnlObserv: TPanel
      Left = 0
      Top = 0
      Width = 1057
      Height = 48
      Hint = 'Observa'#231#245'es do Documento'
      Align = alTop
      TabOrder = 2
      object Label5: TLabel
        Left = 20
        Top = 10
        Width = 84
        Height = 28
        Alignment = taRightJustify
        Caption = 'Observa'#231#245'es do Documento:'
        WordWrap = True
      end
      object edtObs2: TEditFocus
        Left = 112
        Top = 24
        Width = 933
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 100
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
      object edtObs1: TEditFocus
        Left = 112
        Top = 2
        Width = 933
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 100
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 6
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object pnlBotoes2: TPanel [7]
    Left = 0
    Top = 613
    Width = 1057
    Height = 23
    Align = alBottom
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 6
    object btnCfgRomLoteSep: TBitBtnLocked
      Left = 0
      Top = 0
      Width = 111
      Height = 23
      Align = alLeft
      Caption = 'Configurar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000010000000900000012000000120000
        0009000000020000000000000000000000000000000000000000000000000000
        0000000000030000000A0000000A0000000B2519156F68473BFF67443BFF1D13
        0F700000000C0000000B0000000C000000050000000100000000000000000000
        00030403021A543B33C738251EB30D0907454C362DC4B5A198FFAB958AFF3E29
        23C50D080748311F1AB13A241ECE030202220000000400000000000000000000
        00085A4138C9C7B9B0FFA8958BFF6C4F47FF715044FECABAB0FFC6B5AAFF6142
        37FE6B5047FE9C857AFFA89388FF3B241FCB0000000B00000000000000000000
        00074C3930ABC0AEA7FFE3DBD5FFD2C3BAFFC1AFA6FFCFC0B7FFCEBEB5FFBCAA
        9FFFCAB9AEFFC9B8ADFF9F897FFF36221DB20000000A00000000000000010000
        0007110C0B368D6F65FCEAE3DFFFDACDC6FFD8CCC3FFE3D9D3FFE7E0DAFFE1D6
        D0FFD2C3B9FFCDBCB3FF705449FE0D0907410000000A00000002000000042A1E
        1A6B4C372EBB846356FED9CEC8FFE3DAD5FFCDBEB7FF8E6F62FF947567FFD0C0
        B9FFE3DAD3FFC8B7ADFF6A4940FF47312AC22418147100000007000000088D6D
        60FFD8CCC7FFEEE8E5FFEBE6E0FFEAE3DDFF7F6257FF2219155E241B175E9374
        67FFEBE4DFFFD6C8C0FFD3C6BDFFB9A59BFF78574BFF0000000D000000079373
        64FFD9CECAFFF6F3F2FFFAF7F6FFEFEAE5FF76574DFF1D1411551E1613568869
        5DFFEFE9E6FFDDD2CBFFD8CAC3FFC7B8B1FF7E5B4FFF0000000C000000033428
        245F665046B5937467FEECE6E3FFF0ECE8FFCEC2BDFF856961FF886D65FFD2C7
        C2FFECE4DFFFD9CFC9FF856458FD5A443AB92B201C6102010108000000000000
        000316110F2EA78B7EFDF6F4F1FFF3EFECFFF2EEEAFFF3EFECFFF0EBE7FFEFEA
        E6FFEFEBE7FFECE5E0FF83665BFD110C0B390000000600000001000000000000
        0003685349AADCD1CBFFF8F6F3FFF8F5F3FFEBE4E1FFFDFCFBFFF3EEECFFE2D8
        D3FFFAF9F8FFF9F7F5FFC8B9B3FF4E3931B00000000500000000000000000000
        0002776055BDE5DDD8FFDCD0CBFFAC9183FD9E7E6EFDFBF8F8FFF5F1EEFF9979
        6AFDA3897EFCD7CBC5FFE0D6D1FF6E564CC20000000500000000000000000000
        00010605040D7C6458BF69544BA51713102B6F594EB2E1D7D2FFE0D6D1FF6D57
        4DB314100E2B614D44A4775E53C7050404110000000100000000000000000000
        0000000000000000000100000002000000023B302A5EA68676FFA58375FF3A2F
        295F000000030000000300000003000000010000000000000000000000000000
        0000000000000000000000000000000000000000000100000002000000030000
        0001000000000000000000000000000000000000000000000000}
      TabOrder = 0
      OnClick = btnCfgRomLoteSepClick
    end
    object btnVisualizarItensDocumentos: TBitBtnLocked
      Left = 111
      Top = 0
      Width = 184
      Height = 22
      Caption = '[F12] Visualizar itens do documento'
      TabOrder = 1
      OnClick = btnVisualizarItensDocumentosClick
    end
    object btnProdutos: TBitBtnLocked
      Left = 295
      Top = 0
      Width = 151
      Height = 22
      Caption = 'Produtos Selecionados'
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000C40E0000C40E00000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000001E1E1E1E1E1E0000000000000000000000
        000000000000000000000000000000000000000000000000000000000000001E
        1E1E1E1E1E000000000000000000000000000000000000000000000000000000
        0000000000000000000000001E1E1E3C3C3C3C3C3C1E1E1E0000000000000000
        000000000000000000000000000000000000000000000000000000001E1E1E3C
        3C3C3C3C3C1E1E1E000000000000000000000000000000000000000000000000
        0000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000000000
        000000000000000000000000000000000000000000000000001E1E1E3C3C3C3C
        3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000000000000000
        0000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E0000
        000000000000000000000000000000000000000000001E1E1E3C3C3C3C3C3C3C
        3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000000000
        0000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E
        1E0000000000000000000000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C
        3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000000000
        1E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
        3C1E1E1E0000000000000000000000001E1E1E3C3C3C3C3C3C3C3C3C3C3C3C3C
        3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1E1E1E000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      NumGlyphs = 2
      PopupMenu = popProdutos
      TabOrder = 2
      OnClick = btnProdutosClick
    end
    object btnVisualizarVolume: TBitBtnLocked
      Left = 446
      Top = 0
      Width = 227
      Height = 22
      Caption = 'Visualizar Volume X Unidades Selecionados'
      TabOrder = 3
      OnClick = btnVisualizarVolumeClick
    end
  end
  object Panel1: TPanel [8]
    Left = 0
    Top = 409
    Width = 1057
    Height = 15
    Align = alBottom
    TabOrder = 8
    object Shape3: TShape
      Left = 5
      Top = 1
      Width = 12
      Height = 12
      Brush.Color = clPurple
    end
    object lblSepImpExpNaoImp: TLabel
      Left = 20
      Top = 0
      Width = 126
      Height = 14
      Caption = 'Documento Faturado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpSalDoc: TShape
      Left = 159
      Top = 1
      Width = 12
      Height = 12
      Brush.Color = 3644415
      Pen.Color = 3644415
      Shape = stCircle
    end
    object lblSalDoc: TLabel
      Left = 174
      Top = 0
      Width = 686
      Height = 14
      Caption = 
        'Documento possui itens que n'#227'o tem saldo dispon'#237'vel suficiente p' +
        'ara atender a quantidade a separar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object imglIconesGrid: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 18088368
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          000000000000000000000000000000000010421C11FF31140CE2190A069A0304
          07450000000E0000000200000000000000000000000000000000000000000000
          0002000000080000000C0000000D0000001B663C2BDEB9C7D2FF7889A2FF2441
          82FF051033980000001100000002000000000000000000000000000000000000
          0007295B8FBF357DC6FF337AC5FF528CC7FF696573FF879AB2FFC8E3F5FF1F66
          B6FF2B6BA8FF0512369700000010000000020000000000000000000000000000
          000A3C83CAFF8ACCF1FF66B9EBFF7AC0EAFF7AAAC9FF488BC3FFDEFEFDFF51B4
          E3FF1F68B7FF3173AEFF061538960000000F0000000200000000000000000000
          000A3F85CCFF93D1F2FF4690D2FF4F93D2FF6BA2D2FF5291C2FF479FD2FFDEFE
          FDFF59BFE9FF216BB9FF367BB3FF07173A940000000D00000002000000000000
          000A4389CEFF9CD5F3FF4A92D4FFFAF7F3FFF6F1EBFFEEE9E7FF8BB1CCFF4BA5
          D5FFDEFEFDFF61CAEFFF246FBCFF3B83B9FF08193D920000000C000000000000
          0009468CD0FFA3D9F4FF4F97D5FFFBF8F6FFF6F0EBFFF6F1ECFFEFEBE8FF8DB3
          CEFF4EAAD7FFDEFEFDFF68D4F4FF2875BEFF3F8BBEFF091B3F8F000000000000
          00094A8FD2FFABDDF5FF5399D6FFFCFAF8FFF6F1ECFFF6F0ECFFF7F1EEFFF0ED
          E8FF5695C7FF51AEDAFFDEFEFDFF6EDDF8FF2C7BC2FF18448BFF000000000000
          00084D92D3FFB2E0F7FF569CD8FFFDFBFAFFF7F2EDFFF7F1ECFFF7F1EDFFF7F2
          EFFF72A6D6FF62A3D0FF54B1DCFFDEFEFDFF4FA6D4FF102C4E89000000000000
          00075094D6FFBAE4F7FF5B9FDAFFFDFCFBFFF8F2EEFFF8F2EEFFF7F2EDFFF0E8
          E3FF639DD4FF8DC3E6FF4D8EC4FF357FBCFF173A598700000006000000000000
          00075398D7FFBFE7F9FF5EA3DCFFFEFDFDFFF8F3F0FFF8F3F0FFEDE5E0FFE2D6
          D0FF458BCCFF7FBBE6FF5890CBFF0000000D0000000300000001000000000000
          0006559AD9FFC5E9F9FF62A6DEFFFEFEFEFFF9F4F1FFEAE1DCFFDCCDC7FFDCCD
          C7FF478BCCFF67ADDEFF377BC2FF000000090000000000000000000000000000
          0006589DDAFFCAEBFAFF66A9E0FFFFFFFEFFD0BEB7FFBBA298FFBBA199FFBBA1
          98FF4081C3FF66A9DBFF377BC2FF000000080000000000000000000000000000
          00055BA0DDFFCDEDFBFF69ACE1FFAC8E83FF946C5DFF926A5CFF91685AFF9A76
          69FF3D7DC0FF65A6D8FF397CC1FF000000070000000000000000000000000000
          00034678A5C05C9FDCFF599EDCFFB38D7EFFF1E9E2FFE2D2C6FFE1D0C3FF9971
          63FF4386CAFF498DD1FF33689AC1000000040000000000000000000000000000
          0001000000030000000400000005866A5FBEB58F80FFB58F80FFB48E7FFF8569
          5EBF000000060000000600000004000000010000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000002000000070000000C0000001000000012000000110000
          000E000000080000000200000000000000000000000000000000000000000000
          000100000004000101120D2A1D79184E36C6216B4BFF216B4BFF216C4BFF1A53
          3AD20F2F21840001011500000005000000010000000000000000000000000000
          0005050F0A351C5B40DC24805CFF29AC7EFF2CC592FF2DC894FF2DC693FF2AAE
          80FF258560FF1A563DD405110C3D00000007000000010000000000000003040E
          0A31206548ED299D74FF2FC896FF2EC996FF56D4ACFF68DAB5FF3BCD9DFF30C9
          96FF32CA99FF2BA479FF227050F805110C3D00000005000000000000000A1A57
          3DD02EA57CFF33CA99FF2EC896FF4CD2A8FF20835CFF00673BFF45BE96FF31CB
          99FF31CB98FF34CC9CFF31AD83FF1B5C41D300010113000000020B23185E2E8A
          66FF3BCD9EFF30CA97FF4BD3A9FF349571FF87AF9DFFB1CFC1FF238A60FF45D3
          A8FF36CF9FFF33CD9BFF3ED0A3FF319470FF0F32237F00000007184D37B63DB3
          8CFF39CD9FFF4BD5A9FF43A382FF699782FFF8F1EEFFF9F3EEFF357F5DFF56C4
          A1FF43D5A8FF3ED3A4FF3CD1A4FF41BC95FF1B5C43CD0000000B1C6446DF4BCA
          A4FF44D2A8FF4FB392FF4E826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1B75
          4FFF60DCB8FF48D8ACFF47D6AAFF51D4ACFF247A58F80000000E217050F266D9
          B8FF46D3A8FF0B6741FFD2D2CBFF6A8F77FF116B43FF73967EFFF1E8E3FF72A2
          8BFF46A685FF5EDFBAFF4CD9AFFF6BE2C2FF278460FF020604191E684ADC78D9
          BEFF52DAB1FF3DBA92FF096941FF2F9C76FF57DEB8FF2D9973FF73967EFFF0EA
          E7FF4F886CFF5ABB9AFF5BDEB9FF7FE2C7FF27835FF80000000C19523BAB77C8
          B0FF62E0BCFF56DDB7FF59DFBAFF5CE1BDFF5EE2BEFF5FE4C1FF288C67FF698E
          76FFE6E1DCFF176B47FF5FD8B4FF83D5BDFF1E674CC60000000909201747439C
          7BFF95ECD6FF5ADFBAFF5EE2BDFF61E4BFFF64E6C1FF67E6C5FF67E8C7FF39A1
          7EFF1F6D4AFF288B64FF98EFD9FF4DAC8CFF1036286D00000004000000041C5F
          46B578C6ADFF9AEED9FF65E5C0FF64E7C3FF69E7C6FF6BE8C8FF6CE9C9FF6BEA
          C9FF5ED6B6FF97EDD7FF86D3BBFF237759D20102010C0000000100000001030A
          0718247B5BDA70C1A8FFB5F2E3FF98F0DAFF85EDD4FF75EBCEFF88EFD6FF9CF2
          DDFFBAF4E7FF78CDB3FF2A906DEA0615102E0000000200000000000000000000
          0001030A07171E694FB844AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8
          C1FF4BB692FF237F60CB05130E27000000030000000000000000000000000000
          000000000001000000030A241B411B60489D258464CF2C9D77EE258867CF1F71
          56B00E3226560000000600000002000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000090000
          000E000000168A6559C3BF8D7BFFBF8D7BFFC08D7BFFBF8D7BFFC08D7BFF8A65
          58C500000019000000100000000A0000000200000000000000007B5143C0A76E
          5BFFA06855FFC2917FFFF7F0ECFFF7EFECFFF7F0EBFFF6EFEBFFF6EFEAFFC291
          7FFF875746FF8B5948FF623F33C20000000A0000000000000000BB7E6BFFECD9
          CCFFE3CEBEFFC59483FFF9F2F0FFE4B984FFE3B781FFE3B47CFFF8F1EDFFC495
          83FFE2CCBCFFE6D1C1FFB67764FF0000000E0000000000000000BE8571FFF1E5
          DAFFEBDACFFF794734FF794734FF784734FF784734FF784734FF784734FF7847
          34FFECDACEFFEBDBCFFFBA7C69FF0000000D0000000000000000C28B78FFF5EE
          E7FFF2E7DDFFF2E7DEFFF3E7DEFFF2E5DEFFF3E5DEFFF2E7DDFFF2E7DDFFF2E7
          DEFFF2E7DDFFF2E5DEFFBD836FFF0000000C0000000000000000C7937FFFFAF4
          F1FFCDBEB9FF72564AFF624338FF614036FF604035FF5F3F34FF5F3E33FF6E4F
          47FFCCBDB6FFF7F0ECFFC18A76FF0000000A0000000000000000CC9986FFFDFA
          FAFF806256FF745043FF744F43FF744E43FF734E42FF724D42FF724C41FF724C
          40FF7A5C50FFFCF8F6FFC5917CFF000000090000000000000000BB9080E9F5EB
          E6FF7D5C4DFF946E5EFFFAF6F3FFF0E6E0FFF0E5DFFFEFE5DEFFEFE5DEFF9C7B
          6EFFA59086FFF9F3F1FFD7BFB5F300000006000000000000000034292444A681
          72CC886857FF9B7565FFFBF8F6FFF2E8E3FFF1E8E1FFF1E7E2FFF4EDE8FFB5AF
          A3FF3F845CFF147742FD0E6E3EF600411FAC000A051B00000000000000010000
          00030000000CC59685FFFCFAF9FFF3EBE6FFF4EAE5FFF4EDE8FFD0DFD3FF1087
          4DFF008D4EFF008F51FF008B4FFF007C41FF00602EED0010082A000000000000
          000000000008C89B89FFFDFCFBFFF5EDE8FFF4EDE8FFF9F4F0FF4FAD81FF0097
          55FF009655FF1A9F68FF009457FF009353FF008046FF004823AE000000000000
          000000000006CA9E8DFFFEFDFDFFFEFDFCFFFEFCFCFFFEFDFDFF0F9C61FF009A
          58FF1AA36BFFFFFFFFFF1AA26BFF009756FF009051FF006E36F3000000000000
          00000000000498786BC1CDA291FFCCA18FFFCCA090FFE4CDC4FF0DA263FF009E
          5DFFFFFFFFFF46AB7BFFFFFFFFFF1AA76CFF009959FF00763AF3000000000000
          0000000000010000000300000005000000050000000600000006006E42AD00A1
          60FF008F4EFF009C5AFF1A995DFFFFFFFFFF009B59FF00572CAE000000000000
          000000000000000000000000000000000000000000000000000000190F27009C
          5FED00A865FF00A664FF00A35FFF00914FFF00884BED00150B2A000000000000
          0000000000000000000000000000000000000000000000000000000000000012
          0A1B007044A800985BE4009459E400673AA8000F081B00000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00D903DE26722AC08D305CD8CF0E7DF1F10C7FF3F32C5F
          DAD36E2DC091D304DA2CFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FB00FB047429C08B0488FBFB008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF028AFDFD6830C197F700F708FF00FF00FF00FF00FF00FF00FB00
          FB045041C8AF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF424CCEBDF700F708FF00FF00FF00FF007628
          BF89008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF6632C299FF00FF00DD02E1220488
          FBFB008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF028AFDFDCF04D8307827BF87008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF6830C1973656D4C9008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF2664DED91675EAE9008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF0A82F5F51675EAE9008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF0A82F5F53854D3C7008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF2664DED97827BF87008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF6830C197DB02E0240488
          FBFB008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF028AFDFDD104D92EFF00FF007827
          BF87008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF008CFFFF6632C299FF00FF00FF00FF00FB00
          FB045041C8AF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF008CFFFF008CFFFF444BCDBBF700F708FF00FF00FF00FF00FF00
          FF00FB00FB047628BF890488FBFB008CFFFF008CFFFF008CFFFF008CFFFF008C
          FFFF008CFFFF028AFDFD6A2FC195F700F708FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00D903DE267429C08B305CD8CF0E7DF1F10E7DF1F12C5F
          DAD36E2DC091D503DB2AFF00FF00FF00FF00FF00FF00FF00FF00}
      end>
  end
  object imgIndica: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 17563948
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000050000
          0008000000090000000900000009000000090000000900000009000000090000
          0009000000090000000900000009000000090000000800000005000000140000
          00260000002B0000002B0000002B0000002B0000002B0000002B0000002B0000
          002B0000002B0000002B0000002B0000002B00000026000000141A3B6CB0295C
          A8FF295CA8FF295CA8FF295CA8FF295CA8FF295CA8FF2E60AAFF2E60AAFF295C
          A8FF295CA8FF295CA8FF295CA8FF295CA8FF295CA8FF1A3B6AAE27589DEB84B6
          DDFF9ACDF0FF94CBEFFFA7D4F2FFB9DDF5FFCEE7F8FFD9E7F1FFD1E4F0FFB6DC
          F4FF94CBEFFF84C3EDFF78BEEBFF81C1ECFF7EB2DBFF27589DEB1B3D699E5586
          BEFFA7D3F0FF6DB9EAFF61B3E8FF61B3E8FFA3D3F2FF453F3EFF453F3EFFA3D3
          F2FF61B3E8FF61B3E8FF69B7E9FF87C2EAFF437BB8FF1B3C679C0205080E285B
          97DB7EA8D1FF9BD0F1FF72BCEBFF79C0ECFFA0D2F2FF7E858DFF7E858DFFA0D2
          F2FF7AC0ECFF73BDEBFF85C5EEFF6196C8FF285A96D90204070D000000000A16
          2437306DB1F9C0DAEDFFA4D6F2FF91CCF0FF95CDF1FF93C7E8FF93C7E8FF95CD
          F1FF91CCF0FF9BD1F1FF95C2E3FF306DB1F90A16243600000000000000000000
          00011837577C558DC2FFDCEFFAFF9FD4F1FFAFDBF4FF83939EFF83939FFFAFDB
          F4FF9DD3F1FFB3DDF5FF538CC2FF183654790000000100000000000000000000
          000001010205285D8DC273A6D1FFCFEBF9FFC0E3F7FF727071FF727071FFC0E3
          F7FFAFDDF5FF6EA3CFFF285B8BBF000001030000000000000000000000000000
          000000000000060F16213579B3EFA3CCE7FFDAEFFAFF665D5BFF665D5BFFCFEB
          F9FF99C6E4FF3578B2ED060E141F000000000000000000000000000000000000
          00000000000000000001142F435C5B9ACBFFDEF3FBFF766F6DFF766F6EFFD9F0
          FBFF5899CBFF132B3E5500000001000000000000000000000000000000000000
          000000000000000000000000000226587CA385B8DBFFDEF3FCFFDAF2FBFF84B7
          DBFF2555779D0000000200000000000000000000000000000000000000000000
          000000000000000000000000000003070A10377FAFDFA2CEE8FF9FCCE7FF367B
          AAD90306090E0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010E212C3B4095CAFB4094C9FA0D1E
          2937000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000119394C5F1836495B0000
          0001000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000705120D39113D2A9E19593EDD1F6A49FF1E6A48FF1B5D
          3EE313422EAB0717104900000009000000020000000000000000000000000000
          000201020210113C299D20724EFF229A6DFF22B481FF24C78FFF24C890FF23B5
          81FF229C6FFF20724FFF154831B5010503190000000300000000000000010102
          020E174E36C0218A61FF25C58EFF26C992FF25CA93FF28CB93FF3AD3A3FF45D7
          ABFF27CA93FF25C18BFF218860FF19593CD5020503180000000200000005113C
          2995238A63FF27C993FF26CA94FF27CB95FF30CE9AFF42D0A4FF1F9063FF0D7F
          4DFF29CB95FF27CB95FF29CB95FF238F66FF144731AF00000009040F0B2D2176
          53FA2BC693FF29CB95FF2BCC97FF3FD5A7FF42C198FF228056FFABCABBFF0D7E
          4CFF32D09CFF2DCE99FF2ACB96FF2DC996FF247C58FF07191147113A288F2DA1
          78FF2ECD98FF36D19EFF51DAB2FF31A077FF448968FFDEEAE5FFF9F4F0FF0D7D
          4BFF5BE0B9FF5ADFB8FF4DD9B0FF30CF9BFF30A67DFF154933AF195A3ECA35C1
          93FF44D6ABFF51CEA7FF1F7C56FF86B19CFFFAF9F8FFF8F2EEFFF8F0EBFF0D7B
          4AFF0C7748FF0C7444FF228F65FF3BD4A4FF36C395FF1C694AE51C6B4AE946D1
          A4FF33A980FF296D4DFFC3D3CAFFFBF7F5FFF8F2EEFFF8F4F0FFF9F4F0FFFFFF
          FFFFFFFFFFFFFFFFFFFF0C6D41FF43D9AAFF49D5ABFF207853FA1D6B4BE35CD8
          B3FF30A980FF296E4CFFAEB7A9FFECE2DDFFF8F3EFFFF9F6F3FFFAF7F4FFE2D6
          D1FFE0D4CEFFE0D3CDFF0C6B3FFF48DBAFFF62DFBBFF227D59FC195E43C367D0
          B1FF50DEB2FF45CCA2FF1C7751FF73947EFFE4DBD5FFF7F4F2FFFBF9F6FF0B71
          42FF0C6E41FF0C6B40FF1D885CFF52E0B5FF6CD7B7FF1F7050DF113C2B7D5BB7
          98FF61E3BEFF54E1B9FF56E1BAFF319C77FF3B7255FFC8C8C0FFF3F0EDFF0C6E
          41FF5DE7BFFF5AE5BFFF58E3BBFF63E4C0FF65C1A5FF164F399E040E0A1F2C89
          67F58CE8CEFF5BE3BDFF5DE5BFFF5FE8C1FF4EC6A1FF1E6948FF95A898FF0B69
          3EFF61E9C5FF5FE8C1FF5FE5BFFF91EBD4FF2F9670FC07181236000000021242
          307C4CAE8CFF97F0DAFF67E8C4FF62EAC4FF67EAC8FF64E4C2FF2C8462FF0C65
          3BFF67EAC8FF6EECC9FF9EF3DCFF52B493FF16543D9A00000005000000000002
          0105195D44A550B393FFA3EDDAFF95F2D9FF86EFD6FF78EED0FF79EFD1FF87F0
          D7FF96F2DDFFA0ECD8FF4CB592FF1C6C4FB80103030C00000001000000000000
          000000000002124633782F9F77F76AC9ACFF89DEC6FFA7EDDBFFA9F0DEFF8CE1
          C9FF6DCEAFFF30A67DF916563F8F010201080000000100000000000000000000
          00000000000000000001040F0B1B144E3A7E207F5FC226926DDA269670DF2185
          63C816543F850617112900000003000000010000000000000000}
      end>
  end
  object popProdutos: TPopupMenu
    Left = 675
    Top = 356
    object mnuProdutosPedidos: TMenuItem
      Caption = 'Produtos de todos os pedidos selecionados'
      OnClick = mnuProdutosPedidosClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnuProdutosPedidoAtual: TMenuItem
      Caption = 'Produtos do pedido selecionado no grid'
      OnClick = mnuProdutosPedidoAtualClick
    end
  end
end
