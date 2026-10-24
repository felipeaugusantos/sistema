inherited frmCadEmpresasEstoqueExterno: TfrmCadEmpresasEstoqueExterno
  Width = 631
  Height = 250
  Caption = 'Cadastro de Estoque Externo - Empresas'
  ExplicitWidth = 631
  ExplicitHeight = 250
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 177
    Width = 625
    ExplicitTop = 144
    ExplicitWidth = 625
    inherited FlwBotoes: TFlowPanel
      Width = 621
      ExplicitTop = 2
      ExplicitWidth = 621
    end
    inherited btnSair: TBitBtnLocked
      Left = 544
      ExplicitLeft = 544
    end
  end
  inherited pnlStatus: TPanel
    Top = 205
    Width = 625
    ExplicitTop = 172
    ExplicitWidth = 625
    inherited pnlNomeForm: TPanel
      Left = 278
      ExplicitLeft = 278
    end
    inherited pnlInfo: TPanel
      Width = 278
      ExplicitWidth = 278
    end
  end
  inherited pgcDados: TPageControl
    Width = 625
    Height = 177
    ExplicitWidth = 625
    ExplicitHeight = 144
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 617
      ExplicitHeight = 112
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 625
    Height = 177
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    ExplicitHeight = 144
    object Label1: TLabel
      Left = 58
      Top = 15
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 42
      Top = 38
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object LabelCgcCpf1: TLabelCgcCpf
      Left = 24
      Top = 62
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = '1-CNPJ/2-CPF:'
      Pais = opcBrasil
    end
    object Label3: TLabel
      Left = 17
      Top = 84
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente Est. Ext.:'
    end
    object lblCfop: TColorLabel
      Left = 102
      Top = 103
      Width = 476
      Height = 14
      Alignment = taRightJustify
      Caption = 
        'Cliente para identificar outras sa'#237'das de envio de mercadoria pa' +
        'ra o Estoque Externo (5905, 6905).'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object dbeDesEst: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 34
      Width = 403
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EEE_DESEEE'
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
    object dbeCodEst: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 11
      Width = 87
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EEE_CODEEE'
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
    object Panel1: TPanel
      Left = 96
      Top = 57
      Width = 312
      Height = 22
      BevelOuter = bvNone
      TabOrder = 2
      object dbeCgcCpf: TDBEditTipoCgcCpf
        Tag = 99
        Left = 0
        Top = 0
        Width = 69
        Height = 22
        Align = alLeft
        CharCase = ecUpperCase
        DataField = 'EEE_CGCCPF'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 0
        OnExit = dbeCgcCpfExit
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeNumCgc: TDBEditCgcCpf
        Tag = 99
        Left = 69
        Top = 0
        Width = 188
        Height = 22
        Align = alLeft
        CharCase = ecUpperCase
        DataField = 'EEE_C_G_C_'
        DataSource = dtsTabela
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
        Tipo = C_G_C_
      end
    end
    object edtNomCli: TEditFocus
      Left = 153
      Top = 80
      Width = 346
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
    object dbeCodCli: TDBEditFocus
      Tag = 99
      Left = 96
      Top = 80
      Width = 55
      Height = 22
      CharCase = ecUpperCase
      DataField = 'EEE_CODCLI'
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
      OnChange = dbeCodCliChange
      OnKeyPress = dbeCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodCliChamaCadastro
    end
    object chkPerFat: TDBCheckBox
      Left = 96
      Top = 121
      Width = 403
      Height = 17
      Caption = 
        'Permite Faturamento de pedidos do Cliente Estoque Externo pelo A' +
        'utcom'
      DataField = 'EEE_PERFAT'
      DataSource = dtsTabela
      TabOrder = 5
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object chkZerImp: TDBCheckBox
      Left = 96
      Top = 137
      Width = 403
      Height = 17
      Caption = 'Emitir Nota Fiscal de Remessa com impostos zerados e CST x41'
      DataField = 'EEE_ZERIMP'
      DataSource = dtsTabela
      TabOrder = 6
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 424
    Top = 0
  end
  object dtsTabela: TDataSource
    Left = 352
  end
end
