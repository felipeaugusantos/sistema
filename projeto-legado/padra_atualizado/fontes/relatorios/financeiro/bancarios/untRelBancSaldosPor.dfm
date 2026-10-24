inherited frmRelBancSaldosPor: TfrmRelBancSaldosPor
  Left = 513
  Top = 290
  Width = 287
  Height = 312
  Caption = 'Relat'#243'rio de Saldos Por Portador'
  OnDestroy = FormDestroy
  ExplicitWidth = 287
  ExplicitHeight = 312
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 240
    Width = 281
    ExplicitTop = 240
    ExplicitWidth = 281
    inherited btnSair: TBitBtnLocked
      Left = 198
      ExplicitLeft = 198
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 5
      ExplicitLeft = 5
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 81
      Width = 84
      ExplicitLeft = 81
      ExplicitWidth = 84
    end
  end
  inherited pnlDados: TPanel
    Width = 281
    Height = 240
    ExplicitWidth = 281
    ExplicitHeight = 240
    object Label5: TLabel [0]
      Left = 12
      Top = 10
      Width = 76
      Height = 14
      Caption = 'Data para saldo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel [1]
      Left = 103
      Top = 31
      Width = 84
      Height = 14
      Caption = '(LAN'#199'AMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPortador: TLabel [2]
      Left = 12
      Top = 47
      Width = 41
      Height = 14
      Caption = 'Portador'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [3]
      Left = 12
      Top = 85
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
      Left = 12
      Top = 191
      Width = 253
      Height = 43
      TabOrder = 4
      ExplicitLeft = 12
      ExplicitTop = 191
      ExplicitWidth = 253
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Top = 15
        ExplicitTop = 15
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 12
      Top = 24
      Width = 88
      Height = 22
      AutoSelect = False
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
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 12
      Top = 61
      Width = 42
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPortador: TEditFocus
      Left = 55
      Top = 61
      Width = 210
      Height = 22
      Alignment = taLeftJustify
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 12
      Top = 99
      Width = 42
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
      Left = 55
      Top = 99
      Width = 210
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
    object rdgOpcao: TRadioGroup
      Left = 12
      Top = 124
      Width = 253
      Height = 63
      Caption = 'Op'#231#227'o'
      ItemIndex = 2
      Items.Strings = (
        'Conciliados'
        'N'#227'o Conciliados'
        'Todos')
      TabOrder = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 268
    Width = 281
    ExplicitTop = 268
    ExplicitWidth = 281
    inherited pnlNomeForm: TPanel
      Left = 110
      ExplicitLeft = 110
    end
    inherited pnlInfo: TPanel
      Width = 110
      ExplicitWidth = 110
      inherited shpMultSel: TShape
        Left = 86
        Visible = True
        ExplicitLeft = 86
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 192
    Top = 96
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 152
    Top = 96
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 104
    Top = 40
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
  end
  inherited frxDesigner: TfrxDesigner
    Left = 168
    Top = 40
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 200
    Top = 40
  end
end
