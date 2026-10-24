inherited frmRelFatLogLib: TfrmRelFatLogLib
  Left = 504
  Top = 258
  Width = 326
  Height = 407
  Caption = 'Relat'#243'rio de Log de Libera'#231#227'o Remota (Liberados)'
  ExplicitWidth = 326
  ExplicitHeight = 407
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 335
    Width = 320
    ExplicitTop = 335
    ExplicitWidth = 320
    inherited btnSair: TBitBtnLocked
      Left = 239
      ExplicitLeft = 239
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 3
      ExplicitLeft = 3
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 81
      ExplicitLeft = 81
    end
  end
  inherited pnlDados: TPanel
    Width = 320
    Height = 335
    ExplicitWidth = 320
    ExplicitHeight = 335
    object Label11: TLabel [0]
      Left = 7
      Top = 82
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
    object lblDesDtaIni: TLabel [1]
      Left = 78
      Top = 64
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
    object lblDesDtaFin: TLabel [2]
      Left = 78
      Top = 100
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
    object Label12: TLabel [3]
      Left = 7
      Top = 45
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
    object Label1: TLabel [4]
      Left = 7
      Top = 118
      Width = 46
      Height = 14
      Caption = 'Operador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [5]
      Left = 7
      Top = 196
      Width = 97
      Height = 14
      Caption = 'Operador Libera'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [6]
      Left = 7
      Top = 6
      Width = 54
      Height = 14
      Caption = 'Documento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel [7]
      Left = 90
      Top = 6
      Width = 18
      Height = 14
      Caption = 'Esp'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel [8]
      Left = 7
      Top = 234
      Width = 140
      Height = 14
      Caption = 'Palavra-chave na Solicita'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [9]
      Left = 7
      Top = 158
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
    inherited gpbDestino: TGroupBox
      Top = 276
      Width = 202
      TabOrder = 11
      ExplicitTop = 276
      ExplicitWidth = 202
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 59
      Width = 66
      Height = 22
      EditMask = '99/99/9999;1;_'
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
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 94
      Width = 68
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodOpe: TEditFocus
      Left = 7
      Top = 132
      Width = 58
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 4
      OnExit = edtCodOpeExit
      OnKeyPress = edtCodOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesOpe: TEditFocus
      Left = 66
      Top = 132
      Width = 245
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
    object edtOpeLib: TEditFocus
      Left = 7
      Top = 210
      Width = 58
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 8
      OnExit = edtOpeLibExit
      OnKeyPress = edtOpeLibKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesOpeLib: TEditFocus
      Left = 66
      Top = 210
      Width = 245
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumDoc: TEditFocus
      Left = 7
      Top = 21
      Width = 81
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      OnExit = edtEspecieExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspecie: TEditFocus
      Left = 90
      Top = 21
      Width = 31
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 1
      OnExit = edtEspecieExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtMotLib: TEditFocus
      Left = 7
      Top = 248
      Width = 304
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = clWindow
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
      Top = 172
      Width = 58
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 6
      OnExit = edtCodEmpExit
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmp: TEditFocus
      Left = 66
      Top = 172
      Width = 245
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 327
      Width = 318
      Height = 7
      Align = alBottom
      TabOrder = 12
      Visible = False
    end
  end
  inherited pnlStatus: TPanel
    Top = 363
    Width = 320
    ExplicitTop = 363
    ExplicitWidth = 320
    inherited pnlNomeForm: TPanel
      Left = 149
      ExplicitLeft = 149
    end
    inherited pnlInfo: TPanel
      Width = 149
      ExplicitWidth = 149
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 208
    Top = 72
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 264
    Top = 88
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 176
    Top = 72
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 200
    Top = 40
  end
  inherited frxGen: TfrxUserDataSet
    Left = 168
    Top = 40
  end
  inherited frxDesigner: TfrxDesigner
    Left = 176
    Top = 104
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 208
    Top = 104
  end
end
