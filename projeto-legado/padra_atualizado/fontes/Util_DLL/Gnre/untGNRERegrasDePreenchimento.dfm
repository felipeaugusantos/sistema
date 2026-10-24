inherited frmGNRERegrasDePreenchimento: TfrmGNRERegrasDePreenchimento
  Width = 941
  Height = 715
  BorderStyle = bsDialog
  Caption = 'Regras de Preenchimento'
  Position = poMainFormCenter
  ExplicitWidth = 941
  ExplicitHeight = 715
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 642
    Width = 935
    ExplicitTop = 642
    ExplicitWidth = 935
    inherited FlwBotoes: TFlowPanel
      Width = 931
      ExplicitWidth = 931
    end
    inherited btnSair: TBitBtnLocked
      Left = 855
      ExplicitLeft = 855
    end
  end
  inherited pnlStatus: TPanel
    Top = 670
    Width = 935
    ExplicitTop = 670
    ExplicitWidth = 935
    inherited pnlNomeForm: TPanel
      Left = 764
      ExplicitLeft = 764
    end
    inherited pnlInfo: TPanel
      Width = 764
      ExplicitWidth = 764
    end
  end
  object pnlReader: TPanel [2]
    Left = 0
    Top = 0
    Width = 935
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object rdgReceita: TRadioGroup
      Tag = 10
      Left = 6
      Top = 6
      Width = 200
      Height = 45
      Caption = 'Receita'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'ST'
        'FCP'
        'DIFAL')
      TabOrder = 0
      TabStop = True
      OnClick = rdgReceitaClick
    end
    object rdgAmbiente: TRadioGroup
      Tag = 10
      Left = 418
      Top = 6
      Width = 200
      Height = 45
      Caption = 'Ambiente'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Produ'#231#227'o'
        'Homologa'#231#227'o')
      TabOrder = 2
      TabStop = True
      Visible = False
      OnClick = rdgReceitaClick
    end
    object rdgVersao: TRadioGroup
      Tag = 10
      Left = 212
      Top = 6
      Width = 200
      Height = 45
      Caption = 'Vers'#227'o'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        '1.00'
        '2.00')
      TabOrder = 1
      TabStop = True
      OnClick = rdgReceitaClick
    end
  end
  object dbgConsulta: TcxGrid [3]
    Left = 0
    Top = 62
    Width = 935
    Height = 580
    Align = alClient
    TabOrder = 2
    TabStop = False
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = True
    LookAndFeel.ScrollbarMode = sbmClassic
    LookAndFeel.SkinName = ''
    object dbgConsultaDBView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsConsulta
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
        end
        item
          Kind = skCount
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.Footer = True
      OptionsView.GridLines = glVertical
      OptionsView.GroupByBox = False
      object dbgConsultaDBViewColumn1: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'CFG_ESTADO'
      end
      object dbgConsultaDBViewColumn2: TcxGridDBColumn
        Caption = 'Detalhemento da Receita'
        DataBinding.FieldName = 'CFG_DETREC'
      end
      object dbgConsultaDBViewColumn3: TcxGridDBColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'CFG_CODPRO'
      end
      object dbgConsultaDBViewColumn4: TcxGridDBColumn
      end
    end
    object dbgConsultaView: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsConsulta
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Kind = skCount
          Column = dbgConsultaViewColumn1
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem registros'
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Styles.Footer = cxStyleZebrado
      Styles.Header = cxStyleZebrado
      Styles.Inactive = cxStyleSelecao
      Styles.Indicator = cxStyleSelecao
      Styles.Selection = cxStyleSelecao
      Styles.StyleSheet = GridBandedTableViewStyleSheetUserFormat3
      Styles.BandHeader = cxStyleZebrado
      Bands = <
        item
          Options.Moving = False
          VisibleForCustomization = False
        end
        item
          Caption = 'Tipos de Documentos'
          Options.Moving = False
          Options.Sizing = False
          VisibleForCustomization = False
          Width = 180
        end
        item
          Caption = 'Campos Extras'
          Options.Moving = False
          VisibleForCustomization = False
          Width = 210
        end>
      object dbgConsultaViewColumn1: TcxGridDBBandedColumn
        Caption = 'UF'
        DataBinding.FieldName = 'CFG_ESTADO'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.ReadOnly = True
        Options.Editing = False
        Options.Filtering = False
        Options.Focusing = False
        Options.Moving = False
        Options.Sorting = False
        Styles.Content = cxStyle2
        Width = 29
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object dbgConsultaViewColumn2: TcxGridDBBandedColumn
        Caption = 'Detalhamento da Receita'
        DataBinding.FieldName = 'CFG_DETREC'
        PropertiesClassName = 'TcxTextEditProperties'
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 125
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object dbgConsultaViewColumn3: TcxGridDBBandedColumn
        Caption = 'Produto'
        DataBinding.FieldName = 'CFG_CODPRO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        Properties.DecimalPlaces = 0
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object dbgConsultaViewColumn4: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CFG_TIPCOD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        Properties.DecimalPlaces = 0
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 50
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object dbgConsultaViewColumn5: TcxGridDBBandedColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'CFG_TIPDOC'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Items = <
          item
            Description = 'Nota Fiscal'
            ImageIndex = 0
            Value = 'NOTA FISCAL'
          end
          item
            Description = 'Chave de Acesso'
            Value = 'CHAVE DE ACESSO'
          end
          item
            Description = 'Nenhum'
          end>
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 125
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object dbgConsultaViewColumn6: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CFG_EXTCOD'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        Properties.DecimalPlaces = 0
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 45
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object dbgConsultaViewColumn7: TcxGridDBBandedColumn
        Caption = 'Tipo'
        DataBinding.FieldName = 'CFG_EXTTIP'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.Items.Strings = (
          'T'
          'D'
          ' ')
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 35
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object dbgConsultaViewColumn8: TcxGridDBBandedColumn
        Caption = 'T'#237'tulo'
        DataBinding.FieldName = 'CFG_EXTDOC'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.Items = <
          item
            Description = 'Nota Fiscal'
            ImageIndex = 0
            Value = 'NOTA FISCAL'
          end
          item
            Description = 'Chave de Acesso'
            Value = 'CHAVE DE ACESSO'
          end
          item
            Description = 'Data de Emiss'#227'o'
            Value = 'DATA DE EMISSAO'
          end
          item
            Description = 'Observa'#231#227'o'
            Value = 'OBSERVACAO'
          end
          item
            Description = 'Nenhum'
            Value = ''
          end>
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 125
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object dbgConsultaViewColumn9: TcxGridDBBandedColumn
        Caption = 'Conv'#234'nio'
        DataBinding.FieldName = 'CFG_CONVEN'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object dbgConsultaViewColumn10: TcxGridDBBandedColumn
        Caption = 'Envia IE'
        DataBinding.FieldName = 'CFG_ENV_IE'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.ImmediatePost = True
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
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 50
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object dbgConsultaViewColumn12: TcxGridDBBandedColumn
        Caption = 'Tipo de Refer'#234'ncia'
        DataBinding.FieldName = 'CFG_TIPREF'
        PropertiesClassName = 'TcxImageComboBoxProperties'
        Properties.ImmediatePost = True
        Properties.Items = <
          item
            Description = 'M'#234's / Ano'
            ImageIndex = 0
            Value = '1'
          end
          item
            Description = 'M'#234's / Ano / Per'#237'odo'
            Value = '2'
          end
          item
            Description = 'M'#234's / Ano / Per'#237'odo / Parcela'
            Value = '3'
          end
          item
            Description = 'Nenhum'
            Value = '0'
          end>
        Options.Filtering = False
        Options.Moving = False
        Options.Sorting = False
        Width = 161
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
    end
    object dbgConsultalevel: TcxGridLevel
      GridView = dbgConsultaView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 704
    Top = 304
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 704
    Top = 272
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 704
    Top = 376
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 215
    Top = 232
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 215
    Top = 264
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Left = 215
    Top = 296
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspConsulta'
    AfterPost = cdsConsultaAfterPost
    Left = 215
    Top = 344
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 704
    Top = 240
    PixelsPerInch = 96
    object cxStyleSelecao: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clBlack
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
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 16775416
      TextColor = clBlack
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 16443110
      TextColor = clBlack
    end
    object cxStyle6: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 13749760
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle7: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14599344
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle8: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 8519755
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = 14481663
    end
    object cxStyle9: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 13749760
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      TextColor = clBlack
    end
    object cxStyle10: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 191
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxStyle11: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 13749760
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      TextColor = clBlack
    end
    object cxStyle12: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlue
    end
    object cxStyle13: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 166
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxStyle14: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 13749760
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      TextColor = clBlack
    end
    object cxStyle15: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle16: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 16775416
      TextColor = clBlack
    end
    object cxStyleZebrado: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 16443110
      TextColor = clBlack
    end
    object cxStyle18: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 13749760
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle19: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14599344
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle20: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 8519755
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = 14481663
    end
    object cxStyle21: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 13749760
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      TextColor = clBlack
    end
    object cxStyle22: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 191
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxStyle23: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 13749760
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      TextColor = clBlack
    end
    object cxStyle24: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlue
    end
    object cxStyle25: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 166
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object GridBandedTableViewStyleSheetUserFormat3: TcxGridBandedTableViewStyleSheet
      Caption = 'UserFormat3'
      Styles.Content = cxStyle15
      Styles.ContentEven = cxStyle16
      Styles.ContentOdd = cxStyleZebrado
      Styles.Footer = cxStyle18
      Styles.Group = cxStyle19
      Styles.GroupByBox = cxStyle20
      Styles.Header = cxStyle21
      Styles.Inactive = cxStyle22
      Styles.Indicator = cxStyle23
      Styles.Preview = cxStyle24
      Styles.Selection = cxStyle25
      Styles.BandHeader = cxStyle14
      BuiltIn = True
    end
  end
end
