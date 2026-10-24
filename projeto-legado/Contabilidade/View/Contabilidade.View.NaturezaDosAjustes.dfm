inherited frmNaturezaDosAjustes: TfrmNaturezaDosAjustes
  Width = 650
  Height = 389
  Caption = 'Natureza dos Ajustes (LAIR/LACS)'
  OnKeyUp = FormKeyUp
  ExplicitWidth = 650
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 316
    Width = 644
    ExplicitTop = 316
    ExplicitWidth = 644
    inherited FlwBotoes: TFlowPanel
      Width = 640
      ExplicitWidth = 640
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 561
      ExplicitLeft = 561
    end
  end
  inherited pnlStatus: TPanel
    Top = 344
    Width = 644
    ExplicitTop = 344
    ExplicitWidth = 644
    inherited pnlNomeForm: TPanel
      Left = 297
      ExplicitLeft = 297
    end
    inherited pnlInfo: TPanel
      Width = 297
      ExplicitWidth = 297
    end
  end
  inherited pgcDados: TPageControl
    Width = 644
    Height = 316
    TabOrder = 3
    ExplicitWidth = 644
    ExplicitHeight = 316
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 636
      ExplicitHeight = 284
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 644
    Height = 316
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object Label2: TLabel
      Left = 9
      Top = 40
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 24
      Top = 18
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 63
      Top = 36
      Width = 570
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NAT_DESCRI'
      DataSource = dtsNatAju
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 63
      Top = 11
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'NAT_CODIGO'
      DataSource = dtsNatAju
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object rdgTipMov: TDBRadioGroup
      Tag = 99
      Left = 63
      Top = 62
      Width = 570
      Height = 43
      Caption = 'Movimento'
      Columns = 3
      DataField = 'NAT_TIPMOV'
      DataSource = dtsNatAju
      Items.Strings = (
        'Adi'#231#227'o'
        'Exclus'#227'o'
        'Compensa'#231#227'o')
      TabOrder = 2
      TabStop = True
      Values.Strings = (
        'A'
        'E'
        'C')
      OnClick = rdgTipMovClick
    end
    object GroupBox1: TGroupBox
      Left = 63
      Top = 109
      Width = 570
      Height = 49
      Caption = 'Tipo da tabela din'#226'mica ECF'
      TabOrder = 3
      object edtDesEcf: TEditFocus
        Left = 65
        Top = 20
        Width = 496
        Height = 22
        TabStop = False
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
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeTabEcf: TDBEditFocus
        Tag = 99
        Left = 9
        Top = 20
        Width = 53
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NAT_TABECF'
        DataSource = dtsNatAju
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 0
        OnKeyPress = dbeTabEcfKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object GroupBox2: TGroupBox
      Left = 63
      Top = 163
      Width = 570
      Height = 66
      Caption = 'LAIR'
      TabOrder = 4
      TabStop = True
      object dbeCodLal: TDBEditFocus
        Tag = 99
        Left = 9
        Top = 32
        Width = 80
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NAT_CODLAL'
        DataSource = dtsNatAju
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 1
        OnKeyPress = dbeCodLalKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtDesLal: TEditFocus
        Left = 92
        Top = 32
        Width = 469
        Height = 22
        TabStop = False
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
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object chkGerLal: TDBCheckBox
        Tag = 99
        Left = 9
        Top = 15
        Width = 165
        Height = 16
        Caption = 'Gerar lan'#231'amentos - LAIR'
        DataField = 'NAT_GERLAL'
        DataSource = dtsNatAju
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = chkGerLalClick
      end
    end
    object GroupBox3: TGroupBox
      Left = 63
      Top = 235
      Width = 570
      Height = 67
      Caption = 'LACS'
      TabOrder = 5
      TabStop = True
      object chkGerLac: TDBCheckBox
        Tag = 99
        Left = 9
        Top = 18
        Width = 165
        Height = 16
        Caption = 'Gerar lan'#231'amentos - LACS'
        DataField = 'NAT_GERLAC'
        DataSource = dtsNatAju
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = chkGerLacClick
      end
      object dbeCodLac: TDBEditFocus
        Tag = 99
        Left = 9
        Top = 35
        Width = 80
        Height = 22
        CharCase = ecUpperCase
        DataField = 'NAT_CODLAC'
        DataSource = dtsNatAju
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 20
        TabOrder = 1
        OnKeyPress = dbeCodLacKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtDesLac: TEditFocus
        Left = 92
        Top = 35
        Width = 469
        Height = 22
        TabStop = False
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
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = 16768952
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 488
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 456
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 400
    Top = 0
  end
  object dtsNatAju: TDataSource
    Left = 428
  end
end
