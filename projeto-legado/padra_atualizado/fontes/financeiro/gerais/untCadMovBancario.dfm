inherited frmCadMovBancario: TfrmCadMovBancario
  Left = 329
  Top = 205
  Width = 604
  Height = 436
  Caption = 'Movimenta'#231#227'o de Conta Banco'
  OnDestroy = FormDestroy
  ExplicitWidth = 604
  ExplicitHeight = 436
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 366
    Width = 598
    Height = 25
    TabOrder = 2
    ExplicitTop = 366
    ExplicitWidth = 598
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 526
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 526
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnGravar: TBitBtnLocked
        Align = alLeft
      end
      inherited btnAlterar: TBitBtnLocked
        Align = alLeft
      end
      inherited btnExcluir: TBitBtnLocked
        Align = alLeft
      end
      inherited btnCancela: TBitBtnLocked
        Align = alLeft
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 78
        Align = alLeft
        ExplicitWidth = 78
      end
      object btnRegrasPortador: TBitBtnLocked
        Left = 438
        Top = 0
        Width = 81
        Height = 20
        Hint = 
          'Clique aqui para visualizar as regras para altera'#231#227'o de portador' +
          '.'
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alRight
        Caption = 'Regras'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
          33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
          FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
          FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
          FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
          FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
          FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
          3333333773FFFF77333333333FBFBF3333333333377777333333}
        NumGlyphs = 2
        TabOrder = 6
        OnClick = btnRegrasPortadorClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 528
      Width = 68
      Height = 21
      Align = alRight
      ExplicitLeft = 528
      ExplicitWidth = 68
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 391
    Width = 598
    TabOrder = 4
    ExplicitTop = 391
    ExplicitWidth = 598
    inherited pnlNomeForm: TPanel
      Left = 454
      Width = 144
      ExplicitLeft = 454
      ExplicitWidth = 144
    end
    inherited pnlInfo: TPanel
      Width = 454
      ExplicitWidth = 454
    end
  end
  inherited pgcDados: TPageControl
    Width = 598
    Height = 341
    TabOrder = 3
    Visible = False
    ExplicitWidth = 598
    ExplicitHeight = 341
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 590
      ExplicitHeight = 309
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 598
    Height = 341
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 51
      Top = 11
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sequ'#234'ncia:'
    end
    object Label2: TLabel
      Left = 61
      Top = 57
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label3: TLabel
      Left = 258
      Top = 11
      Width = 25
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data:'
    end
    object Label4: TLabel
      Left = 8
      Top = 80
      Width = 97
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero Documento:'
    end
    object Label6: TLabel
      Left = 77
      Top = 103
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object Label8: TLabel
      Left = 60
      Top = 172
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object ColorLabel1: TColorLabel
      Left = 406
      Top = 80
      Width = 89
      Height = 14
      Caption = '(C)r'#233'dito / (D)'#233'bito'
      CorDestaque = clRed
    end
    object Label10: TLabel
      Left = 442
      Top = 11
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Compet'#234'ncia:'
    end
    object Label11: TLabel
      Left = 61
      Top = 31
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label12: TLabel
      Left = 262
      Top = 80
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo Lan'#231'amento:'
    end
    object dbeSeqLan: TDBEditFocus
      Tag = 99
      Left = 108
      Top = 7
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTB_SEQLAN'
      DataSource = dtsMovBan
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodPor: TDBEditFocus
      Tag = 99
      Left = 108
      Top = 53
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTB_CODPOR'
      DataSource = dtsMovBan
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      OnKeyPress = dbeCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodPorChamaCadastro
    end
    object dbeDtaLan: TDBEditFocus
      Tag = 99
      Left = 287
      Top = 7
      Width = 90
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTB_DTALAN'
      DataSource = dtsMovBan
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNumDoc: TDBEditFocus
      Tag = 99
      Left = 108
      Top = 76
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTB_NUMDOC'
      DataSource = dtsMovBan
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCreDeb: TDBEditFocus
      Tag = 99
      Left = 351
      Top = 76
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTB_CREDEB'
      DataSource = dtsMovBan
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeValLan: TDBEditFocus
      Tag = 99
      Left = 108
      Top = 99
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTB_VALLAN'
      DataSource = dtsMovBan
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeHisto01: TDBEditFocus
      Tag = 99
      Left = 108
      Top = 168
      Width = 478
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTB_HIST01'
      DataSource = dtsMovBan
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeHisto02: TDBEditFocus
      Tag = 99
      Left = 108
      Top = 191
      Width = 478
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTB_HIST02'
      DataSource = dtsMovBan
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 12
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomPor: TEditFocus
      Left = 169
      Top = 53
      Width = 417
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 13
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object gpbContraPartida: TGroupBox
      Left = 8
      Top = 221
      Width = 579
      Height = 111
      Caption = 'Contra Partida'
      Enabled = False
      TabOrder = 14
      object Label5: TLabel
        Left = 50
        Top = 23
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object lblPorRes: TLabel
        Left = 257
        Top = 90
        Width = 143
        Height = 14
        Caption = 'Portador do Resumo de Caixa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object lblCaixa: TLabel
        Left = 64
        Top = 68
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Caixa:'
      end
      object edtNomPor2: TEditFocus
        Left = 158
        Top = 19
        Width = 416
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPortadorCaixa: TEditFocus
        Tag = 99
        Left = 97
        Top = 19
        Width = 60
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        OnChange = edtPortadorCaixaChange
        OnExit = edtPortadorCaixaExit
        OnKeyPress = edtPortadorCaixaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object chkGerCon: TCheckBox
        Left = 97
        Top = 88
        Width = 152
        Height = 16
        Caption = 'Gerar movimento cont'#225'bil?'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 6
      end
      object edtCodigoCaixa: TEditFocus
        Tag = 99
        Left = 97
        Top = 65
        Width = 60
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 4
        OnKeyPress = edtCodigoCaixaKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDescricaoCaixa: TEditFocus
        Left = 158
        Top = 65
        Width = 416
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ReadOnly = True
        TabOrder = 5
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object pnlEmpresaContraPartida: TPanel
        Left = 10
        Top = 65
        Width = 566
        Height = 23
        BevelOuter = bvNone
        TabOrder = 3
        object lblEmpresa: TLabel
          Left = 39
          Top = 3
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object edtCodigoEmpresa: TEditFocus
          Tag = 99
          Left = 87
          Top = 0
          Width = 60
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtCodigoEmpresaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtDescricaoEmpresa: TEditFocus
          Left = 148
          Top = 0
          Width = 416
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
      end
      inline fraPlanoDeContasCon: TfraPlanoDeContasMskEdit
        Left = 10
        Top = 42
        Width = 565
        Height = 22
        TabOrder = 1
        ExplicitLeft = 10
        ExplicitTop = 42
        ExplicitWidth = 565
        inherited lblPlaContas: TLabel
          Width = 81
          Height = 14
          ExplicitWidth = 81
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 148
          Width = 416
          Height = 22
          ExplicitLeft = 148
          ExplicitWidth = 416
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Left = 87
          Width = 60
          Height = 22
          OnEnter = fraPlanoDeContasConMskCodCtaEnter
          OnExit = fraPlanoDeContasConMskCodCtaExit
          OnKeyPress = fraPlanoDeContasConMskCodCtaKeyPress
          ExplicitLeft = 87
          ExplicitWidth = 60
          ExplicitHeight = 22
        end
      end
    end
    object mskCompet: TMaskEditFocus
      Tag = 99
      Left = 511
      Top = 7
      Width = 75
      Height = 22
      Enabled = False
      EditMask = '99/9999;1;_'
      MaxLength = 7
      TabOrder = 2
      Text = '  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 108
      Top = 30
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'CTB_CODEMP'
      DataSource = dtsMovBan
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 169
      Top = 30
      Width = 417
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    inline fraCentroCusto: TfraCentroCustoDBEditFocus
      Left = 17
      Top = 145
      Width = 571
      Height = 22
      TabOrder = 10
      ExplicitLeft = 17
      ExplicitTop = 145
      ExplicitWidth = 571
      inherited lblEventos: TLabel
        Left = 0
        Width = 87
        Height = 14
        ExplicitLeft = 0
        ExplicitWidth = 87
        ExplicitHeight = 14
      end
      inherited dbeCodEve: TDBEditFocus
        Left = 91
        Width = 60
        Height = 22
        DataField = 'CTB_CODEVE'
        DataSource = dtsMovBan
        PanelInfo = pnlInfo
        OnChamaCadastro = fraCentroCustodbeCodEveChamaCadastro
        ExplicitLeft = 91
        ExplicitWidth = 60
        ExplicitHeight = 22
      end
      inherited edtDesEve: TEditFocus
        Left = 153
        Width = 416
        Height = 22
        ExplicitLeft = 153
        ExplicitWidth = 416
        ExplicitHeight = 22
      end
    end
    inline fraPlanoDeContas: TfraPlanoDeContasDBEditFocus
      Left = 12
      Top = 122
      Width = 574
      Height = 22
      TabOrder = 9
      ExplicitLeft = 12
      ExplicitTop = 122
      ExplicitWidth = 574
      inherited lblPlaContas: TLabel
        Left = 9
        Width = 84
        Height = 14
        ExplicitLeft = 9
        ExplicitWidth = 84
        ExplicitHeight = 14
      end
      inherited dbeCodCta: TDBEditFocus
        Left = 96
        Width = 60
        Height = 22
        DataField = 'CTB_CODCTA'
        DataSource = dtsMovBan
        OnExit = fraPlanoDeContasdbeCodCtaExit
        OnKeyPress = fraPlanoDeContasdbeCodCtaKeyPress
        PanelInfo = pnlInfo
        OnChamaCadastro = fraPlanoDeContasdbeCodCtaChamaCadastro
        ExplicitLeft = 96
        ExplicitWidth = 60
        ExplicitHeight = 22
      end
      inherited edtDesCta: TEditFocus
        Left = 158
        Width = 416
        Height = 22
        ExplicitLeft = 158
        ExplicitWidth = 416
        ExplicitHeight = 22
      end
    end
  end
  object pnlBotoesInfo: TPanel [4]
    Left = 0
    Top = 341
    Width = 598
    Height = 25
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object btnAbrirPastaAnexos: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 148
      Height = 21
      Align = alLeft
      Caption = 'Arquivos Anexos'
      Enabled = False
      TabOrder = 0
      OnClick = btnAbrirPastaAnexosClick
    end
    object btnHistMovBan: TBitBtnLocked
      Left = 150
      Top = 2
      Width = 148
      Height = 21
      Align = alLeft
      Caption = '&Hist. Documento'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD4C00BD4C00
        BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C
        00BD4C00BD4C00BD4C00BD4C00FFF2E2FFEFDDFEEBD8811E00FEE6CBFEE2C6FE
        E0C0E3B08AFEDAB5FED8B0FFD5ABE3A97AFED1A3FECF9EBD4C00BD4C00FFF3E6
        FFF0E1FEEEDC811E00FEE9CFFFE5CAFEE2C4E3B18EFEDDB8FFD9B2FFD8AFE3AB
        7EFED3A5FED0A0BD4C00BD4C00FEF4EBFEF3E6FFF0E1811E00FEEAD4FFE6CEFE
        E3C9E5B490FEDEBCFFDAB7FED8B1E3AB80FED4A7FED1A3BD4C00BD4C00811E00
        811E00811E00811E00E5BDA3E5BCA0E3BA9EE3B899E5B695E5B590E3B28BE5B0
        88E3AD83E3AC81BD4C00BD4C00FFF8F2FFF7EEFFF3E7811E00FFEEDCFFEBD7FE
        E9D0E3B696FEE2C4FEE0BFFEDCB8E3AD86FFD8AFFED5AABD4C00BD4C00FFFBF4
        FFF8F0FEF6EB811E00FFF0E1FFEDDCFEEAD5E5B899FFE5C9FEE2C2FFE0BDE3B0
        88FED9B2FFD7ADBD4C00BD4C00FFFCF8FFFAF4FFF7EF811E00FFF3E5FFEFE0FE
        EDD9E5BA9DFFE7CEFFE3C7FFE1C1E3B18BFEDCB5FED8B1BD4C00BD4C00811E00
        811E00811E00811E00811E00811E00811E00811E00811E00811E00811E00811E
        00811E00811E00BD4C00BD4C00FFFFFEFFFCFAFFFBF6811E00FFF6EDFFF4E6FF
        F2E1811E00FFEBD7FFE9D0FEE6CA811E00FEE0BFFEDDB7BD4C00BD4C00FFFFFF
        FFFEFCFFFCF8811E00FFF8EFFFF4EAFEF3E5811E00FEEEDAFFEAD4FFE7CE811E
        00FFE1C2FEDEBCBD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD
        4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnHistMovBanClick
      OnMouseEnter = btnHistMovBanMouseEnter
      OnMouseLeave = btnHistMovBanMouseLeave
    end
    object btnImprimir: TBitBtnLocked
      Left = 298
      Top = 2
      Width = 142
      Height = 21
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'I&mprimir Comprovante'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
        8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
        93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
        9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
        678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
        8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
        E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
        8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
        EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
        C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
        C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
        D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
        9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
        B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
        BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
        C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
        C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
        AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnImprimirClick
    end
    object btnAlterarPortador: TBitBtnLocked
      Left = 440
      Top = 2
      Width = 142
      Height = 21
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = 'Alterar Portador'
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000011904360007010F001B043C0259
        0DC6016F10F801580CC60036077B000E02200000000000000000000000000000
        000000000000000000000000000000000000046610D702440B91198C2FFF42B6
        6EFF35A053FF178229FF168128FF105A1DB0000E022000000000000000000000
        000000000000000000000000000000000000057A15FF7BD09BFF53C984FF309C
        50F2013A087F0013032A0013032A0038077F0030066E00000000000000020000
        000A00000010000000120000001300000014067B15FF96E3B8FF7CD19DFF0348
        0CA400000018000000100000000400000000002C066300000000000000089672
        52C1D09D70FFD09B6EFFCE996DFFE2C4A7FF077B16FF067B15FF057915FF2583
        28FF8CA36BFF18751EF7017110FF01700FFF00700FFF000000000000000BD3A1
        75FFFFFFFFFFF7EDE2FFF6EBE1FFF5EADFFF98BF8FFFF4E8DCFFF4E8D9FFF4E7
        D8FFF3E6D8FF5A914AFF58C080FF49C37FFF01700FFF000000000000000AD4A2
        77FFFFFFFFFFFAF4EDFFFAF3EBFFFAF3EAFF90BF8EFF7FB67FFFD0DCC4FFD0DC
        C2FF7CAE75FF44A75DFF54C583FF64C388FF01710FFF0000000000000009D6A4
        7AFFFFFFFFFFFBF5EEFFFAF5EDFFF9F4ECFFDBE4D0FF64AD6CFF1D8B30FF1D89
        30FF4BAC64FF70C78EFF248C37FF01410A9102610ED70000000000000008D7A7
        7CFFFFFFFFFFFBF6F0FFD9A676FFD8A575FFD7A372FFDBE4D0FF84B983FF3B94
        44FF0C7C19FF368834FF011C044B0007010F001804360000000000000006D8A8
        7EFFFFFFFFFFFBF7F2FFF6EDE4FFF5EDE3FFF6ECE2FFFAF4EDFFFAF4EBFFF9F3
        EAFFF5EADFFFE3C4A7FF0000001100000000000000000000000000000005DAAB
        80FFFFFFFFFFFCF8F3FFDDAA7BFFDCA97AFFDAA778FFFAF5EEFFD8A575FFFAF3
        ECFFF5ECE0FFCF9A6DFF0000000F00000000000000000000000000000004DBAC
        82FFFFFFFFFFFCF8F4FFF7F0E7FFF6EFE6FFF6EDE4FFFBF6F0FFFAF5EFFFFBF4
        EEFFF7EDE3FFD19D70FF0000000E00000000000000000000000000000003DCAD
        84FFFFFFFFFFFDF9F6FFDFAC80FFDEAC7FFFDEAC7DFFFBF7F1FFDCA97BFFFBF6
        EFFFF7EFE5FFD29F73FF0000000C00000000000000000000000000000002DDAF
        85FFFFFFFFFFFDFAF7FFFCFAF7FFFCF9F6FFFCF9F4FFFCF8F3FFFCF7F3FFFBF6
        F1FFF8EFE8FFD3A175FF0000000B00000000000000000000000000000001DEB0
        87FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFD5A377FF0000000900000000000000000000000000000000A583
        65BEDEB187FFDDAF86FFDCAE85FFDBAD83FFDBAC82FFDAAB81FFD9A97FFFD8A8
        7DFFD7A67CFF9E7A5BC200000005000000000000000000000000}
      TabOrder = 3
      Visible = False
      OnClick = btnAlterarPortadorClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 412
    Top = 180
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 180
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 240
    Top = 180
  end
  object dtsMovBan: TDataSource
    Left = 368
    Top = 180
  end
  object HintControler: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.Animate = cxhaFadeIn
    HintStyle.CallOutPosition = cxbpBottomLeft
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -13
    HintStyle.Font.Name = 'Courier New'
    HintStyle.Font.Style = [fsBold]
    HintStyle.IconType = cxhiCurrentApplication
    HintStyle.Rounded = True
    Left = 448
    Top = 183
  end
  object frxComprovanteMov: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44244.343229629600000000
    ReportOptions.LastChange = 44246.674095648200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      
        'procedure Page1OnBeforePrint(Sender: TfrxComponent);            ' +
        '                                '
      'begin'
      '  If <frxDBGeral."CTB_CREDEB"> = '#39'D'#39' Then  '
      '    memValTip.Text := '#39'D'#201'BITO'#39
      '  Else'
      '    memValTip.Text := '#39'CR'#201'DITO'#39';'
      ''
      '  If <frxDBContra."CTB_GERCON"> = 1 Then'
      '    memValMovBan.Text := '#39'SIM'#39
      '  Else'
      '    memValMovBan.Text := '#39'N'#195'O'#39';'
      ''
      '  If <frxDBContra."CTB_CODOPE"> = '#39#39' Then'
      '  Begin              '
      '    memOpeValContra.Visible := False;'
      '    memLinhaPart.Visible := False;'
      
        '    memOpeContra.Visible := False;                              ' +
        '                '
      '  End;'
      '    '
      '  If <frxDBGeral."CTB_CODEVE"> = '#39#39' Then'
      '    memValCen.Text := '#39#39';'
      ''
      '  If memNomEmpCon.Visible = True Then'
      '  Begin              '
      '    If memNomMovBan.Top < memNomEmpCon.Top Then'
      '    Begin'
      '      memNomEmpCon.Top := memNomMovBan.Top;'
      '      memNomMovBan.Top := memValEmpCon.Top;'
      ''
      '      memValEmpCon.Top := memNomEmpCon.Top;'
      '      memValMovBan.Top := memNomMovBan.Top;        '
      '    End;'
      '  End;                '
      '      '
      '  '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 524
    Top = 106
    Datasets = <
      item
        DataSet = frxDBGeral
        DataSetName = 'frxDBGeral'
      end
      item
        DataSet = frxDBContra
        DataSetName = 'frxDBContra'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 296.900000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'Page1OnBeforePrint'
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 28.000000000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object rllNomRel: TfrxMemoView
          Align = baCenter
          Left = 16.857019999999980000
          Width = 684.396660000000000000
          Height = 24.559060000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[NOMREL]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 298.582870000000000000
        Top = 105.826840000000000000
        Width = 718.110700000000000000
        DataSet = frxDBGeral
        DataSetName = 'frxDBGeral'
        RowCount = 0
        object memValValor: TfrxMemoView
          Left = 195.401574800000000000
          Top = 56.692913390000000000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGeral."CTB_VALLAN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValEmp: TfrxMemoView
          Left = 195.433070870000000000
          Top = 3.866114879999998000
          Width = 510.236232680000000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGeral."CTB_CODEMP"] - [frxDBGeral."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memData: TfrxMemoView
          Left = 7.559060000000000000
          Top = 30.236240000000010000
          Width = 185.196850393701000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data....................:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValData: TfrxMemoView
          Left = 195.401574800000000000
          Top = 30.236240000000010000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGeral."CTB_DTALAN"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memEmp: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779529999999994000
          Width = 185.196838190000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Empresa.................:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memComp: TfrxMemoView
          Left = 7.559055120000000000
          Top = 83.149659999999990000
          Width = 185.196850393701000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Compet'#234'ncia.............:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValComp: TfrxMemoView
          Left = 195.401574800000000000
          Top = 83.149659999999990000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGeral."CTB_COMPET"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memPort: TfrxMemoView
          Left = 7.559060000000000000
          Top = 109.692950000000000000
          Width = 185.196850393701000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Portador................:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValPort: TfrxMemoView
          Left = 195.401574800000000000
          Top = 109.692950000000000000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGeral."CTB_CODPOR"] - [frxDBGeral."POR_NOMPOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memTip: TfrxMemoView
          Left = 7.559055120000000000
          Top = 162.519685040000000000
          Width = 185.196850390000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tipo Lan'#231'amento.........:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValTip: TfrxMemoView
          Left = 195.401574800000000000
          Top = 162.519685040000000000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGeral."CTB_CREDEB"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memNumDoc: TfrxMemoView
          Left = 7.559060000000000000
          Top = 136.062992130000000000
          Width = 185.196850393701000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'N'#176' Documento............:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValNumDoc: TfrxMemoView
          Left = 195.401574800000000000
          Top = 136.062992130000000000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGeral."CTB_NUMDOC"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValor: TfrxMemoView
          Left = 7.559055120000000000
          Top = 56.692913390000000000
          Width = 185.196850393701000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor...................:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memPL: TfrxMemoView
          Left = 7.559060000000000000
          Top = 188.976377952756000000
          Width = 185.196850390000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Plano de Contas.........:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValPL: TfrxMemoView
          Left = 195.401574800000000000
          Top = 188.976377950000000000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGeral."CTB_CODCTA"] - [frxDBGeral."CTA_DESCTA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memCen: TfrxMemoView
          Left = 7.559060000000000000
          Top = 215.433070866142000000
          Width = 185.196850390000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Centro de Custos........:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValCen: TfrxMemoView
          Left = 195.401574800000000000
          Top = 215.433070870000000000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGeral."CTB_CODEVE"] - [frxDBGeral."EVE_DESEVE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValHist1: TfrxMemoView
          Left = 195.401574800000000000
          Top = 241.889763780000000000
          Width = 510.236220470000000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGeral."CTB_HIST01"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memHist1: TfrxMemoView
          Left = 7.559060000000000000
          Top = 241.889763779528000000
          Width = 185.196850390000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Hist'#243'rico 1.............:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValHist2: TfrxMemoView
          Left = 195.401574800000000000
          Top = 268.346456690000000000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBGeral."CTB_HIST02"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memHist2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 268.346456692913000000
          Width = 185.196850390000000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Hist'#243'rico 2.............:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Height = 139.842610000000000000
        Top = 427.086890000000000000
        Width = 718.110700000000000000
        DataSet = frxDBContra
        DataSetName = 'frxDBContra'
        RowCount = 0
        object memValPortContra: TfrxMemoView
          Left = 195.401574800000000000
          Top = 29.354330710000000000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBContra."CTB_CODPOR"] - [frxDBContra."POR_NOMPOR"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memPortContra: TfrxMemoView
          Left = 7.559055120000000000
          Top = 29.354330710000000000
          Width = 185.196850393701000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Portador................:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValPLContra: TfrxMemoView
          Left = 195.401574800000000000
          Top = 55.811023620000010000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBContra."CTB_CODCTA"] - [frxDBContra."CTA_DESCTA"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memPlContra: TfrxMemoView
          Left = 7.559055120000000000
          Top = 55.811023620000010000
          Width = 185.196850393701000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Plano de Contas.........:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memValMovBan: TfrxMemoView
          Left = 195.401574800000000000
          Top = 82.267716539999970000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBContra."CTB_GERCON"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memNomMovBan: TfrxMemoView
          Left = 7.559060000000000000
          Top = 82.267716539999970000
          Width = 185.196850393701000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Gerou Movimento Cont'#225'bil:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 41.423964999999970000
          Top = 4.000000000000000000
          Width = 635.262770000000000000
          Height = 17.000000000000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Contra Partida')
          ParentFont = False
        end
        object memValEmpCon: TfrxMemoView
          Left = 195.401574800000000000
          Top = 108.724409450000000000
          Width = 510.236220470000000000
          Height = 15.118110240000000000
          Visible = False
          DataSet = frmBaixaCtaPagar.frxDataset
          DataSetName = 'frxDataset'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBContra."CTB_CODEMP"] - [frxDBContra."EMP_NOMEMP"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
          Formats = <
            item
            end
            item
            end>
        end
        object memNomEmpCon: TfrxMemoView
          Left = 7.559055120000000000
          Top = 108.724409450000000000
          Width = 185.196850393701000000
          Height = 15.118110240000000000
          Visible = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Empresa.................:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
      object ColumnFooter1: TfrxColumnFooter
        FillType = ftBrush
        Height = 124.724490000000000000
        Top = 627.401980000000000000
        Width = 718.110700000000000000
        object memOpeLan: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000022000
          Width = 185.196850393701000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Operador Lan'#231'amento.....:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memOpeContra: TfrxMemoView
          Left = 7.559060000000000000
          Top = 73.590443779999990000
          Width = 185.196850393701000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Operador Contra Partida.:')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memLinhaLan: TfrxLineView
          Left = 195.401574803150000000
          Top = 22.677180000000020000
          Width = 510.236220472441000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object memLinhaPart: TfrxLineView
          Left = 195.401574803150000000
          Top = 92.488081569999960000
          Width = 510.236220472441000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object memOpeValContra: TfrxMemoView
          Left = 195.401574803150000000
          Top = 96.267609129999990000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBContra."CTB_CODOPE"] - [frxDBContra."OPE_NOMOPE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
        object memOpeValLan: TfrxMemoView
          Left = 195.401574803150000000
          Top = 24.456710000000040000
          Width = 510.236220472441000000
          Height = 15.118110240000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Courier New'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBGeral."CTB_CODOPE"] - [frxDBGeral."OPE_NOMOPE"]')
          ParentFont = False
          WordWrap = False
          VAlign = vaCenter
        end
      end
    end
  end
  object frxDBGeral: TfrxDBDataset
    UserName = 'frxDBGeral'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 562
    Top = 106
  end
  object frxDBContra: TfrxDBDataset
    UserName = 'frxDBContra'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 477
    Top = 107
  end
end
