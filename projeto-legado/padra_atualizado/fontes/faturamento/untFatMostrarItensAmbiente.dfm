inherited frmFatMostrarItensAmbiente: TfrmFatMostrarItensAmbiente
  Width = 968
  Height = 512
  Caption = 'Mostrar Itens por Ambiente'
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  ExplicitWidth = 968
  ExplicitHeight = 512
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 439
    Width = 962
    ExplicitTop = 439
    ExplicitWidth = 962
    inherited FlwBotoes: TFlowPanel
      Width = 958
      ExplicitWidth = 958
    end
    inherited btnSair: TBitBtnLocked
      Left = 879
      ExplicitLeft = 879
    end
  end
  inherited pnlStatus: TPanel
    Top = 467
    Width = 962
    ExplicitTop = 467
    ExplicitWidth = 962
    inherited pnlNomeForm: TPanel
      Left = 791
      ExplicitLeft = 791
    end
    inherited pnlInfo: TPanel
      Width = 791
      ExplicitWidth = 791
    end
  end
  object cxgrdDadosProdutos: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 962
    Height = 357
    Align = alClient
    TabOrder = 3
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgrdDadosProdutosDBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsDadosProdutos
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = ITE_TOTITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = ITE_TOTITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = ITE_TOTORI
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = ITE_TOTORI
        end
        item
          Format = '#,##0.00'
          Position = spFooter
          Column = ITE_PERDES
        end
        item
          Format = '#,##0.00'
          Column = ITE_PERDES
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = ITE_TOTITE
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = ITE_TOTORI
        end
        item
          Format = '#,##0.00'
          OnGetText = cxgrdDadosProdutosDBTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText
          Column = ITE_PERDES
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfAlwaysVisible
      Styles.Footer = cxsFooter
      Styles.Group = cxsGroup
      Styles.GroupFooterSortedSummary = cxsFooter
      Styles.GroupSortedSummary = cxsFooter
      Styles.Header = cxsHeader
      object AUTOINCREM: TcxGridDBColumn
        Caption = 'N'#186
        DataBinding.FieldName = 'AUTOINCREM'
      end
      object ITE_COMPLE: TcxGridDBColumn
        Caption = 'Ambiente'
        DataBinding.FieldName = 'ITE_COMPLE'
        Visible = False
        GroupIndex = 0
        Options.Moving = False
        SortIndex = 0
        SortOrder = soAscending
      end
      object ITE_CODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODITE'
        Width = 50
      end
      object ITE_DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'ITE_DESITE'
        Width = 216
      end
      object ITE_DESMAR: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'ITE_DESMAR'
        Width = 86
      end
      object ITE_CODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. de F'#225'brica'
        DataBinding.FieldName = 'ITE_CODFAB'
      end
      object ITE_REFERE: TcxGridDBColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'ITE_REFERE'
      end
      object ITE_ENTRET: TcxGridDBColumn
        Caption = 'Ent.'
        DataBinding.FieldName = 'ITE_ENTRET'
        Width = 28
      end
      object ITE_MOTFUT: TcxGridDBColumn
        Caption = 'Mot.'
        DataBinding.FieldName = 'ITE_MOTFUT'
        Width = 34
      end
      object ITE_CLIBUS: TcxGridDBColumn
        Caption = 'C.Ret.'
        DataBinding.FieldName = 'ITE_CLIBUS'
        Width = 39
      end
      object ITE_ENTSAI: TcxGridDBColumn
        Caption = 'E/S'
        DataBinding.FieldName = 'ITE_ENTSAI'
        Width = 34
      end
      object UNI_SIGUNI: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'UNI_SIGUNI'
        Width = 35
      end
      object ITE_QTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'ITE_QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object ITE_UNITAR: TcxGridDBColumn
        Caption = 'Vr. Unit'#225'rio'
        DataBinding.FieldName = 'ITE_UNITAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taRightJustify
        Width = 74
      end
      object ITE_TOTITE: TcxGridDBColumn
        Caption = 'Vr. Total'
        DataBinding.FieldName = 'ITE_TOTITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taRightJustify
        Width = 98
      end
      object ITE_TOTORI: TcxGridDBColumn
        Caption = 'Tot. Valor Original'
        DataBinding.FieldName = 'ITE_TOTORI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taRightJustify
      end
      object ITE_PERDES: TcxGridDBColumn
        Caption = '% Desc.'
        DataBinding.FieldName = 'ITE_PERDES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taRightJustify
      end
    end
    object cxgrdlvlDadosProdutosLevel1: TcxGridLevel
      GridView = cxgrdDadosProdutosDBTableView1
    end
  end
  object pnlRodape: TPanel [4]
    Left = 0
    Top = 357
    Width = 962
    Height = 82
    Align = alBottom
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 4
    Visible = False
    object lblDesPro: TLabel
      Left = 32
      Top = 33
      Width = 159
      Height = 14
      Caption = 'Profissionais do documento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValFre: TLabel
      Left = 32
      Top = 8
      Width = 163
      Height = 14
      Caption = 'Valor do Frete do Documento:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblProfisional: TLabel
      Left = 194
      Top = 33
      Width = 3
      Height = 14
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtValFre: TEditFocus
      Left = 200
      Top = 5
      Width = 121
      Height = 22
      Alignment = taRightJustify
      Color = 16627128
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnProfissionais: TBitBtnLocked
      Left = 32
      Top = 53
      Width = 121
      Height = 25
      Caption = 'Todos Profissionais'
      TabOrder = 1
      Visible = False
      OnClick = btnProfissionaisClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 432
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 464
    Top = 96
  end
  object dsDadosProdutos: TDataSource
    Left = 505
    Top = 95
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 536
    Top = 96
    PixelsPerInch = 96
    object cxsGroup: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxsHeader: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxsFooter: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object cdsProfissionais: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 784
    Top = 144
    object cdsProfissionaisCODDIV: TStringField
      FieldName = 'CODDIV'
      Size = 8
    end
    object cdsProfissionaisNOMDIV: TStringField
      FieldName = 'NOMDIV'
      Size = 40
    end
  end
end
