object frmSelDocumentosReferenciar: TfrmSelDocumentosReferenciar
  Left = 0
  Top = 0
  Caption = 'Documentos para referenciar'
  ClientHeight = 462
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 434
    Width = 737
    Height = 28
    Align = alBottom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      737
      28)
    object btnSair: TBitBtnLocked
      Left = 655
      Top = 3
      Width = 77
      Height = 22
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'C&ancela'
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
      ModalResult = 2
      TabOrder = 1
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 75
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  object pnlCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 737
    Height = 110
    Align = alTop
    TabOrder = 1
    object lblCliFor: TLabel
      Left = 12
      Top = 8
      Width = 390
      Height = 18
      Caption = 'Cliente ou Fornecedor: NOME DO CLIENTE / FORNECEDOR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 12
      Top = 67
      Width = 40
      Height = 13
      Caption = 'Per'#237'odo:'
    end
    object Label2: TLabel
      Left = 96
      Top = 83
      Width = 6
      Height = 13
      Caption = 'a'
    end
    object lblNumDoc: TLabel
      Left = 12
      Top = 29
      Width = 54
      Height = 13
      Caption = 'Documento'
    end
    object lblEspDoc: TLabel
      Left = 96
      Top = 29
      Width = 36
      Height = 13
      Caption = 'Esp'#233'cie'
    end
    object mskDtaIni: TMaskEditFocus
      Left = 12
      Top = 80
      Width = 78
      Height = 21
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Left = 106
      Top = 80
      Width = 78
      Height = 21
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object btnFiltrar: TBitBtnLocked
      Left = 190
      Top = 80
      Width = 75
      Height = 22
      Caption = '&Filtrar'
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btnFiltrarClick
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 12
      Top = 44
      Width = 82
      Height = 21
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      OnChange = edtEspDocChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 96
      Top = 44
      Width = 38
      Height = 21
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 1
      OnChange = edtEspDocChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgDocumentos: TcxGrid
    Left = 0
    Top = 110
    Width = 737
    Height = 324
    Align = alClient
    TabOrder = 2
    object dbgDocumentosDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.Visible = fvNever
      DataController.DataSource = dtsDocumentos
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = 'Nenhum registro para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object FIS_NUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'FIS_NUMDOC'
        Width = 89
      end
      object FIS_ESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'FIS_ESPDOC'
        Width = 63
      end
      object FIS_CODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'FIS_CODEMP'
        Width = 62
      end
      object FIS_DTAENT: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'FIS_DTAENT'
        Width = 111
      end
      object FIS_ACESSO: TcxGridDBColumn
        Caption = 'Chave de Acesso'
        DataBinding.FieldName = 'FIS_ACESSO'
        Width = 216
      end
      object FIS_NUMSER: TcxGridDBColumn
        Caption = 'N'#250'mero de S'#233'rie'
        DataBinding.FieldName = 'FIS_NUMSER'
        Width = 103
      end
      object FIS_NUMCOO: TcxGridDBColumn
        Caption = 'COO'
        DataBinding.FieldName = 'FIS_NUMCOO'
        Width = 91
      end
    end
    object dbgDocumentosLevel: TcxGridLevel
      GridView = dbgDocumentosDBTableView
    end
  end
  object dtsDocumentos: TDataSource
    Left = 568
    Top = 176
  end
end
