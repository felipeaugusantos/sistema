inherited frmAltPrecoFornecedor: TfrmAltPrecoFornecedor
  Left = 214
  Top = 165
  Width = 802
  Height = 700
  BorderStyle = bsSizeable
  Caption = 'Altera'#231#227'o Global de Pre'#231'os de itens do Fornecedor'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 802
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 14
  object pgbProgresso: TProgressBar [0]
    Left = 0
    Top = 634
    Width = 786
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 558
    Width = 786
    ExplicitTop = 558
    ExplicitWidth = 786
    DesignSize = (
      786
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 782
      ExplicitWidth = 782
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 645
    Width = 786
    ExplicitTop = 645
    ExplicitWidth = 786
    inherited pnlNomeForm: TPanel
      Left = 639
      Width = 147
      ExplicitLeft = 639
      ExplicitWidth = 147
    end
    inherited pnlInfo: TPanel
      Width = 639
      ExplicitWidth = 639
    end
  end
  inherited pgcDados: TPageControl
    Top = 377
    Width = 786
    Height = 181
    Visible = False
    ExplicitTop = 377
    ExplicitWidth = 786
    ExplicitHeight = 181
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 778
      ExplicitHeight = 149
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 786
    Height = 377
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object pnlEmpresas: TPanel
      Left = 2
      Top = 276
      Width = 782
      Height = 46
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlEmpresas'
      ShowCaption = False
      TabOrder = 0
      object lbl2: TLabel
        Left = 13
        Top = 1
        Width = 136
        Height = 28
        Alignment = taRightJustify
        Caption = 'Empresas que ter'#227'o a nova tabela de pre'#231'o:'
        WordWrap = True
      end
      object cklEmpresas: TCheckListBox
        Left = 153
        Top = 0
        Width = 616
        Height = 46
        Columns = 8
        ItemHeight = 14
        TabOrder = 0
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 782
      Height = 274
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Label1: TLabel
        Left = 31
        Top = 8
        Width = 68
        Height = 14
        Alignment = taRightJustify
        Caption = 'Linha / Grupo:'
      end
      object Label2: TLabel
        Left = 47
        Top = 30
        Width = 52
        Height = 14
        Alignment = taRightJustify
        Caption = 'Descri'#231#227'o:'
      end
      object Label3: TLabel
        Left = 43
        Top = 52
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Refer'#234'ncia:'
      end
      object Label4: TLabel
        Left = 459
        Top = 52
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Unidade:'
      end
      object Label6: TLabel
        Left = 66
        Top = 74
        Width = 33
        Height = 14
        Alignment = taRightJustify
        Caption = 'Marca:'
      end
      object Label8: TLabel
        Left = 40
        Top = 120
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object Label5: TLabel
        Left = 33
        Top = 142
        Width = 66
        Height = 14
        Alignment = taRightJustify
        Caption = 'Abrev. Fiscal:'
      end
      object Label7: TLabel
        Left = 3
        Top = 186
        Width = 96
        Height = 14
        Alignment = taRightJustify
        Caption = 'Classifica'#231#227'o de IPI:'
      end
      object Label9: TLabel
        Left = 294
        Top = 186
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Ativo?:'
      end
      object ColorLabel1: TColorLabel
        Left = 373
        Top = 186
        Width = 96
        Height = 14
        Caption = '(S)im (N)'#227'o (T)odos'
        CorDestaque = clRed
      end
      object Label10: TLabel
        Left = 46
        Top = 164
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Express'#227'o:'
      end
      object Label12: TLabel
        Left = 19
        Top = 208
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nota de Entrada:'
      end
      object Label11: TLabel
        Left = 19
        Top = 97
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tabela de Pre'#231'o:'
      end
      object mskLinGru: TMaskEditFocus
        Tag = 99
        Left = 101
        Top = 4
        Width = 48
        Height = 22
        CharCase = ecUpperCase
        EditMask = '999.999;0;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 7
        TabOrder = 0
        Text = ''
        OnKeyPress = mskLinGruKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesIte: TEditFocus
        Tag = 99
        Left = 101
        Top = 26
        Width = 439
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        OnKeyPress = edtDesIteKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtRefere: TEditFocus
        Tag = 99
        Left = 101
        Top = 48
        Width = 351
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodUni: TEditFocus
        Tag = 99
        Left = 504
        Top = 48
        Width = 36
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 2
        TabOrder = 3
        OnKeyPress = edtCodUniKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodMar: TEditFocus
        Tag = 99
        Left = 101
        Top = 70
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 4
        OnKeyPress = edtCodMarKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtCodFor: TEditFocus
        Tag = 99
        Left = 101
        Top = 116
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 5
        OnKeyPress = edtCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtDesGru: TEditFocus
        Left = 151
        Top = 4
        Width = 389
        Height = 22
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
      object edtDesMar: TEditFocus
        Left = 170
        Top = 70
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtNomFor: TEditFocus
        Left = 170
        Top = 116
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodAbr: TEditFocus
        Tag = 99
        Left = 101
        Top = 138
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 9
        OnKeyPress = edtCodAbrKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesAbr: TEditFocus
        Left = 170
        Top = 138
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 10
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtClaIPI: TEditFocus
        Tag = 99
        Left = 101
        Top = 182
        Width = 188
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 10
        TabOrder = 11
        OnKeyPress = edtClaIPIKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtStatus: TEditFocus
        Tag = 99
        Left = 330
        Top = 182
        Width = 39
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 12
        Text = 'T'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
      object cmbCampos: TComboBoxFocus
        Tag = 99
        Left = 101
        Top = 160
        Width = 294
        Height = 22
        Style = csOwnerDrawFixed
        Sorted = True
        TabOrder = 13
        OnChange = cmbCamposChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object cmbOperad: TComboBoxFocus
        Tag = 99
        Left = 396
        Top = 160
        Width = 60
        Height = 22
        Style = csDropDownList
        TabOrder = 14
        Items.Strings = (
          '>'
          '>='
          '<'
          '<='
          '='
          '<>')
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
      end
      object edtValDig: TEditFocus
        Tag = 99
        Left = 457
        Top = 160
        Width = 83
        Height = 22
        Alignment = taRightJustify
        TabOrder = 15
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#,##0.00'
      end
      object grpDadosNE: TGroupBox
        Left = 101
        Top = 205
        Width = 676
        Height = 64
        TabOrder = 16
        object lblDocumento: TLabel
          Left = 6
          Top = 23
          Width = 54
          Height = 14
          Caption = 'Documento'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblEspecie: TLabel
          Left = 84
          Top = 23
          Width = 38
          Height = 14
          Caption = 'Esp'#233'cie'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblSerie: TLabel
          Left = 126
          Top = 23
          Width = 25
          Height = 14
          Caption = 'S'#233'rie'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblEmpresa: TLabel
          Left = 158
          Top = 24
          Width = 42
          Height = 14
          Caption = 'Empresa'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblForNot: TLabel
          Left = 358
          Top = 24
          Width = 56
          Height = 14
          Caption = 'Fornecedor'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtDocumento: TEditFocus
          Tag = 99
          Left = 6
          Top = 37
          Width = 80
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 12
          ParentFont = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 12
          TipoTexto = ttNumerico
        end
        object edtEspecie: TEditFocus
          Left = 87
          Top = 37
          Width = 35
          Height = 21
          Alignment = taLeftJustify
          AutoSize = False
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 2
          Text = 'NF'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfabetico
        end
        object edtSerie: TEditFocus
          Left = 126
          Top = 37
          Width = 29
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodEmpresa: TEditFocus
          Tag = 99
          Left = 158
          Top = 37
          Width = 29
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
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
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesEmpresa: TEditFocus
          Left = 189
          Top = 37
          Width = 166
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object chkNotEnt: TCheckBox
          Tag = 99
          Left = 5
          Top = 8
          Width = 289
          Height = 17
          Caption = 'Informar nota de entrada para selecionar os produtos?'
          TabOrder = 0
          OnClick = chkNotEntClick
        end
        object edtForNot: TEditFocus
          Tag = 99
          Left = 357
          Top = 37
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnExit = edtForNotExit
          OnKeyPress = edtForNotKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDesForNot: TEditFocus
          Left = 416
          Top = 37
          Width = 254
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object edtTabPre: TEditFocus
        Tag = 99
        Left = 101
        Top = 93
        Width = 69
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 17
        OnKeyPress = edtTabPreKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
      object edtNomTab: TEditFocus
        Left = 170
        Top = 93
        Width = 370
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 18
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object pnlTipoAlteracao: TPanel
        Left = 540
        Top = 0
        Width = 242
        Height = 182
        BevelOuter = bvNone
        Caption = 'pnlTipoAlteracao'
        ShowCaption = False
        TabOrder = 19
        object rdgTipAltFor: TRadioGroup
          Left = 4
          Top = 5
          Width = 215
          Height = 72
          Caption = 'Tipo de Altera'#231#227'o'
          ItemIndex = 1
          Items.Strings = (
            'Alterar Pre'#231'o de Venda mantendo a margem'
            'Alterar Margem de Lucro mantendo o pre'#231'o de venda')
          TabOrder = 0
          WordWrap = True
        end
        object grbGirGer: TGroupBox
          Left = 4
          Top = 83
          Width = 215
          Height = 47
          Caption = 'N'#237'vel de Giro de Estoque Geral'
          TabOrder = 1
          object chkGerA: TCheckBox
            Left = 30
            Top = 21
            Width = 33
            Height = 17
            Caption = 'A'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object chkGerB: TCheckBox
            Left = 74
            Top = 21
            Width = 33
            Height = 17
            Caption = 'B'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object chkGerC: TCheckBox
            Left = 117
            Top = 21
            Width = 33
            Height = 17
            Caption = 'C'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
        end
        object grbGirFor: TGroupBox
          Left = 4
          Top = 136
          Width = 215
          Height = 46
          Caption = 'N'#237'vel de Giro de Estoque por Fornecedor'
          TabOrder = 2
          object chkForA: TCheckBox
            Left = 30
            Top = 21
            Width = 33
            Height = 17
            Caption = 'A'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object chkForB: TCheckBox
            Left = 74
            Top = 21
            Width = 33
            Height = 17
            Caption = 'B'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object chkForC: TCheckBox
            Left = 117
            Top = 21
            Width = 33
            Height = 17
            Caption = 'C'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
        end
      end
    end
    object grpOpc: TGroupBox
      Left = 2
      Top = 322
      Width = 782
      Height = 53
      Align = alClient
      Caption = 'Compos que ser'#227'o alterados?'
      TabOrder = 2
      object Label13: TLabel
        Left = 272
        Top = 14
        Width = 227
        Height = 14
        Caption = 'Selecione a Tabela De Pre'#231'o que Ser'#225' Alterada'
      end
      object rdgCamposVariaveisPorTabelaPreco: TRadioButton
        Left = 13
        Top = 32
        Width = 210
        Height = 17
        Caption = 'Vari'#225'veis por Tabela de Pre'#231'o'
        TabOrder = 0
        OnClick = rdgCamposVariaveisPorTabelaPrecoClick
      end
      object rdbIguais: TRadioButton
        Left = 13
        Top = 17
        Width = 210
        Height = 17
        Caption = 'Iguais Para Todas Tabela de Pre'#231'o'
        TabOrder = 1
        OnClick = rdbIguaisClick
      end
      object cmbTabPre: TComboBox
        Left = 505
        Top = 11
        Width = 35
        Height = 22
        Style = csDropDownList
        TabOrder = 2
      end
    end
  end
  object dbgTiposAlt: TDBGridCitel [5]
    Left = 0
    Top = 377
    Width = 786
    Height = 181
    Align = alClient
    DataSource = dtsAltGlo
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgTiposAltDrawColumnCell
    OnDblClick = dbgTiposAltDblClick
    OnKeyDown = dbgTiposAltKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_DESCAM'
        Title.Alignment = taCenter
        Title.Caption = 'Descri'#231#227'o do Tipo de Altera'#231#227'o'
        Width = 600
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_VALCAM'
        Title.Alignment = taCenter
        Title.Caption = 'Valor'
        Width = 150
        Visible = True
      end>
  end
  object pnlDadosAlt: TPanel [6]
    Left = 0
    Top = 558
    Width = 786
    Height = 48
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
    object lblCamAlt: TLabel
      Left = 8
      Top = 6
      Width = 221
      Height = 14
      Caption = 'A Descri'#231#227'o campo sendo alterado vai aqui....'
    end
    object edtCamAlt: TEditFocus
      Tag = 99
      Left = 8
      Top = 20
      Width = 190
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnKeyPress = edtCamAltKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnConfirmaAlt: TBitBtnLocked
      Left = 214
      Top = 20
      Width = 93
      Height = 22
      Caption = '&Confirma'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnConfirmaAltClick
    end
    object btnCancelaAlt: TBitBtnLocked
      Left = 312
      Top = 20
      Width = 93
      Height = 22
      Caption = 'C&ancelar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
        015603015603FF00FF0000820000820000820000820000820000820000820000
        820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
        27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
        30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
        FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
        0082000082000082000082000082000082000082000082000082FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
        00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
        0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
        50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
        5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
        8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 2
      OnClick = btnCancelaAltClick
    end
  end
  object pnlBotoesEnt: TPanel [7]
    Left = 0
    Top = 606
    Width = 786
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 7
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 111
      Height = 24
      Align = alLeft
      Caption = '[ F10 ] Confirma'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnSairAlt: TBitBtnLocked
      Left = 673
      Top = 2
      Width = 111
      Height = 24
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairAltClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 456
    Top = 480
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 400
  end
  object cdsAltGlo: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 352
    object cdsAltGloITE_DESCAM: TStringField
      FieldName = 'ITE_DESCAM'
      Size = 40
    end
    object cdsAltGloITE_VALCAM: TStringField
      FieldName = 'ITE_VALCAM'
      Size = 100
    end
    object cdsAltGloITE_MASCAM: TStringField
      FieldName = 'ITE_MASCAM'
      Size = 15
    end
    object cdsAltGloITE_NOMCAM: TStringField
      FieldName = 'ITE_NOMCAM'
      Size = 10
    end
    object cdsAltGloITE_DESABR: TStringField
      FieldName = 'ITE_DESABR'
      Size = 15
    end
    object cdsAltGloITE_LIMCAM: TIntegerField
      FieldName = 'ITE_LIMCAM'
    end
    object cdsAltGloITE_TIPCAM: TStringField
      FieldName = 'ITE_TIPCAM'
      Size = 15
    end
    object cdsAltGloITE_ALTERA: TStringField
      FieldName = 'ITE_ALTERA'
      Size = 1
    end
    object cdsAltGloPOR_TABELA: TStringField
      FieldName = 'POR_TABELA'
      Size = 1
    end
  end
  object dtsAltGlo: TDataSource
    DataSet = cdsAltGlo
    Left = 200
    Top = 384
  end
  object dspIteGlo: TUniDataSetProvider
    Options = []
    Left = 136
    Top = 352
  end
  object cdsIteGlo: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ITE_DESITE'
    Params = <>
    ProviderName = 'dspIteGlo'
    Left = 168
    Top = 416
  end
end
