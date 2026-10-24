inherited frmRelTitDeletados: TfrmRelTitDeletados
  Left = 372
  Top = 218
  Width = 364
  Height = 309
  Caption = 'Relat'#243'rio de T'#237'tulos Deletados'
  OnDestroy = FormDestroy
  ExplicitWidth = 364
  ExplicitHeight = 309
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 240
    Width = 358
    ExplicitTop = 240
    ExplicitWidth = 358
    inherited btnSair: TBitBtnLocked
      Left = 275
      ExplicitLeft = 275
    end
    inherited btnImprimir: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 79
      Width = 82
      ExplicitLeft = 79
      ExplicitWidth = 82
    end
  end
  inherited pnlStatus: TPanel
    Top = 268
    Width = 358
    ExplicitTop = 268
    ExplicitWidth = 358
    inherited pnlNomeForm: TPanel
      Left = 217
      Width = 141
      ExplicitLeft = 217
      ExplicitWidth = 141
    end
    inherited pnlInfo: TPanel
      Width = 217
      ExplicitWidth = 217
    end
  end
  inherited pnlDados: TPanel
    Width = 358
    Height = 240
    ExplicitWidth = 358
    ExplicitHeight = 240
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
      Left = 167
      Top = 7
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
      Left = 85
      Top = 26
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
    object Label8: TLabel [3]
      Left = 238
      Top = 26
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
      Left = 14
      Top = 49
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
      Left = 14
      Top = 180
      Width = 174
      TabOrder = 6
      ExplicitLeft = 14
      ExplicitTop = 180
      ExplicitWidth = 174
      inherited ColorLabel1: TColorLabel
        Left = 29
        Top = 19
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitLeft = 29
        ExplicitTop = 19
        ExplicitWidth = 138
      end
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 14
      Top = 21
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
      Left = 167
      Top = 21
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
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 14
      Top = 65
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
      TabOrder = 2
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
      Left = 57
      Top = 65
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
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkLisCtaRec: TCheckBox
      Left = 189
      Top = 180
      Width = 162
      Height = 48
      Caption = 'Listar somente as deletadas pela manuten'#231#227'o do contas a receber'
      TabOrder = 7
      WordWrap = True
    end
    object gpbStatus: TGroupBox
      Left = 14
      Top = 93
      Width = 329
      Height = 43
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object lbl1: TColorLabel
        Left = 36
        Top = 18
        Width = 262
        Height = 14
        Caption = '(S)omente os n'#227'o impressos        (T)odos os registros'
        CorDestaque = clRed
      end
      object shpOpe: TShape
        Left = 7
        Top = 15
        Width = 8
        Height = 22
      end
      object edtStatus: TEditFocus
        Tag = 99
        Left = 14
        Top = 15
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 0
        Text = 'S'
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
    object gpbOrdem: TGroupBox
      Left = 14
      Top = 138
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 72
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 480
    Top = 41
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 384
    Top = 72
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 448
    Top = 40
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 416
    Top = 40
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 384
    Top = 40
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 448
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 384
    Top = 9
  end
  inherited frxGen: TfrxUserDataSet
    Left = 416
  end
  inherited frxDesigner: TfrxDesigner
    Left = 448
    Top = 72
  end
end
