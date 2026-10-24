inherited frmCadFreteRegiao: TfrmCadFreteRegiao
  Height = 152
  Caption = 'Frete Regi'#227'o'
  ExplicitHeight = 152
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 79
    ExplicitTop = 79
    inherited FlwBotoes: TFlowPanel
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 107
    ExplicitTop = 107
  end
  inherited pgcDados: TPageControl
    Top = 79
    Height = 0
    Visible = False
    ExplicitTop = 79
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 79
    Align = alTop
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 48
      Top = 11
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 54
      Top = 36
      Width = 30
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
    end
    object dbeCodFre: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 8
      Width = 88
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'FRE_CODFRE'
      DataSource = dtsFreReg
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeNomFre: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 31
      Width = 386
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FRE_NOMFRE'
      DataSource = dtsFreReg
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
  end
  object dtsFreReg: TDataSource
    Left = 484
    Top = 4
  end
end
