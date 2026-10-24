inherited frmFatRomaneioCaixas: TfrmFatRomaneioCaixas
  Width = 758
  Height = 600
  BorderStyle = bsDialog
  Caption = 'Gera'#231#227'o de Romaneio por C'#243'digo de Barras de Volumes'
  Position = poOwnerFormCenter
  ExplicitWidth = 758
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  object Label13: TLabel [0]
    Left = 76
    Top = 15
    Width = 78
    Height = 14
    Alignment = taRightJustify
    Caption = 'Transportadora:'
  end
  object Label1: TLabel [1]
    Left = 7
    Top = 42
    Width = 147
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'd.barras etiqueta do volume'
  end
  object Label2: TLabel [2]
    Left = 17
    Top = 70
    Width = 137
    Height = 14
    Alignment = taRightJustify
    Caption = #218'ltimo c'#243'd.barras carregado'
  end
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 752
    TabOrder = 3
    ExplicitTop = 527
    ExplicitWidth = 752
    inherited FlwBotoes: TFlowPanel
      Width = 748
      TabOrder = 3
    end
    inherited btnSair: TBitBtnLocked
      Left = 669
      TabOrder = 2
      ExplicitLeft = 669
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 92
      Height = 22
      Caption = '[F10] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnDeletaDocumento: TBitBtnLocked
      Left = 102
      Top = 3
      Width = 140
      Height = 22
      Caption = '[F6] Remover Documento'
      TabOrder = 1
      OnClick = btnDeletaDocumentoClick
    end
  end
  object edtCodTra: TEditFocus [5]
    Tag = 99
    Left = 158
    Top = 11
    Width = 65
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 5
    TabOrder = 0
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
  object edtDesTra: TEditFocus [6]
    Left = 224
    Top = 11
    Width = 515
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
  object blnSituacao: TPanel [7]
    Left = 365
    Top = 68
    Width = 20
    Height = 20
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clGreen
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 6
  end
  object edtCodBar: TEditFocus [8]
    Tag = 99
    Left = 160
    Top = 39
    Width = 200
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 23
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 23
    TipoTexto = ttAlfanumerico
  end
  object edtCodBarUltimo: TEditFocus [9]
    Tag = 99
    Left = 160
    Top = 67
    Width = 200
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 15
    ReadOnly = True
    TabOrder = 2
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 15
    TipoTexto = ttAlfanumerico
  end
  object cxGrid: TcxGrid [10]
    Left = 0
    Top = 97
    Width = 752
    Height = 430
    Align = alBottom
    TabOrder = 7
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridDBDocumentos: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridDBDocumentosCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxGridDBDocumentosDTAENT: TcxGridDBColumn
        Caption = 'Dt.Venda'
        DataBinding.FieldName = 'DTAENT'
        Options.Editing = False
        Options.Focusing = False
        Width = 75
      end
      object cxGridDBDocumentosDOCUMENTO: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'DOCUMENTO'
        Options.Editing = False
        Options.Focusing = False
        Width = 120
      end
      object cxGridDBDocumentosCODCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CODCLI'
        Options.Editing = False
        Options.Focusing = False
        Width = 63
      end
      object cxGridDBDocumentosNOMCLI: TcxGridDBColumn
        Caption = 'Nome do Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Options.Editing = False
        Options.Focusing = False
        Width = 300
      end
      object cxGridDBDocumentosCODVEN: TcxGridDBColumn
        Caption = 'Vendedor'
        DataBinding.FieldName = 'CODVEN'
        Options.Editing = False
        Options.Focusing = False
        Width = 56
      end
      object cxGridDBDocumentosVLRCON: TcxGridDBColumn
        Caption = 'Vr.Documento'
        DataBinding.FieldName = 'VLRCON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Focusing = False
        Width = 85
      end
      object cxGridDBDocumentosVOLUME: TcxGridDBColumn
        Caption = 'Volume'
        DataBinding.FieldName = 'VOLUME'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Options.Focusing = False
        Width = 62
      end
      object cxGridDBDocumentosOK: TcxGridDBColumn
        DataBinding.FieldName = 'OK'
        Visible = False
        Options.Editing = False
        Options.Focusing = False
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBDocumentos
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 752
    TabOrder = 4
    ExplicitTop = 555
    ExplicitWidth = 752
    inherited pnlNomeForm: TPanel
      Left = 581
      ExplicitLeft = 581
    end
    inherited pnlInfo: TPanel
      Width = 581
      ExplicitWidth = 581
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 192
    Top = 328
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 224
    Top = 328
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 160
    Top = 328
  end
  object cdsDocumentos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 304
    Top = 328
    object cdsDocumentosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsDocumentosDOCUMENTO: TStringField
      FieldName = 'DOCUMENTO'
    end
    object cdsDocumentosNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsDocumentosESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsDocumentosCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsDocumentosCODBAR: TStringField
      FieldName = 'CODBAR'
      Size = 50
    end
    object cdsDocumentosDTAENT: TDateField
      FieldName = 'DTAENT'
    end
    object cdsDocumentosCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsDocumentosNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 40
    end
    object cdsDocumentosCODVEN: TStringField
      FieldName = 'CODVEN'
      Size = 3
    end
    object cdsDocumentosVLRCON: TFloatField
      FieldName = 'VLRCON'
    end
    object cdsDocumentosTABELA: TStringField
      FieldName = 'TABELA'
      Size = 10
    end
    object cdsDocumentosCODTRA: TStringField
      FieldName = 'CODTRA'
      Size = 5
    end
    object cdsDocumentosOK: TStringField
      FieldName = 'OK'
      Size = 1
    end
    object cdsDocumentosVOLUME: TStringField
      FieldName = 'VOLUME'
      Size = 8
    end
    object cdsDocumentosQTDVOL: TIntegerField
      FieldName = 'QTDVOL'
    end
    object cdsDocumentosTOTVOL: TIntegerField
      FieldName = 'TOTVOL'
    end
  end
  object cdsCodBar: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 328
    object StringField3: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object StringField4: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object StringField5: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object StringField6: TStringField
      FieldName = 'CODBAR'
      Size = 50
    end
    object cdsCodBarSEQVOL: TIntegerField
      FieldName = 'SEQVOL'
    end
  end
end
