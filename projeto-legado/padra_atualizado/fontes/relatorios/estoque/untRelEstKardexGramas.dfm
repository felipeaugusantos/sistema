inherited frmRelEstKardexGramas: TfrmRelEstKardexGramas
  Width = 375
  Height = 286
  ActiveControl = edtProdutos
  Caption = 'Ficha Kardex - Gramas'
  ExplicitWidth = 375
  ExplicitHeight = 286
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 217
    Width = 369
    ExplicitTop = 217
    ExplicitWidth = 369
    inherited btnSair: TBitBtnLocked
      Left = 286
      ExplicitLeft = 286
    end
  end
  inherited pnlDados: TPanel
    Width = 369
    Height = 217
    ExplicitWidth = 369
    ExplicitHeight = 217
    object pnlTopo: TPanel [0]
      Left = 1
      Top = 1
      Width = 367
      Height = 122
      Align = alTop
      Color = 16770261
      TabOrder = 0
      object Label10: TLabel
        Left = 7
        Top = 2
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
      object Label11: TLabel
        Left = 7
        Top = 42
        Width = 30
        Height = 14
        Caption = 'Marca'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 7
        Top = 82
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
      object edtProdutos: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 50
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
        TabOrder = 0
        OnExit = edtProdutosExit
        OnKeyPress = edtProdutosKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesProduto: TEditFocus
        Left = 60
        Top = 16
        Width = 298
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtDesMarca: TEditFocus
        Left = 7
        Top = 58
        Width = 352
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtEmpresa: TEditFocus
        Tag = 99
        Left = 7
        Top = 96
        Width = 35
        Height = 22
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 3
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
        Left = 44
        Top = 96
        Width = 313
        Height = 22
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object Panel1: TPanel [1]
      Left = 1
      Top = 123
      Width = 367
      Height = 97
      Align = alTop
      Color = 16770261
      TabOrder = 1
      object Label5: TLabel
        Left = 7
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
      object Label7: TLabel
        Left = 98
        Top = 72
        Width = 75
        Height = 14
        Caption = '(MOVIMENTO)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 98
        Top = 32
        Width = 75
        Height = 14
        Caption = '(MOVIMENTO)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 7
        Top = 48
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
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 7
        Top = 24
        Width = 86
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
        Left = 7
        Top = 64
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
    end
    inherited gpbDestino: TGroupBox
      Top = 228
      TabOrder = 2
      Visible = False
      ExplicitTop = 228
      inherited edtDestino: TEditFocus
        Enabled = False
        Visible = False
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 245
    Width = 369
    ExplicitTop = 245
    ExplicitWidth = 369
    inherited pnlNomeForm: TPanel
      Left = 198
      ExplicitLeft = 198
    end
    inherited pnlInfo: TPanel
      Width = 198
      ExplicitWidth = 198
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 40
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed12CPP
    Left = 232
    Top = 40
  end
  object cdsMovBas: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'DTAENT'
    Params = <>
    Left = 217
    Top = 139
    object cdsMovBasNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsMovBasESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsMovBasCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsMovBasDTAENT: TDateField
      FieldName = 'DTAENT'
    end
    object cdsMovBasNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 50
    end
    object cdsMovBasQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#,####0.0000'
      EditFormat = '#,####0.0000'
    end
  end
end
