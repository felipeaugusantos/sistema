inherited frmRelEspNotaEntDev: TfrmRelEspNotaEntDev
  Left = 571
  Top = 255
  Width = 376
  Height = 409
  Caption = 'Relat'#243'rio de Espelho Nota de Devolu'#231#227'o (Entrada)'
  ExplicitWidth = 376
  ExplicitHeight = 409
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 337
    Width = 370
    ExplicitTop = 337
    ExplicitWidth = 370
    inherited btnSair: TBitBtnLocked
      Left = 287
      ExplicitLeft = 287
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 14
      ExplicitLeft = 14
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 91
      Width = 85
      ExplicitLeft = 91
      ExplicitWidth = 85
    end
  end
  inherited pnlDados: TPanel
    Width = 370
    Height = 337
    ExplicitWidth = 370
    ExplicitHeight = 337
    object Label5: TLabel [0]
      Left = 14
      Top = 7
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
      Left = 14
      Top = 43
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
    object Label7: TLabel [2]
      Left = 104
      Top = 26
      Width = 58
      Height = 14
      Caption = '(ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel [3]
      Left = 104
      Top = 62
      Width = 58
      Height = 14
      Caption = '(ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel [4]
      Left = 14
      Top = 115
      Width = 32
      Height = 14
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [5]
      Left = 14
      Top = 151
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
    object Label9: TLabel [6]
      Left = 14
      Top = 79
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
    object Label10: TLabel [7]
      Left = 106
      Top = 79
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel [8]
      Left = 152
      Top = 79
      Width = 25
      Height = 14
      Caption = 'S'#233'rie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 16
      Top = 281
      Width = 343
      Height = 43
      TabOrder = 9
      ExplicitLeft = 16
      ExplicitTop = 281
      ExplicitWidth = 343
      ExplicitHeight = 43
      inherited ColorLabel1: TColorLabel
        Top = 19
        ExplicitTop = 19
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 21
      Width = 88
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
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 57
      Width = 88
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
      ValidaData = True
    end
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 14
      Top = 129
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
      MaxLength = 8
      ParentFont = False
      TabOrder = 5
      OnKeyPress = edtCodClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 14
      Top = 165
      Width = 29
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
      TabOrder = 6
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDocumento: TEditFocus
      Left = 14
      Top = 93
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 12
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspecie: TEditFocus
      Left = 106
      Top = 93
      Width = 35
      Height = 21
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 3
      Text = 'NF'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtSerie: TEditFocus
      Left = 152
      Top = 93
      Width = 29
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
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesCliente: TEditFocus
      Left = 82
      Top = 129
      Width = 277
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 46
      Top = 165
      Width = 313
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgOrdem: TRadioGroup
      Left = 15
      Top = 189
      Width = 344
      Height = 43
      Caption = 'Ordenado'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Por Data Entrada'
        'Por Cliente')
      TabOrder = 7
    end
    object rdgOrdemProd: TRadioGroup
      Left = 15
      Top = 237
      Width = 344
      Height = 43
      Caption = 'Ordenar produtos'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Por Grava'#231#227'o'
        'Por Descri'#231#227'o')
      TabOrder = 8
    end
  end
  inherited pnlStatus: TPanel
    Top = 365
    Width = 370
    ExplicitTop = 365
    ExplicitWidth = 370
    inherited pnlNomeForm: TPanel
      Left = 217
      Width = 153
      ExplicitLeft = 217
      ExplicitWidth = 153
    end
    inherited pnlInfo: TPanel
      Width = 217
      ExplicitWidth = 217
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 384
  end
end
