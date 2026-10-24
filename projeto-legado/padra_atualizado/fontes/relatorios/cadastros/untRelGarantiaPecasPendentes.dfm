inherited frmRelGarantiaPecasPendentes: TfrmRelGarantiaPecasPendentes
  Left = 520
  Top = 357
  Width = 400
  Height = 322
  Caption = 'Relat'#243'rio de Pe'#231'as Pendentes'
  ExplicitWidth = 400
  ExplicitHeight = 322
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 250
    Width = 394
    ExplicitTop = 250
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
    Top = 278
    Width = 394
    ExplicitTop = 278
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
    Height = 250
    ExplicitWidth = 394
    ExplicitHeight = 250
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
    object Label1: TLabel [4]
      Left = 8
      Top = 127
      Width = 37
      Height = 14
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel [5]
      Left = 8
      Top = 86
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
    inherited gpbDestino: TGroupBox
      Left = 200
      Top = 178
      Width = 185
      Height = 65
      TabOrder = 7
      ExplicitLeft = 200
      ExplicitTop = 178
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
      Width = 75
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
    object edtCodCli: TEditFocus
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
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
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
      Top = 178
      Width = 185
      Height = 65
      Caption = 'Tipos de Filtro'
      ItemIndex = 0
      Items.Strings = (
        'A Enviar'
        'Com Fornecedor'
        'A Retirar')
      TabOrder = 6
    end
    object edtDesIte: TEditFocus
      Left = 85
      Top = 141
      Width = 301
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
    object edtCodIte: TEditFocus
      Left = 8
      Top = 141
      Width = 75
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 4
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 16
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 312
    Top = 16
  end
end
