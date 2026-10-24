inherited frmCadServicos: TfrmCadServicos
  Left = 284
  Top = 223
  Width = 750
  Height = 727
  Caption = 'Cadastro de Servi'#231'os'
  ExplicitWidth = 750
  ExplicitHeight = 727
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 656
    Width = 744
    Height = 26
    TabOrder = 13
    ExplicitTop = 656
    ExplicitWidth = 744
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 663
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 663
      ExplicitHeight = 22
      inherited btnIncluir: TBitBtnLocked
        Width = 66
        Height = 22
        Align = alLeft
        ExplicitWidth = 66
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 66
        Height = 22
        Align = alLeft
        ExplicitLeft = 66
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 138
        Height = 22
        Align = alLeft
        ExplicitLeft = 138
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 210
        Height = 22
        Align = alLeft
        ExplicitLeft = 210
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 282
        Height = 22
        Align = alLeft
        ExplicitLeft = 282
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 354
        Width = 77
        Height = 22
        Align = alLeft
        ExplicitLeft = 354
        ExplicitWidth = 77
        ExplicitHeight = 22
      end
      object btnTribMunicipio: TBitBtnLocked
        Left = 431
        Top = 0
        Width = 102
        Height = 22
        Align = alLeft
        Caption = 'C'#243'd. Trib. &Munic'#237'pio'
        TabOrder = 6
        OnClick = btnTribMunicipioClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 665
      Align = alRight
      ExplicitLeft = 665
    end
  end
  inherited pnlStatus: TPanel
    Top = 682
    Width = 744
    TabOrder = 14
    ExplicitTop = 682
    ExplicitWidth = 744
    inherited pnlNomeForm: TPanel
      Left = 598
      Width = 146
      ExplicitLeft = 598
      ExplicitWidth = 146
    end
    inherited pnlInfo: TPanel
      Width = 598
      ExplicitWidth = 598
    end
  end
  inherited pgcDados: TPageControl
    Left = 1500
    Top = 141
    Width = 535
    Height = 291
    Align = alNone
    TabOrder = 15
    ExplicitLeft = 1500
    ExplicitTop = 141
    ExplicitWidth = 535
    ExplicitHeight = 291
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 527
      ExplicitHeight = 259
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 744
    Height = 204
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
    object Label2: TLabel
      Left = 73
      Top = 36
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 91
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object lbl1: TLabel
      Left = 40
      Top = 135
      Width = 87
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Valor do Servi'#231'o:'
      Layout = tlBottom
    end
    object lblTmpMed: TLabel
      Left = 465
      Top = 135
      Width = 125
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Tempo m'#233'dio do servi'#231'o:'
      Layout = tlBottom
    end
    object lblTitDesMax: TLabel
      Left = 34
      Top = 159
      Width = 94
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Desconto m'#225'ximo:'
      Layout = tlBottom
    end
    object lblPerDesMax: TLabel
      Left = 191
      Top = 159
      Width = 11
      Height = 14
      AutoSize = False
      Caption = '%'
      Layout = tlBottom
    end
    object Label12: TLabel
      Left = 74
      Top = 82
      Width = 51
      Height = 14
      Caption = 'Aplica'#231#227'o:'
    end
    object lblCodGru: TLabel
      Left = 37
      Top = 60
      Width = 88
      Height = 14
      Alignment = taRightJustify
      Caption = 'Grupo de Servi'#231'o:'
    end
    object lblCusSer: TLabel
      Left = 256
      Top = 135
      Width = 73
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Custo Servi'#231'o:'
      Layout = tlBottom
    end
    object lblSimplesNacional: TLabel
      Left = 211
      Top = 158
      Width = 118
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tabela Simples Nacional:'
    end
    object Label37: TLabel
      Left = 497
      Top = 12
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ativo:'
    end
    object ColorLabel1: TColorLabel
      Left = 570
      Top = 12
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblPerBrd: TLabel
      Left = 552
      Top = 152
      Width = 38
      Height = 28
      Alignment = taRightJustify
      Caption = 'Permite Brinde:'
      WordWrap = True
    end
    object clbPerBrd: TColorLabel
      Left = 635
      Top = 159
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblIBPT_F: TLabel
      Left = 42
      Top = 183
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'IBPT Trib.Federal:'
    end
    object lblIBPT_FP: TLabel
      Left = 191
      Top = 183
      Width = 10
      Height = 14
      Alignment = taRightJustify
          Caption = '%'
        end
        object lblIBPT_M: TLabel
          Left = 498
          Top = 183
          Width = 92
          Height = 14
      Alignment = taRightJustify
          Caption = 'IBPT Trib.Municipal:'
        end
        object lblIBPT_MP: TLabel
          Left = 657
          Top = 183
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object lblIBPT_E: TLabel
          Left = 239
          Top = 183
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'IBPT Trib.Estadual:'
        end
        object lblIBPT_EP: TLabel
          Left = 393
          Top = 183
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object cmbSimplesNacional: TComboBoxFocus
          Tag = 99
          Left = 331
      Top = 155
      Width = 145
      Height = 22
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 9
      OnChange = cmbSimplesNacionalChange
      Items.Strings = (
        'Servi'#231'o (Anexo III)'
        'Servi'#231'o (Anexo IV)'
        'Servi'#231'o (Anexo V)'
        'Servi'#231'o (Anexo V-A)')
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeDesSer: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 32
      Width = 568
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_DESSER'
      DataSource = dtsCadSer
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodSer: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 8
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_CODSER'
      DataSource = dtsCadSer
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeValSer: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 131
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_VALSER'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTmpMed: TDBEditFocus
      Tag = 99
      Left = 592
      Top = 131
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_TMPMED'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesMax: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 155
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_DESMAX'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbmAplicacao: TDBMemoFocus
      Left = 129
      Top = 82
      Width = 568
      Height = 47
      DataField = 'SER_APLICA'
      DataSource = dtsCadSer
      TabOrder = 4
      OnKeyPress = dbmAplicacaoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object dbeCodGru: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 57
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_CODGRU'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 3
      OnKeyPress = dbeCodGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodGruChamaCadastro
    end
    object dbeCusSer: TDBEditFocus
      Tag = 99
      Left = 331
      Top = 131
      Width = 86
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_VALCUS'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtDesGru: TEditFocus
      Left = 170
      Top = 57
      Width = 527
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 14
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeStatus: TDBEditFocus
      Tag = 99
      Left = 529
      Top = 8
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_ATIVO_'
      DataSource = dtsCadSer
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePerBrd: TDBEditFocus
      Tag = 99
      Left = 594
      Top = 155
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_PERBRD'
      DataSource = dtsCadSer
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeIBPT_F: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 179
      Width = 60
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'SER_IBPT_F'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
        end
        object dbeIBPT_M: TDBEditFocus
          Tag = 99
          Left = 594
          Top = 179
          Width = 60
          Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'SER_IBPT_M'
          DataSource = dtsCadSer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          TabOrder = 13
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeIBPT_E: TDBEditFocus
          Tag = 99
          Left = 331
          Top = 179
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          Ctl3D = True
          DataField = 'SER_IBPT_E'
          DataSource = dtsCadSer
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentCtl3D = False
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlSerTer: TPanel [4]
    Left = 0
    Top = 521
    Width = 744
    Height = 133
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    TabOrder = 12
    object GroupBox3: TGroupBox
      Left = 12
      Top = -2
      Width = 717
      Height = 131
      Caption = 'Servi'#231'o Terceirizado:'
      TabOrder = 0
      object Label4: TLabel
        Left = 15
        Top = 28
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Serv. Tercei.:'
      end
      object Label5: TLabel
        Left = 19
        Top = 51
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object Label7: TLabel
        Left = 17
        Top = 97
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cond. Pagto:'
      end
      object ColorLabel8: TColorLabel
        Left = 141
        Top = 28
        Width = 55
        Height = 14
        Caption = '(S)im (N)'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        CorDestaque = clRed
      end
      object mskConPag: TMaskEditFocus
        Tag = 99
        Left = 80
        Top = 94
        Width = 526
        Height = 22
        CharCase = ecUpperCase
        Enabled = False
        EditMask = 
          '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
          '99.999.999.999.999.999.999.999.999;0;'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 98
        TabOrder = 4
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object dbeTercer: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 25
        Width = 55
        Height = 22
        CharCase = ecUpperCase
        DataField = 'SER_TERCER'
        DataSource = dtsCadSer
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCodFor: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 48
        Width = 55
        Height = 22
        CharCase = ecUpperCase
        DataField = 'SER_CODFOR'
        DataSource = dtsCadSer
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        OnKeyPress = dbeCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
        OnChamaCadastro = dbeCodForChamaCadastro
      end
      object edtNomFor: TEditFocus
        Left = 136
        Top = 48
        Width = 550
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
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
      object dbeCndPag: TDBEditFocus
        Tag = 99
        Left = 80
        Top = 94
        Width = 55
        Height = 22
        CharCase = ecUpperCase
        DataField = 'SER_CODCND'
        DataSource = dtsCadSer
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        OnKeyPress = dbeCndPagKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttAlfanumerico
        OnChamaCadastro = dbeCndPagChamaCadastro
      end
      object edtDesPag: TEditFocus
        Left = 136
        Top = 94
        Width = 550
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      inline fraPlanoDeContas: TfraPlanoDeContasDBEditFocus
        Left = 3
        Top = 71
        Width = 683
        Height = 22
        TabOrder = 3
        ExplicitLeft = 3
        ExplicitTop = 71
        ExplicitWidth = 683
        inherited lblPlaContas: TLabel
          Left = 6
          Width = 69
          Height = 14
          Caption = 'Plano Contas: '
          ExplicitLeft = 6
          ExplicitWidth = 69
          ExplicitHeight = 14
        end
        inherited dbeCodCta: TDBEditFocus
          Left = 77
          Height = 22
          DataField = 'SER_CODCTA'
          DataSource = dtsCadSer
          OnKeyPress = fraPlanoDeContasdbeCodCtaKeyPress
          OnChamaCadastro = dbeCodCtaChamaCadastro
          ExplicitLeft = 77
          ExplicitHeight = 22
        end
        inherited edtDesCta: TEditFocus
          Left = 133
          Width = 550
          Height = 22
          ExplicitLeft = 133
          ExplicitWidth = 550
          ExplicitHeight = 22
        end
      end
    end
  end
  object pnlTriMunicipio: TPanel [5]
    Left = 0
    Top = 250
    Width = 744
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label3: TLabel
      Left = 345
      Top = 5
      Width = 124
      Height = 14
      Caption = 'C'#243'digo da lista LC 116/03:'
    end
    object lbl6: TLabel
      Left = 51
      Top = 5
      Width = 77
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'd.Trib.Munic.:'
      Layout = tlBottom
    end
    object lblNatOpe: TLabel
      Left = 538
      Top = 6
      Width = 116
      Height = 14
      Caption = 'Natureza da Opera'#231#227'o :'
    end
    object dbeCdLsSe: TDBEditFocus
      Tag = 99
      Left = 471
      Top = 1
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_CDLSSE'
      DataSource = dtsCadSer
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTriMun: TDBEditFocus
      Tag = 99
      Left = 130
      Top = 1
      Width = 200
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_TRIMUN'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNatOpe: TDBEditFocus
      Tag = 99
      Left = 657
      Top = 2
      Width = 40
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_NATOPE'
      DataSource = dtsCadSer
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlTipSer: TPanel [6]
    Left = 0
    Top = 422
    Width = 744
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 8
    object lblTipSer: TLabel
      Left = 49
      Top = 4
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Servi'#231'o:'
    end
    object dbeTipSer: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 1
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_TIPSER'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnKeyPress = dbeTipSerKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeTipSerChamaCadastro
    end
    object edtTipSer: TEditFocus
      Left = 170
      Top = 1
      Width = 527
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
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
  end
  object pnlEmpresa: TPanel [7]
    Left = 0
    Top = 374
    Width = 744
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 6
    object Label11: TLabel
      Left = 27
      Top = 5
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa do Servi'#231'o:'
    end
    object dbeCodEmp: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 1
      Width = 41
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_CODEMP'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      OnKeyPress = dbeCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCodEmpChamaCadastro
    end
    object edtNomEmp: TEditFocus
      Left = 170
      Top = 1
      Width = 527
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
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
  end
  object pnlComMec: TPanel [8]
    Left = 0
    Top = 398
    Width = 744
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 7
    object lblTipComMecTec: TLabel
      Left = 37
      Top = 11
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Mec'#226'nico/T'#233'cnico:'
    end
    object lblPerValMc: TLabel
      Left = 449
      Top = 6
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object lblValComMecTec: TLabel
      Left = 267
      Top = 6
      Width = 115
      Height = 14
      Alignment = taRightJustify
      Caption = 'Comiss'#227'o do Mec./T'#233'c.:'
    end
    object Label162: TLabel
      Left = 42
      Top = -1
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Comiss'#227'o'
    end
    object ColorLabel31: TColorLabel
      Left = 157
      Top = 6
      Width = 96
      Height = 14
      Caption = '(P)ercentual (V)alor'
      CorDestaque = clRed
    end
    object dbeComMec: TDBEditFocus
      Tag = 99
      Left = 384
      Top = 1
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_COMMEC'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTpCoMc: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 1
      Width = 22
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_TPCOMC'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnExit = dbeTpCoMcExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
  end
  object pnlComVen: TPanel [9]
    Left = 0
    Top = 350
    Width = 744
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 5
    object lblComVen: TLabel
      Left = 77
      Top = 11
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object lblPerValVn: TLabel
      Left = 449
      Top = 6
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object lblComVenValor: TLabel
      Left = 267
      Top = 6
      Width = 115
      Height = 14
      Alignment = taRightJustify
      Caption = 'Comiss'#227'o do Vendedor:'
    end
    object lblComissao: TLabel
      Left = 42
      Top = -1
      Width = 85
      Height = 14
      Alignment = taRightJustify
      Caption = 'Tipo de Comiss'#227'o'
    end
    object cllComVen: TColorLabel
      Left = 157
      Top = 6
      Width = 96
      Height = 14
      Caption = '(P)ercentual (V)alor'
      CorDestaque = clRed
    end
    object dbeComVen: TDBEditFocus
      Tag = 99
      Left = 384
      Top = 1
      Width = 64
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'SER_COMVEN'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeTpCoVn: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 1
      Width = 22
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'SER_TPCOMV'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 0
      OnExit = dbeTpCoVnExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
  end
  object pnlAliqISS: TPanel [10]
    Left = 0
    Top = 226
    Width = 744
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object lblPerAliqIss: TLabel
      Left = 191
      Top = 6
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object lblAliqIss: TLabel
      Left = 66
      Top = 6
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Al'#237'quota ISS:'
    end
    object lblRedIss: TLabel
      Left = 212
      Top = 6
      Width = 65
      Height = 14
      Alignment = taRightJustify
      Caption = 'Redu'#231#227'o ISS:'
    end
    object lblPerRedIss: TLabel
      Left = 334
      Top = 6
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object dbeAliqISS: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 1
      Width = 58
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'SER_ALQISS'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeRedIss: TDBEditFocus
      Tag = 99
      Left = 280
      Top = 1
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'SER_REDISS'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlRetIRPJ: TPanel [11]
    Left = 0
    Top = 446
    Width = 744
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 9
    object lblVLIRPJ: TLabel
      Left = 368
      Top = 5
      Width = 240
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor m'#237'nimo de faturamento para reten'#231#227'o - IRPJ:'
    end
    object lblRetIRPJ: TLabel
      Left = 71
      Top = 5
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ret'#233'm IRPJ:'
    end
    object clReIRPJ: TColorLabel
      Left = 158
      Top = 5
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object dbeReIRPJ: TDBEditFocus
      Tag = 99
      Left = 130
      Top = 0
      Width = 22
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'SER_REIRPJ'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 0
      OnExit = dbeTpCoVnExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeVlIRPJ: TDBEditFocus
      Tag = 99
      Left = 611
      Top = 0
      Width = 86
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_VLIRPJ'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  object pnlCnaeFiscal: TPanel [12]
    Left = 0
    Top = 204
    Width = 744
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlCnaeFiscal'
    ShowCaption = False
    TabOrder = 1
    object Label47: TLabel
      Left = 63
      Top = 5
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'CNAE Fiscal:'
    end
    object dbeCNAE: TDBEditFocus
      Tag = 99
      Left = 129
      Top = 0
      Width = 75
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_CNAEFI'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 0
      OnKeyPress = dbeCNAEKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
      OnChamaCadastro = dbeCndPagChamaCadastro
    end
    object edtNomCna: TEditFocus
      Left = 207
      Top = 0
      Width = 490
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
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
  end
  object pnlServicoTributavel: TPanel [13]
    Left = 0
    Top = 494
    Width = 744
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 11
    object Label6: TLabel
      Left = 35
      Top = 4
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'Servi'#231'o Tribut'#225'vel:'
    end
    object ColorLabel2: TColorLabel
      Left = 191
      Top = 4
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object dbeTribut: TDBEditFocus
      Tag = 99
      Left = 130
      Top = 1
      Width = 55
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_TRIBUT'
      DataSource = dtsCadSer
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlRetPCC: TPanel [14]
    Left = 0
    Top = 470
    Width = 744
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 10
    object Label8: TLabel
      Left = 304
      Top = 5
      Width = 304
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor m'#237'nimo de faturamento para reten'#231#227'o - PIS/COFINS/CSLL:'
    end
    object Label9: TLabel
      Left = 7
      Top = 5
      Width = 120
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ret'#233'm PIS/COFINS/CSLL:'
    end
    object ColorLabel3: TColorLabel
      Left = 158
      Top = 5
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object dbeRetPCC: TDBEditFocus
      Tag = 99
      Left = 130
      Top = 0
      Width = 22
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'SER_RETPCC'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 0
      OnExit = dbeTpCoVnExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeValPCC: TDBEditFocus
      Tag = 99
      Left = 611
      Top = 0
      Width = 86
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_VALPCC'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 20
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
  end
  object pnlReformaTributaria: TPanel [15]
    Left = 0
    Top = 275
    Width = 744
    Height = 75
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    object Label16: TLabel
      Left = 29
      Top = 53
      Width = 96
      Height = 14
      Caption = 'C'#243'd. Ind. Opera'#231#227'o:'
    end
    object Label17: TLabel
      Left = 51
      Top = 29
      Width = 77
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'C'#243'd.Class.Trib.:'
      Layout = tlBottom
    end
    object Label10: TLabel
      Left = 66
      Top = 6
      Width = 60
      Height = 14
      Caption = 'C'#243'digo NBS:'
    end
    object dbeIndOpe: TDBEditFocus
      Tag = 99
      Left = 130
      Top = 50
      Width = 100
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_INDOPE'
      DataSource = dtsCadSer
      MaxLength = 10
      TabOrder = 4
      OnKeyPress = dbeIndOpeKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeClaTri: TDBEditFocus
      Tag = 99
      Left = 130
      Top = 26
      Width = 100
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_CLATRI'
      DataSource = dtsCadSer
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      OnKeyPress = dbeClaTriKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbtClaTri: TEditFocus
      Left = 233
      Top = 26
      Width = 465
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
    object dbtIndOpe: TEditFocus
      Left = 233
      Top = 50
      Width = 465
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object dbeCodNBS: TDBEditFocus
      Tag = 99
      Left = 130
      Top = 3
      Width = 100
      Height = 22
      CharCase = ecUpperCase
      DataField = 'SER_CODNBS'
      DataSource = dtsCadSer
      TabOrder = 0
      OnKeyPress = dbeCodNBSKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbtCodNBS: TEditFocus
      Left = 233
      Top = 3
      Width = 465
      Height = 22
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 187
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 480
    Top = 187
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 496
    Top = 232
  end
  object dtsCadSer: TDataSource
    OnStateChange = dtsCadSerStateChange
    Left = 512
    Top = 187
  end
end
