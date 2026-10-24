inherited frmRelEstMovSaldoBal: TfrmRelEstMovSaldoBal
  Left = 536
  Top = 220
  Width = 380
  Height = 350
  Caption = 'Relat'#243'rio de Movimenta'#231#227'o de Saldo de Balan'#231'o'
  OnDestroy = FormDestroy
  ExplicitWidth = 380
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 278
    Width = 374
    ExplicitTop = 281
    ExplicitWidth = 374
    inherited btnSair: TBitBtnLocked
      Left = 292
      ExplicitLeft = 292
    end
  end
  inherited pnlStatus: TPanel
    Top = 306
    Width = 374
    ExplicitTop = 309
    ExplicitWidth = 374
    inherited pnlNomeForm: TPanel
      Left = 203
      ExplicitLeft = 203
    end
    inherited pnlInfo: TPanel
      Width = 203
      ExplicitWidth = 203
    end
  end
  inherited pnlDados: TPanel
    Width = 374
    Height = 278
    ExplicitWidth = 374
    ExplicitHeight = 281
    object Label9: TLabel [0]
      Left = 8
      Top = 84
      Width = 88
      Height = 14
      Caption = 'Linha/Grupo Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel [1]
      Left = 8
      Top = 122
      Width = 84
      Height = 14
      Caption = 'Linha/Grupo Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel [2]
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
    object Label6: TLabel [3]
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
    object Label7: TLabel [4]
      Left = 82
      Top = 26
      Width = 61
      Height = 14
      Caption = '(BALAN'#199'O)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel [5]
      Left = 82
      Top = 64
      Width = 61
      Height = 14
      Caption = '(BALAN'#199'O)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel [6]
      Left = 8
      Top = 160
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
      Left = 189
      Top = 221
      Width = 177
      TabOrder = 7
      ExplicitLeft = 189
      ExplicitTop = 221
      ExplicitWidth = 177
      inherited ColorLabel1: TColorLabel
        Top = 19
        Width = 138
        Caption = '(V)'#237'deo (I)mpressora (E)xcel'
        ParentFont = False
        ExplicitTop = 19
        ExplicitWidth = 138
      end
      inherited edtDestino: TEditFocus
        ParentFont = False
      end
    end
    object mskLinhaGrupo: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 98
      Width = 48
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
      TabOrder = 2
      Text = ''
      OnEnter = mskLinhaGrupoEnter
      OnExit = mskLinhaGrupoExit
      OnKeyPress = mskLinhaGrupoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskLinhaGrupo2: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 136
      Width = 48
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
      TabOrder = 3
      Text = ''
      OnExit = mskLinhaGrupo2Exit
      OnKeyPress = mskLinhaGrupo2KeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGrupo: TEditFocus
      Left = 59
      Top = 98
      Width = 307
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesGrupo2: TEditFocus
      Left = 59
      Top = 136
      Width = 307
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
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
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 8
      Top = 60
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
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 174
      Width = 48
      Height = 22
      Alignment = taLeftJustify
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
      Left = 59
      Top = 174
      Width = 307
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkImpRef: TCheckBox
      Left = 8
      Top = 200
      Width = 115
      Height = 17
      Caption = 'Imprimir refer'#234'ncia'
      TabOrder = 5
    end
    object gpbOpcao: TGroupBox
      Left = 8
      Top = 221
      Width = 177
      Height = 45
      Caption = 'Op'#231#227'o'
      TabOrder = 6
      object ColorLabel2: TColorLabel
        Left = 28
        Top = 19
        Width = 140
        Height = 14
        Caption = '(L)inha / Grupo (F)ornecedor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object edtOpcao: TEditFocus
        Tag = 99
        Left = 7
        Top = 16
        Width = 18
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
        MaxLength = 1
        ParentFont = False
        TabOrder = 0
        Text = 'L'
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
    Left = 316
    Top = 36
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 260
    Top = 36
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 204
    Top = 36
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 232
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 344
    Top = 36
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 176
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 232
    Top = 36
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 344
  end
  inherited frxRelatorio: TfrxDBDataset
    DataSet = nil
    Left = 260
  end
  inherited frxGen: TfrxUserDataSet
    Left = 288
    Top = 36
  end
  inherited frxDesigner: TfrxDesigner
    Left = 316
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 204
  end
end
