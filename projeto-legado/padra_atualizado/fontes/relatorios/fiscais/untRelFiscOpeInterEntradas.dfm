inherited frmRelFiscOpeInterEntradas: TfrmRelFiscOpeInterEntradas
  Left = 502
  Top = 459
  Width = 362
  Height = 290
  Caption = 'Relat'#243'rio de Opera'#231#245'es Interestaduais - Entradas'
  ExplicitWidth = 362
  ExplicitHeight = 290
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 219
    Width = 356
    ExplicitTop = 219
    ExplicitWidth = 356
    inherited FlwBotoes: TFlowPanel
      Width = 275
      ExplicitTop = 2
      ExplicitWidth = 269
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 277
      ExplicitLeft = 277
    end
  end
  inherited pnlDados: TPanel
    Width = 356
    Height = 219
    ExplicitWidth = 356
    ExplicitHeight = 219
    object lblEmpresa: TLabel [0]
      Left = 7
      Top = 78
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel [1]
      Left = 7
      Top = 42
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDesDtaIni: TLabel [2]
      Left = 78
      Top = 24
      Width = 105
      Height = 14
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDesDtaFin: TLabel [3]
      Left = 78
      Top = 60
      Width = 105
      Height = 14
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel [4]
      Left = 7
      Top = 5
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [5]
      Left = 7
      Top = 116
      Width = 33
      Height = 14
      Caption = 'Estado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Top = 157
      TabOrder = 4
      ExplicitTop = 157
    end
    object edtEmpresa: TEditFocus
      Tag = 99
      Left = 7
      Top = 92
      Width = 39
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      OnExit = edtEmpresaExit
      OnKeyPress = edtEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 48
      Top = 92
      Width = 299
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 19
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 54
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object cmbEstados: TComboBoxFocus
      Left = 7
      Top = 130
      Width = 59
      Height = 22
      Style = csOwnerDrawFixed
      Sorted = True
      TabOrder = 3
      OnExit = cmbEstadosExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtDesEstado: TEditFocus
      Left = 66
      Top = 130
      Width = 281
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 245
    Width = 356
    ExplicitTop = 245
    ExplicitWidth = 356
    inherited pnlNomeForm: TPanel
      Left = 185
      ExplicitLeft = 185
    end
    inherited pnlInfo: TPanel
      Width = 185
      ExplicitWidth = 185
      object Shape1: TShape
        Left = 169
        Top = 1
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 536
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 504
    Top = 40
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 568
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 536
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 504
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 472
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 440
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 376
  end
  inherited frxGen: TfrxUserDataSet
    Left = 408
  end
  inherited frxDesigner: TfrxDesigner
    Left = 632
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 664
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 568
  end
end
