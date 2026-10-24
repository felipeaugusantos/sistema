inherited frmAuditoriaLancamentos: TfrmAuditoriaLancamentos
  Width = 1122
  Height = 788
  BorderStyle = bsSizeable
  Caption = 'Auditoria de Lan'#231'amentos Cont'#225'beis'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1122
  ExplicitHeight = 788
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 707
    Width = 1106
    TabOrder = 1
    ExplicitTop = 707
    ExplicitWidth = 1106
    inherited FlwBotoes: TFlowPanel
      Width = 1102
      ExplicitWidth = 1102
      inherited btnConfirma: TBitBtnLocked
        Caption = '&Fechar'
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1026
      Visible = False
      ExplicitLeft = 1026
    end
  end
  inherited pnlStatus: TPanel
    Top = 733
    Width = 1106
    TabOrder = 2
    ExplicitTop = 733
    ExplicitWidth = 1106
    inherited pnlNomeForm: TPanel
      Left = 935
      ExplicitLeft = 935
    end
    inherited pnlInfo: TPanel
      Width = 935
      ExplicitWidth = 935
    end
  end
  object gbFiltroAvancado: TcxGroupBox [2]
    Left = 0
    Top = 0
    Align = alTop
    Caption = 'Filtro Avan'#231'ado'
    TabOrder = 0
    Height = 209
    Width = 1106
    object Label15: TLabel
      Left = 54
      Top = 45
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label12: TLabel
      Left = 52
      Top = 74
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'C. D'#233'bito:'
    end
    object lbContaCredito: TLabel
      Left = 48
      Top = 99
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'C. Cr'#233'dito:'
    end
    object lbValor: TLabel
      Left = 70
      Top = 124
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object Label1: TLabel
      Left = 12
      Top = 19
      Width = 87
      Height = 14
      Caption = 'Data Lan'#231'amento:'
    end
    object Label2: TLabel
      Left = 32
      Top = 150
      Width = 67
      Height = 14
      Caption = 'Complemento:'
    end
    object edtEmpLan: TEditFocus
      Tag = 99
      Left = 103
      Top = 42
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtEmpLanKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 162
      Top = 42
      Width = 522
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
    object mskContaDebito: TMaskEditFocus
      Tag = 99
      Left = 103
      Top = 69
      Width = 126
      Height = 22
      TabOrder = 3
      Text = ''
      OnClick = mskContaDebitoClick
      OnKeyPress = mskContaDebitoKeyPress
      OnKeyUp = mskContaDebitoKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtConDebRed: TEditFocus
      Tag = 99
      Left = 231
      Top = 69
      Width = 113
      Height = 22
      Alignment = taLeftJustify
      Color = clWhite
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      OnClick = edtConDebRedClick
      OnKeyUp = edtConDebRedKeyUp
      NormalColor = clWhite
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesContaDebito: TEditFocus
      Left = 346
      Top = 69
      Width = 465
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskContaCredito: TMaskEditFocus
      Tag = 99
      Left = 103
      Top = 95
      Width = 126
      Height = 22
      TabOrder = 5
      Text = ''
      OnClick = mskContaCreditoClick
      OnKeyPress = mskContaCreditoKeyPress
      OnKeyUp = mskContaCreditoKeyUp
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtConCreRed: TEditFocus
      Tag = 99
      Left = 231
      Top = 95
      Width = 113
      Height = 22
      Alignment = taLeftJustify
      Color = clWhite
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      OnClick = edtConCreRedClick
      OnKeyUp = edtConCreRedKeyUp
      NormalColor = clWhite
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesContaCRedito: TEditFocus
      Left = 346
      Top = 95
      Width = 465
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtValor: TCurrencyEditFocus
      Left = 103
      Top = 121
      Properties.DisplayFormat = '0.00;-0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 107
    end
    object dbgBuscaConta: TDBGridCitel
      Left = 807
      Top = 0
      Width = 474
      Height = 185
      DataSource = dtsBusca
      Options = [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 12
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      Visible = False
      OnDblClick = dbgBuscaContaDblClick
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'CODCON'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONRED'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCON'
          Visible = True
        end>
    end
    object edtDataInicial: TcxDateEdit
      Left = 103
      Top = 16
      TabOrder = 0
      Width = 121
    end
    object edtDataFinal: TcxDateEdit
      Left = 230
      Top = 16
      TabOrder = 1
      Width = 121
    end
    object edtComplemento: TEditFocus
      Left = 103
      Top = 147
      Width = 708
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnAbrirFiltro: TBitBtn
      Left = 103
      Top = 175
      Width = 121
      Height = 25
      Caption = 'Abrir Filtro'
      TabOrder = 13
      OnClick = btnAbrirFiltroClick
    end
  end
  object gbDadosLancon: TcxGroupBox [3]
    Left = 0
    Top = 209
    Align = alTop
    Caption = 'Lan'#231'amentos Cont'#225'beis'
    TabOrder = 3
    Height = 184
    Width = 1106
    object GridLancon: TcxGridCitel
      Left = 2
      Top = 19
      Width = 1102
      Height = 163
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object GridTableViewLancon: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        OnFocusedItemChanged = GridTableViewLanconFocusedItemChanged
        DataController.DataSource = dsLancon
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsCustomize.BandMoving = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Bands = <
          item
            Width = 3411
          end
          item
            Caption = 'Info. Origem Par'#226'metro'
            FixedKind = fkRight
            Width = 850
          end>
        object GridTableViewLanconAUTOINCREM: TcxGridDBBandedColumn
          Caption = 'C'#243'digo AutoIncremento'
          DataBinding.FieldName = 'AUTOINCREM'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_EMPLAN: TcxGridDBBandedColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CON_EMPLAN'
          Width = 87
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_DTALAN: TcxGridDBBandedColumn
          Caption = 'Data'
          DataBinding.FieldName = 'CON_DTALAN'
          Width = 91
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_TIPLAN: TcxGridDBBandedColumn
          Caption = 'Tipo de Lancto'
          DataBinding.FieldName = 'CON_TIPLAN'
          Width = 99
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_CLAFIS: TcxGridDBBandedColumn
          Caption = 'CLAFIS'
          DataBinding.FieldName = 'CON_CLAFIS'
          Width = 60
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_CONDEB: TcxGridDBBandedColumn
          Caption = 'Conta D'#233'bito'
          DataBinding.FieldName = 'CON_CONDEB'
          PropertiesClassName = 'TcxMaskEditProperties'
          Width = 125
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object GridTableViewLanconDES_CONDEB: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o Conta D'#233'bito'
          DataBinding.FieldName = 'DES_CONDEB'
          Width = 445
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object GridTableViewLanconRED_CONDEB: TcxGridDBBandedColumn
          Caption = 'Conta D'#233'bito Reduzida'
          DataBinding.FieldName = 'RED_CONDEB'
          Width = 148
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_CONCRE: TcxGridDBBandedColumn
          Caption = 'Conta Cr'#233'dito'
          DataBinding.FieldName = 'CON_CONCRE'
          PropertiesClassName = 'TcxMaskEditProperties'
          Width = 123
          Position.BandIndex = 0
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object GridTableViewLanconDES_CONCRE: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o Conta Cr'#233'dito'
          DataBinding.FieldName = 'DES_CONCRE'
          Width = 446
          Position.BandIndex = 0
          Position.ColIndex = 9
          Position.RowIndex = 0
        end
        object GridTableViewLanconRED_CONCRE: TcxGridDBBandedColumn
          Caption = 'Conta Cr'#233'dito Reduzida'
          DataBinding.FieldName = 'RED_CONCRE'
          Width = 148
          Position.BandIndex = 0
          Position.ColIndex = 10
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_HISPAD: TcxGridDBBandedColumn
          Caption = 'Hist'#243'rico Padr'#227'o'
          DataBinding.FieldName = 'CON_HISPAD'
          Width = 108
          Position.BandIndex = 0
          Position.ColIndex = 11
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_HISTOR: TcxGridDBBandedColumn
          Caption = 'Complemento'
          DataBinding.FieldName = 'CON_HISTOR'
          PropertiesClassName = 'TcxBlobEditProperties'
          Properties.AlwaysSaveData = False
          Properties.BlobEditKind = bekMemo
          Properties.BlobPaintStyle = bpsText
          Width = 233
          Position.BandIndex = 0
          Position.ColIndex = 12
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_VALLAN: TcxGridDBBandedColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'CON_VALLAN'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Width = 120
          Position.BandIndex = 0
          Position.ColIndex = 13
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_AUTOMA: TcxGridDBBandedColumn
          Caption = 'Lan'#231'amento Autom'#225'tico?'
          DataBinding.FieldName = 'CON_AUTOMA'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'N'#227'o'
              ImageIndex = 0
              Value = '0'
            end
            item
              Description = 'Sim'
              Value = '1'
            end>
          Width = 151
          Position.BandIndex = 0
          Position.ColIndex = 14
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_CCUSTO: TcxGridDBBandedColumn
          Caption = 'Centro Custo D'#233'bito'
          DataBinding.FieldName = 'CON_CCUSTO'
          Width = 126
          Position.BandIndex = 0
          Position.ColIndex = 15
          Position.RowIndex = 0
        end
        object GridTableViewLanconDES_CCUSTO: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o Centro Custo D'#233'bito'
          DataBinding.FieldName = 'DES_CCUSTO'
          Width = 294
          Position.BandIndex = 0
          Position.ColIndex = 16
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_CCUSCR: TcxGridDBBandedColumn
          Caption = 'Centro Custo Cr'#233'dito'
          DataBinding.FieldName = 'CON_CCUSCR'
          Width = 125
          Position.BandIndex = 0
          Position.ColIndex = 17
          Position.RowIndex = 0
        end
        object GridTableViewLanconDES_CCUSCR: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o Centro Custo Cr'#233'dito'
          DataBinding.FieldName = 'DES_CCUSCR'
          Width = 286
          Position.BandIndex = 0
          Position.ColIndex = 18
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_CODOPE: TcxGridDBBandedColumn
          Caption = 'Operador Lanc.'
          DataBinding.FieldName = 'CON_CODOPE'
          Width = 89
          Position.BandIndex = 0
          Position.ColIndex = 19
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_AUTMOD: TcxGridDBBandedColumn
          Caption = 'Registro Aut. Modificado?'
          DataBinding.FieldName = 'CON_AUTMOD'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Sim'
              ImageIndex = 0
              Value = 'S'
            end
            item
              Description = 'N'#227'o'
              Value = 'N'
            end>
          Width = 107
          Position.BandIndex = 0
          Position.ColIndex = 20
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_SEQPAR: TcxGridDBBandedColumn
          Caption = 'Seq. Par'#226'metro Cont'#225'bil'
          DataBinding.FieldName = 'CON_SEQPAR'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                6100000026744558745469746C650046696E643B426172733B526962626F6E3B
                5374616E646172643B536561726368BB659C08000002D149444154785EAD936D
                48936B18C7FF7B369FB5E3CB3C6AEACC66E66C94980AF6C1B74A462FE743E087
                2526299812C519A20B03C98A3AC9D2E8E518519F52222A2789ACF99264C58AD0
                322A848E9BBA6992D95496BACD3DDBF43EF7C62AE9ABFDE1C77D735DF7F5E7BA
                EEFB79788410FC2EF128020A4B09A230AB733FF8454CEDE54EFF7AF8EFC6CD6A
                4DFBA39A069DBDF282565F507A2AD96758A369939EB9D6ABAB6BEA75D55EE9D2
                A9EAEE487D466A4D07FC525FF46F84AAF3DA572F07C7C8F0E814B9DD6A20AA73
                5A0E40485D538F6BE0C3383159BE929B779F90AAFA760300BEEA6CDBCF2E9465
                F5F9FF5CEF21D3338BC43060240DD75BC9D1DA7B04C0969397F464F2CB376234
                5B49F3FD3EA23A7D8F9454DFC8FA3E0E43091286FD59BE4D168B2597070E9717
                939356184DA3D8B1F784D16432C3C97941C0032B12C2EB716085B01500F87E83
                2D698AE820365429A70636BB0B8B4E17161C2E78380F122591F0B8396ABA0CEF
                0A8150148C20FE0ABCCB284ECB514600E031F2F4FDF58A6CB9302E468CD4E418
                A46FDD88785FA1D78D71CB3838B71B3C1E81242A1407F2535176682FC0D9D689
                C2132E0010308C4054989F2547F7D31114553DC4DB8F56ECCE4D839B165A67A6
                C0D1B1A2C422E8FB465158A9C390D981A2821CDAA1BBC46FC0B9BCFCF03021BA
                0CA38854E4A17BC08CED294960593EC6FFD3FF151B17075FBEF38505EBF765A3
                67F013D25393E97D39F900186689B34F8E4DCC4091BB09F3AFFBB13B538A11F3
                17D817E626000C3916178C96092BF6E44961EB7F83FCCC784C4DCF8273DA2D00
                0833373D72B5B9F53912625834AA7642124CD0F2E031E667276E02B0DBAC9F2F
                B5689F214922C0BFD53990867970ABB9034EFBAC06808702B12C43A94EC93B36
                BC2DEF389165161B6365BB6A0044049E6A5D4A56E991949C8A77F2AC32929871
                F0BD44AE2807205AFD2DFC4189A66CA0C450820371040EB18198981242610371
                ACF96F64B046FD0FE22625E3DA6A63E80000000049454E44AE426082}
              Hint = 'Chamar Cadastro'
              Kind = bkGlyph
            end>
          Properties.ReadOnly = True
          Properties.OnButtonClick = GridTableViewLanconCON_SEQPARPropertiesButtonClick
          Options.ShowEditButtons = isebAlways
          Width = 106
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object GridTableViewLanconLAN_NUMLOT: TcxGridDBBandedColumn
          Caption = 'Numero Lote'
          DataBinding.FieldName = 'LAN_NUMLOT'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 21
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_TT_ULT: TcxGridDBBandedColumn
          Caption = 'Data/Hora Ultima Modifica'#231#227'o'
          DataBinding.FieldName = 'CON_TT_ULT'
          PropertiesClassName = 'TcxDateEditProperties'
          Properties.Kind = ckDateTime
          Position.BandIndex = 0
          Position.ColIndex = 22
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_TIP_FC: TcxGridDBBandedColumn
          Caption = 'Cliente/Fornecedor'
          DataBinding.FieldName = 'CON_TIP_FC'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Cliente'
              ImageIndex = 0
              Value = 'C'
            end
            item
              Description = 'Fornecedor'
              Value = 'F'
            end>
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 23
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_NATOPE: TcxGridDBBandedColumn
          Caption = 'Condi'#231#227'o de Pagamento'
          DataBinding.FieldName = 'CON_NATOPE'
          Width = 49
          Position.BandIndex = 1
          Position.ColIndex = 12
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_PAGAME: TcxGridDBBandedColumn
          Caption = 'Pagamentos'
          DataBinding.FieldName = 'CON_PAGAME'
          Width = 96
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_DESVAL: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o Valor'
          DataBinding.FieldName = 'CON_DESVAL'
          Width = 90
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_INVNCO: TcxGridDBBandedColumn
          Caption = 'Conta Invertida?'
          DataBinding.FieldName = 'CON_INVNCO'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'N'#227'o'
              ImageIndex = 0
              Value = 'N'
            end
            item
              Description = 'Sim'
              Value = 'S'
            end>
          Width = 73
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_TPORIC: TcxGridDBBandedColumn
          Caption = 'Tipo Ori. Cred.'
          DataBinding.FieldName = 'CON_TPORIC'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Parcon'
              ImageIndex = 0
              Value = 'PR'
            end
            item
              Description = 'Cliente/Fornecedor'
              Value = 'CF'
            end
            item
              Description = 'Portador'
              Value = 'PT'
            end
            item
              Description = 'Bandeira'
              Value = 'BN'
            end
            item
              Description = 'Plano Contas'
              Value = 'PC'
            end
            item
              Description = 'Abrev. Prod.'
              Value = 'AB'
            end
            item
              Description = 'Configura'#231#227'o'
              Value = 'CN'
            end>
          Width = 65
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_CDORIC: TcxGridDBBandedColumn
          Caption = 'C'#243'digo Ori. Cred.'
          DataBinding.FieldName = 'CON_CDORIC'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                6100000026744558745469746C650046696E643B426172733B526962626F6E3B
                5374616E646172643B536561726368BB659C08000002D149444154785EAD936D
                48936B18C7FF7B369FB5E3CB3C6AEACC66E66C94980AF6C1B74A462FE743E087
                2526299812C519A20B03C98A3AC9D2E8E518519F52222A2789ACF99264C58AD0
                322A848E9BBA6992D95496BACD3DDBF43EF7C62AE9ABFDE1C77D735DF7F5E7BA
                EEFB79788410FC2EF128020A4B09A230AB733FF8454CEDE54EFF7AF8EFC6CD6A
                4DFBA39A069DBDF282565F507A2AD96758A369939EB9D6ABAB6BEA75D55EE9D2
                A9EAEE487D466A4D07FC525FF46F84AAF3DA572F07C7C8F0E814B9DD6A20AA73
                5A0E40485D538F6BE0C3383159BE929B779F90AAFA760300BEEA6CDBCF2E9465
                F5F9FF5CEF21D3338BC43060240DD75BC9D1DA7B04C0969397F464F2CB376234
                5B49F3FD3EA23A7D8F9454DFC8FA3E0E43091286FD59BE4D168B2597070E9717
                939356184DA3D8B1F784D16432C3C97941C0032B12C2EB716085B01500F87E83
                2D698AE820365429A70636BB0B8B4E17161C2E78380F122591F0B8396ABA0CEF
                0A8150148C20FE0ABCCB284ECB514600E031F2F4FDF58A6CB9302E468CD4E418
                A46FDD88785FA1D78D71CB3838B71B3C1E81242A1407F2535176682FC0D9D689
                C2132E0010308C4054989F2547F7D31114553DC4DB8F56ECCE4D839B165A67A6
                C0D1B1A2C422E8FB465158A9C390D981A2821CDAA1BBC46FC0B9BCFCF03021BA
                0CA38854E4A17BC08CED294960593EC6FFD3FF151B17075FBEF38505EBF765A3
                67F013D25393E97D39F900186689B34F8E4DCC4091BB09F3AFFBB13B538A11F3
                17D817E626000C3916178C96092BF6E44961EB7F83FCCC784C4DCF8273DA2D00
                0833373D72B5B9F53912625834AA7642124CD0F2E031E667276E02B0DBAC9F2F
                B5689F214922C0BFD53990867970ABB9034EFBAC06808702B12C43A94EC93B36
                BC2DEF389165161B6365BB6A0044049E6A5D4A56E991949C8A77F2AC32929871
                F0BD44AE2807205AFD2DFC4189A66CA0C450820371040EB18198981242610371
                ACF96F64B046FD0FE22625E3DA6A63E80000000049454E44AE426082}
              Hint = 'Mostrar Cadastro'
              Kind = bkGlyph
            end>
          Properties.ReadOnly = True
          Properties.OnButtonClick = GridTableViewLanconCON_CDORICPropertiesButtonClick
          Options.ShowEditButtons = isebAlways
          Width = 81
          Position.BandIndex = 1
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_OPBCCR: TcxGridDBBandedColumn
          Caption = 'Origem Cred.'
          DataBinding.FieldName = 'CON_OPBCCR'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Conta da Baixa'
              ImageIndex = 0
              Value = 'B'
            end
            item
              Description = 'Conta do Cadastro'
              Value = 'C'
            end>
          Width = 82
          Position.BandIndex = 1
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_TPORID: TcxGridDBBandedColumn
          Caption = 'Tipo Ori. Deb.'
          DataBinding.FieldName = 'CON_TPORID'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Parcon'
              ImageIndex = 0
              Value = 'PR'
            end
            item
              Description = 'Cliente/Fornecedor'
              Value = 'CF'
            end
            item
              Description = 'Portador'
              Value = 'PT'
            end
            item
              Description = 'Bandeira'
              Value = 'BN'
            end
            item
              Description = 'Plano Contas'
              Value = 'PC'
            end
            item
              Description = 'Abrev. Prod.'
              Value = 'AB'
            end
            item
              Description = 'Configura'#231#227'o'
              Value = 'CN'
            end>
          Width = 68
          Position.BandIndex = 1
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_CDORID: TcxGridDBBandedColumn
          Caption = 'C'#243'digo Ori. Deb.'
          DataBinding.FieldName = 'CON_CDORID'
          PropertiesClassName = 'TcxButtonEditProperties'
          Properties.Buttons = <
            item
              Default = True
              Glyph.SourceDPI = 96
              Glyph.Data = {
                89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                6100000026744558745469746C650046696E643B426172733B526962626F6E3B
                5374616E646172643B536561726368BB659C08000002D149444154785EAD936D
                48936B18C7FF7B369FB5E3CB3C6AEACC66E66C94980AF6C1B74A462FE743E087
                2526299812C519A20B03C98A3AC9D2E8E518519F52222A2789ACF99264C58AD0
                322A848E9BBA6992D95496BACD3DDBF43EF7C62AE9ABFDE1C77D735DF7F5E7BA
                EEFB79788410FC2EF128020A4B09A230AB733FF8454CEDE54EFF7AF8EFC6CD6A
                4DFBA39A069DBDF282565F507A2AD96758A369939EB9D6ABAB6BEA75D55EE9D2
                A9EAEE487D466A4D07FC525FF46F84AAF3DA572F07C7C8F0E814B9DD6A20AA73
                5A0E40485D538F6BE0C3383159BE929B779F90AAFA760300BEEA6CDBCF2E9465
                F5F9FF5CEF21D3338BC43060240DD75BC9D1DA7B04C0969397F464F2CB376234
                5B49F3FD3EA23A7D8F9454DFC8FA3E0E43091286FD59BE4D168B2597070E9717
                939356184DA3D8B1F784D16432C3C97941C0032B12C2EB716085B01500F87E83
                2D698AE820365429A70636BB0B8B4E17161C2E78380F122591F0B8396ABA0CEF
                0A8150148C20FE0ABCCB284ECB514600E031F2F4FDF58A6CB9302E468CD4E418
                A46FDD88785FA1D78D71CB3838B71B3C1E81242A1407F2535176682FC0D9D689
                C2132E0010308C4054989F2547F7D31114553DC4DB8F56ECCE4D839B165A67A6
                C0D1B1A2C422E8FB465158A9C390D981A2821CDAA1BBC46FC0B9BCFCF03021BA
                0CA38854E4A17BC08CED294960593EC6FFD3FF151B17075FBEF38505EBF765A3
                67F013D25393E97D39F900186689B34F8E4DCC4091BB09F3AFFBB13B538A11F3
                17D817E626000C3916178C96092BF6E44961EB7F83FCCC784C4DCF8273DA2D00
                0833373D72B5B9F53912625834AA7642124CD0F2E031E667276E02B0DBAC9F2F
                B5689F214922C0BFD53990867970ABB9034EFBAC06808702B12C43A94EC93B36
                BC2DEF389165161B6365BB6A0044049E6A5D4A56E991949C8A77F2AC32929871
                F0BD44AE2807205AFD2DFC4189A66CA0C450820371040EB18198981242610371
                ACF96F64B046FD0FE22625E3DA6A63E80000000049454E44AE426082}
              Hint = 'Mostrar Cadastro'
              Kind = bkGlyph
            end>
          Properties.ReadOnly = True
          Properties.OnButtonClick = GridTableViewLanconCON_CDORIDPropertiesButtonClick
          Options.ShowEditButtons = isebAlways
          Width = 74
          Position.BandIndex = 1
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_OPBCDB: TcxGridDBBandedColumn
          Caption = 'Origem Deb.'
          DataBinding.FieldName = 'CON_OPBCDB'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Conta da Baixa'
              ImageIndex = 0
              Value = 'B'
            end
            item
              Description = 'Conta do Cadastro'
              Value = 'C'
            end>
          Width = 66
          Position.BandIndex = 1
          Position.ColIndex = 9
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_INCDOC: TcxGridDBBandedColumn
          Caption = 'Documento Vinculado'
          DataBinding.FieldName = 'CON_INCDOC'
          Visible = False
          Position.BandIndex = 1
          Position.ColIndex = 10
          Position.RowIndex = 0
        end
        object GridTableViewLanconCON_TABELA: TcxGridDBBandedColumn
          Caption = 'Tabela Doc. Vinculado'
          DataBinding.FieldName = 'CON_TABELA'
          Visible = False
          Width = 83
          Position.BandIndex = 1
          Position.ColIndex = 11
          Position.RowIndex = 0
        end
      end
      object GridLanconLevel: TcxGridLevel
        GridView = GridTableViewLancon
      end
    end
  end
  object gbInfoParametrizacao: TcxGroupBox [4]
    Left = 0
    Top = 578
    Align = alClient
    Caption = 'Informa'#231#227'o de parametriza'#231#227'o do registro'
    TabOrder = 4
    Height = 129
    Width = 1106
    object pgParcon: TcxPageControl
      Left = 2
      Top = 19
      Width = 1102
      Height = 108
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = tsBandeira
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 9
      Properties.TabSlants.Positions = [spLeft, spRight]
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = True
      TabSlants.Positions = [spLeft, spRight]
      ClientRectBottom = 108
      ClientRectRight = 1102
      ClientRectTop = 21
      object tsParcon: TcxTabSheet
        Caption = 'Par'#226'metro Cont'#225'bil'
        ImageIndex = 0
        object gbParconAtual: TcxGroupBox
          Left = 0
          Top = 0
          Align = alTop
          Caption = 'Par'#226'metro Atual'
          TabOrder = 0
          Height = 97
          Width = 1102
          object GridParcon: TcxGridCitel
            Left = 2
            Top = 19
            Width = 1098
            Height = 76
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewParcon: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewParconFocusedItemChanged
              DataController.DataSource = dsParcon
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Width = 3000
                end>
              object GridTableViewParconCON_SEQPAR: TcxGridDBBandedColumn
                Caption = 'Seq. Par'#226'metro Cont'#225'bil'
                DataBinding.FieldName = 'CON_SEQPAR'
                Width = 126
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_TIPLAN: TcxGridDBBandedColumn
                Caption = 'Tipo de Lancto'
                DataBinding.FieldName = 'CON_TIPLAN'
                Width = 76
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_FORPGO: TcxGridDBBandedColumn
                Caption = 'Forma de Pagamento'
                DataBinding.FieldName = 'CON_FORPGO'
                Width = 140
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_DESVAL: TcxGridDBBandedColumn
                Caption = 'Descri'#231#227'o Valor'
                DataBinding.FieldName = 'CON_DESVAL'
                Width = 142
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_CLAFIS: TcxGridDBBandedColumn
                Caption = 'CLAFIS'
                DataBinding.FieldName = 'CON_CLAFIS'
                Width = 68
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_NATCFO: TcxGridDBBandedColumn
                Caption = 'Natureza de Opera'#231#227'o'
                DataBinding.FieldName = 'CON_NATCFO'
                Width = 123
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_PAGAME: TcxGridDBBandedColumn
                Caption = 'Pagamentos'
                DataBinding.FieldName = 'CON_PAGAME'
                Width = 166
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_NATOPE: TcxGridDBBandedColumn
                Caption = 'Condi'#231#227'o de Pagamento'
                DataBinding.FieldName = 'CON_NATOPE'
                Width = 175
                Position.BandIndex = 0
                Position.ColIndex = 7
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_CONDEB: TcxGridDBBandedColumn
                Caption = 'Conta de D'#233'bito'
                DataBinding.FieldName = 'CON_CONDEB'
                PropertiesClassName = 'TcxMaskEditProperties'
                Width = 94
                Position.BandIndex = 0
                Position.ColIndex = 8
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_CFDEBI: TcxGridDBBandedColumn
                Caption = 'Cli/For D'#233'bito'
                DataBinding.FieldName = 'CON_CFDEBI'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 100
                Position.BandIndex = 0
                Position.ColIndex = 9
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_PORDEB: TcxGridDBBandedColumn
                Caption = 'Portador D'#233'bito'
                DataBinding.FieldName = 'CON_PORDEB'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 96
                Position.BandIndex = 0
                Position.ColIndex = 10
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_PCDEBI: TcxGridDBBandedColumn
                Caption = 'Plano de Contas D'#233'bito'
                DataBinding.FieldName = 'CON_PCDEBI'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 117
                Position.BandIndex = 0
                Position.ColIndex = 11
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_BANDEB: TcxGridDBBandedColumn
                Caption = 'Bandeira D'#233'bito'
                DataBinding.FieldName = 'CON_BANDEB'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 97
                Position.BandIndex = 0
                Position.ColIndex = 12
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_ABFDEB: TcxGridDBBandedColumn
                Caption = 'Abrev. Prod. D'#233'bito'
                DataBinding.FieldName = 'CON_ABFDEB'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 95
                Position.BandIndex = 0
                Position.ColIndex = 13
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_TIPPCD: TcxGridDBBandedColumn
                Caption = 'Considerar D'#233'bito'
                DataBinding.FieldName = 'CON_TIPPCD'
                PropertiesClassName = 'TcxRadioGroupProperties'
                Properties.Columns = 2
                Properties.Items = <
                  item
                    Caption = 'Baixa'
                    Value = 'B'
                  end
                  item
                    Caption = 'Cadastro'
                    Value = 'C'
                  end>
                Width = 134
                Position.BandIndex = 0
                Position.ColIndex = 14
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_CONCRE: TcxGridDBBandedColumn
                Caption = 'Conta de Cr'#233'dito'
                DataBinding.FieldName = 'CON_CONCRE'
                PropertiesClassName = 'TcxMaskEditProperties'
                Width = 95
                Position.BandIndex = 0
                Position.ColIndex = 15
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_CFCRED: TcxGridDBBandedColumn
                Caption = 'Cli/For Cr'#233'dito'
                DataBinding.FieldName = 'CON_CFCRED'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 101
                Position.BandIndex = 0
                Position.ColIndex = 16
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_PORCRE: TcxGridDBBandedColumn
                Caption = 'Portador Cr'#233'dito'
                DataBinding.FieldName = 'CON_PORCRE'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 90
                Position.BandIndex = 0
                Position.ColIndex = 17
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_PCCRED: TcxGridDBBandedColumn
                Caption = 'Plano de Contas Cr'#233'dito'
                DataBinding.FieldName = 'CON_PCCRED'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 121
                Position.BandIndex = 0
                Position.ColIndex = 18
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_BANCRE: TcxGridDBBandedColumn
                Caption = 'Bandeira Cr'#233'dito'
                DataBinding.FieldName = 'CON_BANCRE'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 90
                Position.BandIndex = 0
                Position.ColIndex = 19
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_ABFCRE: TcxGridDBBandedColumn
                Caption = 'Abrev. Prod. Cr'#233'dito'
                DataBinding.FieldName = 'CON_ABFCRE'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = '1'
                Properties.ValueUnchecked = '0'
                Width = 104
                Position.BandIndex = 0
                Position.ColIndex = 20
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_TIPPCC: TcxGridDBBandedColumn
                Caption = 'Considerar Cr'#233'dito'
                DataBinding.FieldName = 'CON_TIPPCC'
                PropertiesClassName = 'TcxRadioGroupProperties'
                Properties.Columns = 2
                Properties.Items = <
                  item
                    Caption = 'Baixa'
                    Value = 'B'
                  end
                  item
                    Caption = 'Cadastro'
                    Value = 'C'
                  end>
                Width = 133
                Position.BandIndex = 0
                Position.ColIndex = 21
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_ORIGEM: TcxGridDBBandedColumn
                Caption = 'Origem'
                DataBinding.FieldName = 'CON_ORIGEM'
                Width = 85
                Position.BandIndex = 0
                Position.ColIndex = 22
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_PAGANT: TcxGridDBBandedColumn
                Caption = 'Adiantamento'
                DataBinding.FieldName = 'CON_PAGANT'
                Width = 93
                Position.BandIndex = 0
                Position.ColIndex = 23
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_TITPDD: TcxGridDBBandedColumn
                Caption = 'T'#237'tulos PDD'
                DataBinding.FieldName = 'CON_TITPDD'
                Width = 81
                Position.BandIndex = 0
                Position.ColIndex = 24
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'CON_CODEMP'
                Width = 85
                Position.BandIndex = 0
                Position.ColIndex = 25
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_VIGINI: TcxGridDBBandedColumn
                Caption = 'Vig'#234'ncia In'#237'cio'
                DataBinding.FieldName = 'CON_VIGINI'
                Width = 86
                Position.BandIndex = 0
                Position.ColIndex = 26
                Position.RowIndex = 0
              end
              object GridTableViewParconCON_VIGFIN: TcxGridDBBandedColumn
                Caption = 'Vig'#234'ncia Final'
                DataBinding.FieldName = 'CON_VIGFIN'
                Width = 87
                Position.BandIndex = 0
                Position.ColIndex = 27
                Position.RowIndex = 0
              end
            end
            object GridParconLevel: TcxGridLevel
              GridView = GridTableViewParcon
            end
          end
        end
        object gbParconLog: TcxGroupBox
          Left = 0
          Top = 97
          Align = alClient
          Caption = 'Log de Altera'#231#245'es'
          TabOrder = 1
          Height = 70
          Width = 1102
          object GridParconLog: TcxGridCitel
            Left = 2
            Top = 19
            Width = 1098
            Height = 49
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewParconLog: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewParconLogFocusedItemChanged
              DataController.DataSource = dsParconLog
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnSorting = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Caption = 'Info. Log'
                  FixedKind = fkLeft
                  Width = 485
                end
                item
                  Caption = 'Info. Dados'
                  Width = 3000
                end>
              object GridTableViewParconLogLOG_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'LOG_CODEMP'
                Width = 52
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewParconLogLOG_DTAALT: TcxGridDBBandedColumn
                Caption = 'Dta. Log'
                DataBinding.FieldName = 'LOG_DTAALT'
                Width = 65
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewParconLogLOG_HRAALT: TcxGridDBBandedColumn
                Caption = 'Hora Log'
                DataBinding.FieldName = 'LOG_HRAALT'
                Width = 68
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewParconLogLOG_CODOPE: TcxGridDBBandedColumn
                Caption = 'Operador'
                DataBinding.FieldName = 'LOG_CODOPE'
                Width = 63
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewParconLogLOG_TIPAJU: TcxGridDBBandedColumn
                Caption = 'Tipo Ajuste'
                DataBinding.FieldName = 'LOG_TIPAJU'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'Inclus'#227'o'
                    ImageIndex = 0
                    Value = 'INC'
                  end
                  item
                    Description = 'Exclus'#227'o'
                    Value = 'EXC'
                  end
                  item
                    Description = 'Alt. Anterior'
                    Value = 'ALT-ANT'
                  end
                  item
                    Description = 'Alt. Atual'
                    Value = 'ALT-ATU'
                  end>
                Width = 82
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object GridTableViewParconLogLOG_NOMFRM: TcxGridDBBandedColumn
                Caption = 'Formul'#225'rio/M'#243'dulo'
                DataBinding.FieldName = 'LOG_NOMFRM'
                Width = 155
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object GridTableViewParconLogLOG_SEQAJU: TcxGridDBBandedColumn
                Caption = 'Log Seq. Ajuste'
                DataBinding.FieldName = 'LOG_SEQAJU'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object GridTableViewParconLogLOG_INCDOC: TcxGridDBBandedColumn
                Caption = 'Log Info. Doc.'
                DataBinding.FieldName = 'LOG_INCDOC'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 7
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_SEQPAR: TcxGridDBBandedColumn
                Caption = 'Seq. Par'#226'metro Cont'#225'bil'
                DataBinding.FieldName = 'CON_SEQPAR'
                Width = 126
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_TIPLAN: TcxGridDBBandedColumn
                Caption = 'Tipo de Lancto'
                DataBinding.FieldName = 'CON_TIPLAN'
                Width = 76
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_FORPGO: TcxGridDBBandedColumn
                Caption = 'Forma de Pagamento'
                DataBinding.FieldName = 'CON_FORPGO'
                Width = 140
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_DESVAL: TcxGridDBBandedColumn
                Caption = 'Descri'#231#227'o Valor'
                DataBinding.FieldName = 'CON_DESVAL'
                Width = 142
                Position.BandIndex = 1
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_CLAFIS: TcxGridDBBandedColumn
                Caption = 'CLAFIS'
                DataBinding.FieldName = 'CON_CLAFIS'
                Width = 68
                Position.BandIndex = 1
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_NATCFO: TcxGridDBBandedColumn
                Caption = 'Natureza de Opera'#231#227'o'
                DataBinding.FieldName = 'CON_NATCFO'
                Width = 123
                Position.BandIndex = 1
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_PAGAME: TcxGridDBBandedColumn
                Caption = 'Pagamentos'
                DataBinding.FieldName = 'CON_PAGAME'
                Width = 166
                Position.BandIndex = 1
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_NATOPE: TcxGridDBBandedColumn
                Caption = 'Condi'#231#227'o de Pagamento'
                DataBinding.FieldName = 'CON_NATOPE'
                Width = 175
                Position.BandIndex = 1
                Position.ColIndex = 7
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_CONDEB: TcxGridDBBandedColumn
                Caption = 'Conta de D'#233'bito'
                DataBinding.FieldName = 'CON_CONDEB'
                Width = 94
                Position.BandIndex = 1
                Position.ColIndex = 8
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_CFDEBI: TcxGridDBBandedColumn
                Caption = 'Cli/For D'#233'bito'
                DataBinding.FieldName = 'CON_CFDEBI'
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 9
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_PORDEB: TcxGridDBBandedColumn
                Caption = 'Portador D'#233'bito'
                DataBinding.FieldName = 'CON_PORDEB'
                Width = 96
                Position.BandIndex = 1
                Position.ColIndex = 10
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_PCDEBI: TcxGridDBBandedColumn
                Caption = 'Plano de Contas D'#233'bito'
                DataBinding.FieldName = 'CON_PCDEBI'
                Width = 117
                Position.BandIndex = 1
                Position.ColIndex = 11
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_BANDEB: TcxGridDBBandedColumn
                Caption = 'Bandeira D'#233'bito'
                DataBinding.FieldName = 'CON_BANDEB'
                Width = 97
                Position.BandIndex = 1
                Position.ColIndex = 12
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_ABFDEB: TcxGridDBBandedColumn
                Caption = 'Abrev. Prod. D'#233'bito'
                DataBinding.FieldName = 'CON_ABFDEB'
                Width = 95
                Position.BandIndex = 1
                Position.ColIndex = 13
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_TIPPCD: TcxGridDBBandedColumn
                Caption = 'Considerar D'#233'bito'
                DataBinding.FieldName = 'CON_TIPPCD'
                Width = 134
                Position.BandIndex = 1
                Position.ColIndex = 14
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_CONCRE: TcxGridDBBandedColumn
                Caption = 'Conta de Cr'#233'dito'
                DataBinding.FieldName = 'CON_CONCRE'
                Width = 101
                Position.BandIndex = 1
                Position.ColIndex = 15
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_CFCRED: TcxGridDBBandedColumn
                Caption = 'Cli/For Cr'#233'dito'
                DataBinding.FieldName = 'CON_CFCRED'
                Width = 101
                Position.BandIndex = 1
                Position.ColIndex = 16
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_PORCRE: TcxGridDBBandedColumn
                Caption = 'Portador Cr'#233'dito'
                DataBinding.FieldName = 'CON_PORCRE'
                Width = 90
                Position.BandIndex = 1
                Position.ColIndex = 17
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_PCCRED: TcxGridDBBandedColumn
                Caption = 'Plano de Contas Cr'#233'dito'
                DataBinding.FieldName = 'CON_PCCRED'
                Width = 121
                Position.BandIndex = 1
                Position.ColIndex = 18
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_BANCRE: TcxGridDBBandedColumn
                Caption = 'Bandeira Cr'#233'dito'
                DataBinding.FieldName = 'CON_BANCRE'
                Width = 90
                Position.BandIndex = 1
                Position.ColIndex = 19
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_ABFCRE: TcxGridDBBandedColumn
                Caption = 'Abrev. Prod. Cr'#233'dito'
                DataBinding.FieldName = 'CON_ABFCRE'
                Width = 104
                Position.BandIndex = 1
                Position.ColIndex = 20
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_TIPPCC: TcxGridDBBandedColumn
                Caption = 'Considerar Cr'#233'dito'
                DataBinding.FieldName = 'CON_TIPPCC'
                Width = 133
                Position.BandIndex = 1
                Position.ColIndex = 21
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_ORIGEM: TcxGridDBBandedColumn
                Caption = 'Origem'
                DataBinding.FieldName = 'CON_ORIGEM'
                Width = 85
                Position.BandIndex = 1
                Position.ColIndex = 22
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_PAGANT: TcxGridDBBandedColumn
                Caption = 'Adiantamento'
                DataBinding.FieldName = 'CON_PAGANT'
                Width = 93
                Position.BandIndex = 1
                Position.ColIndex = 23
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_TITPDD: TcxGridDBBandedColumn
                Caption = 'T'#237'tulos PDD'
                DataBinding.FieldName = 'CON_TITPDD'
                Width = 81
                Position.BandIndex = 1
                Position.ColIndex = 24
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'CON_CODEMP'
                Width = 85
                Position.BandIndex = 1
                Position.ColIndex = 25
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_VIGINI: TcxGridDBBandedColumn
                Caption = 'Vig'#234'ncia In'#237'cio'
                DataBinding.FieldName = 'CON_VIGINI'
                Width = 86
                Position.BandIndex = 1
                Position.ColIndex = 26
                Position.RowIndex = 0
              end
              object GridTableViewParconLogCON_VIGFIN: TcxGridDBBandedColumn
                Caption = 'Vig'#234'ncia Final'
                DataBinding.FieldName = 'CON_VIGFIN'
                Width = 87
                Position.BandIndex = 1
                Position.ColIndex = 27
                Position.RowIndex = 0
              end
            end
            object GridParconLogLevel: TcxGridLevel
              GridView = GridTableViewParconLog
            end
          end
        end
      end
      object tsComplemento: TcxTabSheet
        Caption = 'Complemento Hist'#243'rico'
        ImageIndex = 1
        object gbCmpPar: TcxGroupBox
          Left = 0
          Top = 0
          Align = alLeft
          Caption = 'Complemento(s) Atual(is)'
          TabOrder = 0
          Height = 87
          Width = 481
          object GridCmpPar: TcxGridCitel
            Left = 2
            Top = 19
            Width = 477
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewCmpPar: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewCmpParFocusedItemChanged
              DataController.DataSource = dsCmpPar
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Width = 455
                end>
              object GridTableViewCmpParAUTOINCREM: TcxGridDBBandedColumn
                Caption = 'Autoincrem'
                DataBinding.FieldName = 'AUTOINCREM'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewCmpParPAR_SEQPAR: TcxGridDBBandedColumn
                Caption = 'Seq. Par'#226'metro Cont'#225'bil'
                DataBinding.FieldName = 'PAR_SEQPAR'
                Width = 81
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewCmpParPAR_MD5KEY: TcxGridDBBandedColumn
                Caption = 'Md5 Key'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewCmpParPAR_COMPLE: TcxGridDBBandedColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'PAR_COMPLE'
                Width = 374
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
            end
            object GridCmpParLevel: TcxGridLevel
              GridView = GridTableViewCmpPar
            end
          end
        end
        object gbCmpParLog: TcxGroupBox
          Left = 481
          Top = 0
          Align = alClient
          Caption = 'Log de Altera'#231#245'es'
          TabOrder = 1
          Height = 87
          Width = 621
          object GridCmpParLog: TcxGridCitel
            Left = 2
            Top = 19
            Width = 617
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewCmpParLog: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewCmpParLogFocusedItemChanged
              DataController.DataSource = dsCmpParLog
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnSorting = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Caption = 'Info. Log'
                  FixedKind = fkLeft
                  Width = 485
                end
                item
                  Caption = 'Info. Dados'
                  Width = 680
                end>
              object GridTableViewCmpParLogLOG_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'LOG_CODEMP'
                Width = 52
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewCmpParLogLOG_DTAALT: TcxGridDBBandedColumn
                Caption = 'Dta. Log'
                DataBinding.FieldName = 'LOG_DTAALT'
                Width = 65
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewCmpParLogLOG_HRAALT: TcxGridDBBandedColumn
                Caption = 'Hora Log'
                DataBinding.FieldName = 'LOG_HRAALT'
                Width = 68
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewCmpParLogLOG_CODOPE: TcxGridDBBandedColumn
                Caption = 'Operador'
                DataBinding.FieldName = 'LOG_CODOPE'
                Width = 63
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewCmpParLogLOG_TIPAJU: TcxGridDBBandedColumn
                Caption = 'Tipo Ajuste'
                DataBinding.FieldName = 'LOG_TIPAJU'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'Inclus'#227'o'
                    ImageIndex = 0
                    Value = 'INC'
                  end
                  item
                    Description = 'Exclus'#227'o'
                    Value = 'EXC'
                  end
                  item
                    Description = 'Alt. Anterior'
                    Value = 'ALT-ANT'
                  end
                  item
                    Description = 'Alt. Atual'
                    Value = 'ALT-ATU'
                  end>
                Width = 82
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object GridTableViewCmpParLogLOG_NOMFRM: TcxGridDBBandedColumn
                Caption = 'Formul'#225'rio/M'#243'dulo'
                DataBinding.FieldName = 'LOG_NOMFRM'
                Width = 155
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object GridTableViewCmpParLogLOG_SEQAJU: TcxGridDBBandedColumn
                Caption = 'Log Seq. Ajuste'
                DataBinding.FieldName = 'LOG_SEQAJU'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object GridTableViewCmpParLogLOG_INCDOC: TcxGridDBBandedColumn
                Caption = 'Log Info. Doc.'
                DataBinding.FieldName = 'LOG_INCDOC'
                Visible = False
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewCmpParLogAUTOINCREM: TcxGridDBBandedColumn
                Caption = 'Autoincrem'
                DataBinding.FieldName = 'AUTOINCREM'
                Visible = False
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewCmpParLogPAR_SEQPAR: TcxGridDBBandedColumn
                Caption = 'Seq. Par'#226'metro Cont'#225'bil'
                DataBinding.FieldName = 'PAR_SEQPAR'
                Width = 135
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewCmpParLogPAR_MD5KEY: TcxGridDBBandedColumn
                Caption = 'MD5 key'
                DataBinding.FieldName = 'PAR_MD5KEY'
                Visible = False
                Position.BandIndex = 1
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewCmpParLogPAR_COMPLE: TcxGridDBBandedColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'PAR_COMPLE'
                Width = 545
                Position.BandIndex = 1
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
            end
            object GridCmpParLogLevel: TcxGridLevel
              GridView = GridTableViewCmpParLog
            end
          end
        end
      end
      object tsContasPorEmpresa: TcxTabSheet
        Caption = 'Contas Por Empresa'
        ImageIndex = 2
        object gbParNco: TcxGroupBox
          Left = 0
          Top = 0
          Align = alLeft
          Caption = 'Conta(s) Atual(is)'
          TabOrder = 0
          Height = 87
          Width = 481
          object GridParNco: TcxGridCitel
            Left = 2
            Top = 19
            Width = 477
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewParNco: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewParNcoFocusedItemChanged
              DataController.DataSource = dsParNco
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Width = 455
                end>
              object GridTableViewParNcoCON_SEQPAR: TcxGridDBBandedColumn
                Caption = 'Seq. Par'#226'metro Cont'#225'bil'
                DataBinding.FieldName = 'CON_SEQPAR'
                Width = 82
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewParNcoNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Width = 125
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewParNcoNCO_CREDEB: TcxGridDBBandedColumn
                Caption = 'Tipo'
                DataBinding.FieldName = 'NCO_CREDEB'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'Cr'#233'dito'
                    ImageIndex = 0
                    Value = 'C'
                  end
                  item
                    Description = 'D'#233'bito'
                    Value = 'D'
                  end>
                Width = 123
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewParNcoNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Width = 125
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object GridTableViewParNcoNCO_MD5KEY: TcxGridDBBandedColumn
                Caption = 'Md5 Key'
                DataBinding.FieldName = 'NCO_MD5KEY'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
            end
            object GridParNcoLevel: TcxGridLevel
              GridView = GridTableViewParNco
            end
          end
        end
        object gbParNcoLog: TcxGroupBox
          Left = 481
          Top = 0
          Align = alClient
          Caption = 'Log de Altera'#231#245'es'
          TabOrder = 1
          Height = 87
          Width = 621
          object GridParNcoLog: TcxGridCitel
            Left = 2
            Top = 19
            Width = 617
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewParNcoLog: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewParNcoLogFocusedItemChanged
              DataController.DataSource = dsParNcoLog
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnSorting = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Caption = 'Info. Log'
                  FixedKind = fkLeft
                  Width = 485
                end
                item
                  Caption = 'Info Dados'
                  Width = 680
                end>
              object GridTableViewParNcoLogLOG_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'LOG_CODEMP'
                Width = 52
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewParNcoLogLOG_DTAALT: TcxGridDBBandedColumn
                Caption = 'Dta. Log'
                DataBinding.FieldName = 'LOG_DTAALT'
                Width = 65
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewParNcoLogLOG_HRAALT: TcxGridDBBandedColumn
                Caption = 'Hora Log'
                DataBinding.FieldName = 'LOG_HRAALT'
                Width = 68
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewParNcoLogLOG_CODOPE: TcxGridDBBandedColumn
                Caption = 'Operador'
                DataBinding.FieldName = 'LOG_CODOPE'
                Width = 63
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewParNcoLogLOG_TIPAJU: TcxGridDBBandedColumn
                Caption = 'Tipo Ajuste'
                DataBinding.FieldName = 'LOG_TIPAJU'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'Inclus'#227'o'
                    ImageIndex = 0
                    Value = 'INC'
                  end
                  item
                    Description = 'Exclus'#227'o'
                    Value = 'EXC'
                  end
                  item
                    Description = 'Alt. Anterior'
                    Value = 'ALT-ANT'
                  end
                  item
                    Description = 'Alt. Atual'
                    Value = 'ALT-ATU'
                  end>
                Width = 82
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object GridTableViewParNcoLogLOG_NOMFRM: TcxGridDBBandedColumn
                Caption = 'Formul'#225'rio/M'#243'dulo'
                DataBinding.FieldName = 'LOG_NOMFRM'
                Width = 155
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object GridTableViewParNcoLogLOG_SEQAJU: TcxGridDBBandedColumn
                Caption = 'Log Seq. Ajuste'
                DataBinding.FieldName = 'LOG_SEQAJU'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object GridTableViewParNcoLogCON_SEQPAR: TcxGridDBBandedColumn
                Caption = 'Seq. Par'#226'metro Cont'#225'bil'
                DataBinding.FieldName = 'CON_SEQPAR'
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewParNcoLogNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewParNcoLogNCO_CREDEB: TcxGridDBBandedColumn
                Caption = 'Tipo'
                DataBinding.FieldName = 'NCO_CREDEB'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'Cr'#233'dito'
                    ImageIndex = 0
                    Value = 'C'
                  end
                  item
                    Description = 'D'#233'bito'
                    Value = 'D'
                  end>
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewParNcoLogNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Position.BandIndex = 1
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
            end
            object GridParNcoLogLevel: TcxGridLevel
              GridView = GridTableViewParNcoLog
            end
          end
        end
      end
      object tsPortador: TcxTabSheet
        Caption = 'Portador'
        ImageIndex = 3
        object gbPorNco: TcxGroupBox
          Left = 0
          Top = 0
          Align = alLeft
          Caption = 'Conta(s) Atual(is)'
          TabOrder = 0
          Height = 87
          Width = 481
          object GridPorNco: TcxGridCitel
            Left = 2
            Top = 19
            Width = 477
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewPorNco: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewPorNcoFocusedItemChanged
              DataController.DataSource = dsPorNco
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Width = 455
                end>
              object GridTableViewPorNcoNCO_CODPOR: TcxGridDBBandedColumn
                Caption = 'Portador'
                DataBinding.FieldName = 'NCO_CODPOR'
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewPorNcoNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewPorNcoNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
            end
            object GridPorNcoLevel: TcxGridLevel
              GridView = GridTableViewPorNco
            end
          end
        end
        object gbPorNcoLog: TcxGroupBox
          Left = 481
          Top = 0
          Align = alClient
          Caption = 'Log de Altera'#231#245'es'
          TabOrder = 1
          Height = 87
          Width = 621
          object GridPorNcoLog: TcxGridCitel
            Left = 2
            Top = 19
            Width = 617
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewPorNcoLog: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewPorNcoLogFocusedItemChanged
              DataController.DataSource = dsPorNcoLog
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnSorting = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Caption = 'Info. Log'
                  FixedKind = fkLeft
                  Width = 485
                end
                item
                  Caption = 'Info Dados'
                  Width = 680
                end>
              object GridTableViewPorNcoLogLOG_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'LOG_CODEMP'
                Width = 52
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewPorNcoLogLOG_DTAALT: TcxGridDBBandedColumn
                Caption = 'Dta. Log'
                DataBinding.FieldName = 'LOG_DTAALT'
                Width = 65
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewPorNcoLogLOG_HRAALT: TcxGridDBBandedColumn
                Caption = 'Hora Log'
                DataBinding.FieldName = 'LOG_HRAALT'
                Width = 68
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewPorNcoLogLOG_CODOPE: TcxGridDBBandedColumn
                Caption = 'Operador'
                DataBinding.FieldName = 'LOG_CODOPE'
                Width = 63
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewPorNcoLogLOG_TIPAJU: TcxGridDBBandedColumn
                Caption = 'Tipo Ajuste'
                DataBinding.FieldName = 'LOG_TIPAJU'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'Inclus'#227'o'
                    ImageIndex = 0
                    Value = 'INC'
                  end
                  item
                    Description = 'Exclus'#227'o'
                    Value = 'EXC'
                  end
                  item
                    Description = 'Alt. Anterior'
                    Value = 'ALT-ANT'
                  end
                  item
                    Description = 'Alt. Atual'
                    Value = 'ALT-ATU'
                  end>
                Width = 82
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object GridTableViewPorNcoLogLOG_NOMFRM: TcxGridDBBandedColumn
                Caption = 'Formul'#225'rio/M'#243'dulo'
                DataBinding.FieldName = 'LOG_NOMFRM'
                Width = 155
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object GridTableViewPorNcoLogLOG_SEQAJU: TcxGridDBBandedColumn
                Caption = 'Log Seq. Ajuste'
                DataBinding.FieldName = 'LOG_SEQAJU'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object GridTableViewPorNcoLogNCO_CODPOR: TcxGridDBBandedColumn
                Caption = 'Portador'
                DataBinding.FieldName = 'NCO_CODPOR'
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewPorNcoLogNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewPorNcoLogNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
            end
            object GridPorNcoLogLevel: TcxGridLevel
              GridView = GridTableViewPorNcoLog
            end
          end
        end
      end
      object tsPlanoContas: TcxTabSheet
        Caption = 'Plano Contas Fin.'
        ImageIndex = 4
        object gbCtaNco: TcxGroupBox
          Left = 0
          Top = 0
          Align = alLeft
          Caption = 'Conta(s) Atual(is)'
          TabOrder = 0
          Height = 87
          Width = 481
          object GridCtaNco: TcxGridCitel
            Left = 2
            Top = 19
            Width = 477
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewCtaNco: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewCtaNcoFocusedItemChanged
              DataController.DataSource = dsCtaNco
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Width = 455
                end>
              object GridTableViewCtaNcoNCO_CODCTA: TcxGridDBBandedColumn
                Caption = 'Plano Conta'
                DataBinding.FieldName = 'NCO_CODCTA'
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewCtaNcoNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewCtaNcoNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
            end
            object GridCtaNcoLevel: TcxGridLevel
              GridView = GridTableViewCtaNco
            end
          end
        end
        object gbCtaNcoLog: TcxGroupBox
          Left = 481
          Top = 0
          Align = alClient
          Caption = 'Log de Altera'#231#245'es'
          TabOrder = 1
          Height = 87
          Width = 621
          object GridCtaNcoLog: TcxGridCitel
            Left = 2
            Top = 19
            Width = 617
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewCtaNcoLog: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewCtaNcoLogFocusedItemChanged
              DataController.DataSource = dsCtaNcoLog
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnSorting = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Caption = 'Info. Log'
                  FixedKind = fkLeft
                  Width = 485
                end
                item
                  Caption = 'Info Dados'
                  Width = 680
                end>
              object GridTableViewCtaNcoLogLOG_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'LOG_CODEMP'
                Width = 52
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewCtaNcoLogLOG_DTAALT: TcxGridDBBandedColumn
                Caption = 'Dta. Log'
                DataBinding.FieldName = 'LOG_DTAALT'
                Width = 65
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewCtaNcoLogLOG_HRAALT: TcxGridDBBandedColumn
                Caption = 'Hora Log'
                DataBinding.FieldName = 'LOG_HRAALT'
                Width = 68
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewCtaNcoLogLOG_CODOPE: TcxGridDBBandedColumn
                Caption = 'Operador'
                DataBinding.FieldName = 'LOG_CODOPE'
                Width = 63
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewCtaNcoLogLOG_TIPAJU: TcxGridDBBandedColumn
                Caption = 'Tipo Ajuste'
                DataBinding.FieldName = 'LOG_TIPAJU'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'Inclus'#227'o'
                    ImageIndex = 0
                    Value = 'INC'
                  end
                  item
                    Description = 'Exclus'#227'o'
                    Value = 'EXC'
                  end
                  item
                    Description = 'Alt. Anterior'
                    Value = 'ALT-ANT'
                  end
                  item
                    Description = 'Alt. Atual'
                    Value = 'ALT-ATU'
                  end>
                Width = 82
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object GridTableViewCtaNcoLogLOG_NOMFRM: TcxGridDBBandedColumn
                Caption = 'Formul'#225'rio/M'#243'dulo'
                DataBinding.FieldName = 'LOG_NOMFRM'
                Width = 155
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object GridTableViewCtaNcoLogLOG_SEQAJU: TcxGridDBBandedColumn
                Caption = 'Log Seq. Ajuste'
                DataBinding.FieldName = 'LOG_SEQAJU'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object GridTableViewCtaNcoLogNCO_CODCTA: TcxGridDBBandedColumn
                Caption = 'Plano Conta'
                DataBinding.FieldName = 'NCO_CODCTA'
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewCtaNcoLogNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewCtaNcoLogNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
            end
            object GridCtaNcoLogLevel: TcxGridLevel
              GridView = GridTableViewCtaNcoLog
            end
          end
        end
      end
      object tsCliente: TcxTabSheet
        Caption = 'Cliente'
        ImageIndex = 5
        object gbCliNco: TcxGroupBox
          Left = 0
          Top = 0
          Align = alLeft
          Caption = 'Conta(s) Atual(is)'
          TabOrder = 0
          Height = 87
          Width = 481
          object GridCliNco: TcxGridCitel
            Left = 2
            Top = 19
            Width = 477
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewCliNco: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewCliNcoFocusedItemChanged
              DataController.DataSource = dsCliNco
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Width = 455
                end>
              object GridTableViewCliNcoNCO_CODCLI: TcxGridDBBandedColumn
                Caption = 'Cliente'
                DataBinding.FieldName = 'NCO_CODCLI'
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewCliNcoNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewCliNcoNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
            end
            object GridCliNcoLevel: TcxGridLevel
              GridView = GridTableViewCliNco
            end
          end
        end
        object gbCliNcoLog: TcxGroupBox
          Left = 481
          Top = 0
          Align = alClient
          Caption = 'Log de Altera'#231#245'es'
          TabOrder = 1
          Height = 87
          Width = 621
          object GridCliNcoLog: TcxGridCitel
            Left = 2
            Top = 19
            Width = 617
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewCliNcoLog: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewCliNcoLogFocusedItemChanged
              DataController.DataSource = dsCliNcoLog
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnSorting = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Caption = 'Info. Log'
                  FixedKind = fkLeft
                  Width = 485
                end
                item
                  Caption = 'Info Dados'
                  Width = 680
                end>
              object GridTableViewCliNcoLogLOG_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'LOG_CODEMP'
                Width = 52
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewCliNcoLogLOG_DTAALT: TcxGridDBBandedColumn
                Caption = 'Dta. Log'
                DataBinding.FieldName = 'LOG_DTAALT'
                Width = 65
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewCliNcoLogLOG_HRAALT: TcxGridDBBandedColumn
                Caption = 'Hora Log'
                DataBinding.FieldName = 'LOG_HRAALT'
                Width = 68
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewCliNcoLogLOG_CODOPE: TcxGridDBBandedColumn
                Caption = 'Operador'
                DataBinding.FieldName = 'LOG_CODOPE'
                Width = 63
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewCliNcoLogLOG_TIPAJU: TcxGridDBBandedColumn
                Caption = 'Tipo Ajuste'
                DataBinding.FieldName = 'LOG_TIPAJU'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'Inclus'#227'o'
                    ImageIndex = 0
                    Value = 'INC'
                  end
                  item
                    Description = 'Exclus'#227'o'
                    Value = 'EXC'
                  end
                  item
                    Description = 'Alt. Anterior'
                    Value = 'ALT-ANT'
                  end
                  item
                    Description = 'Alt. Atual'
                    Value = 'ALT-ATU'
                  end>
                Width = 82
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object GridTableViewCliNcoLogLOG_NOMFRM: TcxGridDBBandedColumn
                Caption = 'Formul'#225'rio/M'#243'dulo'
                DataBinding.FieldName = 'LOG_NOMFRM'
                Width = 155
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object GridTableViewCliNcoLogLOG_SEQAJU: TcxGridDBBandedColumn
                Caption = 'Log Seq. Ajuste'
                DataBinding.FieldName = 'LOG_SEQAJU'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object GridTableViewCliNcoLogNCO_CODCLI: TcxGridDBBandedColumn
                Caption = 'Cliente'
                DataBinding.FieldName = 'NCO_CODCLI'
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewCliNcoLogNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewCliNcoLogNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
            end
            object GridCliNcoLogLevel: TcxGridLevel
              GridView = GridTableViewCliNcoLog
            end
          end
        end
      end
      object tsFornecedor: TcxTabSheet
        Caption = 'Fornecedor'
        ImageIndex = 6
        object gbForNco: TcxGroupBox
          Left = 0
          Top = 0
          Align = alLeft
          Caption = 'Conta(s) Atual(is)'
          TabOrder = 0
          Height = 87
          Width = 481
          object GridForNco: TcxGridCitel
            Left = 2
            Top = 19
            Width = 477
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewForNco: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewForNcoFocusedItemChanged
              DataController.DataSource = dsForNco
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Width = 455
                end>
              object GridTableViewForNcoNCO_CODFOR: TcxGridDBBandedColumn
                Caption = 'Fornecedor'
                DataBinding.FieldName = 'NCO_CODFOR'
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewForNcoNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewForNcoNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
            end
            object GridForNcoLevel: TcxGridLevel
              GridView = GridTableViewForNco
            end
          end
        end
        object gbForNcoLog: TcxGroupBox
          Left = 481
          Top = 0
          Align = alClient
          Caption = 'Log de Altera'#231#245'es'
          TabOrder = 1
          Height = 87
          Width = 621
          object GridForNcoLog: TcxGridCitel
            Left = 2
            Top = 19
            Width = 617
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewForNcoLog: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewForNcoLogFocusedItemChanged
              DataController.DataSource = dsForNcoLog
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnSorting = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Caption = 'Info. Log'
                  FixedKind = fkLeft
                  Width = 485
                end
                item
                  Caption = 'Info Dados'
                  Width = 680
                end>
              object GridTableViewForNcoLogLOG_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'LOG_CODEMP'
                Width = 52
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewForNcoLogLOG_DTAALT: TcxGridDBBandedColumn
                Caption = 'Dta. Log'
                DataBinding.FieldName = 'LOG_DTAALT'
                Width = 65
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewForNcoLogLOG_HRAALT: TcxGridDBBandedColumn
                Caption = 'Hora Log'
                DataBinding.FieldName = 'LOG_HRAALT'
                Width = 68
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewForNcoLogLOG_CODOPE: TcxGridDBBandedColumn
                Caption = 'Operador'
                DataBinding.FieldName = 'LOG_CODOPE'
                Width = 63
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewForNcoLogLOG_TIPAJU: TcxGridDBBandedColumn
                Caption = 'Tipo Ajuste'
                DataBinding.FieldName = 'LOG_TIPAJU'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'Inclus'#227'o'
                    ImageIndex = 0
                    Value = 'INC'
                  end
                  item
                    Description = 'Exclus'#227'o'
                    Value = 'EXC'
                  end
                  item
                    Description = 'Alt. Anterior'
                    Value = 'ALT-ANT'
                  end
                  item
                    Description = 'Alt. Atual'
                    Value = 'ALT-ATU'
                  end>
                Width = 82
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object GridTableViewForNcoLogLOG_NOMFRM: TcxGridDBBandedColumn
                Caption = 'Formul'#225'rio/M'#243'dulo'
                DataBinding.FieldName = 'LOG_NOMFRM'
                Width = 155
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object GridTableViewForNcoLogLOG_SEQAJU: TcxGridDBBandedColumn
                Caption = 'Log Seq. Ajuste'
                DataBinding.FieldName = 'LOG_SEQAJU'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object GridTableViewForNcoLogNCO_CODFOR: TcxGridDBBandedColumn
                Caption = 'Fornecedor'
                DataBinding.FieldName = 'NCO_CODFOR'
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewForNcoLogNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewForNcoLogNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
            end
            object GridForNcoLogLevel: TcxGridLevel
              GridView = GridTableViewForNcoLog
            end
          end
        end
      end
      object tsBandeira: TcxTabSheet
        Caption = 'Bandeira'
        ImageIndex = 7
        object gbBanNco: TcxGroupBox
          Left = 0
          Top = 0
          Align = alLeft
          Caption = 'Conta(s) Atual(is)'
          TabOrder = 0
          Height = 87
          Width = 481
          object GridBanNco: TcxGridCitel
            Left = 2
            Top = 19
            Width = 477
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewBanNco: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewBanNcoFocusedItemChanged
              DataController.DataSource = dsBanNco
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Width = 455
                end>
              object GridTableViewBanNcoNCO_CODBAN: TcxGridDBBandedColumn
                Caption = 'Bandeira'
                DataBinding.FieldName = 'NCO_CODBAN'
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewBanNcoNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewBanNcoNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
            end
            object GridBanNcoLevel: TcxGridLevel
              GridView = GridTableViewBanNco
            end
          end
        end
        object gbBanNcoLog: TcxGroupBox
          Left = 481
          Top = 0
          Align = alClient
          Caption = 'Log de Altera'#231#245'es'
          TabOrder = 1
          Height = 87
          Width = 621
          object GridBanNcoLog: TcxGridCitel
            Left = 2
            Top = 19
            Width = 617
            Height = 66
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object GridTableViewBanNcoLog: TcxGridDBBandedTableView
              Navigator.Buttons.CustomButtons = <>
              OnFocusedItemChanged = GridTableViewBanNcoLogFocusedItemChanged
              DataController.DataSource = dsBanNcoLog
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.FocusCellOnCycle = True
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnSorting = False
              OptionsCustomize.ColumnsQuickCustomization = True
              OptionsCustomize.BandMoving = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.InvertSelect = False
              OptionsView.GroupByBox = False
              OptionsView.Indicator = True
              Bands = <
                item
                  Caption = 'Info. Log'
                  FixedKind = fkLeft
                  Width = 485
                end
                item
                  Caption = 'Info Dados'
                  Width = 680
                end>
              object GridTableViewBanNcoLogLOG_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'LOG_CODEMP'
                Width = 52
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewBanNcoLogLOG_DTAALT: TcxGridDBBandedColumn
                Caption = 'Dta. Log'
                DataBinding.FieldName = 'LOG_DTAALT'
                Width = 65
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewBanNcoLogLOG_HRAALT: TcxGridDBBandedColumn
                Caption = 'Hora Log'
                DataBinding.FieldName = 'LOG_HRAALT'
                Width = 68
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object GridTableViewBanNcoLogLOG_CODOPE: TcxGridDBBandedColumn
                Caption = 'Operador'
                DataBinding.FieldName = 'LOG_CODOPE'
                Width = 63
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object GridTableViewBanNcoLogLOG_TIPAJU: TcxGridDBBandedColumn
                Caption = 'Tipo Ajuste'
                DataBinding.FieldName = 'LOG_TIPAJU'
                PropertiesClassName = 'TcxImageComboBoxProperties'
                Properties.Items = <
                  item
                    Description = 'Inclus'#227'o'
                    ImageIndex = 0
                    Value = 'INC'
                  end
                  item
                    Description = 'Exclus'#227'o'
                    Value = 'EXC'
                  end
                  item
                    Description = 'Alt. Anterior'
                    Value = 'ALT-ANT'
                  end
                  item
                    Description = 'Alt. Atual'
                    Value = 'ALT-ATU'
                  end>
                Width = 82
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object GridTableViewBanNcoLogLOG_NOMFRM: TcxGridDBBandedColumn
                Caption = 'Formul'#225'rio/M'#243'dulo'
                DataBinding.FieldName = 'LOG_NOMFRM'
                Width = 155
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object GridTableViewBanNcoLogLOG_SEQAJU: TcxGridDBBandedColumn
                Caption = 'Log Seq. Ajuste'
                DataBinding.FieldName = 'LOG_SEQAJU'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object GridTableViewBanNcoLogNCO_CODBAN: TcxGridDBBandedColumn
                Caption = 'Bandeira'
                DataBinding.FieldName = 'NCO_CODBAN'
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object GridTableViewBanNcoLogNCO_CODEMP: TcxGridDBBandedColumn
                Caption = 'Empresa'
                DataBinding.FieldName = 'NCO_CODEMP'
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object GridTableViewBanNcoLogNCO_CODCON: TcxGridDBBandedColumn
                Caption = 'Conta Cont'#225'bil'
                DataBinding.FieldName = 'NCO_CODCON'
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
            end
            object GridBanNcoLogLevel: TcxGridLevel
              GridView = GridTableViewBanNcoLog
            end
          end
        end
      end
    end
  end
  object gbDadosLanconLog: TcxGroupBox [5]
    Left = 0
    Top = 393
    Align = alTop
    Caption = 'Log Lan'#231'amento Cont'#225'bil'
    TabOrder = 5
    Height = 185
    Width = 1106
    object GridLanconLog: TcxGridCitel
      Left = 2
      Top = 19
      Width = 1102
      Height = 133
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object GridTableLanconLog: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        OnFocusedItemChanged = GridTableLanconLogFocusedItemChanged
        DataController.DataSource = dsLanconLog
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnSorting = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsCustomize.BandMoving = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Bands = <
          item
            Caption = 'Info. Log'
            FixedKind = fkLeft
            Options.Moving = False
            Options.Sizing = False
            Width = 485
          end
          item
            Caption = 'Info. Dados'
            Options.Moving = False
            Width = 4000
          end>
        object GridTableLanconLogLOG_CODEMP: TcxGridDBBandedColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'LOG_CODEMP'
          Width = 52
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object GridTableLanconLogLOG_DTAALT: TcxGridDBBandedColumn
          Caption = 'Dta. Log'
          DataBinding.FieldName = 'LOG_DTAALT'
          Width = 65
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object GridTableLanconLogLOG_HRAALT: TcxGridDBBandedColumn
          Caption = 'Hora Log'
          DataBinding.FieldName = 'LOG_HRAALT'
          Width = 68
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object GridTableLanconLogLOG_CODOPE: TcxGridDBBandedColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'LOG_CODOPE'
          Width = 63
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object GridTableLanconLogLOG_TIPAJU: TcxGridDBBandedColumn
          Caption = 'Tipo Ajuste'
          DataBinding.FieldName = 'LOG_TIPAJU'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Inclus'#227'o'
              ImageIndex = 0
              Value = 'INC'
            end
            item
              Description = 'Exclus'#227'o'
              Value = 'EXC'
            end
            item
              Description = 'Alt. Anterior'
              Value = 'ALT-ANT'
            end
            item
              Description = 'Alt. Atual'
              Value = 'ALT-ATU'
            end>
          Width = 82
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object GridTableLanconLogLOG_NOMFRM: TcxGridDBBandedColumn
          Caption = 'Formul'#225'rio/M'#243'dulo'
          DataBinding.FieldName = 'LOG_NOMFRM'
          Width = 155
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object GridTableLanconLogLOG_SEQAJU: TcxGridDBBandedColumn
          Caption = 'Log Seq. Ajuste'
          DataBinding.FieldName = 'LOG_SEQAJU'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object GridTableLanconLogLOG_INCDOC: TcxGridDBBandedColumn
          Caption = 'Log Info. Doc.'
          DataBinding.FieldName = 'LOG_INCDOC'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object GridTableLanconLogAUTOINCREM: TcxGridDBBandedColumn
          Caption = 'Num. Lan'#231'amento'
          DataBinding.FieldName = 'AUTOINCREM'
          Width = 96
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_EMPLAN: TcxGridDBBandedColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CON_EMPLAN'
          Width = 54
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_DTALAN: TcxGridDBBandedColumn
          Caption = 'Data'
          DataBinding.FieldName = 'CON_DTALAN'
          Width = 75
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_TIPLAN: TcxGridDBBandedColumn
          Caption = 'Tipo Lancto'
          DataBinding.FieldName = 'CON_TIPLAN'
          Width = 71
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_CLAFIS: TcxGridDBBandedColumn
          Caption = 'CLAFIS'
          DataBinding.FieldName = 'CON_CLAFIS'
          Width = 95
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_NATOPE: TcxGridDBBandedColumn
          Caption = 'Condi'#231#227'o de Pagamento'
          DataBinding.FieldName = 'CON_NATOPE'
          Width = 129
          Position.BandIndex = 1
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_DESVAL: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o Valor'
          DataBinding.FieldName = 'CON_DESVAL'
          Width = 132
          Position.BandIndex = 1
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_CONCRE: TcxGridDBBandedColumn
          Caption = 'Conta Cr'#233'dito'
          DataBinding.FieldName = 'CON_CONCRE'
          Width = 132
          Position.BandIndex = 1
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_CONDEB: TcxGridDBBandedColumn
          Caption = 'Conta D'#233'bito'
          DataBinding.FieldName = 'CON_CONDEB'
          Width = 130
          Position.BandIndex = 1
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_HISPAD: TcxGridDBBandedColumn
          Caption = 'Hist'#243'rico Padr'#227'o'
          DataBinding.FieldName = 'CON_HISPAD'
          Width = 158
          Position.BandIndex = 1
          Position.ColIndex = 9
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_HISTOR: TcxGridDBBandedColumn
          Caption = 'Complemento'
          DataBinding.FieldName = 'CON_HISTOR'
          PropertiesClassName = 'TcxBlobEditProperties'
          Properties.AlwaysSaveData = False
          Properties.BlobEditKind = bekMemo
          Properties.BlobPaintStyle = bpsText
          Width = 279
          Position.BandIndex = 1
          Position.ColIndex = 10
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_VALLAN: TcxGridDBBandedColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'CON_VALLAN'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Width = 127
          Position.BandIndex = 1
          Position.ColIndex = 11
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_AUTOMA: TcxGridDBBandedColumn
          Caption = 'Lan'#231'amento Autom'#225'tico?'
          DataBinding.FieldName = 'CON_AUTOMA'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Sim'
              ImageIndex = 0
              Value = '1'
            end
            item
              Description = 'N'#227'o'
              Value = '0'
            end>
          Width = 162
          Position.BandIndex = 1
          Position.ColIndex = 12
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_CCUSTO: TcxGridDBBandedColumn
          Caption = 'Centro Custo D'#233'bito'
          DataBinding.FieldName = 'CON_CCUSTO'
          Width = 125
          Position.BandIndex = 1
          Position.ColIndex = 13
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_CCUSCR: TcxGridDBBandedColumn
          Caption = 'Centro Custo Cr'#233'dito'
          DataBinding.FieldName = 'CON_CCUSCR'
          Width = 133
          Position.BandIndex = 1
          Position.ColIndex = 14
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_CODOPE: TcxGridDBBandedColumn
          Caption = 'Operador Lanc.'
          DataBinding.FieldName = 'CON_CODOPE'
          Width = 125
          Position.BandIndex = 1
          Position.ColIndex = 15
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_INCDOC: TcxGridDBBandedColumn
          Caption = 'Documento Vinculado'
          DataBinding.FieldName = 'CON_INCDOC'
          Width = 141
          Position.BandIndex = 1
          Position.ColIndex = 16
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_TABELA: TcxGridDBBandedColumn
          Caption = 'Tabela Doc. Vinculado'
          DataBinding.FieldName = 'CON_TABELA'
          Width = 149
          Position.BandIndex = 1
          Position.ColIndex = 17
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_PAGAME: TcxGridDBBandedColumn
          Caption = 'Pagamentos'
          DataBinding.FieldName = 'CON_PAGAME'
          Width = 117
          Position.BandIndex = 1
          Position.ColIndex = 18
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_VERSIS: TcxGridDBBandedColumn
          Caption = 'Vers'#227'o Sistema'
          DataBinding.FieldName = 'CON_VERSIS'
          Width = 117
          Position.BandIndex = 1
          Position.ColIndex = 19
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_CLIFOR: TcxGridDBBandedColumn
          Caption = 'Cod. Cli./Forn.'
          DataBinding.FieldName = 'CON_CLIFOR'
          Width = 120
          Position.BandIndex = 1
          Position.ColIndex = 20
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_TIP_FC: TcxGridDBBandedColumn
          Caption = 'C/F'
          DataBinding.FieldName = 'CON_TIP_FC'
          Width = 46
          Position.BandIndex = 1
          Position.ColIndex = 21
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_TT_ULT: TcxGridDBBandedColumn
          Caption = 'Data/Hora Ultima Modifica'#231#227'o'
          DataBinding.FieldName = 'CON_TT_ULT'
          Width = 192
          Position.BandIndex = 1
          Position.ColIndex = 22
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_EMPLOG: TcxGridDBBandedColumn
          Caption = 'Empresa Logada'
          DataBinding.FieldName = 'CON_EMPLOG'
          Width = 119
          Position.BandIndex = 1
          Position.ColIndex = 23
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_FORPGO: TcxGridDBBandedColumn
          Caption = 'Forma de Pagamento'
          DataBinding.FieldName = 'CON_FORPGO'
          Width = 140
          Position.BandIndex = 1
          Position.ColIndex = 24
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_AUTMOD: TcxGridDBBandedColumn
          Caption = 'Registro Aut. Modificado?'
          DataBinding.FieldName = 'CON_AUTMOD'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'N'#227'o'
              ImageIndex = 0
              Value = 'N'
            end
            item
              Description = 'Sim'
              Value = 'S'
            end>
          Width = 136
          Position.BandIndex = 1
          Position.ColIndex = 25
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_SEQPAR: TcxGridDBBandedColumn
          Caption = 'Seq. Par'#226'metro Cont'#225'bil'
          DataBinding.FieldName = 'CON_SEQPAR'
          Width = 128
          Position.BandIndex = 1
          Position.ColIndex = 26
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_INVNCO: TcxGridDBBandedColumn
          Caption = 'Conta Invertida?'
          DataBinding.FieldName = 'CON_INVNCO'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'N'#227'o'
              ImageIndex = 0
              Value = 'N'
            end
            item
              Description = 'Sim'
              Value = 'S'
            end>
          Width = 91
          Position.BandIndex = 1
          Position.ColIndex = 27
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_TPORIC: TcxGridDBBandedColumn
          Caption = 'Tipo Ori. Cred.'
          DataBinding.FieldName = 'CON_TPORIC'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Parcon'
              ImageIndex = 0
              Value = 'PR'
            end
            item
              Description = 'Cliente/Fornecedor'
              Value = 'CF'
            end
            item
              Description = 'Portador'
              Value = 'PT'
            end
            item
              Description = 'Bandeira'
              Value = 'BN'
            end
            item
              Description = 'Plano Contas'
              Value = 'PC'
            end
            item
              Description = 'Abrev. Prod.'
              Value = 'AB'
            end
            item
              Description = 'Configura'#231#227'o'
              Value = 'CN'
            end>
          Width = 81
          Position.BandIndex = 1
          Position.ColIndex = 28
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_CDORIC: TcxGridDBBandedColumn
          Caption = 'C'#243'digo Ori. Cred.'
          DataBinding.FieldName = 'CON_CDORIC'
          Width = 78
          Position.BandIndex = 1
          Position.ColIndex = 29
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_OPBCCR: TcxGridDBBandedColumn
          Caption = 'Origem Cred.'
          DataBinding.FieldName = 'CON_OPBCCR'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Conta da Baixa'
              ImageIndex = 0
              Value = 'B'
            end
            item
              Description = 'Conta do Cadastro'
              Value = 'C'
            end>
          Width = 82
          Position.BandIndex = 1
          Position.ColIndex = 30
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_TPORID: TcxGridDBBandedColumn
          Caption = 'Tipo Ori. Deb.'
          DataBinding.FieldName = 'CON_TPORID'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Parcon'
              ImageIndex = 0
              Value = 'PR'
            end
            item
              Description = 'Cliente/Fornecedor'
              Value = 'CF'
            end
            item
              Description = 'Portador'
              Value = 'PT'
            end
            item
              Description = 'Bandeira'
              Value = 'BN'
            end
            item
              Description = 'Plano Contas'
              Value = 'PC'
            end
            item
              Description = 'Abrev. Prod.'
              Value = 'AB'
            end
            item
              Description = 'Configura'#231#227'o'
              Value = 'CN'
            end>
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 31
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_CDORID: TcxGridDBBandedColumn
          Caption = 'C'#243'digo Ori. Deb.'
          DataBinding.FieldName = 'CON_CDORID'
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 32
          Position.RowIndex = 0
        end
        object GridTableLanconLogCON_OPBCDB: TcxGridDBBandedColumn
          Caption = 'Origem Deb.'
          DataBinding.FieldName = 'CON_OPBCDB'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Items = <
            item
              Description = 'Conta da Baixa'
              ImageIndex = 0
              Value = 'B'
            end
            item
              Description = 'Conta do Cadastro'
              Value = 'C'
            end>
          Width = 80
          Position.BandIndex = 1
          Position.ColIndex = 33
          Position.RowIndex = 0
        end
      end
      object GridLanconLogLevel: TcxGridLevel
        GridView = GridTableLanconLog
      end
    end
    object gbOpcoesLanconLog: TcxGroupBox
      Left = 2
      Top = 152
      Align = alBottom
      TabOrder = 1
      Height = 31
      Width = 1102
      object cbMostrarLogIncDoc: TcxCheckBox
        Left = 5
        Top = 9
        Caption = 'Mostrar o Log de todos os lan'#231'amentos com o mesmo IncDoc'
        State = cbsChecked
        TabOrder = 0
        OnClick = cbMostrarLogIncDocClick
      end
    end
  end
  object dsLancon: TDataSource
    AutoEdit = False
    Left = 832
    Top = 16
  end
  object dsLanconLog: TDataSource
    AutoEdit = False
    Left = 832
    Top = 72
  end
  object dsParcon: TDataSource
    AutoEdit = False
    Left = 872
    Top = 16
  end
  object dsParconLog: TDataSource
    AutoEdit = False
    Left = 872
    Top = 72
  end
  object dsParNco: TDataSource
    AutoEdit = False
    Left = 912
    Top = 16
  end
  object dsParNcoLog: TDataSource
    AutoEdit = False
    Left = 912
    Top = 72
  end
  object dsCmpPar: TDataSource
    AutoEdit = False
    Left = 952
    Top = 16
  end
  object dsCmpParLog: TDataSource
    AutoEdit = False
    Left = 952
    Top = 72
  end
  object dtsBusca: TDataSource
    AutoEdit = False
    Left = 828
    Top = 124
  end
  object dsPorNco: TDataSource
    AutoEdit = False
    Left = 1000
    Top = 16
  end
  object dsPorNcoLog: TDataSource
    AutoEdit = False
    Left = 1000
    Top = 72
  end
  object dsBanNco: TDataSource
    AutoEdit = False
    Left = 1040
    Top = 16
  end
  object dsBanNcoLog: TDataSource
    AutoEdit = False
    Left = 1040
    Top = 72
  end
  object dsCliNco: TDataSource
    AutoEdit = False
    Left = 872
    Top = 128
  end
  object dsCliNcoLog: TDataSource
    AutoEdit = False
    Left = 872
    Top = 184
  end
  object dsCtaNco: TDataSource
    AutoEdit = False
    Left = 912
    Top = 128
  end
  object dsCtaNcoLog: TDataSource
    AutoEdit = False
    Left = 912
    Top = 184
  end
  object dsForNco: TDataSource
    AutoEdit = False
    Left = 952
    Top = 128
  end
  object dsForNcoLog: TDataSource
    AutoEdit = False
    Left = 952
    Top = 184
  end
end
