inherited frmFatMostraComboProdAtivacao: TfrmFatMostraComboProdAtivacao
  Width = 1024
  Height = 600
  Caption = 'Produtos do Combo de Venda'
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 1018
    ExplicitTop = 527
    ExplicitWidth = 1018
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
    end
    inherited btnConfirma: TBitBtnLocked
      Visible = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 1018
    ExplicitTop = 555
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 26
    Width = 1018
    Height = 501
    Align = alClient
    TabOrder = 3
    object pnlRodape: TPanel
      Left = 1
      Top = 474
      Width = 1016
      Height = 26
      Align = alBottom
      TabOrder = 0
      object Label1: TLabel
        Left = 448
        Top = 4
        Width = 353
        Height = 14
        Caption = '[ ENTER ] - Sobre o produto de ativa'#231#227'o do combo para substituir'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 4
        Width = 315
        Height = 14
        Caption = '[ ESC ] - Para continuar com o produto que voc'#234' escolheu'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object cxgComVen: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1016
      Height = 208
      Align = alTop
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgComVenDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel
        OnDblClick = cxgComVenDBBandedTableViewCitel1DblClick
        OnKeyDown = cxgComVenDBBandedTableViewCitel1KeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsComVen
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = 'DADOS DO COMBO'
            Styles.Header = cxStyle1
            Width = 484
          end
          item
            Caption = 'PRODUTOS DE ATIVA'#199#195'O DO COMBO'
            Styles.Header = cxStyle1
            Width = 518
          end>
        Zebra = True
        Destaque = False
        DestacarRegistro = True
        CorZebra = clMoneyGreen
        object COMVEN: TcxGridDBBandedColumn
          Caption = 'Combo'
          DataBinding.FieldName = 'COMVEN'
          PropertiesClassName = 'TcxLabelProperties'
          Options.CellMerging = True
          Styles.Header = cxStyle2
          Width = 165
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object VIGENC: TcxGridDBBandedColumn
          Caption = 'Vig'#234'ncia'
          DataBinding.FieldName = 'VIGENC'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Styles.Header = cxStyle2
          Width = 130
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object TABPRE: TcxGridDBBandedColumn
          Caption = 'Tabelas Pre'#231'o'
          DataBinding.FieldName = 'TABPRE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          Styles.Header = cxStyle2
          Width = 79
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object CODITE: TcxGridDBBandedColumn
          Caption = 'C'#243'd.'
          DataBinding.FieldName = 'CODITE'
          Styles.Header = cxStyle2
          Width = 55
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object DESITE: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          Styles.Header = cxStyle2
          Width = 207
          Position.BandIndex = 1
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object REFERE: TcxGridDBBandedColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERE'
          Styles.Header = cxStyle2
          Width = 126
          Position.BandIndex = 1
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object UNIDAD: TcxGridDBBandedColumn
          Caption = 'Un.'
          DataBinding.FieldName = 'SIGUNI'
          Styles.Header = cxStyle2
          Width = 23
          Position.BandIndex = 1
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object QTDITE: TcxGridDBBandedColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDITE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Styles.Header = cxStyle2
          Width = 95
          Position.BandIndex = 1
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
      end
      object cxgComVenLevel1: TcxGridLevel
        GridView = cxgComVenDBBandedTableViewCitel1
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 209
      Width = 1016
      Height = 16
      Align = alTop
      TabOrder = 2
    end
    object cxgProCom: TcxGridCitel
      Left = 1
      Top = 225
      Width = 1016
      Height = 249
      Align = alClient
      TabOrder = 3
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgProComDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataModeController.GridMode = True
        DataController.DataSource = dtsProCom
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = 'PRODUTOS DA COMPOSI'#199#195'O DO COMBO DE VENDA'
            Styles.Header = cxStyle1
            Width = 994
          end>
        Zebra = True
        Destaque = True
        DestacarRegistro = True
        CorZebra = clMoneyGreen
        object cxGridDBBandedColumn1: TcxGridDBBandedColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODITE'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle2
          Width = 55
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxGridDBBandedColumn2: TcxGridDBBandedColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESITE'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle2
          Width = 328
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxGridDBBandedColumn3: TcxGridDBBandedColumn
          Caption = 'Refer'#234'ncia'
          DataBinding.FieldName = 'REFERE'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle2
          Width = 188
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object SIGUNI: TcxGridDBBandedColumn
          Caption = 'Unidade'
          DataBinding.FieldName = 'SIGUNI'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle2
          Width = 52
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxGridDBBandedColumn4: TcxGridDBBandedColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'QTDITE'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle2
          Width = 89
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object SITUAC: TcxGridDBBandedColumn
          Caption = 'Situa'#231#227'o'
          DataBinding.FieldName = 'SITUAC'
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle2
          Width = 89
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object PREVEN: TcxGridDBBandedColumn
          Caption = 'Pre'#231'o de Venda'
          DataBinding.FieldName = 'PREVEN'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Options.Focusing = False
          Options.Grouping = False
          Styles.Header = cxStyle2
          Width = 124
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
      end
      object cxgProComLevel1: TcxGridLevel
        GridView = cxgProComDBBandedTableViewCitel1
      end
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 1018
    Height = 26
    Align = alTop
    Caption = 
      'Existe um ou mais Produtos Similar ao que voc'#234' escolheu em Siste' +
      'ma de Combo'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 624
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 704
    Top = 112
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 848
    Top = 104
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = 17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object dtsComVen: TDataSource
    Left = 608
    Top = 184
  end
  object dtsProCom: TDataSource
    Left = 584
    Top = 336
  end
end
