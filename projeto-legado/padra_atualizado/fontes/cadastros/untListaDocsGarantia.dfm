inherited frmListaDocsGarantia: TfrmListaDocsGarantia
  Left = 249
  Top = 171
  Width = 1024
  Height = 504
  BorderIcons = [biSystemMenu]
  Caption = 'Documentos Dentro do Prazo de Garantia'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 504
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 431
    Width = 1018
    ExplicitTop = 431
    ExplicitWidth = 1018
    DesignSize = (
      1018
      28)
    object Label1: TLabel [0]
      Left = 137
      Top = 7
      Width = 564
      Height = 14
      Caption = 
        '* Ao realizar a garantia de um documento de reposi'#231#227'o de garanti' +
        'a, '#233' utilizado os dados documento da venda original'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited FlwBotoes: TFlowPanel
      Left = 931
      Top = -3
      Width = 1
      Height = 3
      Align = alNone
      TabOrder = 2
      ExplicitLeft = 931
      ExplicitTop = -3
      ExplicitWidth = 1
      ExplicitHeight = 3
    end
    inherited btnSair: TBitBtnLocked
      Left = 937
      ExplicitLeft = 937
    end
    object btnConfirmar: TBitBtnLocked
      Left = 3
      Top = 3
      Width = 128
      Height = 22
      Caption = '[ F10 ] Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 459
    Width = 1018
    ExplicitTop = 459
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
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 1018
    Height = 431
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlPrincipal'
    ShowCaption = False
    TabOrder = 2
    object pnlProduto: TPanel
      Left = 0
      Top = 0
      Width = 1018
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlProduto'
      ShowCaption = False
      TabOrder = 0
      object lblProduto: TLabel
        Left = 6
        Top = 13
        Width = 40
        Height = 14
        Caption = 'Produto:'
      end
      object lblQtdIte: TLabel
        Left = 520
        Top = 13
        Width = 102
        Height = 14
        Caption = 'Quantidade Receber:'
        Visible = False
      end
      object lblQtdSel: TLabel
        Left = 698
        Top = 13
        Width = 87
        Height = 14
        Caption = 'Total Selecionado:'
        Visible = False
      end
      object edtCodIte: TEditFocus
        Tag = 99
        Left = 52
        Top = 10
        Width = 110
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesIte: TEditFocus
        Left = 168
        Top = 10
        Width = 338
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtQtdRec: TEditFocus
        Tag = 99
        Left = 626
        Top = 10
        Width = 62
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 2
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object edtTotSel: TEditFocus
        Tag = 99
        Left = 789
        Top = 10
        Width = 62
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 3
        Visible = False
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
    end
    object pnlGrid: TPanel
      Left = 0
      Top = 41
      Width = 1018
      Height = 390
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlGrid'
      ShowCaption = False
      TabOrder = 1
      object cxGrid: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1018
        Height = 390
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBTableViewCitel1: TcxGridDBTableViewCitel
          OnDblClick = cxGridDBTableViewCitel1DblClick
          OnKeyDown = cxGridDBTableViewCitel1KeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxGridDBTableViewCitel1CustomDrawCell
          DataController.DataSource = dtsDocumentos
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridDBTableViewCitelQTDSEL: TcxGridDBColumn
            Caption = 'Qde Selec'
            DataBinding.FieldName = 'QTDSEL'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ValidationOptions = []
            Width = 76
          end
          object cxGridDBTableViewCitel1NUMDOC: TcxGridDBColumn
            DataBinding.FieldName = 'NUMDOC'
            Options.Editing = False
            Width = 109
          end
          object cxGridDBTableViewCitel1SERIE_: TcxGridDBColumn
            Caption = 'S'#233'rie'
            DataBinding.FieldName = 'SERIE_'
            Options.Editing = False
            Width = 32
          end
          object cxGridDBTableViewCitel1EMPDOC: TcxGridDBColumn
            Caption = 'Emp.'
            DataBinding.FieldName = 'EMPDOC'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 32
          end
          object cxGridDBTableViewCitel1DTAENT: TcxGridDBColumn
            DataBinding.FieldName = 'DTAENT'
            Options.Editing = False
            Width = 60
          end
          object cxGridDBTableViewCitel1TMPGAR: TcxGridDBColumn
            DataBinding.FieldName = 'TMPGAR'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 80
          end
          object cxGridDBTableViewCitel1DTAFIN: TcxGridDBColumn
            DataBinding.FieldName = 'DTAFIN'
            Options.Editing = False
            Width = 60
          end
          object cxGridDBTableViewCitel1VALUNT: TcxGridDBColumn
            Caption = 'Valor Unit'#225'rio'
            DataBinding.FieldName = 'VALUNT'
            Options.Editing = False
          end
          object cxGridDBTableViewCitel1VENDA_: TcxGridDBColumn
            DataBinding.FieldName = 'VENDA_'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 68
          end
          object cxGridDBTableViewCitel1FORNEC: TcxGridDBColumn
            DataBinding.FieldName = 'FORNEC'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 73
          end
          object cxGridDBTableViewCitel1DEVOLU: TcxGridDBColumn
            Caption = 'Devolu'#231#227'o'
            DataBinding.FieldName = 'DEVOLU'
            Options.Editing = False
          end
          object cxGridDBTableViewCitel1DISPON: TcxGridDBColumn
            DataBinding.FieldName = 'DISPON'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 73
          end
          object cxGridDBTableViewCitel1REPOR_: TcxGridDBColumn
            DataBinding.FieldName = 'REPOR_'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 73
          end
          object cxGridDBTableViewCitel1REFUGO: TcxGridDBColumn
            DataBinding.FieldName = 'REFUGO'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 59
          end
          object cxGridDBTableViewCitel1PREJUI: TcxGridDBColumn
            DataBinding.FieldName = 'PREJUI'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 58
          end
          object cxGridDBTableViewCitel1DOCFAT: TcxGridDBColumn
            Caption = 'Doc. Confirma'#231#227'o'
            DataBinding.FieldName = 'DOCFAT'
            Options.Editing = False
            Width = 120
          end
          object cxGridDBTableViewCitel1DOCVEN: TcxGridDBColumn
            Caption = '*Documento da Venda'
            DataBinding.FieldName = 'DOCVEN'
            Options.Editing = False
          end
          object cxGridDBTableViewCitel1MARDES: TcxGridDBColumn
            DataBinding.FieldName = 'MARDES'
            Visible = False
            Options.Editing = False
          end
          object cxGridDBTableViewCitel1TABELA: TcxGridDBColumn
            DataBinding.FieldName = 'TABELA'
            Visible = False
            Options.Editing = False
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableViewCitel1
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 460
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 80
  end
  object dtsDocumentos: TDataSource
    DataSet = cdsDocumentos
    Left = 520
    Top = 152
  end
  object cdsDocumentos: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'IDX_DTAENT'
        Fields = 'DTAENT'
      end>
    IndexName = 'IDX_DTAENT'
    Params = <>
    StoreDefs = True
    BeforePost = cdsDocumentosBeforePost
    AfterPost = cdsDocumentosAfterPost
    OnNewRecord = cdsDocumentosNewRecord
    Left = 492
    Top = 152
    object cdsDocumentosNUMDOC: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'NUMDOC'
    end
    object cdsDocumentosEMPDOC: TStringField
      FieldName = 'EMPDOC'
      Size = 3
    end
    object cdsDocumentosTMPGAR: TIntegerField
      DisplayLabel = 'Prazo (Meses)'
      FieldName = 'TMPGAR'
      DisplayFormat = '#,##0.00'
    end
    object cdsDocumentosDTAENT: TDateTimeField
      DisplayLabel = 'Dt. Venda'
      FieldName = 'DTAENT'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsDocumentosDTAFIN: TDateTimeField
      DisplayLabel = 'Dt. T'#233'rmino'
      FieldName = 'DTAFIN'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object cdsDocumentosVENDA_: TFloatField
      DisplayLabel = 'Venda'
      FieldName = 'VENDA_'
      DisplayFormat = '#,##0.00'
    end
    object cdsDocumentosVALITE: TFloatField
      FieldName = 'VALITE'
      DisplayFormat = '#,##0.00'
    end
    object cdsDocumentosDISPON: TFloatField
      DisplayLabel = 'Dispon'#237'vel'
      FieldName = 'DISPON'
      DisplayFormat = '#,##0.00'
    end
    object cdsDocumentosFORNEC: TFloatField
      DisplayLabel = 'Fornecedor'
      FieldName = 'FORNEC'
      DisplayFormat = '#,##0.00'
    end
    object cdsDocumentosREPOR_: TFloatField
      DisplayLabel = 'A Repor'
      FieldName = 'REPOR_'
      DisplayFormat = '#,##0.00'
    end
    object cdsDocumentosREFUGO: TFloatField
      DisplayLabel = 'Refugo'
      FieldName = 'REFUGO'
      DisplayFormat = '#,##0.00'
    end
    object cdsDocumentosPREJUI: TFloatField
      DisplayLabel = 'Preju'#237'zo'
      FieldName = 'PREJUI'
      DisplayFormat = '#,##0.00'
    end
    object cdsDocumentosMARDES: TStringField
      FieldName = 'MARDES'
      Size = 1
    end
    object cdsDocumentosDET_NUMDOC: TStringField
      FieldName = 'DET_NUMDOC'
      Size = 12
    end
    object cdsDocumentosDET_ESPDOC: TStringField
      FieldName = 'DET_ESPDOC'
      Size = 2
    end
    object cdsDocumentosDEVOLU: TFloatField
      FieldName = 'DEVOLU'
      DisplayFormat = '#,##0.00'
    end
    object cdsDocumentosCODVEN: TStringField
      FieldName = 'CODVEN'
      Size = 3
    end
    object cdsDocumentosSERIE_: TStringField
      FieldName = 'SERIE_'
      Size = 3
    end
    object cdsDocumentosDET_SERIE_: TStringField
      FieldName = 'DET_SERIE_'
      Size = 3
    end
    object cdsDocumentosDET_DESACE: TFloatField
      FieldName = 'DET_DESACE'
    end
    object cdsDocumentosDOCFAT: TStringField
      FieldName = 'DOCFAT'
    end
    object cdsDocumentosSEQDOC: TStringField
      FieldName = 'SEQDOC'
    end
    object cdsDocumentosINCORI: TStringField
      FieldName = 'INCORI'
    end
    object cdsDocumentosDOCVEN: TStringField
      FieldName = 'DOCVEN'
    end
    object cdsDocumentosVALUNT: TFloatField
      FieldName = 'VALUNT'
    end
    object cdsDocumentosTABELA: TStringField
      FieldName = 'TABELA'
      ProviderFlags = []
      Size = 6
    end
    object cdsDocumentosQTDSEL: TFloatField
      DisplayLabel = 'Qtd'
      FieldName = 'QTDSEL'
      ProviderFlags = []
      OnValidate = cdsDocumentosQTDSELValidate
    end
    object cdsDocumentosQTDSELANT: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'QTDSELANT'
    end
    object cdsDocumentosUNICRD: TFloatField
      FieldName = 'UNICRD'
    end
    object cdsDocumentosDET_UNITAR: TFloatField
      FieldName = 'DET_UNITAR'
    end
    object cdsDocumentosDET_DESESP: TFloatField
      FieldName = 'DET_DESESP'
    end
    object cdsDocumentosDET_DESCFF: TFloatField
      FieldName = 'DET_DESCFF'
    end
    object cdsDocumentosTOTSEL: TAggregateField
      FieldName = 'TOTSEL'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDSEL)'
    end
  end
end
