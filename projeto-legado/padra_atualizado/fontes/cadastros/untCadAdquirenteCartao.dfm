inherited frmCadAdquirenteCartao: TfrmCadAdquirenteCartao
  Width = 637
  Height = 200
  Caption = 'Adquirente'
  ExplicitWidth = 637
  ExplicitHeight = 200
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 130
    Width = 631
    Height = 25
    ExplicitTop = 130
    ExplicitWidth = 631
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 553
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 553
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 82
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitLeft = 82
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 164
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitLeft = 164
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 246
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitLeft = 246
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 328
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitLeft = 328
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 410
        Width = 82
        Height = 21
        Spacing = 2
        ExplicitLeft = 410
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 555
      Width = 74
      Height = 21
      Align = alRight
      Spacing = 2
      ExplicitLeft = 555
      ExplicitWidth = 74
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 155
    Width = 631
    ExplicitTop = 155
    ExplicitWidth = 631
    inherited pnlNomeForm: TPanel
      Left = 444
      Width = 187
      ExplicitLeft = 444
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 444
      ExplicitWidth = 444
    end
  end
  inherited pgcDados: TPageControl
    Width = 248
    Height = 41
    Align = alNone
    ExplicitWidth = 248
    ExplicitHeight = 41
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 240
      ExplicitHeight = 9
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 631
    Height = 130
    Align = alClient
    TabOrder = 3
    object Label1: TLabel
      Left = 135
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 141
      Top = 36
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
    end
    object lbCodOperadora: TLabel
      Left = 22
      Top = 85
      Width = 149
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'd Operadora Fiserv-ClisiTef:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 10
      Top = 107
      Width = 161
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'd Operadora Conex'#227'oTech-Scope:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblModPos: TLabel
      Left = 52
      Top = 59
      Width = 119
      Height = 14
      Alignment = taRightJustify
      Caption = 'Usar somente para POS:'
    end
    object ColorLabel2: TColorLabel
      Left = 206
      Top = 59
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object dbeCodAdq: TDBEditFocus
      Tag = 99
      Left = 173
      Top = 8
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ADQ_CODADQ'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNomAdq: TDBEditFocus
      Tag = 99
      Left = 173
      Top = 32
      Width = 403
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ADQ_NOMADQ'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBETFTOPE: TDBEditFocus
      Tag = 99
      Left = 173
      Top = 80
      Width = 79
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ADQ_TFTRED'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object DBETFRED2: TDBEditFocus
      Tag = 99
      Left = 173
      Top = 104
      Width = 79
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ADQ_TFRED2'
      DataSource = dtsTabela
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeModPos: TDBEditFocus
      Tag = 99
      Left = 173
      Top = 56
      Width = 29
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ADQ_MODPOS'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 472
    Top = 8
  end
  object dtsTabela: TDataSource
    Left = 408
    Top = 16
  end
end
