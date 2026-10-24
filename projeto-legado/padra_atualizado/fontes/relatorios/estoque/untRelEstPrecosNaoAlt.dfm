inherited frmRelEstPrecosNaoAlt: TfrmRelEstPrecosNaoAlt
  Width = 335
  Height = 350
  Caption = 'Relat'#243'rio de Pre'#231'os n'#227'o Alterados'
  OnDestroy = FormDestroy
  ExplicitWidth = 335
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 277
    Width = 329
    ExplicitTop = 277
    ExplicitWidth = 329
    inherited btnSair: TBitBtnLocked
      Left = 248
      ExplicitLeft = 248
    end
  end
  inherited pnlDados: TPanel
    Width = 329
    Height = 277
    ExplicitWidth = 329
    ExplicitHeight = 277
    object Label5: TLabel [0]
      Left = 8
      Top = 8
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
    object Label6: TLabel [1]
      Left = 118
      Top = 8
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
    object lblDescricao: TLabel [2]
      Left = 8
      Top = 46
      Width = 49
      Height = 14
      Caption = 'Descri'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel [3]
      Left = 8
      Top = 84
      Width = 53
      Height = 14
      Caption = 'Refer'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel [4]
      Left = 8
      Top = 122
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [5]
      Left = 8
      Top = 160
      Width = 64
      Height = 14
      Caption = 'Listar Pre'#231'os'
    end
    inherited gpbDestino: TGroupBox
      Left = 129
      Top = 221
      Width = 192
      ExplicitLeft = 129
      ExplicitTop = 221
      ExplicitWidth = 192
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 85
      Height = 22
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 118
      Top = 22
      Width = 86
      Height = 22
      EditMask = '!99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDescri: TEditFocus
      Left = 8
      Top = 60
      Width = 314
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
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtRefere: TEditFocus
      Left = 8
      Top = 98
      Width = 314
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
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 8
      Top = 136
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 5
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFor: TEditFocus
      Left = 66
      Top = 136
      Width = 256
      Height = 22
      Alignment = taLeftJustify
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
    object chkLisPre: TCheckListBox
      Tag = 99
      Left = 8
      Top = 174
      Width = 111
      Height = 97
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 14
      TabOrder = 7
    end
    object rdgOrdena: TRadioGroup
      Left = 129
      Top = 160
      Width = 192
      Height = 60
      Caption = 'Ordenar por'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Descri'#231#227'o'
        'Linha/Grupo'
        'Fornecedor'
        'Marca')
      TabOrder = 8
    end
  end
  inherited pnlStatus: TPanel
    Top = 305
    Width = 329
    ExplicitTop = 305
    ExplicitWidth = 329
    inherited pnlNomeForm: TPanel
      Left = 158
      ExplicitLeft = 158
    end
    inherited pnlInfo: TPanel
      Width = 158
      ExplicitWidth = 158
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 184
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 96
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 152
    Top = 96
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 280
    Top = 64
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 248
    Top = 64
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 216
    Top = 64
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 184
    Top = 64
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 152
    Top = 64
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 216
    Top = 96
  end
  inherited frxGen: TfrxUserDataSet
    Left = 248
    Top = 96
  end
  inherited frxDesigner: TfrxDesigner
    Left = 184
    Top = 128
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 216
    Top = 128
  end
end
