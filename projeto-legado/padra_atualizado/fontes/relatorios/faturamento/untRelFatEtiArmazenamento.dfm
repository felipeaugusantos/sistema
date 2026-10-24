inherited frmRelFatEtiArmazenamento: TfrmRelFatEtiArmazenamento
  Width = 376
  Height = 211
  Caption = 'Etiqueta de Armazenamento'
  ExplicitWidth = 376
  ExplicitHeight = 211
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 140
    Width = 370
    ExplicitTop = 140
    ExplicitWidth = 370
    inherited FlwBotoes: TFlowPanel
      Width = 289
      ExplicitWidth = 289
    end
    inherited btnSair: TBitBtnLocked
      Left = 291
      ExplicitLeft = 291
    end
  end
  inherited pnlStatus: TPanel
    Top = 166
    Width = 370
    ExplicitTop = 166
    ExplicitWidth = 370
    inherited pnlNomeForm: TPanel
      Left = 199
      ExplicitLeft = 199
    end
    inherited pnlInfo: TPanel
      Width = 199
      ExplicitWidth = 199
    end
  end
  inherited pnlDados: TPanel
    Width = 370
    Height = 140
    ExplicitWidth = 370
    ExplicitHeight = 140
    object Label2: TLabel [0]
      Left = 9
      Top = 8
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
      Left = 9
      Top = 50
      Width = 81
      Height = 14
      Caption = 'Qtd. de Produtos'
    end
    object Label1: TLabel [2]
      Left = 9
      Top = 92
      Width = 82
      Height = 14
      Caption = 'Qtd. de Etiquetas'
    end
    inherited gpbDestino: TGroupBox
      Left = 223
      Top = 83
      TabOrder = 4
      ExplicitLeft = 223
      ExplicitTop = 83
      inherited edtDestino: TEditFocus
        Top = 17
        ExplicitTop = 17
      end
    end
    object edtCodIte: TEditFocus
      Tag = 99
      Left = 9
      Top = 22
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
      Left = 74
      Top = 22
      Width = 287
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
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
      Left = 9
      Top = 64
      Width = 64
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
      Left = 9
      Top = 106
      Width = 64
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 600
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 568
    Top = 200
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 568
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 632
    Top = 104
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 600
    Top = 104
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 568
    Top = 104
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 632
    Top = 56
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 600
    Top = 56
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 632
  end
  inherited frxGen: TfrxUserDataSet
    Left = 568
    Top = 56
  end
  inherited frxDesigner: TfrxDesigner
    Left = 568
    Top = 152
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 600
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 640
    Top = 152
  end
  object UniClientDataSet1: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 88
  end
end
