object fraCadImpostosNFS: TfraCadImpostosNFS
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  Color = 16770261
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object scroll: TScrollBox
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    TabOrder = 0
    object grpIss: TGroupBox
      Left = 0
      Top = 0
      Width = 434
      Height = 53
      Align = alTop
      Caption = 'ISS'
      TabOrder = 0
      object Label68: TLabel
        Left = 15
        Top = 20
        Width = 41
        Height = 13
        Alignment = taRightJustify
        Caption = 'Bas.ISS:'
      end
      object Label23: TLabel
        Left = 137
        Top = 20
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Alq.ISS:'
      end
      object Label67: TLabel
        Left = 234
        Top = 19
        Width = 47
        Height = 13
        Alignment = taRightJustify
        Caption = 'Total ISS:'
      end
      object Label82: TLabel
        Left = 377
        Top = 20
        Width = 107
        Height = 13
        Alignment = taRightJustify
        Caption = 'C'#243'digo de Verifica'#231#227'o:'
        Visible = False
      end
      object lblCodTipoServico: TLabel
        Left = 573
        Top = 19
        Width = 113
        Height = 13
        Caption = 'C'#243'digo Tipo de Servi'#231'o:'
        Visible = False
      end
      object dbeBasIss: TDBEditFocus
        Tag = 99
        Left = 57
        Top = 16
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_BASISS'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnExit = dbeBasIssExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeAlqIss: TDBEditFocus
        Tag = 99
        Left = 178
        Top = 16
        Width = 52
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_ALQISS'
        DataSource = dtsTabela
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
      object dbeValIss: TDBEditFocus
        Left = 283
        Top = 16
        Width = 83
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        DataField = 'FIS_VALISS'
        DataSource = dtsTabela
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object edtCodigoVerificacaoNSE: TDBEditFocus
        Tag = 99
        Left = 488
        Top = 16
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_CODVER'
        DataSource = dtsTabela
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
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodTipoServico: TDBEditFocus
        Tag = 99
        Left = 691
        Top = 16
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_CDSERV'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        ParentFont = False
        TabOrder = 4
        Visible = False
        OnExit = dbeCodTipoServicoExit
        OnKeyPress = dbeCodTipoServicoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object grbRetencoes: TGroupBox
      Left = 0
      Top = 365
      Width = 434
      Height = 196
      Align = alTop
      Caption = 'Reten'#231#245'es Fornecedor'
      TabOrder = 3
      Visible = False
      object grdImpostos: TcxGridCitel
        Left = 2
        Top = 15
        Width = 430
        Height = 153
        Align = alTop
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdImpostosTableView1: TcxGridDBTableViewCitel
          OnDblClick = grdImpostosTableView1DblClick
          Navigator.Buttons.CustomButtons = <>
          OnEditValueChanged = grdImpostosTableView1EditValueChanged
          OnFocusedItemChanged = grdImpostosTableView1FocusedItemChanged
          OnFocusedRecordChanged = grdImpostosTableView1FocusedRecordChanged
          DataController.DataSource = dtsForRet
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object grdImpostosDESTIP: TcxGridDBColumn
            DataBinding.FieldName = 'DESTIP'
            Options.Editing = False
          end
          object grdImpostosVALBAS: TcxGridDBColumn
            Caption = 'Base Reten'#231#227'o'
            DataBinding.FieldName = 'VALBAS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            Width = 83
          end
          object grdImpostosRET_ALIQUO: TcxGridDBColumn
            DataBinding.FieldName = 'RET_ALIQUO'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
          end
          object grdImpostosVALRET: TcxGridDBColumn
            Caption = 'Valor Reten'#231#227'o'
            DataBinding.FieldName = 'VALRET'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
          end
          object grdImpostosDESCTA: TcxGridDBColumn
            DataBinding.FieldName = 'DESCTA'
            Options.Editing = False
          end
          object grdImpostosNOMPOR: TcxGridDBColumn
            DataBinding.FieldName = 'NOMPOR'
            Options.Editing = False
          end
          object grdImpostosDESEVE: TcxGridDBColumn
            DataBinding.FieldName = 'DESEVE'
            Options.Editing = False
          end
          object grdImpostosDESVEN: TcxGridDBColumn
            DataBinding.FieldName = 'DESVEN'
            Options.Editing = False
            Width = 88
          end
          object grdImpostosRET_DIAVEN: TcxGridDBColumn
            DataBinding.FieldName = 'RET_DIAVEN'
            Options.Editing = False
            Width = 76
          end
          object grdImpostosRET_TIPRET: TcxGridDBColumn
            DataBinding.FieldName = 'RET_TIPRET'
            Visible = False
            VisibleForCustomization = False
            VisibleForEditForm = bFalse
          end
          object grdImpostosRET_TIPDOC: TcxGridDBColumn
            Caption = 'Tipo Doc.'
            DataBinding.FieldName = 'RET_TIPDOC'
          end
          object grdImpostosRET_Q_GUIA: TcxGridDBColumn
            Caption = 'Guia tributo'
            DataBinding.FieldName = 'RET_Q_GUIA'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.DropDownRows = 16
            Properties.DropDownSizeable = True
            Properties.DropDownWidth = 500
            Properties.ImmediateDropDownWhenKeyPressed = False
            Properties.KeyFieldNames = 'GUI_CODGUI'
            Properties.ListColumns = <
              item
                FieldName = 'GUI_DESCRI'
              end>
            Properties.ListOptions.CaseInsensitive = True
            Properties.ListOptions.GridLines = glVertical
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = dtsGuiaTributo
            Width = 68
          end
          object grdImpostosRET_CODREC: TcxGridDBColumn
            Caption = 'Tipo tributo'
            DataBinding.FieldName = 'RET_CODREC'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.DropDownRows = 16
            Properties.DropDownSizeable = True
            Properties.DropDownWidth = 500
            Properties.ImmediateDropDownWhenKeyPressed = False
            Properties.KeyFieldNames = 'TRI_CODTRI'
            Properties.ListColumns = <
              item
                FieldName = 'TRI_CODTRI'
              end
              item
                FieldName = 'TRI_DESCRI'
              end>
            Properties.ListOptions.CaseInsensitive = True
            Properties.ListOptions.GridLines = glVertical
            Properties.ListOptions.ShowHeader = False
            Properties.ListSource = dtsTipoTributo
            Properties.OnInitPopup = grdImpostosRET_CODRECPropertiesInitPopup
          end
        end
        object grdImpostosLevel1: TcxGridLevel
          GridView = grdImpostosTableView1
        end
      end
      object pnlCalcRet: TPanel
        Left = 2
        Top = 168
        Width = 430
        Height = 26
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        Visible = False
        object btnCalcRet: TBitBtnLocked
          Left = 0
          Top = 2
          Width = 130
          Height = 22
          Caption = '&Calcular Reten'#231#245'es'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000000030000000B00000013000000190000001A0000
            00140000000B0000000300000000000000000000000000000000000000000000
            000000000000000000060402011C4827118B7C431ED2A65927FFA55927FF7E44
            1ED442230F7B0100000F0000000E000000070000000000000000000000000000
            000000000005120A05348A4F26DDC58A53FFDCB37CFFEFD298FFEFD198FFB676
            43FF2E1A0C62100904398F5127E10E05013A0000000600000000000000000000
            0002040201198D552BDCD1A169FFF1D6A5FFCE9E6EFFC08656FFBD8251FF613A
            1DA6000000227D4B26CBE2B97BFF5F290FCF0101001900000003000000000000
            00074C2F1B82C99765FFECD2A3FFB98154FB5238238A120C07300F0A06270201
            01194C2F1B88CE9D66FFF6DC9BFFBA8657FF3F1C0C910000000D000000000000
            000A8C5B36D0E3C598FFCB9D75FF573B258C0000000C00000003000000062014
            0C43BD875AFBF8E5BCFFF8DFA5FFF7E4BAFFA16540FC1C0E074C000000080000
            0014B37A4BFAF5E6BDFFBC8356FF0D0704300000000C00000003000000079666
            3FD5B87D4DFFBB8153FFF2D9A1FFB87D4DFFB87C4DFF9C6941DE845331D3A263
            3BFFBB8557FFF6E7BFFFBF8B5EFFA06238FF87522FDC00000006000000020000
            000B0D08042FA1653CFFF4DEAEFFB68155FA000000180000000A1F170F34C79D
            75FBFBF5DCFFFCF3CCFFFAF4DAFFB3855FFB21150C4100000004000000020000
            0009492C1886BA8B5EFFE7CEA7FF926B48CB0000000900000000000000045540
            2D77DDC1A2FFFDF7D9FFD4B598FF5037227F0202010C0D08041F110A05274B2D
            1986A1683EFAF3E4C3FFD8B692FF533F2C780000000400000000000000000000
            00058F6F50BCEFE1CDFF886343C20202010D58382091A3693CFFA66F43FFBE94
            6DFFF4E9D1FFE3CAADFFA47E5BD60504030E0000000100000000000000000000
            0001130F0B1DAB8863DA18130E242C1E1248B78B63FDF8F3E2FFF9F3E4FFEDDE
            C7FFDCC1A1FFA3815ED215110C22000000020000000000000000000000000000
            000000000001000000010101000342301E629A7B5CC2C6A078F9C6A078F9997B
            5DC3564634710504030A00000001000000000000000000000000000000000000
            0000000000000000000000000000000000010000000200000002000000020000
            0002000000010000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 0
          OnClick = btnCalcRetClick
        end
      end
    end
    object grpRetencaoDados: TGroupBox
      Left = 0
      Top = 130
      Width = 434
      Height = 164
      Align = alTop
      Caption = 'Dados da Reten'#231#227'o '
      TabOrder = 1
      Visible = False
      object Label5: TLabel
        Left = 573
        Top = 19
        Width = 113
        Height = 13
        Caption = 'C'#243'digo Tipo de Servi'#231'o:'
        Visible = False
      end
      object lblForn: TLabel
        Left = 31
        Top = 48
        Width = 59
        Height = 13
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object lblCentroCusto: TLabel
        Left = 8
        Top = 92
        Width = 82
        Height = 13
        Alignment = taRightJustify
        Caption = 'Plano de Contas:'
      end
      object lblEventos: TLabel
        Left = 52
        Top = 115
        Width = 38
        Height = 13
        Caption = 'Evento:'
      end
      object lblTipo: TLabel
        Left = 47
        Top = 28
        Width = 43
        Height = 13
        Caption = 'Imposto:'
      end
      object lblAliq: TLabel
        Left = 246
        Top = 26
        Width = 43
        Height = 13
        Caption = 'Al'#237'quota:'
      end
      object lblPortador: TLabel
        Left = 44
        Top = 70
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object Label25: TLabel
        Left = 448
        Top = 48
        Width = 49
        Height = 13
        Caption = 'Tipo Doc.:'
      end
      object lblGuia: TLabel
        Left = 528
        Top = 48
        Width = 25
        Height = 13
        Alignment = taRightJustify
        Caption = 'Guia:'
        Visible = False
      end
      object spbDicaTributo: TSpeedButton
        Left = 758
        Top = 44
        Width = 20
        Height = 22
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000800000010000000100000
          0008000000010000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
          0B60000000070000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
          27EA0000000E0000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
          30EC0000000D0000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
          1A51000000050000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000600000011000000140000
          000A000000020000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000670503AA999532EFF4528
          187A000000070000000100000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
          4AF724150D490000000800000002000000000000000000000000000000000000
          0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
          9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
          000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
          AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
          00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
          76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
          000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
          70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
          000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
          C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
          0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
          77E570533B9A17100A2500000002000000000000000000000000000000000000
          0000000000000000000000000000000000010000000100000002000000030000
          0002000000020000000100000000000000000000000000000000}
        ParentShowHint = False
        ShowHint = False
        Visible = False
        OnClick = spbDicaTributoClick
      end
      object lblWarning: TLabel
        Left = 339
        Top = 26
        Width = 577
        Height = 16
        AutoSize = False
        Caption = 
          'O INSS patronal n'#227'o '#233' deduzido do valor do contas a pagar do for' +
          'necedor.'
        Color = 16770261
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Visible = False
      end
      object DBEditFocus5: TDBEditFocus
        Tag = 99
        Left = 691
        Top = 16
        Width = 75
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_CDSERV'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 15
        Visible = False
        OnKeyPress = dbeCodTipoServicoKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 91
        Top = 45
        Width = 55
        Height = 21
        Alignment = taLeftJustify
        Enabled = False
        MaxLength = 8
        TabOrder = 2
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object mskCodCtaRet: TMaskEditFocus
        Tag = 99
        Left = 91
        Top = 89
        Width = 55
        Height = 21
        AutoSize = False
        Enabled = False
        EditMask = '99.99.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 9
        TabOrder = 5
        Text = ''
        OnEnter = mskCodCtaRetEnter
        OnExit = mskCodCtaRetExit
        OnKeyPress = mskCodCtaRetKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtCodEve: TEditFocus
        Tag = 99
        Left = 91
        Top = 111
        Width = 55
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 5
        TabOrder = 8
        OnKeyPress = edtCodEveKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesFor: TEditFocus
        Left = 147
        Top = 45
        Width = 295
        Height = 21
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
      object edtDesCtaRet: TEditFocus
        Left = 147
        Top = 89
        Width = 295
        Height = 21
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
      object edtDesEve: TEditFocus
        Left = 147
        Top = 111
        Width = 295
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object cmbTipImp: TComboBoxFocus
        Tag = 99
        Left = 91
        Top = 22
        Width = 145
        Height = 21
        Enabled = False
        TabOrder = 0
        OnChange = cmbTipImpChange
        OnSelect = cmbTipImpSelect
        Items.Strings = (
          'Reten'#231#227'o de PIS'
          'Reten'#231#227'o de COFINS'
          'Reten'#231#227'o de CSLL'
          'Reten'#231#227'o de IRRF'
          'Reten'#231#227'o de INSS'
          'Reten'#231#227'o de ISS'
          'Reten'#231#227'o de INSS Patronal')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtAliq: TEditFocus
        Tag = 99
        Left = 290
        Top = 23
        Width = 43
        Height = 21
        Alignment = taRightJustify
        Enabled = False
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
      object rdgVencimento: TRadioGroup
        Tag = 99
        Left = 444
        Top = 72
        Width = 119
        Height = 60
        Caption = 'Dia Vencimento'
        ItemIndex = 1
        Items.Strings = (
          'Dia Fixo'
          #218'ltimo Dia do M'#234's')
        TabOrder = 12
        OnClick = rdgVencimentoClick
        OnExit = rdgVencimentoExit
      end
      object edtVencimento: TEditFocus
        Tag = 99
        Left = 526
        Top = 86
        Width = 20
        Height = 21
        Alignment = taLeftJustify
        MaxLength = 2
        TabOrder = 14
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 2
        TipoTexto = ttInteiro
      end
      object pnlBotoesImp: TPanel
        Left = 2
        Top = 135
        Width = 430
        Height = 27
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 16
        Visible = False
        object btnIncluirImp: TBitBtnLocked
          Left = 4
          Top = 2
          Width = 76
          Height = 24
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
          TabOrder = 0
          OnClick = btnIncluirImpClick
        end
        object btnAlterarImp: TBitBtnLocked
          Left = 157
          Top = 2
          Width = 76
          Height = 24
          Caption = '&Alterar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
            69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
            CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
            A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
            7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
            820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
            A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
            81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
            860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
            A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
            93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
            C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
            BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
            A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
            D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
            D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
            B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
            9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
            DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
            55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
            E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
            6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
            926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 2
          OnClick = btnAlterarImpClick
        end
        object btnExcluirImp: TBitBtnLocked
          Left = 233
          Top = 2
          Width = 76
          Height = 24
          Caption = '&Excluir'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
            00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
            00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
            DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
            006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
            16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
            20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
            00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
            00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
            E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 3
          OnClick = btnExcluirImpClick
        end
        object btnCancelarImp: TBitBtnLocked
          Left = 309
          Top = 2
          Width = 76
          Height = 24
          Caption = '&Cancelar'
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
          TabOrder = 4
          OnClick = btnCancelarImpClick
        end
        object btnGravarImp: TBitBtnLocked
          Left = 80
          Top = 2
          Width = 76
          Height = 24
          Caption = '&Gravar'
          Enabled = False
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
          TabOrder = 1
          OnClick = btnGravarImpClick
        end
      end
      object edtCodPorRet: TEditFocus
        Tag = 99
        Left = 91
        Top = 67
        Width = 55
        Height = 21
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 4
        OnKeyPress = edtCodPorRetKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtNomPorRet: TEditFocus
        Left = 147
        Top = 67
        Width = 295
        Height = 21
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
      object dbeTipDoc: TDBEditFocus
        Tag = 99
        Left = 497
        Top = 45
        Width = 23
        Height = 21
        Hint = 'TipDoc'
        DataField = 'RET_TIPDOC'
        DataSource = dtsForRet
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnExit = dbeTipDocExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object LcbGuiaTributo: TDBLookupComboBox
        Tag = 99
        Left = 554
        Top = 45
        Width = 116
        Height = 21
        DataField = 'RET_Q_GUIA'
        DataSource = dtsForRet
        DropDownRows = 10
        Enabled = False
        KeyField = 'GUI_CODGUI'
        ListField = 'GUI_DESCRI'
        ListSource = dtsGuiaTributo
        TabOrder = 10
        Visible = False
        OnExit = LcbGuiaTributoExit
      end
      object LcbTipoTributo: TDBLookupComboBox
        Tag = 99
        Left = 672
        Top = 45
        Width = 85
        Height = 21
        DataField = 'RET_CODREC'
        DataSource = dtsForRet
        DropDownRows = 10
        DropDownWidth = 500
        Enabled = False
        KeyField = 'TRI_CODTRI'
        ListField = 'TRI_CODTRI;TRI_DESCRI'
        ListSource = dtsTipoTributo
        TabOrder = 11
        Visible = False
      end
    end
    object grpRent: TGroupBox
      Left = 0
      Top = 294
      Width = 434
      Height = 71
      Align = alTop
      Caption = 'Reten'#231#245'es'
      TabOrder = 2
      object Label69: TLabel
        Left = 380
        Top = 20
        Width = 77
        Height = 13
        Alignment = taRightJustify
        Caption = 'Reten'#231#227'o IRRF:'
      end
      object Label70: TLabel
        Left = 197
        Top = 43
        Width = 76
        Height = 13
        Alignment = taRightJustify
        Caption = 'Reten'#231#227'o CSLL:'
      end
      object Label71: TLabel
        Left = 381
        Top = 43
        Width = 76
        Height = 13
        Alignment = taRightJustify
        Caption = 'Reten'#231#227'o INSS:'
      end
      object Label72: TLabel
        Left = 204
        Top = 20
        Width = 69
        Height = 13
        Alignment = taRightJustify
        Caption = 'Reten'#231#227'o ISS:'
      end
      object Label110: TLabel
        Left = 36
        Top = 20
        Width = 69
        Height = 13
        Alignment = taRightJustify
        Caption = 'Reten'#231#227'o PIS:'
      end
      object Label111: TLabel
        Left = 14
        Top = 43
        Width = 91
        Height = 13
        Alignment = taRightJustify
        Caption = 'Reten'#231#227'o COFINS:'
      end
      object Label1: TLabel
        Left = 555
        Top = 22
        Width = 115
        Height = 13
        Alignment = taRightJustify
        Caption = 'Reten'#231#227'o INSS Patronal'
      end
      object dbeRetISS: TDBEditFocus
        Tag = 99
        Left = 274
        Top = 17
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_RETISS'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        OnExit = dbeRetISSExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeReIRRF: TDBEditFocus
        Tag = 99
        Left = 458
        Top = 17
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_REIRRF'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 4
        OnExit = dbeReIRRFExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeReCSSL: TDBEditFocus
        Tag = 99
        Left = 274
        Top = 40
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_RECSSL'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 3
        OnExit = dbeReCSSLExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeReINSS: TDBEditFocus
        Tag = 99
        Left = 458
        Top = 40
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_REINSS'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 5
        OnExit = dbeReINSSExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
      object dbeVREPIS: TDBEditFocus
        Tag = 99
        Left = 106
        Top = 17
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_VREPIS'
        DataSource = dtsTabela
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
      object dbeVRECOF: TDBEditFocus
        Tag = 99
        Left = 106
        Top = 40
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_VRECOF'
        DataSource = dtsTabela
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
      object dbeReINSSP: TDBEditFocus
        Tag = 99
        Left = 673
        Top = 17
        Width = 83
        Height = 22
        CharCase = ecUpperCase
        DataField = 'FIS_RINSSP'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 6
        OnExit = dbeReINSSPExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
    object gbpREINF: TGroupBox
      Left = 0
      Top = 53
      Width = 434
      Height = 77
      Align = alTop
      Caption = 'REINF'
      TabOrder = 4
      Visible = False
      object lblNatRend: TLabel
        Left = 10
        Top = 25
        Width = 123
        Height = 13
        Alignment = taRightJustify
        Caption = 'Natureza do Rendimento:'
      end
      object lblTipServ: TLabel
        Left = 56
        Top = 49
        Width = 77
        Height = 13
        Alignment = taRightJustify
        Caption = 'Tipo de Servi'#231'o:'
      end
      object edtNatRend: TEditFocus
        Left = 199
        Top = 22
        Width = 683
        Height = 21
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtTipoServico: TEditFocus
        Left = 199
        Top = 46
        Width = 683
        Height = 21
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
      object dbeCodNatRend: TDBEditFocus
        Tag = 99
        Left = 134
        Top = 22
        Width = 65
        Height = 21
        CharCase = ecUpperCase
        DataField = 'FIS_TB01RE'
        DataSource = dtsTabela
        MaxLength = 5
        TabOrder = 0
        OnKeyPress = dbeCodNatRendKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodTipServ: TDBEditFocus
        Tag = 99
        Left = 134
        Top = 46
        Width = 65
        Height = 21
        CharCase = ecUpperCase
        DataField = 'FIS_TB06RE'
        DataSource = dtsTabela
        MaxLength = 9
        TabOrder = 2
        OnKeyPress = dbeCodTipServKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  object cdsForRet: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspForRet'
    Left = 248
    Top = 324
    object cdsForRetAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsForRetRET_ALIQUO: TFloatField
      DisplayLabel = '% Al'#237'quota'
      FieldName = 'RET_ALIQUO'
      EditFormat = '#,####0.0000'
    end
    object cdsForRetDESTIP: TStringField
      DisplayLabel = 'Tipo Imposto'
      FieldName = 'DESTIP'
    end
    object cdsForRetRET_DIAVEN: TIntegerField
      DisplayLabel = 'Dia Vencimto'
      FieldName = 'RET_DIAVEN'
    end
    object cdsForRetDESVEN: TStringField
      DisplayLabel = 'Tipo Vencimto'
      FieldName = 'DESVEN'
    end
    object cdsForRetDESEVE: TStringField
      DisplayLabel = 'Evento'
      FieldName = 'DESEVE'
    end
    object cdsForRetDESCTA: TStringField
      DisplayLabel = 'Plano de Contas'
      FieldName = 'DESCTA'
    end
    object cdsForRetDESFOR: TStringField
      DisplayLabel = 'Fornecedor'
      FieldName = 'DESFOR'
    end
    object cdsForRetNOMPOR: TStringField
      DisplayLabel = 'Portador'
      FieldName = 'NOMPOR'
    end
    object cdsForRetRET_TIPRET: TStringField
      FieldName = 'RET_TIPRET'
      Visible = False
      Size = 1
    end
    object cdsForRetRET_CODFOR: TStringField
      FieldName = 'RET_CODFOR'
      Visible = False
      Size = 8
    end
    object cdsForRetRET_CODEVE: TStringField
      FieldName = 'RET_CODEVE'
      Visible = False
      Size = 7
    end
    object cdsForRetRET_CODCTA: TStringField
      FieldName = 'RET_CODCTA'
      Visible = False
      Size = 7
    end
    object cdsForRetRET_TIPVEN: TStringField
      FieldName = 'RET_TIPVEN'
      Visible = False
      Size = 1
    end
    object cdsForRetRET_FORRET: TStringField
      FieldName = 'RET_FORRET'
      Visible = False
      Size = 8
    end
    object cdsForRetFOR_NOMFOR: TStringField
      FieldName = 'FOR_NOMFOR'
      Visible = False
    end
    object cdsForRetCTA_DESCTA: TStringField
      FieldName = 'CTA_DESCTA'
      Visible = False
    end
    object cdsForRetEVE_DESEVE: TStringField
      FieldName = 'EVE_DESEVE'
      Visible = False
    end
    object cdsForRetVALRET: TFloatField
      FieldName = 'VALRET'
    end
    object cdsForRetVALBAS: TFloatField
      FieldName = 'VALBAS'
    end
    object cdsForRetPOR_NOMPOR: TStringField
      FieldName = 'POR_NOMPOR'
    end
    object cdsForRetRET_CODPOR: TStringField
      FieldName = 'RET_CODPOR'
    end
    object cdsForRetRET_TIPDOC: TIntegerField
      FieldName = 'RET_TIPDOC'
    end
    object cdsForRetRET_Q_GUIA: TStringField
      FieldName = 'RET_Q_GUIA'
      Size = 2
    end
    object cdsForRetRET_CODREC: TStringField
      FieldName = 'RET_CODREC'
      Size = 12
    end
  end
  object dtsForRet: TDataSource
    DataSet = cdsForRet
    Left = 184
    Top = 324
  end
  object dtsTabela: TDataSource
    Left = 744
    Top = 230
  end
  object qryForRet: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 352
    Top = 318
  end
  object dspForRet: TUniDataSetProvider
    DataSet = qryForRet
    Options = []
    Left = 424
    Top = 318
  end
  object dtsGuiaTributo: TDataSource
    AutoEdit = False
    Left = 600
    Top = 362
  end
  object dtsTipoTributo: TDataSource
    AutoEdit = False
    Left = 512
    Top = 366
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TdxScreenTipStyle'
    HintStyle.ScreenTipLinks = <
      item
        ScreenTip = dxScreenTipRepositoryScreenTip1
        Control = dbeTipDoc
      end>
    HintStyle.ScreenTipActionLinks = <>
    UseHintControlLookAndFeel = True
    OnShowHint = HintControlerShowHint
    Left = 624
    Top = 176
  end
  object dxScreenTipRepository: TdxScreenTipRepository
    Left = 688
    Top = 145
    PixelsPerInch = 96
    object dxScreenTipRepositoryScreenTip1: TdxScreenTip
      Header.Text = 'Tipos de Documento:'
      Description.Text = '(1)-T'#237'tulos (2)-Tributos (3)-Concession'#225'rias'
      Width = 270
    end
  end
end
