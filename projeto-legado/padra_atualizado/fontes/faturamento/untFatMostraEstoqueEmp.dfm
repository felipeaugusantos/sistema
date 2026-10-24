inherited frmFatMostraEstoqueEmp: TfrmFatMostraEstoqueEmp
  Left = 203
  Top = 270
  Width = 1024
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Estoque das Empresas'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 508
    Width = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
    end
    inherited btnSair: TBitBtnLocked
      Left = 382
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1008
    TabOrder = 6
    inherited pnlNomeForm: TPanel
      Left = 839
      Width = 169
    end
    inherited pnlInfo: TPanel
      Width = 839
    end
  end
  inherited pgcDados: TPageControl
    Top = 35
    Width = 1008
    Height = 473
    Visible = False
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1008
    Height = 35
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object Label1: TLabel
      Left = 28
      Top = 12
      Width = 22
      Height = 14
      Caption = 'Item:'
    end
    object edtItem: TEditFocus
      Left = 55
      Top = 8
      Width = 450
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnPrepTE: TBitBtnLocked
      Left = 666
      Top = 8
      Width = 149
      Height = 22
      Caption = '[F8] Prepara Gera'#231#227'o TE'
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnPrepTEClick
    end
    object chkMostrarML: TCheckBox
      Left = 821
      Top = 11
      Width = 156
      Height = 17
      Caption = '&Mostrar saldos em ML / GR'
      TabOrder = 2
      OnClick = chkMostrarMLClick
    end
  end
  object pnlBotoesMostra: TPanel [4]
    Left = 0
    Top = 35
    Width = 1008
    Height = 473
    Align = alClient
    TabOrder = 3
    object Splitter1: TSplitter
      Left = 1
      Top = 175
      Width = 1006
      Height = 4
      Cursor = crVSplit
      Align = alBottom
    end
    object cxGridEstrutura: TcxGridCitel
      Left = 1
      Top = 179
      Width = 1006
      Height = 293
      Align = alBottom
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridDadosEstrutura: TcxGridDBTableViewCitel
        OnKeyDown = cxGridDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        FilterBox.CustomizeDialog = False
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
            Column = gsITE_SALFIS
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
            Column = gsITE_SALRES
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
            Column = gsITE_SALDIS
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
            Column = gsITE_FUTPRE
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
            Column = gsITE_SALREG
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Position = spFooter
            Column = gsITE_SALEXT
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gsITE_SALFIS
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = gsITE_ORDPRO
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gsITE_SALRES
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gsITE_SALDIS
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = gsITE_FUTPRE
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gsITE_SALREG
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gsITE_SALEND
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = gsITE_FUTAGU
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = gsITE_FUTFAL
          end
          item
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gsITE_SALEXT
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gsITE_SDPDBF
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.Footer = True
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        Styles.Selection = cxStyleSelecao
        Zebra = True
        Destaque = False
        CorZebra = clMoneyGreen
        object gsITE_SUBITE: TcxGridDBColumn
          Caption = 'Sub Item'
          DataBinding.FieldName = 'DESITE'
          Visible = False
          GroupIndex = 0
          SortIndex = 1
          SortOrder = soAscending
        end
        object gsEMP_NOMEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'EMP_NOMEMP'
          Options.Editing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 144
        end
        object gsITE_SALFIS: TcxGridDBColumn
          Caption = 'Saldo F'#237'sico'
          DataBinding.FieldName = 'ITE_SALFIS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000;-,0.000'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 93
        end
        object gsITE_SALREG: TcxGridDBColumn
          Caption = 'Saldo Reserv. Garantia'
          DataBinding.FieldName = 'ITE_SALREG'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000;-,0.000'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Styles.Content = cxStyleSalRes
          Styles.Footer = cxStyleSalRes
          Width = 120
        end
        object gsITE_SALEXT: TcxGridDBColumn
          Caption = 'Saldo Reserv. Externo'
          DataBinding.FieldName = 'ITE_SALEXT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000;-,0.000'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Styles.Content = cxStyleSalRes
          Styles.Footer = cxStyleSalRes
          Width = 114
        end
        object gsITE_SALRES: TcxGridDBColumn
          Caption = 'Saldo Reserv. Pedido'
          DataBinding.FieldName = 'ITE_SALRES'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000;-,0.000'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Styles.Content = cxStyleSalRes
          Styles.Footer = cxStyleSalRes
          Width = 112
        end
        object gsITE_SALEND: TcxGridDBColumn
          Caption = 'Saldo Endere'#231'am.'
          DataBinding.FieldName = 'ITE_SALEND'
          HeaderAlignmentHorz = taRightJustify
          Width = 96
        end
        object gsITE_ORDPRO: TcxGridDBColumn
          Caption = 'Ordem Produ'#231#227'o'
          DataBinding.FieldName = 'ITE_SALORD'
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 88
        end
        object gsITE_FUTPRE: TcxGridDBColumn
          Caption = 'Ent.Fut.Previs'#227'o'
          DataBinding.FieldName = 'ITE_FUTPRE'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 86
        end
        object gsITE_FUTFAL: TcxGridDBColumn
          Caption = 'Entr.Fut.Falta'
          DataBinding.FieldName = 'ITE_FUTFAL'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 80
        end
        object gsITE_FUTAGU: TcxGridDBColumn
          Caption = 'Ent.Fut.Ag.'
          DataBinding.FieldName = 'ITE_FUTAGU'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 80
        end
        object gsITE_SALDIS: TcxGridDBColumn
          Caption = 'Saldo Dispon'#237'vel'
          DataBinding.FieldName = 'ITE_SALDIS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000;-,0.000'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Styles.Content = cxStyleSalDis
          Styles.Footer = cxStyleSalDis
          Width = 86
        end
        object gsITE_PREVE1: TcxGridDBColumn
          AlternateCaption = 'Pv1'
          Caption = 'Pre'#231'o de Venda1'
          DataBinding.FieldName = 'ITE_PREVE1'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gsITE_PREVE2: TcxGridDBColumn
          AlternateCaption = 'Pv2'
          Caption = 'Pre'#231'o de Venda2'
          DataBinding.FieldName = 'ITE_PREVE2'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gsITE_PREVE3: TcxGridDBColumn
          AlternateCaption = 'Pv3'
          Caption = 'Pre'#231'o de Venda3'
          DataBinding.FieldName = 'ITE_PREVE3'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gsITE_PREVE4: TcxGridDBColumn
          AlternateCaption = 'Pv4'
          Caption = 'Pre'#231'o de Venda4'
          DataBinding.FieldName = 'ITE_PREVE4'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gsITE_PREVE5: TcxGridDBColumn
          AlternateCaption = 'Pv5'
          Caption = 'Pre'#231'o de Venda5'
          DataBinding.FieldName = 'ITE_PREVE5'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gsITE_PREVE6: TcxGridDBColumn
          AlternateCaption = 'Pv6'
          Caption = 'Pre'#231'o de Venda6'
          DataBinding.FieldName = 'ITE_PREVE6'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gsITE_PREVE7: TcxGridDBColumn
          AlternateCaption = 'Pv7'
          Caption = 'Pre'#231'o de Venda7'
          DataBinding.FieldName = 'ITE_PREVE7'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gsITE_SDPDBF: TcxGridDBColumn
          Caption = 'Reserv. Ped.Bai.Ent.Fut'
          DataBinding.FieldName = 'ITE_SDPDBF'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 125
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDadosEstrutura
      end
    end
    object dbeEstoqueMM: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1006
      Height = 174
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGridDados: TcxGridDBTableViewCitel
        OnKeyDown = cxGridDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        FilterBox.CustomizeDialog = False
        DataController.DataSource = dtsSalEmp
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gdITE_SALFIS
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = gdITE_FUTAGU
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gdITE_SALRES
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gdITE_SALDIS
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = gdITE_FUTPRE
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gdITE_SALREG
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gdITE_SALEND
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = gdITE_ORDPRO
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = gdITE_FUTFAL
          end
          item
            Format = ',0.00;-,0.00'
            Kind = skSum
            Column = gdITE_FUTPRE
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gdITE_SALEXT
          end
          item
            Format = ',0.000;-,0.000'
            Kind = skSum
            Column = gdITE_SDPDBF
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.ExpandButtonsForEmptyDetails = False
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        Styles.Selection = cxStyleSelecao
        Zebra = True
        Destaque = False
        CorZebra = clMoneyGreen
        object gdEMP_NOMEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'EMP_NOMEMP'
          Options.Editing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 158
        end
        object gdITE_SALFIS: TcxGridDBColumn
          Caption = 'Saldo F'#237'sico'
          DataBinding.FieldName = 'ITE_SALFIS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000;-,0.000'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 93
        end
        object gdITE_SALREG: TcxGridDBColumn
          Caption = 'Saldo Reserv. Garantia'
          DataBinding.FieldName = 'ITE_SALREG'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000;-,0.000'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Styles.Content = cxStyleSalRes
          Styles.Footer = cxStyleSalRes
          Width = 120
        end
        object gdITE_SALEXT: TcxGridDBColumn
          Caption = 'Saldo Reserv. Externo'
          DataBinding.FieldName = 'ITE_SALEXT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000;-,0.000'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Styles.Content = cxStyleSalRes
          Styles.Footer = cxStyleSalRes
          Width = 114
        end
        object gdITE_SALRES: TcxGridDBColumn
          Caption = 'Saldo Reserv. Pedido'
          DataBinding.FieldName = 'ITE_SALRES'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000;-,0.000'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Styles.Content = cxStyleSalRes
          Styles.Footer = cxStyleSalRes
          Width = 112
        end
        object gdITE_SALEND: TcxGridDBColumn
          Caption = 'Saldo Endere'#231'am.'
          DataBinding.FieldName = 'ITE_SALEND'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000;-,0.000'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 96
        end
        object gdITE_ORDPRO: TcxGridDBColumn
          Caption = 'Ordem Produ'#231#227'o'
          DataBinding.FieldName = 'ITE_SALORD'
          HeaderAlignmentHorz = taRightJustify
          Width = 88
        end
        object gdITE_FUTPRE: TcxGridDBColumn
          Caption = 'Ent.Fut.Previs'#227'o'
          DataBinding.FieldName = 'ITE_FUTPRE'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 86
        end
        object gdITE_FUTFAL: TcxGridDBColumn
          Caption = 'Entr.Fut.Falta'
          DataBinding.FieldName = 'ITE_FUTFAL'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 80
        end
        object gdITE_FUTAGU: TcxGridDBColumn
          Caption = 'Ent.Fut.Ag.'
          DataBinding.FieldName = 'ITE_FUTAGU'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 80
        end
        object gdITE_SALDIS: TcxGridDBColumn
          Caption = 'Saldo Dispon'#237'vel'
          DataBinding.FieldName = 'ITE_SALDIS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DecimalPlaces = 3
          Properties.DisplayFormat = ',0.000;-,0.000'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Styles.Content = cxStyleSalDis
          Styles.Footer = cxStyleSalDis
          Width = 85
        end
        object gdITE_PREVE1: TcxGridDBColumn
          AlternateCaption = 'Pv1'
          Caption = 'Pre'#231'o de Venda1'
          DataBinding.FieldName = 'ITE_PREVE1'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gdITE_PREVE2: TcxGridDBColumn
          AlternateCaption = 'Pv2'
          Caption = 'Pre'#231'o de Venda2'
          DataBinding.FieldName = 'ITE_PREVE2'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gdITE_PREVE3: TcxGridDBColumn
          AlternateCaption = 'Pv3'
          Caption = 'Pre'#231'o de Venda3'
          DataBinding.FieldName = 'ITE_PREVE3'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gdITE_PREVE4: TcxGridDBColumn
          AlternateCaption = 'Pv4'
          Caption = 'Pre'#231'o de Venda4'
          DataBinding.FieldName = 'ITE_PREVE4'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gdITE_PREVE5: TcxGridDBColumn
          AlternateCaption = 'Pv5'
          Caption = 'Pre'#231'o de Venda5'
          DataBinding.FieldName = 'ITE_PREVE5'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gdITE_PREVE6: TcxGridDBColumn
          AlternateCaption = 'Pv6'
          Caption = 'Pre'#231'o de Venda6'
          DataBinding.FieldName = 'ITE_PREVE6'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gdITE_PREVE7: TcxGridDBColumn
          AlternateCaption = 'Pv7'
          Caption = 'Pre'#231'o de Venda7'
          DataBinding.FieldName = 'ITE_PREVE7'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 74
        end
        object gdITE_ESTMIN: TcxGridDBColumn
          Caption = 'Estoque Min. '
          DataBinding.FieldName = 'ITE_ESTMIN'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 91
        end
        object gdITE_ESTMAX: TcxGridDBColumn
          Caption = 'Estoque M'#225'x.'
          DataBinding.FieldName = 'ITE_ESTMAX'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 74
        end
        object gdITE_SDPDBF: TcxGridDBColumn
          Caption = 'Reserv. Ped.Bai.Ent.Fut'
          DataBinding.FieldName = 'ITE_SDPDBF'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Width = 125
        end
      end
      object cxGridNivel: TcxGridLevel
        GridView = cxGridDados
        Options.TabsForEmptyDetails = False
      end
    end
  end
  object pnlSelecEmpresa: TPanel [5]
    Left = 0
    Top = 508
    Width = 1008
    Height = 37
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 5
    Visible = False
    object lbl1: TLabel
      Left = 595
      Top = 14
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object chkSaldosDisponiveis: TCheckBox
      Left = 7
      Top = 14
      Width = 261
      Height = 17
      Caption = '&Exibir somente empresas com saldo dispon'#237'vel'
      TabOrder = 0
      OnClick = chkSaldosDisponiveisClick
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 642
      Top = 8
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
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
      Left = 708
      Top = 8
      Width = 202
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnConfirma: TBitBtnLocked
      Left = 910
      Top = 8
      Width = 81
      Height = 22
      Caption = '&Confirmar'
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
      TabOrder = 3
      OnClick = btnConfirmaClick
    end
  end
  object btnResPadResumo: TBitBtnLocked [6]
    Left = 511
    Top = 7
    Width = 149
    Height = 22
    Caption = 'Restaura padr'#227'o do grid'
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnResPadResumoClick
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 504
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 72
  end
  object dtsSalEmp: TDataSource
    DataSet = cdsSalEmp
    Left = 632
    Top = 64
  end
  object cdsSalEmp: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSalEmp'
    AfterScroll = cdsSalEmpAfterScroll
    Left = 600
    Top = 64
  end
  object dspSalEmp: TUniDataSetProvider
    DataSet = qrySalEmp
    Options = []
    Left = 568
    Top = 64
  end
  object qrySalEmp: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 536
    Top = 64
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 424
    Top = 64
    PixelsPerInch = 96
    object cxStyleSalRes: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clRed
    end
    object cxStyleSalDis: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clBlue
    end
    object cxStyleSelecao: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clBlack
    end
  end
end
