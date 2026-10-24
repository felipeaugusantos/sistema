inherited frmRelGarantiaRefPre: TfrmRelGarantiaRefPre
  Left = 558
  Top = 436
  Width = 400
  Height = 277
  Caption = 'Relat'#243'rio de Refugos e Preju'#237'zos'
  ExplicitWidth = 400
  ExplicitHeight = 277
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 205
    Width = 394
    ExplicitTop = 205
    ExplicitWidth = 394
    inherited btnSair: TBitBtnLocked
      Left = 312
      ExplicitLeft = 312
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 233
    Width = 394
    ExplicitTop = 233
    ExplicitWidth = 394
    inherited pnlNomeForm: TPanel
      Left = 223
      ExplicitLeft = 223
    end
    inherited pnlInfo: TPanel
      Width = 223
      ExplicitWidth = 223
      end
      inherited shpMultSel: TShape
        Left = 205
        Visible = True
        ExplicitLeft = 205
      end
    end
  inherited pnlDados: TPanel
    Width = 394
    Height = 205
    ExplicitWidth = 394
    ExplicitHeight = 205
    object Label5: TLabel [0]
      Left = 8
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
      Left = 8
      Top = 46
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
      Left = 92
      Top = 28
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
      Left = 92
      Top = 67
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
    object Label10: TLabel [4]
      Left = 8
      Top = 86
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
    inherited gpbDestino: TGroupBox
      Left = 200
      Top = 134
      Width = 185
      Height = 65
      TabOrder = 5
      ExplicitLeft = 200
      ExplicitTop = 134
      ExplicitWidth = 185
      ExplicitHeight = 65
      inherited ColorLabel1: TColorLabel
        Top = 29
        ExplicitTop = 29
      end
      inherited edtDestino: TEditFocus
        Top = 26
        ExplicitTop = 26
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 76
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
      Left = 8
      Top = 60
      Width = 78
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
    object edtFornecedor: TEditFocus
      Left = 8
      Top = 100
      Width = 75
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
      OnExit = edtFornecedorExit
      OnKeyPress = edtFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 85
      Top = 100
      Width = 301
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object rdgFiltros: TRadioGroup
      Left = 8
      Top = 134
      Width = 185
      Height = 65
      Caption = 'Filtros'
      ItemIndex = 0
      Items.Strings = (
        'Todas'
        'Bancadas'
        'N'#227'o Bancadas')
      TabOrder = 4
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 312
    Top = 16
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 280
    Top = 16
  end
end
