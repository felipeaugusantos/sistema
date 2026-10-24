inherited frmRelContratoAberturaCredito: TfrmRelContratoAberturaCredito
  Left = 306
  Top = 325
  Width = 514
  Height = 146
  Caption = 'Relat'#243'rio do Contrato Particular de Abertura de Cr'#233'dito'
  ExplicitWidth = 514
  ExplicitHeight = 146
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 76
    Width = 508
    Height = 25
    ExplicitTop = 76
    ExplicitWidth = 508
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 427
      Height = 21
      ExplicitWidth = 427
      inherited btnConfigurar: TBitBtnLocked
        Width = 82
        ExplicitWidth = 82
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 429
      Height = 21
      ExplicitLeft = 429
    end
  end
  inherited pnlDados: TPanel
    Width = 508
    Height = 76
    ExplicitWidth = 508
    ExplicitHeight = 75
    inherited gpbDestino: TGroupBox
      Left = -3
      Top = -8
      Width = 513
      Height = 116
      Caption = ''
      ExplicitLeft = -3
      ExplicitTop = -8
      ExplicitWidth = 513
      ExplicitHeight = 116
      inherited ColorLabel1: TColorLabel
        Left = 113
        Top = 58
        ExplicitLeft = 113
        ExplicitTop = 58
      end
      object Label1: TLabel [1]
        Left = 57
        Top = 14
        Width = 35
        Height = 14
        Caption = 'Cliente:'
      end
      object Label2: TLabel [2]
        Left = 10
        Top = 36
        Width = 82
        Height = 14
        Caption = 'Limite de Cr'#233'dito:'
      end
      object Label3: TLabel [3]
        Left = 53
        Top = 58
        Width = 39
        Height = 14
        Caption = 'Destino:'
      end
      object Label4: TLabel [4]
        Left = 216
        Top = 36
        Width = 83
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data do contrato:'
      end
      inherited edtDestino: TEditFocus
        Left = 93
        Top = 54
        TabOrder = 3
        ExplicitLeft = 93
        ExplicitTop = 54
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 93
        Top = 10
        Width = 68
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 0
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttAlfanumerico
      end
      object edtNomCli: TEditFocus
        Left = 162
        Top = 10
        Width = 340
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
      object edtLimCre: TEditFocus
        Tag = 99
        Left = 93
        Top = 32
        Width = 116
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '##,#0.00'
      end
      object mskDtaCon: TMaskEditFocus
        Tag = 99
        Left = 300
        Top = 32
        Width = 69
        Height = 22
        CharCase = ecUpperCase
        EditMask = '99/99/9999'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 2
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 101
    Width = 508
    ExplicitTop = 101
    ExplicitWidth = 508
    inherited pnlNomeForm: TPanel
      Left = 282
      Width = 226
      ExplicitLeft = 282
      ExplicitWidth = 226
    end
    inherited pnlInfo: TPanel
      Width = 282
      ExplicitWidth = 282
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 8
    Top = 120
  end
  inherited rldFiltro: TRLDraftFilter
    Top = 152
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 232
    Top = 120
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 200
    Top = 120
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 168
    Top = 120
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 136
    Top = 120
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 104
    Top = 120
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 40
    Top = 120
  end
  inherited frxGen: TfrxUserDataSet
    Left = 72
    Top = 120
  end
  inherited frxDesigner: TfrxDesigner
    Left = 296
    Top = 120
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 328
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 232
    Top = 152
  end
end
