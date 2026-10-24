inherited frmCadParametrosEmpresa: TfrmCadParametrosEmpresa
  Width = 1408
  Height = 673
  BorderStyle = bsSizeable
  Caption = 'Par'#226'metros de Compra'
  OnKeyPress = FormKeyPress
  ExplicitWidth = 1408
  ExplicitHeight = 673
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 592
    Width = 1392
    TabOrder = 1
    ExplicitTop = 592
    ExplicitWidth = 1392
    inherited FlwBotoes: TFlowPanel
      Width = 1311
      ExplicitWidth = 1311
      inherited btnConfirma: TBitBtnLocked
        Width = 119
        Caption = '[ F10 ] Confirma'
        ExplicitWidth = 119
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 119
        Top = 0
        Width = 123
        Height = 22
        Caption = '[ F6 ] Marca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarcaTodosClick
      end
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 242
        Top = 0
        Width = 141
        Height = 22
        Caption = '[ F7 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnDesmarcaTodosClick
      end
      object btnMarDes: TBitBtnLocked
        Left = 383
        Top = 0
        Width = 141
        Height = 22
        Caption = '[ F8 ] Marca / Desmarca'
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnMarDesClick
      end
      object btnCopia: TBitBtnLocked
        Left = 524
        Top = 0
        Width = 368
        Height = 22
        Caption = 
          '[ F5 ] Copiar os dados do registro posicionado para os seleciona' +
          'dos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000089898989BFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF89898989BFBFBFBF6B55
          49FF4A3429FF493328FF473228FF473128FF463126FF442F26FF432F26FF422E
          25FF412D24FF402D24FF402C23FF3E2B23FF261913FFBFBFBFBFB1B1B1B1BFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB1B1B1B1BFBFBFBF6E57
          4AFF4C362AFF4B352AFF4A3429FF493329FF483328FF463127FF453027FF4430
          26FF432F26FF422E25FF412D24FF402D24FF271A14FFBFBFBFBF8E8E8E8EBFBF
          BFBFBFBFBFBFA17355E7BCB8B7C2BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB1B1B1B1000000000000
          000000000000954B1BFF733715DA1509032A0000000000000000BFBFBFBF6652
          45FF463126FF442F25FF432E26FF432E25FF291B14FFBFBFBFBF723E1BB79E55
          24FF9C5422FF9B5221FFE5AB69FF924E22F73117086000000000B1B1B1B1BFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB1B1B1B1BA7B49FFFCE0
          B5FFFBD195FFFBCE92FFF8C074FFF5C380FFA45C2AFF00000000BFBFBFBF6953
          48FF483228FF463127FF453127FF442F26FF2A1C15FFBFBFBFBF8E603CBDBF80
          4FFFBD7F4EFFBC7D4CFFF0CDA2FFAF6F3FF53E24116000000000B1B1B1B1BFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB1B1B1B1000000000000
          000000000000C28453FF975F34D61B1008270000000000000000BFBFBFBF6B55
          49FF4A3429FF483328FF473228FF463228FF2C1C16FFBFBFBFBF89898989BFBF
          BFBFBFBFBFBFC49F7FE7BFBCBAC1BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB1B1B1B1BFBFBFBF755D
          50FF553D30FF543C2FFF533B2FFF523A2EFF50392DFF4F392CFF4F382CFF4D37
          2BFF4C362BFF4B352AFF4A3429FF483428FF2E1E17FFBFBFBFBFB1B1B1B1BFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFB1B1B1B1BFBFBFBF765F
          51FF573F31FF563E31FF553C30FF543C2FFF533C2FFF523A2EFF51392DFF5039
          2DFF4E382CFF4E372CFF4C362BFF4B352AFF2F1F18FFBFBFBFBF8E8E8E8EBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF
          BFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBFBF8E8E8E8E}
        TabOrder = 4
        OnClick = btnCopiaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1313
      Top = 2
      Align = alRight
      ExplicitLeft = 1313
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 618
    Width = 1392
    TabOrder = 2
    ExplicitTop = 618
    ExplicitWidth = 1392
    inherited pnlNomeForm: TPanel
      Left = 1221
      ExplicitLeft = 1221
    end
    inherited pnlInfo: TPanel
      Width = 1221
      ExplicitWidth = 1221
    end
  end
  object cxgEmpresas: TcxGrid [2]
    Left = 0
    Top = 19
    Width = 1392
    Height = 549
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitHeight = 573
    object cxvEmpresas: TcxGridDBBandedTableView
      OnMouseMove = cxvEmpresasMouseMove
      Navigator.Buttons.CustomButtons = <>
      OnCanFocusRecord = cxvEmpresasCanFocusRecord
      OnCustomDrawCell = cxvEmpresasCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsCustomize.ColumnMoving = False
      OptionsCustomize.BandMoving = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsView.GroupByBox = False
      Styles.ContentEven = cxStyle1
      Bands = <
        item
          Caption = 'Empresa'
          FixedKind = fkLeft
          Width = 256
        end
        item
          Caption = 'Dados Gerais'
          Width = 533
        end
        item
          Caption = 'Dias para Compra'
          Width = 776
        end
        item
          Caption = 'Ponto de Pedido'
          Width = 820
        end
        item
          Caption = 'Dias para Estoque de seguran'#231'a'
          Position.BandIndex = 3
          Position.ColIndex = 1
          Width = 751
        end
        item
          Position.BandIndex = 3
          Position.ColIndex = 0
          Width = 70
        end
        item
          Caption = 'Giro de Venda'
          Width = 330
        end>
      object cxvEmpresasCODEMP: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'PAR_CODEMP'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 62
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvEmpresasNOMEMP: TcxGridDBBandedColumn
        Caption = 'Nome da Empresa'
        DataBinding.FieldName = 'PAR_NOMEMP'
        Options.Editing = False
        Width = 194
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvEmpresasTIPEMP: TcxGridDBBandedColumn
        Caption = 'Tipo de Empresa'
        DataBinding.FieldName = 'DESTIP'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsEditFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'Aut'#244'noma'
          'Sat'#233'lite'
          'HUB'
          'N'#227'o gerar pedidos')
        Properties.OnCloseUp = cxvEmpresasTIPEMPPropertiesCloseUp
        HeaderAlignmentHorz = taCenter
        Width = 90
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMIN: TcxGridDBBandedColumn
        Caption = 'Dia Est. M'#237'nimo'
        DataBinding.FieldName = 'PAR_DIAMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taRightJustify
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvEmpresasFATMAX: TcxGridDBBandedColumn
        Caption = 'Fator Est. M'#225'ximo'
        DataBinding.FieldName = 'PAR_FATMAX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 4
        Properties.DisplayFormat = ',0.0000;-,0.0000'
        HeaderAlignmentHorz = taRightJustify
        Width = 99
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMAG: TcxGridDBBandedColumn
        Caption = 'Geral'
        DataBinding.FieldName = 'PAR_DIAMAG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMAA: TcxGridDBBandedColumn
        Caption = 'N'#237'vel A'
        DataBinding.FieldName = 'PAR_DIAMAA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMAB: TcxGridDBBandedColumn
        Caption = 'N'#237'vel B'
        DataBinding.FieldName = 'PAR_DIAMAB'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMAC: TcxGridDBBandedColumn
        Caption = 'N'#237'vel C'
        DataBinding.FieldName = 'PAR_DIAMAC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvEmpresasPONPED: TcxGridDBBandedColumn
        Caption = 'Utilizar'
        DataBinding.FieldName = 'DESPON'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'N'#227'o utiliza'
          'Geral'
          'ABC'
          'XYZ'
          'ABC+XYZ'
          '')
        Properties.OnValidate = cxvEmpresasPONPEDPropertiesValidate
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 5
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvEmpresasPONGER: TcxGridDBBandedColumn
        Caption = 'Geral'
        DataBinding.FieldName = 'PAR_PONGER'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNIB: TcxGridDBBandedColumn
        Caption = 'N'#237'vel B'
        DataBinding.FieldName = 'PAR_PONNIB'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNIA: TcxGridDBBandedColumn
        Caption = 'N'#237'vel A'
        DataBinding.FieldName = 'PAR_PONNIA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNIC: TcxGridDBBandedColumn
        Caption = 'N'#237'vel C'
        DataBinding.FieldName = 'PAR_PONNIC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNIX: TcxGridDBBandedColumn
        Caption = 'N'#237'vel X'
        DataBinding.FieldName = 'PAR_PONNIX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNIY: TcxGridDBBandedColumn
        Caption = 'N'#237'vel Y'
        DataBinding.FieldName = 'PAR_PONNIY'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNIZ: TcxGridDBBandedColumn
        Caption = 'N'#237'vel Z'
        DataBinding.FieldName = 'PAR_PONNIZ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNAX: TcxGridDBBandedColumn
        Caption = 'N'#237'vel AX'
        DataBinding.FieldName = 'PAR_PONNAX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNAY: TcxGridDBBandedColumn
        Caption = 'N'#237'vel AY'
        DataBinding.FieldName = 'PAR_PONNAY'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNAZ: TcxGridDBBandedColumn
        Caption = 'N'#237'vel AZ'
        DataBinding.FieldName = 'PAR_PONNAZ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNBX: TcxGridDBBandedColumn
        Caption = 'N'#237'vel BX'
        DataBinding.FieldName = 'PAR_PONNBX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNBY: TcxGridDBBandedColumn
        Caption = 'N'#237'vel BY'
        DataBinding.FieldName = 'PAR_PONNBY'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNBZ: TcxGridDBBandedColumn
        Caption = 'N'#237'vel BZ'
        DataBinding.FieldName = 'PAR_PONNBZ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNCX: TcxGridDBBandedColumn
        Caption = 'N'#237'vel CX'
        DataBinding.FieldName = 'PAR_PONNCX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNCY: TcxGridDBBandedColumn
        Caption = 'N'#237'vel CY'
        DataBinding.FieldName = 'PAR_PONNCY'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxvEmpresasPONNCZ: TcxGridDBBandedColumn
        Caption = 'N'#237'vel CZ'
        DataBinding.FieldName = 'PAR_PONNCZ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 4
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxvEmpresasMESGIR: TcxGridDBBandedColumn
        Caption = 'Meses'
        DataBinding.FieldName = 'PAR_MESGIR'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          '3'
          '6'
          '12')
        HeaderAlignmentHorz = taCenter
        Width = 49
        Position.BandIndex = 6
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAGIR: TcxGridDBBandedColumn
        Caption = 'Dias Corridos'
        DataBinding.FieldName = 'PAR_DIAGIR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = ',0;-,0'
        HeaderAlignmentHorz = taCenter
        Width = 89
        Position.BandIndex = 6
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvEmpresasSUGGAR: TcxGridDBBandedColumn
        Caption = 'PD Comp. Garant. Influencia Compra'
        DataBinding.FieldName = 'PAR_SUGGAR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 189
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvEmpresasEMPHUB: TcxGridDBBandedColumn
        Caption = 'Empresa HUB'
        DataBinding.FieldName = 'PAR_EMPHUB'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.OnCloseUp = cxvEmpresasEMPHUBPropertiesCloseUp
        Properties.OnValidate = cxvEmpresasEMPHUBPropertiesValidate
        HeaderAlignmentHorz = taCenter
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvEmpresasDESABA: TcxGridDBBandedColumn
        Caption = 'Utilizar'
        DataBinding.FieldName = 'DESABA'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'Geral'
          'ABC'
          'XYZ'
          'ABC+XYZ')
        Properties.OnValidate = cxvEmpresasDESABAPropertiesValidate
        HeaderAlignmentHorz = taCenter
        Width = 70
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvEmpresasColumn2: TcxGridDBBandedColumn
        Caption = 'Utilizar'
        DataBinding.FieldName = 'DESGIR'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'Meses'
          'Dias')
        HeaderAlignmentHorz = taCenter
        Width = 54
        Position.BandIndex = 6
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvEmpresasDESMAI: TcxGridDBBandedColumn
        Caption = 'Desprezar maior e menor valores'
        DataBinding.FieldName = 'PAR_DESMAI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        HeaderAlignmentHorz = taCenter
        Width = 208
        Position.BandIndex = 6
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvEmpresasMARDES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMNX: TcxGridDBBandedColumn
        Caption = 'N'#237'vel X'
        DataBinding.FieldName = 'PAR_DIAMNX'
        Position.BandIndex = 2
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMNY: TcxGridDBBandedColumn
        Caption = 'N'#237'vel Y'
        DataBinding.FieldName = 'PAR_DIAMNY'
        Position.BandIndex = 2
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMNZ: TcxGridDBBandedColumn
        Caption = 'N'#237'vel Z'
        DataBinding.FieldName = 'PAR_DIAMNZ'
        Position.BandIndex = 2
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMAX: TcxGridDBBandedColumn
        Caption = 'N'#237'vel AX'
        DataBinding.FieldName = 'PAR_DIAMAX'
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMAY: TcxGridDBBandedColumn
        Caption = 'N'#237'vel AY'
        DataBinding.FieldName = 'PAR_DIAMAY'
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMAZ: TcxGridDBBandedColumn
        Caption = 'N'#237'vel AZ'
        DataBinding.FieldName = 'PAR_DIAMAZ'
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMBX: TcxGridDBBandedColumn
        Caption = 'N'#237'vel BX'
        DataBinding.FieldName = 'PAR_DIAMBX'
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMBY: TcxGridDBBandedColumn
        Caption = 'N'#237'vel BY'
        DataBinding.FieldName = 'PAR_DIAMBY'
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMBZ: TcxGridDBBandedColumn
        Caption = 'N'#237'vel BZ'
        DataBinding.FieldName = 'PAR_DIAMBZ'
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMCX: TcxGridDBBandedColumn
        Caption = 'N'#237'vel CX'
        DataBinding.FieldName = 'PAR_DIAMCX'
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMCY: TcxGridDBBandedColumn
        Caption = 'N'#237'vel CY'
        DataBinding.FieldName = 'PAR_DIAMCY'
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxvEmpresasDIAMCZ: TcxGridDBBandedColumn
        Caption = 'N'#237'vel CZ'
        DataBinding.FieldName = 'PAR_DIAMCZ'
        Width = 64
        Position.BandIndex = 2
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
    end
    object cxgEmpresasLevel1: TcxGridLevel
      GridView = cxvEmpresas
    end
  end
  object pnlAtivacaoPorProduto: TPanel [3]
    Left = 0
    Top = 0
    Width = 1392
    Height = 19
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    object chkAtivaProduto: TCheckBox
      Left = 0
      Top = 0
      Width = 280
      Height = 19
      Align = alLeft
      Caption = 'Par'#226'metros de compra ativado para o item.'
      TabOrder = 0
      OnClick = chkAtivaProdutoClick
    end
  end
  object pnlRodape: TPanel [4]
    Left = 0
    Top = 568
    Width = 1392
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object chkReplicaItens: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 283
      Height = 18
      Align = alLeft
      Caption = 'Replicar para todos os itens do mesmo fornecedor'
      TabOrder = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 184
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 176
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 256
    Top = 184
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 112
    Top = 232
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object cxHintStyleController1: TcxHintStyleController
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Tahoma'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'Tahoma'
    HintStyle.Font.Style = []
    Left = 500
    Top = 324
  end
end
