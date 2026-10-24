inherited frmRelCtpTitDeletados: TfrmRelCtpTitDeletados
  Width = 364
  Height = 298
  Caption = 'Relat'#243'rio de t'#237'tulos deletados'
  OnDestroy = FormDestroy
  ExplicitWidth = 364
  ExplicitHeight = 298
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 229
    Width = 358
    ExplicitTop = 226
    ExplicitWidth = 358
    inherited btnSair: TBitBtnLocked
      Left = 276
      ExplicitLeft = 276
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 84
      ExplicitLeft = 84
    end
  end
  inherited pnlStatus: TPanel
    Top = 257
    Width = 358
    ExplicitTop = 254
    ExplicitWidth = 358
    inherited pnlNomeForm: TPanel
      Left = 187
      ExplicitLeft = 187
    end
    inherited pnlInfo: TPanel
      Width = 187
      ExplicitWidth = 187
    end
  end
  inherited pnlDados: TPanel
    Width = 358
    Height = 229
    ExplicitWidth = 358
    ExplicitHeight = 226
    object Label5: TLabel [0]
      Left = 7
      Top = 44
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
      Left = 77
      Top = 63
      Width = 58
      Height = 14
      Caption = '(DELE'#199#195'O)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel [2]
      Left = 167
      Top = 44
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
    object Label8: TLabel [3]
      Left = 238
      Top = 63
      Width = 58
      Height = 14
      Caption = '(DELE'#199#195'O)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblEmpresa: TLabel [4]
      Left = 7
      Top = 83
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
    object Label1: TLabel [5]
      Left = 7
      Top = 5
      Width = 62
      Height = 14
      Caption = 'Compet'#234'ncia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Top = 175
      Width = 173
      Height = 40
      TabOrder = 6
      ExplicitTop = 175
      ExplicitWidth = 173
      ExplicitHeight = 40
      inherited ColorLabel1: TColorLabel
        Top = 17
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitTop = 17
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Top = 13
        ExplicitTop = 13
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 58
      Width = 65
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
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 167
      Top = 58
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
      ValidaData = True
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 7
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
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 3
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
      Left = 50
      Top = 99
      Width = 286
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbOrdem: TGroupBox
      Left = 7
      Top = 127
      Width = 329
      Height = 40
      Caption = 'Ordenar por'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object ColorLabel5: TColorLabel
        Left = 29
        Top = 17
        Width = 228
        Height = 14
        Caption = '(D)ata/Hora da Dele'#231#227'o   (N)'#250'mero de duplicata'
        CorDestaque = clRed
      end
      object edtOrdem: TEditFocus
        Tag = 99
        Left = 7
        Top = 13
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'D'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object chkLisCtaRec: TCheckBox
      Left = 189
      Top = 177
      Width = 156
      Height = 45
      Caption = 'Listar somente as deletadas pela manuten'#231#227'o do contas a pagar'
      TabOrder = 7
      WordWrap = True
    end
    object mskCompet: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 19
      Width = 65
      Height = 22
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 32
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 376
    Top = 32
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 440
    Top = 1
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 408
    Top = 1
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 344
    Top = 9
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 344
    Top = 1
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 504
    Top = 32
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 440
    Top = 32
  end
  inherited frxGen: TfrxUserDataSet
    Left = 472
    Top = 32
  end
  inherited frxDesigner: TfrxDesigner
    Left = 504
    Top = 1
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 472
    Top = 0
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 368
    Top = 0
  end
end
