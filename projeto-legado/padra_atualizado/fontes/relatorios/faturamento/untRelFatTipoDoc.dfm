inherited frmRelFatTipoDoc: TfrmRelFatTipoDoc
  Left = 345
  Top = 198
  Width = 350
  Height = 638
  Caption = 'Relat'#243'rio por Esp'#233'cie de Documento'
  OnClose = FormClose
  ExplicitWidth = 350
  ExplicitHeight = 638
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 8
    Top = 190
    Width = 67
    Height = 14
    Caption = 'Departamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 566
    Width = 344
    ExplicitTop = 522
    ExplicitWidth = 344
    inherited btnSair: TBitBtnLocked
      Left = 262
      ExplicitLeft = 262
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 3
      ExplicitLeft = 3
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 80
      ExplicitLeft = 80
    end
  end
  inherited pnlDados: TPanel
    Width = 344
    Height = 566
    ExplicitWidth = 344
    ExplicitHeight = 522
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
    object Label7: TLabel [1]
      Left = 169
      Top = 24
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
    object Label6: TLabel [2]
      Left = 86
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
    object lblEmpresa: TLabel [3]
      Left = 8
      Top = 48
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
    object Label1: TLabel [4]
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
    object Label4: TLabel [5]
      Left = 8
      Top = 124
      Width = 69
      Height = 14
      Caption = 'Rede de Lojas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel [6]
      Left = 8
      Top = 237
      Width = 62
      Height = 14
      Caption = 'Linha/Grupo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel [7]
      Left = 8
      Top = 162
      Width = 107
      Height = 14
      Caption = 'Depto. de Operadores'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel [8]
      Left = 69
      Top = 239
      Width = 261
      Height = 12
      Caption = '* Filtra documentos que contenham ao menos 1 item do grupo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblVen: TLabel [9]
      Left = 8
      Top = 275
      Width = 47
      Height = 14
      Caption = 'Vendedor'
    end
    object lblDig: TLabel [10]
      Left = 8
      Top = 312
      Width = 42
      Height = 14
      Caption = 'Digitador'
    end
    object Label3: TLabel [11]
      Left = 8
      Top = 198
      Width = 92
      Height = 14
      Caption = 'Depto. de Produtos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 3
      Top = 508
      Width = 333
      TabOrder = 19
      ExplicitLeft = 3
      ExplicitTop = 508
      ExplicitWidth = 333
      inherited ColorLabel1: TColorLabel
        Left = 30
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitLeft = 30
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Left = 8
        ExplicitLeft = 8
      end
    end
    object pgbProgresso: TProgressBar
      Left = 1
      Top = 557
      Width = 342
      Height = 8
      Align = alBottom
      Smooth = True
      TabOrder = 20
      ExplicitTop = 513
    end
    object pnlRodape: TPanel
      Left = 3
      Top = 348
      Width = 333
      Height = 163
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 10
      object lblEspecie: TLabel
        Left = 5
        Top = 1
        Width = 43
        Height = 12
        AutoSize = False
        Caption = 'Esp'#233'cie'
      end
      object mskEspecie: TMaskEditFocus
        Tag = 99
        Left = 5
        Top = 16
        Width = 165
        Height = 22
        CharCase = ecUpperCase
        EditMask = 'll-ll-ll-ll-ll-ll-ll-ll-ll-ll;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 29
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        Text = '  -  -  -  -  -  -  -  -  -  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object rdgEspeciais: TRadioGroup
        Left = 0
        Top = 37
        Width = 331
        Height = 70
        ItemIndex = 0
        Items.Strings = (
          'Exibir todas as Notas'
          'N'#227'o exibir Nota Especial e Cupom Especial'
          'Exibir apenas Nota Especial e Cupom Especial')
        TabOrder = 1
      end
      object gpbTipo: TGroupBox
        Left = 0
        Top = 110
        Width = 159
        Height = 45
        Caption = 'Tipo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object ColorLabel2: TColorLabel
          Left = 30
          Top = 20
          Width = 101
          Height = 14
          Caption = '(A)nal'#237'tico (S)int'#233'tico'
          CorDestaque = clRed
        end
        object edtTipo: TEditFocus
          Tag = 99
          Left = 8
          Top = 16
          Width = 18
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 0
          Text = 'A'
          OnChange = edtTipoChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
      end
      object rdgEmpresa: TRadioGroup
        Left = 165
        Top = 110
        Width = 167
        Height = 45
        Caption = 'Empresa de'
        Ctl3D = True
        ItemIndex = 0
        Items.Strings = (
          'Faturamento'
          'Origem')
        ParentCtl3D = False
        TabOrder = 3
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 22
      Width = 70
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
      Left = 86
      Top = 22
      Width = 75
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
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 8
      Top = 62
      Width = 35
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
      Left = 46
      Top = 62
      Width = 292
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 15
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Left = 8
      Top = 100
      Width = 62
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
      MaxLength = 8
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
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
    object edtDesCli: TEditFocus
      Left = 73
      Top = 100
      Width = 265
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRed: TEditFocus
      Left = 8
      Top = 138
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 4
      OnExit = edtCodRedExit
      OnKeyPress = edtCodRedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesRed: TEditFocus
      Left = 73
      Top = 138
      Width = 265
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDep: TEditFocus
      Left = 8
      Top = 176
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
      OnExit = edtCodDepExit
      OnKeyPress = edtCodDepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesDep: TEditFocus
      Left = 73
      Top = 176
      Width = 265
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskCodGru: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 252
      Width = 51
      Height = 22
      EditMask = '999.999;0;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      ParentFont = False
      TabOrder = 7
      Text = ''
      OnExit = mskCodGruExit
      OnKeyPress = mskCodGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 61
      Top = 252
      Width = 277
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodVen: TEditFocus
      Tag = 99
      Left = 8
      Top = 289
      Width = 52
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
      TabOrder = 8
      OnExit = edtCodVenExit
      OnKeyPress = edtCodVenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomVen: TEditFocus
      Left = 60
      Top = 289
      Width = 278
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDig: TEditFocus
      Tag = 99
      Left = 8
      Top = 327
      Width = 52
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
      TabOrder = 9
      OnExit = edtCodDigExit
      OnKeyPress = edtCodDigKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 60
      Top = 327
      Width = 278
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 18
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodDepProd: TEditFocus
      Left = 8
      Top = 211
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 6
      OnExit = edtCodDepProdExit
      OnKeyPress = edtCodDepProdKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtDesDepProd: TEditFocus
      Left = 73
      Top = 211
      Width = 265
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 14
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
    Top = 594
    Width = 344
    ExplicitTop = 550
    ExplicitWidth = 344
    inherited pnlNomeForm: TPanel
      Left = 173
      ExplicitLeft = 173
    end
    inherited pnlInfo: TPanel
      Width = 173
      ExplicitWidth = 173
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 168
    Top = 104
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 200
    Top = 104
  end
  inherited frxExpRTF: TfrxRTFExport
    Top = 104
  end
  inherited frxExpXLS: TfrxXLSExport
    Top = 104
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 264
    Top = 136
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 232
    Top = 136
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 296
    Top = 102
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 136
    Top = 104
  end
  inherited frxGen: TfrxUserDataSet
    Left = 168
    Top = 136
  end
  inherited frxDesigner: TfrxDesigner
    Top = 104
  end
  inherited frxComandos: TfrxUserDataSet
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 296
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 136
  end
end
