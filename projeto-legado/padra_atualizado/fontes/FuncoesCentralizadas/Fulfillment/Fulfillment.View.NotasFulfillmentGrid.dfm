inherited frmNotasFulfillmentGrid: TfrmNotasFulfillmentGrid
  Width = 1024
  Height = 610
  BorderStyle = bsSizeable
  Caption = 'Auditoria de Notas Emitidas pelo Fulfillment - XMLs'
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 610
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 529
    Width = 1008
    TabOrder = 1
    ExplicitTop = 529
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
      inherited btnConfirma: TBitBtnLocked
        Visible = False
      end
      object btnImportar: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 206
        Height = 22
        Caption = '&Importar documentos n'#227'o encontrados'
        ModalResult = 1
        NumGlyphs = 2
        TabOrder = 1
        Visible = False
        OnClick = btnImportarClick
      end
      object btnAbrirXML: TBitBtnLocked
        Left = 281
        Top = 0
        Width = 88
        Height = 22
        Hint = 'Duplo cique na linha para abrir o XML'
        Caption = 'Abrir XML'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          001200000012000000110000000C000000030000000000000000000000087B50
          43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
          59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
          5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
          ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
          62FFFDFBFAFFF7EDE6FF5B524CFF4E443EFF4C413AFF484038FF463D36FF443A
          33FF413731FF3F362FFF3E352DFF3C312BFF393129FF382F27FF0000000BB079
          66FFFDFBFBFFF8EEE8FF5D544DFFFAF8F7FF4D433DFFF9F6F5FF473E37FFF9F4
          F2FF433932FFF7F1EFFF3F362FFFF7F0EDFFF7EEECFF393029FF0000000AB37C
          69FFFEFCFBFFF8F0EAFF5F564FFFFAF8F7FF4E443EFFF9F6F5FF494038FFF8F5
          F3FF453A35FFF7F3F0FF403730FFF7F0EEFF3C322CFF3A312BFF00000009B67F
          6CFFFEFDFCFFF9F0EBFF625952FF88817BFFFAF8F7FF857E78FF4B4139FFF9F6
          F3FF463D36FFF8F2F0FF413831FFF7F1EEFF3E332CFF3C312BFF00000009B983
          71FFFEFDFCFFFAF3EEFF645B55FFFAF9F8FF514740FFFAF8F6FF4D433CFFF9F6
          F5FFF9F5F2FFF9F3F2FF433932FFF7F2EFFF3F352DFF3D322CFF00000008BC88
          77FFFEFEFDFFFBF4EFFF675C56FFFBF9F8FF524841FFFAF8F7FF4E443EFFF9F7
          F5FF493F38FFF9F5F3FF443A33FFF8F2EFFF403630FF3E352DFF00000007BF8C
          7AFFFEFEFDFFFBF6F1FF685E59FF665C55FF635853FF5F564FFF5D524CFF594F
          49FF564B44FF524941FF4E453EFF4B413AFF493F38FF463D35FF00000006C18F
          7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
          82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
          85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
          89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
          67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
          87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
          0002000000030000000400000004000000050000000500000005000000060000
          0006000000060000000600000005000000010000000000000000}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnAbrirXMLClick
      end
      object btnAbrirCSV: TBitBtnLocked
        Left = 369
        Top = 0
        Width = 96
        Height = 22
        Caption = 'Exportar CSV'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00090000000E0000000F00000010000000100000001100000011000000110000
          001200000012000000110000000C000000030000000000000000000000087B50
          43C0AB705CFFAB6F5AFFAB705CFFAA6F5BFFAA6E59FFA96F5AFFAA6D59FFAA6C
          59FFAA6C59FFA96C58FF794D3FC30000000B00000000000000000000000CAD73
          5FFFFDFBF9FFFBF5F2FFFAF5F1FFFAF4F0FFFAF4EFFFFAF2EEFFFAF1EDFFF8F1
          ECFFF8F0EBFFF8F0EAFFD5B6ADFF0000001100000000000000000000000CB077
          62FFFDFBFAFFCEAF69FFBA8D2CFFB68B2AFFB3892AFFB18728FFAF8526FFAD82
          25FFAA7F24FFA77D22FFA67C21FFA57A20FFA2761FFF6C4F14AD0000000BB079
          66FFFDFBFBFFBD932FFFDBC292FFFAF5F4FFF9F5F3FFB3892AFFF8F2F1FFF7F2
          EFFFD2B98AFFAA7E23FFC4A86EFFF5EEEAFFC2A66CFFA1791FFF0000000AB37C
          69FFFEFCFBFFC09430FFFBF7F6FFBB8E2DFFB88D2BFFB58B2AFFB3872AFFAF85
          27FFF7F2EFFFAC8124FFE4D5BCFFCEB686FFE2D3BAFFA37A20FF00000009B67F
          6CFFFEFDFCFFC19531FFFBF8F7FFBC922EFFBA8D2CFFB68C2BFFD7C08EFFF9F4
          F1FFD4BC8CFFAD8225FFF6F1EEFFA97E22FFF6EEEAFFA37B21FF00000009B983
          71FFFEFDFCFFC29732FFFCF8F8FFC0932FFFBB912FFFBA8D2DFFFAF5F3FFB489
          2AFFB18728FFAF8526FFF7F1EFFFAA7F24FFF6F0ECFFA67C21FF00000008BC88
          77FFFEFEFDFFC69933FFDFC996FFFCF8F8FFFAF8F7FFBB912EFFDAC291FFFAF5
          F4FFF8F3F0FFB18728FFF8F2F0FFAC8225FFF6F0EDFFA77D22FF00000007BF8C
          7AFFFEFEFDFFD7B871FFC39932FFC29532FFC09431FFBC922FFFBB8E2DFFB88D
          2CFFB58B2AFFB38729FFB18628FFAE8325FFAC8124FF735618AD00000006C18F
          7FFFFEFEFEFFFAF6F3FFFAF5F3FFFBF6F2FFFBF5F1FFFBF5F0FFFBF5F0FFFAF4
          EFFFFAF4EEFFFDF9F8FFDEC3BAFF0000000B000000000000000000000006C493
          82FFFFFEFEFFFBF7F4FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF4F2FFFBF5
          F1FFFBF5F0FFFDFBF9FFBF8C7BFF0000000B000000000000000000000005C799
          85FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6
          F3FFFCF6F2FFFDFCFAFFC28F7FFF0000000A000000000000000000000004C99A
          89FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
          FDFFFEFDFDFFFEFDFDFFC49382FF000000080000000000000000000000029775
          67C0CA9C8BFFCA9C8BFFC99C8AFFC99B89FFC99B8AFFCA9A88FFC89A88FFC999
          87FFC79887FFC89886FF927163C2000000050000000000000000000000010000
          0002000000030000000400000004000000050000000500000005000000060000
          0006000000060000000600000005000000010000000000000000}
        TabOrder = 3
        OnClick = btnAbrirCSVClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 928
      ExplicitLeft = 928
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 1008
    TabOrder = 2
    ExplicitTop = 555
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 70
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object chkSoInconsis: TCheckBox
      Left = 14
      Top = 14
      Width = 187
      Height = 17
      Caption = 'Mostrar somente inconsist'#234'ncias'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkSoInconsisClick
    end
    object GroupBox1: TGroupBox
      Left = 207
      Top = 6
      Width = 778
      Height = 57
      TabOrder = 1
      object Shape1: TShape
        Left = 13
        Top = 21
        Width = 14
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
      object Label6: TLabel
        Left = 31
        Top = 22
        Width = 180
        Height = 14
        Caption = 'Registros encontrado sem problemas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape2: TShape
        Left = 13
        Top = 37
        Width = 14
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = 4227327
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
      object Label7: TLabel
        Left = 31
        Top = 38
        Width = 281
        Height = 14
        Caption = 'Documento cancelado no XML mas n'#227'o cancelado no livro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape3: TShape
        Left = 321
        Top = 21
        Width = 14
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clPurple
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
      object Label8: TLabel
        Left = 339
        Top = 21
        Width = 407
        Height = 28
        Caption = 
          'Documento n'#227'o encontrado nos zips selecionados (n'#250'mero faltante ' +
          'considerando o intervalo dos n'#250'meros nos xml'#39's selecionados)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Shape4: TShape
        Left = 13
        Top = 5
        Width = 14
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clRed
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
      object Label1: TLabel
        Left = 31
        Top = 6
        Width = 158
        Height = 14
        Caption = 'Chave de Acesso n'#227'o localizada'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Shape5: TShape
        Left = 321
        Top = 5
        Width = 14
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clFuchsia
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
      object Label2: TLabel
        Left = 339
        Top = 6
        Width = 384
        Height = 14
        Caption = 
          'Chave de Acesso n'#227'o localizada  mas o documento foi encontrado p' +
          'elo n'#250'mero'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object cxgNotas: TcxGrid [3]
    Left = 0
    Top = 70
    Width = 1008
    Height = 459
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvNotas: TcxGridDBTableView
      OnKeyDown = cxvNotasKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxvNotasCellDblClick
      OnCustomDrawCell = cxvNotasCustomDrawCell
      DataController.DataSource = dtsNotas
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = ',0'
          Kind = skCount
          Position = spFooter
          Column = cxvNotasKEYACE
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0'
          Kind = skCount
          Column = cxvNotasKEYACE
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      OptionsBehavior.CopyCaptionsToClipboard = False
      OptionsBehavior.CopyRecordsToClipboard = False
      OptionsBehavior.CopyPreviewToClipboard = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum registro encontrado>'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfAlwaysVisible
      Styles.ContentEven = cxStyle1
      object cxvNotasDTAEMI: TcxGridDBColumn
        Caption = 'Dt. Emiss'#227'o'
        DataBinding.FieldName = 'DTAEMI'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 80
      end
      object cxvNotasNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 95
      end
      object cxvNotasESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'ESPDOC'
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 35
      end
      object cxvNotasCODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'CODEMP'
        HeaderAlignmentHorz = taCenter
        Width = 40
      end
      object cxvNotasSERIE_: TcxGridDBColumn
        Caption = 'S'#233'rie'
        DataBinding.FieldName = 'SERIE_'
        OnGetDisplayText = cxvNotasSERIE_GetDisplayText
        HeaderAlignmentHorz = taCenter
        Width = 35
      end
      object cxvNotasCODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CODCLI'
        HeaderAlignmentHorz = taCenter
        Width = 70
      end
      object cxvNotasNOMCLI: TcxGridDBColumn
        Caption = 'Nome do Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Width = 257
      end
      object cxvNotasKEYACE: TcxGridDBColumn
        Caption = 'Chave de Acesso'
        DataBinding.FieldName = 'KEYACE'
        Width = 278
      end
      object cxvNotasSTATUS: TcxGridDBColumn
        Caption = 'Status (Cores)'
        DataBinding.FieldName = 'STATUS'
        Visible = False
      end
      object cxvNotasHISTOR: TcxGridDBColumn
        Caption = 'Hist'#243'rico'
        DataBinding.FieldName = 'HISTOR'
        Width = 200
      end
      object cxvNotasVLRCON: TcxGridDBColumn
        Caption = 'Valor Cont'#225'bil'
        DataBinding.FieldName = 'VLRCON'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Width = 104
      end
      object cxvNotasNOMARQ: TcxGridDBColumn
        Caption = 'Nome do Arqruivo'
        DataBinding.FieldName = 'NOMARQ'
        Width = 420
      end
      object cxvNotasNOMPAT: TcxGridDBColumn
        Caption = 'Pasta'
        DataBinding.FieldName = 'NOMPAT'
        Visible = False
        GroupIndex = 0
      end
      object cxvNotasENCONT: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'ENCONT'
        Visible = False
        OnGetDisplayText = cxvNotasENCONTGetDisplayText
        GroupIndex = 1
      end
    end
    object cxgNotasLevel1: TcxGridLevel
      GridView = cxvNotas
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
    Top = 240
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 384
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 272
    Top = 152
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 104
    Top = 208
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 15066597
    end
  end
  object dtsNotas: TDataSource
    Left = 104
    Top = 280
  end
end
