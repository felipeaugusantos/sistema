inherited frmCadBeneficioFiscal: TfrmCadBeneficioFiscal
  Height = 205
  Caption = 'Cadastro de Benef'#237'cio Fiscal'
  ExplicitHeight = 205
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 135
    Height = 25
    TabOrder = 1
    ExplicitTop = 135
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Height = 21
      ExplicitHeight = 21
      inherited btnPesquisa: TBitBtnLocked
        Width = 75
        ExplicitWidth = 75
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 498
      Height = 20
      ExplicitLeft = 498
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 160
    TabOrder = 3
    ExplicitTop = 160
  end
  inherited pgcDados: TPageControl
    Height = 135
    Visible = False
    ExplicitHeight = 135
    inherited tbsGeral: TTabSheet
      ExplicitHeight = 103
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 585
    Height = 135
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object lblCodigo: TLabel
      Left = 57
      Top = 10
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lblDescricao: TLabel
      Left = 41
      Top = 34
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblCST: TLabel
      Left = 71
      Top = 82
      Width = 22
      Height = 14
      Caption = 'CST:'
    end
    object lblCFOP: TLabel
      Left = 63
      Top = 58
      Width = 30
      Height = 14
      Caption = 'CFOP:'
    end
    object lblPerfilAbreviacao: TLabel
      Left = 8
      Top = 106
      Width = 85
      Height = 14
      Caption = 'Perfil Abrevia'#231#227'o:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 99
      Top = 7
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BEF_CODIGO'
      DataSource = dtsCadBef
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescricao: TDBEditFocus
      Tag = 99
      Left = 99
      Top = 31
      Width = 471
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BEF_DESBEF'
      DataSource = dtsCadBef
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodCFOP: TDBEditFocus
      Tag = 99
      Left = 99
      Top = 55
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BEF_CFOPBF'
      DataSource = dtsCadBef
      TabOrder = 2
      OnKeyPress = dbeCodCFOPKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodCST: TDBEditFocus
      Tag = 99
      Left = 99
      Top = 79
      Width = 57
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BEF_CSTBEF'
      DataSource = dtsCadBef
      TabOrder = 3
      OnKeyPress = dbeCodCSTKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object edtDescCFOP: TEditFocus
      Left = 159
      Top = 55
      Width = 411
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDescCST: TEditFocus
      Left = 159
      Top = 79
      Width = 411
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object cmbTipAbf: TComboBoxFocus
      Tag = 99
      Left = 99
      Top = 103
      Width = 471
      Height = 22
      Style = csDropDownList
      Ctl3D = True
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
      OnChange = cmbTipAbfChange
      OnCloseUp = cmbTipAbfCloseUp
      Items.Strings = (
        'PEF - ENTRADAS PESSOA FISICA (PF OU PJ SEM INSC. ESTADUAL)'
        'PEJ - ENTRADAS PESSOA JURIDICA (INDUSTRIA)'
        
          'PER - ENTRADAS PESSOA JURIDICA (DISTRIBUICAO/REVENDA/COMERCIALIZ' +
          'ACAO)'
        
          'PES - ENTRADAS PESSOA JUR'#205'DICA  (SIMPLES NACIONAL - DISTRIBUI'#199#195'O' +
          ' / REVENDA / COMERCIALIZA'#199#195'O)'
        'PSI - ENTRADAS PESSOA JUR'#205'DICA (SIMPLES NACIONAL - IND'#218'STRIA)'
        'PII - ENTRADAS PESSOA JURIDICA ( IND'#218'STRIA INCENTIVADA )'
        'NCO - SAIDAS NAO CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL)'
        'CCO - SAIDAS CONTRIBUINTE CONSUMIDOR'
        'CNC - SAIDAS CONTRIBUINTE NAO CONSUMIDOR'
        'SNA - SAIDAS SIMPLES NACIONAL'
        'CTA - SAIDAS CONSTRUTORA / NAO CONTRIBUINTE COM INSC.ESTADUAL'
        'PRU - SAIDAS PRODUTOR RURAL'
        'IND - SAIDAS INDUSTRIA'
        'TRS - SAIDAS TRANSFERENCIAS ENTRE LOJAS')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeTipAbf: TDBEditFocus
      Left = 99
      Top = 103
      Width = 121
      Height = 22
      DataField = 'BEF_PERABR'
      DataSource = dtsCadBef
      TabOrder = 7
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEmpresa: TDBEditFocus
      Tag = 99
      Left = 99
      Top = 175
      Width = 88
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'BEF_CODEMP'
      DataSource = dtsCadBef
      TabOrder = 8
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 384
    Top = 8
  end
  object dtsCadBef: TDataSource
    Left = 488
    Top = 8
  end
end
