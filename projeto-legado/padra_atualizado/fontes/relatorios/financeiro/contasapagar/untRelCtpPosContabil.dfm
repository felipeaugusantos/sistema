inherited frmRelCtpPosContabil: TfrmRelCtpPosContabil
  Left = 354
  Top = 199
  Width = 349
  Height = 542
  Caption = 'Relat'#243'rio da Posi'#231#227'o Cont'#225'bil de Contas a Pagar'
  OnDestroy = FormDestroy
  ExplicitWidth = 349
  ExplicitHeight = 542
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 470
    Width = 343
    ExplicitTop = 470
    ExplicitWidth = 343
    DesignSize = (
      343
      28)
    inherited btnSair: TBitBtnLocked
      Left = 262
      ExplicitLeft = 262
    end
    inherited btnConfigurar: TBitBtnLocked
      Left = 81
      Width = 85
      ExplicitLeft = 81
      ExplicitWidth = 85
    end
  end
  inherited pnlDados: TPanel
    Width = 343
    Height = 470
    ExplicitWidth = 343
    ExplicitHeight = 470
    object Label10: TLabel [0]
      Left = 6
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
    object Label12: TLabel [1]
      Left = 86
      Top = 28
      Width = 68
      Height = 14
      Caption = '(CADASTRO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblEmpresa: TLabel [2]
      Left = 6
      Top = 87
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
    object Label1: TLabel [3]
      Left = 6
      Top = 198
      Width = 45
      Height = 14
      Caption = 'Atividade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel [4]
      Left = 6
      Top = 124
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
    object Label3: TLabel [5]
      Left = 6
      Top = 160
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
    object Label4: TLabel [6]
      Left = 6
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
    object Label5: TLabel [7]
      Left = 86
      Top = 66
      Width = 78
      Height = 14
      Caption = '(VENCIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel [8]
      Left = 174
      Top = 45
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
    object Label7: TLabel [9]
      Left = 257
      Top = 66
      Width = 78
      Height = 14
      Caption = '(VENCIMENTO)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel [10]
      Left = 174
      Top = 7
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
      Left = 150
      Top = 238
      Width = 186
      TabOrder = 11
      ExplicitLeft = 150
      ExplicitTop = 238
      ExplicitWidth = 186
      inherited ColorLabel1: TColorLabel
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        Left = 4
        Top = 20
        OnExit = nil
        ExplicitLeft = 4
        ExplicitTop = 20
      end
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 6
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
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 6
      Top = 101
      Width = 56
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
    object gpbBoleto: TGroupBox
      Left = 6
      Top = 238
      Width = 138
      Height = 45
      Caption = 'Veio boleto ?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 20
        Width = 96
        Height = 14
        Caption = '(T)odos (S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtBoleto: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'T'
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
    object edtDesEmpresa: TEditFocus
      Left = 65
      Top = 102
      Width = 271
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object GroupBox1: TGroupBox
      Left = 150
      Top = 288
      Width = 186
      Height = 42
      Caption = 'Tipo'
      TabOrder = 13
      object ColorLabel3: TColorLabel
        Left = 31
        Top = 19
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipo: TEditFocus
        Tag = 99
        Left = 8
        Top = 15
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
    object edtCodAtividade: TEditFocus
      Tag = 99
      Left = 6
      Top = 213
      Width = 56
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
      OnExit = edtCodAtividadeExit
      OnKeyPress = edtCodAtividadeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesAtividade: TEditFocus
      Left = 65
      Top = 213
      Width = 271
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
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbPrevis: TGroupBox
      Left = 6
      Top = 288
      Width = 138
      Height = 42
      Caption = 'Previs'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      object ColorLabel4: TColorLabel
        Left = 28
        Top = 20
        Width = 96
        Height = 14
        Caption = '(T)odos (S)im (N)'#227'o'
        CorDestaque = clRed
      end
      object edtPrevis: TEditFocus
        Tag = 99
        Left = 7
        Top = 17
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'T'
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
      Left = 6
      Top = 331
      Width = 330
      Height = 70
      Caption = 'Ordem Anal'#237'tico'
      TabOrder = 14
      object lbl1: TColorLabel
        Left = 28
        Top = 14
        Width = 183
        Height = 14
        Caption = '(C)'#243'digo do Fornecedor + Vencimento'
        CorDestaque = clRed
      end
      object lbl2: TColorLabel
        Left = 28
        Top = 30
        Width = 104
        Height = 14
        Caption = '(D)ata de Vencimento'
        CorDestaque = clRed
      end
      object ColorLabel5: TColorLabel
        Left = 28
        Top = 46
        Width = 177
        Height = 14
        Caption = '(N)ome do Fornecedor + Vencimento'
        CorDestaque = clRed
      end
      object edtOrdem: TEditFocus
        Tag = 99
        Left = 7
        Top = 27
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'C'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object gpbOpSint: TGroupBox
      Left = 6
      Top = 401
      Width = 330
      Height = 49
      Caption = 'Ordem Sint'#233'tico'
      TabOrder = 15
      object lblOpc1: TColorLabel
        Left = 33
        Top = 21
        Width = 108
        Height = 14
        Caption = '(1) Fornec. + Empresa'
        CorDestaque = clRed
      end
      object lblOpc2: TColorLabel
        Left = 161
        Top = 21
        Width = 157
        Height = 14
        Caption = '(2) Fornec. + Empresa + Vencto.'
        CorDestaque = clRed
      end
      object edtOpcao: TEditFocus
        Tag = 99
        Left = 7
        Top = 17
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = '1'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
      end
    end
    object edtCodFornecedor: TEditFocus
      Tag = 99
      Left = 6
      Top = 138
      Width = 56
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
      TabOrder = 5
      OnExit = edtCodFornecedorExit
      OnKeyPress = edtCodFornecedorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 65
      Top = 138
      Width = 271
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 16
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesPortador: TEditFocus
      Left = 65
      Top = 175
      Width = 271
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 17
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPortador: TEditFocus
      Tag = 99
      Left = 6
      Top = 175
      Width = 55
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 6
      OnKeyPress = edtCodPortadorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object mskVenIni: TMaskEditFocus
      Tag = 99
      Left = 6
      Top = 59
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
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskVenFin: TMaskEditFocus
      Tag = 99
      Left = 174
      Top = 59
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
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskCompet: TMaskEditFocus
      Tag = 99
      Left = 174
      Top = 21
      Width = 49
      Height = 22
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
  end
  inherited pnlStatus: TPanel
    Top = 498
    Width = 343
    ExplicitTop = 498
    ExplicitWidth = 343
    inherited pnlNomeForm: TPanel
      Left = 172
      ExplicitLeft = 172
    end
    inherited pnlInfo: TPanel
      Width = 172
      ExplicitWidth = 172
      inherited shpMultSel: TShape
        Left = 156
        Top = 2
        Width = 14
        Height = 13
        Visible = True
        ExplicitLeft = 156
        ExplicitTop = 2
        ExplicitWidth = 14
        ExplicitHeight = 13
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 112
    Top = 88
  end
  inherited rldFiltro: TRLDraftFilter
    CPPSelection = csFixed20CPP
    Left = 144
    Top = 88
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 176
    Top = 160
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 144
    Top = 160
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 112
    Top = 160
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 208
    Top = 120
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 176
    Top = 120
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 112
    Top = 120
  end
  inherited frxGen: TfrxUserDataSet
    Left = 144
    Top = 120
  end
  inherited frxDesigner: TfrxDesigner
    Left = 240
    Top = 160
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 104
    Top = 192
  end
  object svdExcel: TSaveDialog
    Filter = 'Planilha Excel|*.xls'
    Left = 208
    Top = 88
  end
end
