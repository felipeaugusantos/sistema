inherited frmRelEtiqQtdRestante: TfrmRelEtiqQtdRestante
  Width = 506
  Height = 418
  Caption = 'Impress'#227'o de Etiquetas de quantidade restante de item'
  OnDestroy = FormDestroy
  ExplicitWidth = 506
  ExplicitHeight = 418
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 345
    Width = 500
    ExplicitTop = 345
    ExplicitWidth = 500
    inherited btnSair: TBitBtnLocked
      Left = 418
      ExplicitLeft = 418
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 7
      ExplicitLeft = 7
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 85
      ExplicitLeft = 85
    end
  end
  inherited pnlDados: TPanel
    Width = 500
    Height = 345
    ExplicitWidth = 500
    ExplicitHeight = 345
    object Label2: TLabel [0]
      Left = 8
      Top = 6
      Width = 58
      Height = 14
      AutoSize = False
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblQuantidade: TLabel [1]
      Left = 8
      Top = 196
      Width = 81
      Height = 14
      Caption = 'Qtde. do produto'
    end
    object Label1: TLabel [2]
      Left = 95
      Top = 196
      Width = 91
      Height = 14
      Caption = 'Qtde. de Etiquetas:'
    end
    object Label3: TLabel [3]
      Left = 8
      Top = 161
      Width = 58
      Height = 14
      AutoSize = False
      Caption = 'Conferente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel [4]
      Left = 8
      Top = 231
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente'
    end
    object lblCodEmp: TLabel [5]
      Left = 9
      Top = 267
      Width = 42
      Height = 14
      Caption = 'Empresa'
    end
    object lbl2: TLabel [6]
      Left = 8
      Top = 303
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento'
    end
    object lbl3: TLabel [7]
      Left = 95
      Top = 303
      Width = 38
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie'
    end
    inherited gpbDestino: TGroupBox
      Left = 353
      Top = 196
      TabOrder = 4
      ExplicitLeft = 353
      ExplicitTop = 196
      inherited edtDestino: TEditFocus
        Text = 'I'
      end
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 8
      Top = 19
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttInteiro
    end
    object edtDesIte: TEditFocus
      Left = 73
      Top = 19
      Width = 418
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdIte: TEditFocus
      Tag = 99
      Left = 8
      Top = 209
      Width = 65
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtQtdEti: TEditFocus
      Tag = 99
      Left = 95
      Top = 209
      Width = 65
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      Text = '1'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
      EditFormat = '#,##0.00'
    end
    object edtCodCon: TEditFocus
      Tag = 99
      Left = 8
      Top = 174
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtCodConKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomCon: TEditFocus
      Left = 73
      Top = 174
      Width = 418
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cxgEmbala: TcxGrid
      Left = 8
      Top = 48
      Width = 483
      Height = 111
      TabOrder = 13
      TabStop = False
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgEmbalaView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        FilterBox.Visible = fvNever
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ColumnHeaderHints = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.GroupByBox = False
        object cxgEmbalaCodBar: TcxGridDBColumn
          AlternateCaption = 'cxgEmbalaCodBar'
          Caption = 'C'#243'digo de Barras'
          DataBinding.FieldName = 'BAR_CODBAR'
          Options.Editing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 107
        end
        object cxgEmbalaEmbala: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'BAR_EMBALA'
          HeaderAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 70
        end
        object cxgEmbalaPrinci: TcxGridDBColumn
          Caption = 'Principal'
          DataBinding.FieldName = 'BAR_PRINCI'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 49
        end
        object cxgEmbalaCompra: TcxGridDBColumn
          Caption = 'Principal para Compras'
          DataBinding.FieldName = 'BAR_COMPRA'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          Width = 120
        end
        object cxgEmbalaExbFat: TcxGridDBColumn
          Caption = 'Exibir no Faturamento'
          DataBinding.FieldName = 'BAR_EXBFAT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          HeaderAlignmentHorz = taCenter
          Width = 113
        end
      end
      object cxgEmbalaLevel1: TcxGridLevel
        GridView = cxgEmbalaView
      end
    end
    object edtNomCli: TEditFocus
      Left = 81
      Top = 244
      Width = 350
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 7
      Top = 281
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 7
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 81
      Top = 281
      Width = 350
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumDoc: TEditFocus
      Left = 8
      Top = 317
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 95
      Top = 317
      Width = 40
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfabetico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 7
      Top = 244
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 5
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 373
    Width = 500
    ExplicitTop = 373
    ExplicitWidth = 500
    inherited pnlNomeForm: TPanel
      Left = 329
      ExplicitLeft = 329
    end
    inherited pnlInfo: TPanel
      Width = 329
      ExplicitWidth = 329
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 72
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 512
    Top = 104
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 512
    Top = 72
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 512
    Top = 40
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 576
    Top = 104
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 544
    Top = 104
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 576
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 544
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 576
    Top = 72
  end
  inherited frxGen: TfrxUserDataSet
    Left = 512
  end
  inherited frxDesigner: TfrxDesigner
    Left = 576
    Top = 40
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 608
    Top = 40
  end
end
