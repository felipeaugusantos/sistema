inherited frmRelPedMetasVendedor: TfrmRelPedMetasVendedor
  Left = 563
  Top = 299
  Width = 338
  Height = 345
  ActiveControl = mskMesAnoIni
  Caption = 'Relat'#243'rio de Metas por Vendedor (Pedido)'
  OnDestroy = FormDestroy
  ExplicitWidth = 338
  ExplicitHeight = 345
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 273
    Width = 332
    ExplicitTop = 273
    ExplicitWidth = 332
    inherited btnSair: TBitBtnLocked
      Left = 249
      ExplicitLeft = 249
    end
  end
  inherited pnlStatus: TPanel
    Top = 301
    Width = 332
    ExplicitTop = 301
    ExplicitWidth = 332
    inherited pnlNomeForm: TPanel
      Left = 161
      ExplicitLeft = 161
    end
    inherited pnlInfo: TPanel
      Width = 161
      ExplicitWidth = 161
    end
  end
  inherited pnlDados: TPanel
    Width = 332
    Height = 273
    ExplicitWidth = 332
    ExplicitHeight = 273
    object Label7: TLabel [0]
      Left = 65
      Top = 28
      Width = 57
      Height = 14
      Caption = '(M'#202'S/ANO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel [1]
      Left = 65
      Top = 63
      Width = 57
      Height = 14
      Caption = '(M'#202'S/ANO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel [2]
      Left = 4
      Top = 42
      Width = 61
      Height = 14
      Caption = 'Per'#237'odo Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel [3]
      Left = 4
      Top = 7
      Width = 65
      Height = 14
      Caption = 'Per'#237'odo Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel [4]
      Left = 4
      Top = 119
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
    object Label12: TLabel [5]
      Left = 4
      Top = 81
      Width = 47
      Height = 14
      Caption = 'Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 168
      Top = 219
      Width = 157
      TabOrder = 8
      ExplicitLeft = 168
      ExplicitTop = 219
      ExplicitWidth = 157
    end
    object edtCodVendedor: TEditFocus
      Left = 4
      Top = 95
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
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      OnExit = edtCodVendedorExit
      OnKeyPress = edtCodVendedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesVendedor: TEditFocus
      Left = 62
      Top = 95
      Width = 263
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
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 4
      Top = 133
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
      OnExit = edtCodEmpresaExit
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 34
      Top = 133
      Width = 291
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
    object gpbQuebra: TGroupBox
      Left = 168
      Top = 162
      Width = 157
      Height = 50
      Caption = 'Quebra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      object ColorLabel6: TColorLabel
        Left = 28
        Top = 24
        Width = 87
        Height = 14
        Caption = '(M)'#234's (V)endedor'
        CorDestaque = clRed
      end
      object edtQuebra: TEditFocus
        Tag = 99
        Left = 7
        Top = 21
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'V'
        OnExit = edtDestinoExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object mskMesAnoIni: TMaskEditFocus
      Tag = 99
      Left = 4
      Top = 21
      Width = 52
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/9999;1;_'
      MaxLength = 7
      TabOrder = 0
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskMesAnoFin: TMaskEditFocus
      Tag = 99
      Left = 4
      Top = 56
      Width = 52
      Height = 22
      CharCase = ecUpperCase
      EditMask = '99/9999;1;_'
      MaxLength = 7
      TabOrder = 1
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object rdgFaturamento: TRadioGroup
      Left = 4
      Top = 162
      Width = 157
      Height = 102
      Caption = 'Faturamento'
      ItemIndex = 0
      Items.Strings = (
        'Todos Pedidos'
        'J'#225' Faturados'
        'N'#227'o Faturados'
        'Baixados N'#227'o Entregues')
      TabOrder = 6
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 232
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 200
    Top = 40
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
  end
  inherited frxDesigner: TfrxDesigner
    Left = 296
    Top = 40
  end
end
