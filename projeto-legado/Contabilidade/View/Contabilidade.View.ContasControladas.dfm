inherited frmCadContasControladas: TfrmCadContasControladas
  Width = 701
  Height = 473
  Caption = 'Contas Controladas (Parte B)'
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 701
  ExplicitHeight = 473
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 400
    Width = 695
    TabOrder = 1
    ExplicitTop = 400
    ExplicitWidth = 695
    inherited FlwBotoes: TFlowPanel
      Width = 691
      ExplicitWidth = 691
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 428
    Width = 695
    TabOrder = 2
    ExplicitTop = 428
    ExplicitWidth = 695
    inherited pnlNomeForm: TPanel
      Left = 348
      ExplicitLeft = 348
    end
    inherited pnlInfo: TPanel
      Width = 348
      ExplicitWidth = 348
    end
  end
  inherited pgcDados: TPageControl
    Width = 695
    Height = 400
    TabOrder = 3
    Visible = False
    ExplicitWidth = 695
    ExplicitHeight = 400
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 687
      ExplicitHeight = 368
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 695
    Height = 400
    Align = alClient
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 34
      Top = 17
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 18
      Top = 72
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 18
      Top = 99
      Width = 155
      Height = 14
      Caption = 'Tipo da Tabela Din'#226'mica do ECF:'
    end
    object Label15: TLabel
      Tag = 50
      Left = 24
      Top = 45
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object dbeCodCon: TDBEditFocus
      Tag = 99
      Left = 74
      Top = 15
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTA_CODCON'
      DataSource = dtsCtaCon
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 74
      Top = 69
      Width = 607
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTA_DESCRI'
      DataSource = dtsCtaCon
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object cbxTipTab: TComboBoxFocus
      Tag = 99
      Left = 179
      Top = 96
      Width = 502
      Height = 22
      TabOrder = 3
      OnChange = cbxTipTabChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object gbLalur: TGroupBox
      Left = 14
      Top = 123
      Width = 667
      Height = 129
      Caption = 'LAIR'
      TabOrder = 4
      object Label4: TLabel
        Left = 9
        Top = 39
        Width = 201
        Height = 14
        Caption = 'V'#237'nculo com a Tabela Din'#226'mica da Parte A'
      end
      object Label5: TLabel
        Left = 9
        Top = 83
        Width = 204
        Height = 14
        Caption = 'V'#237'nculo com a Tabela Din'#226'mica da Parte B:'
      end
      object dbeTbdElu: TDBEditFocus
        Tag = 99
        Left = 9
        Top = 56
        Width = 113
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CTA_TBDELU'
        DataSource = dtsCtaCon
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeTbdEluKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtTbdElu: TEditFocus
        Left = 126
        Top = 56
        Width = 513
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeTbdBlu: TDBEditFocus
        Tag = 99
        Left = 9
        Top = 100
        Width = 113
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CTA_TBDBLU'
        DataSource = dtsCtaCon
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        OnKeyPress = dbeTbdBluKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtTbdBlu: TEditFocus
        Left = 126
        Top = 100
        Width = 513
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object chkGerLal: TDBCheckBox
        Tag = 99
        Left = 9
        Top = 18
        Width = 165
        Height = 16
        Caption = 'Gerar lan'#231'amentos - LAIR'
        DataField = 'CTA_GRLALU'
        DataSource = dtsCtaCon
        TabOrder = 4
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = chkGerLalClick
      end
    end
    object gbLacs: TGroupBox
      Left = 14
      Top = 260
      Width = 666
      Height = 129
      Caption = 'LACS'
      TabOrder = 5
      object Label6: TLabel
        Left = 9
        Top = 41
        Width = 201
        Height = 14
        Caption = 'V'#237'nculo com a Tabela Din'#226'mica da Parte A'
      end
      object Label7: TLabel
        Left = 9
        Top = 84
        Width = 204
        Height = 14
        Caption = 'V'#237'nculo com a Tabela Din'#226'mica da Parte B:'
      end
      object dbeTbdEla: TDBEditFocus
        Tag = 99
        Left = 9
        Top = 58
        Width = 113
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CTA_TBDELA'
        DataSource = dtsCtaCon
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeTbdElaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtTbdEla: TEditFocus
        Left = 126
        Top = 58
        Width = 513
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object dbeTbdBla: TDBEditFocus
        Tag = 99
        Left = 9
        Top = 100
        Width = 113
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CTA_TBDBLA'
        DataSource = dtsCtaCon
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 2
        OnKeyPress = dbeTbdBlaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtTbdBla: TEditFocus
        Left = 126
        Top = 100
        Width = 513
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      object chkGerLac: TDBCheckBox
        Tag = 99
        Left = 9
        Top = 21
        Width = 165
        Height = 16
        Caption = 'Gerar lan'#231'amentos - LACS'
        DataField = 'CTA_GRLACS'
        DataSource = dtsCtaCon
        TabOrder = 4
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = chkGerLacClick
      end
    end
    object edtDesEmp: TEditFocus
      Tag = 50
      Left = 138
      Top = 42
      Width = 542
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
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 73
      Top = 42
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTA_CODEMP'
      DataSource = dtsCtaCon
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 0
  end
  object dtsCtaCon: TDataSource
    AutoEdit = False
    Left = 512
  end
end
