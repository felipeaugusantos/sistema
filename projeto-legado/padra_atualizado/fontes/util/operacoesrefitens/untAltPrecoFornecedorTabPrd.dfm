inherited frmAltPrecoFornecedorTabPrd: TfrmAltPrecoFornecedorTabPrd
  Left = 214
  Top = 165
  Width = 1024
  Height = 946
  BorderStyle = bsSizeable
  Caption = 'Altera'#231#227'o Global de Pre'#231'os de itens do Fornecedor'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitTop = -227
  ExplicitWidth = 1024
  ExplicitHeight = 946
  PixelsPerInch = 96
  TextHeight = 14
  object pgbProgresso: TProgressBar [0]
    Left = 0
    Top = 880
    Width = 1008
    Height = 11
    Align = alBottom
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  inherited pnlBotoes: TPanel
    Top = 804
    Width = 1008
    ExplicitTop = 804
    ExplicitWidth = 1008
    DesignSize = (
      1008
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 891
    Width = 1008
    ExplicitTop = 891
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 861
      Width = 147
      ExplicitLeft = 861
      ExplicitWidth = 147
    end
    inherited pnlInfo: TPanel
      Width = 861
      ExplicitWidth = 861
      object lblContadorLocal: TLabel
        Left = 2
        Top = 2
        Width = 3
        Height = 14
        Align = alClient
      end
    end
  end
  inherited pgcDados: TPageControl
    Left = 360
    Top = 329
    Width = 648
    Height = 475
    Visible = False
    ExplicitLeft = 360
    ExplicitTop = 329
    ExplicitWidth = 648
    ExplicitHeight = 475
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 640
      ExplicitHeight = 443
    end
  end
  object pnlCabecalho: TPanel [4]
    Left = 0
    Top = 0
    Width = 1008
    Height = 329
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object pnlEmpresas: TPanel
      Left = 2
      Top = 276
      Width = 1004
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
      Width = 1004
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
        Width = 267
        Height = 182
        BevelOuter = bvNone
        Caption = 'pnlTipoAlteracao'
        ShowCaption = False
        TabOrder = 19
        object grbGirGer: TGroupBox
          Left = 4
          Top = 83
          Width = 245
          Height = 47
          Caption = 'N'#237'vel de Giro de Estoque Geral'
          TabOrder = 0
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
          Width = 245
          Height = 46
          Caption = 'N'#237'vel de Giro de Estoque por Fornecedor'
          TabOrder = 1
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
        object rdgTipAltFor: TRadioGroup
          Left = 4
          Top = 6
          Width = 245
          Height = 72
          Caption = 'Tipo de Altera'#231#227'o'
          ItemIndex = 0
          Items.Strings = (
            'Pre'#231'o de Custo, Alterando Pre'#231'o de Venda'
            'Pre'#231'o de Custo, Alterando Margem de Lucro'
            'Pre'#231'o de Venda, Alterando Margem de Lucro')
          TabOrder = 2
          OnClick = rdgTipAltForClick
        end
      end
      object rdgAtiCom: TRadioGroup
        Left = 791
        Top = 6
        Width = 110
        Height = 72
        Caption = 'Ativo Para Compra'
        ItemIndex = 2
        Items.Strings = (
          'Sim'
          'N'#227'o'
          'Todos')
        TabOrder = 20
        WordWrap = True
      end
      object rdgCusAtivo: TRadioGroup
        Left = 791
        Top = 84
        Width = 110
        Height = 72
        Caption = 'Custo Ativo'
        ItemIndex = 2
        Items.Strings = (
          'Sim'
          'N'#227'o'
          'Todos')
        TabOrder = 21
        WordWrap = True
      end
    end
  end
  object pnlDadosAlt: TPanel [5]
    Left = 0
    Top = 804
    Width = 1008
    Height = 48
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
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
  object pnlBotoesEnt: TPanel [6]
    Left = 0
    Top = 852
    Width = 1008
    Height = 28
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 6
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
      Left = 895
      Top = 2
      Width = 111
      Height = 24
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairAltClick
    end
  end
  object cxvAlteracao: TcxVerticalGrid [7]
    Left = 0
    Top = 329
    Width = 360
    Height = 475
    Align = alLeft
    OptionsView.RowHeaderWidth = 217
    TabOrder = 7
    Visible = False
    OnKeyPress = cxvAlteracaoKeyPress
    Version = 1
    object cxvAlteracaoCategoryRow1: TcxCategoryRow
      Properties.Caption = 'Outras Informa'#231#245'es'
      ID = 0
      ParentID = -1
      Index = 0
      Version = 1
    end
    object cxvAlteracaoABFCOF: TcxEditorRow
      Options.CanAutoHeight = False
      Options.CanMovedToCustomizationForm = False
      Options.CanResized = False
      Options.Moving = False
      Options.ShowExpandButton = False
      Options.ShowInCustomizationForm = False
      Properties.Caption = 'Abrevia'#231#227'o COFINS   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.MaxLength = 3
      Properties.EditProperties.OnValidate = cxvAlteracaoABFCOFEditPropertiesValidate
      Properties.DataBinding.ValueType = 'String'
      Properties.Options.Filtering = False
      Properties.Options.IncSearch = False
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 1
      ParentID = 0
      Index = 0
      Version = 1
    end
    object cxvAlteracaoABFPIS: TcxEditorRow
      Properties.Caption = 'Abrevia'#231#227'o PIS   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.MaxLength = 3
      Properties.EditProperties.OnValidate = cxvAlteracaoABFPISEditPropertiesValidate
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 2
      ParentID = 0
      Index = 1
      Version = 1
    end
    object cxvAlteracaoPRDGRU: TcxEditorRow
      Properties.Caption = 'Grupo de Produto   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.EditProperties.MaxLength = 5
      Properties.EditProperties.OnValidate = cxvAlteracaoPRDGRUEditPropertiesValidate
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 3
      ParentID = 0
      Index = 2
      Version = 1
    end
    object cxvgPrecoCompra: TcxCategoryRow
      Properties.Caption = 'Pre'#231'o de Compra'
      ID = 4
      ParentID = -1
      Index = 1
      Version = 1
    end
    object cxerPRECOM: TcxEditorRow
      Properties.Caption = 'Pre'#231'o de Compra   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.DisplayFormat = ',0.00'
      Properties.EditProperties.ValidationOptions = []
      Properties.EditProperties.OnValidate = cxerPRECOMEditPropertiesValidate
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 5
      ParentID = 4
      Index = 0
      Version = 1
    end
    object cxerDESF01: TcxEditorRow
      Properties.Caption = 'Desconto 01 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.OnValidate = cxerDESF01EditPropertiesValidate
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 6
      ParentID = 4
      Index = 1
      Version = 1
    end
    object cxerDESF02: TcxEditorRow
      Properties.Caption = 'Desconto 02 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.OnValidate = cxerDESF01EditPropertiesValidate
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 7
      ParentID = 4
      Index = 2
      Version = 1
    end
    object cxerDESF03: TcxEditorRow
      Properties.Caption = 'Desconto 03 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.OnValidate = cxerDESF01EditPropertiesValidate
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 8
      ParentID = 4
      Index = 3
      Version = 1
    end
    object cxerDESF04: TcxEditorRow
      Properties.Caption = 'Desconto 04 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 9
      ParentID = 4
      Index = 4
      Version = 1
    end
    object cxerDESF05: TcxEditorRow
      Properties.Caption = 'Desconto 05 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 10
      ParentID = 4
      Index = 5
      Version = 1
    end
    object cxerDESF06: TcxEditorRow
      Properties.Caption = 'Desconto 06 (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 11
      ParentID = 4
      Index = 6
      Version = 1
    end
    object cxvgPrecoDeCusto: TcxCategoryRow
      Properties.Caption = 'Pre'#231'o de Custo'
      ID = 12
      ParentID = -1
      Index = 2
      Version = 1
    end
    object cxerDESADB: TcxEditorRow
      Properties.Caption = 'Desconto Adicionais(Boleto) (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.OnValidate = cxerDESF01EditPropertiesValidate
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 13
      ParentID = 12
      Index = 0
      Version = 1
    end
    object cxerSUBFED: TcxEditorRow
      Properties.Caption = 'Impostos Federais (-)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 14
      ParentID = 12
      Index = 1
      Version = 1
    end
    object cxerIPIENT: TcxEditorRow
      Properties.Caption = 'IPI Entrada (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 15
      ParentID = 12
      Index = 2
      Version = 1
    end
    object cxerFREENT: TcxEditorRow
      Properties.Caption = 'Frete (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 16
      ParentID = 12
      Index = 3
      Version = 1
    end
    object cxerVALFRE: TcxEditorRow
      Properties.Caption = 'Valor Frete (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 17
      ParentID = 12
      Index = 4
      Version = 1
    end
    object cxerACRFIN: TcxEditorRow
      Properties.Caption = 'Acr'#233'cimo Finaceiro (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 18
      ParentID = 12
      Index = 5
      Version = 1
    end
    object cxvCustoReal: TcxCategoryRow
      Properties.Caption = 'Pre'#231'o de Custo Real'
      ID = 19
      ParentID = -1
      Index = 3
      Version = 1
    end
    object cxerIMPFED: TcxEditorRow
      Properties.Caption = 'Impostos Federais  (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.OnValidate = cxerDESF01EditPropertiesValidate
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle1
      ID = 20
      ParentID = 19
      Index = 0
      Version = 1
    end
    object cxvCustoRealTab1: TcxCategoryRow
      Properties.Caption = 'Tabela de Pre'#231'o 1'
      ID = 21
      ParentID = 19
      Index = 1
      Version = 1
    end
    object cxerDESOPE1: TcxEditorRow
      Properties.Caption = 'Despesas Operacionais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.EditProperties.OnValidate = cxerDESF01EditPropertiesValidate
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle2
      ID = 22
      ParentID = 21
      Index = 0
      Version = 1
    end
    object cxerICMSAI1: TcxEditorRow
      Properties.Caption = 'ICMS Sa'#237'da (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle2
      ID = 23
      ParentID = 21
      Index = 1
      Version = 1
    end
    object cxerOUTVAL1: TcxEditorRow
      Properties.Caption = 'Outros Valores (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle2
      ID = 24
      ParentID = 21
      Index = 2
      Version = 1
    end
    object cxerMARBR1: TcxEditorRow
      Properties.Caption = 'Margem Bruta    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle2
      ID = 25
      ParentID = 21
      Index = 3
      Version = 1
    end
    object cxerPREVE1: TcxEditorRow
      Properties.Caption = 'Pre'#231'o de Venda    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle2
      ID = 26
      ParentID = 21
      Index = 4
      Version = 1
    end
    object cxvCustoRealTab2: TcxCategoryRow
      Properties.Caption = 'Tabela de Pre'#231'o 2'
      ID = 27
      ParentID = 19
      Index = 2
      Version = 1
    end
    object cxerDESOPE2: TcxEditorRow
      Properties.Caption = 'Despesas Operacionais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle3
      ID = 28
      ParentID = 27
      Index = 0
      Version = 1
    end
    object cxerICMSAI2: TcxEditorRow
      Properties.Caption = 'ICMS Sa'#237'da (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle3
      ID = 29
      ParentID = 27
      Index = 1
      Version = 1
    end
    object cxerOUTVAL2: TcxEditorRow
      Properties.Caption = 'Outros Valores (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle3
      ID = 30
      ParentID = 27
      Index = 2
      Version = 1
    end
    object cxerMARBR2: TcxEditorRow
      Properties.Caption = 'Margem Bruta    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle3
      ID = 31
      ParentID = 27
      Index = 3
      Version = 1
    end
    object cxerPREVE2: TcxEditorRow
      Properties.Caption = 'Pre'#231'o de Venda    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle3
      ID = 32
      ParentID = 27
      Index = 4
      Version = 1
    end
    object cxvCustoRealTab3: TcxCategoryRow
      Properties.Caption = 'Tabela de Pre'#231'o 3'
      ID = 33
      ParentID = 19
      Index = 3
      Version = 1
    end
    object cxerDESOPE3: TcxEditorRow
      Properties.Caption = 'Despesas Operacionais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle4
      ID = 34
      ParentID = 33
      Index = 0
      Version = 1
    end
    object cxerICMSAI3: TcxEditorRow
      Properties.Caption = 'ICMS Sa'#237'da (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle4
      ID = 35
      ParentID = 33
      Index = 1
      Version = 1
    end
    object cxerOUTVAL3: TcxEditorRow
      Properties.Caption = 'Outros Valores (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle4
      ID = 36
      ParentID = 33
      Index = 2
      Version = 1
    end
    object cxerMARBR3: TcxEditorRow
      Properties.Caption = 'Margem Bruta    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle4
      ID = 37
      ParentID = 33
      Index = 3
      Version = 1
    end
    object cxerPREVE3: TcxEditorRow
      Properties.Caption = 'Pre'#231'o de Venda    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle4
      ID = 38
      ParentID = 33
      Index = 4
      Version = 1
    end
    object cxvCustoRealTab4: TcxCategoryRow
      Properties.Caption = 'Tabela de Pre'#231'o 4'
      ID = 39
      ParentID = 19
      Index = 4
      Version = 1
    end
    object cxerDESOPE4: TcxEditorRow
      Properties.Caption = 'Despesas Operacionais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle5
      ID = 40
      ParentID = 39
      Index = 0
      Version = 1
    end
    object cxerICMSAI4: TcxEditorRow
      Properties.Caption = 'ICMS Sa'#237'da (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle5
      ID = 41
      ParentID = 39
      Index = 1
      Version = 1
    end
    object cxerOUTVAL4: TcxEditorRow
      Properties.Caption = 'Outros Valores (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle5
      ID = 42
      ParentID = 39
      Index = 2
      Version = 1
    end
    object cxerMARBR4: TcxEditorRow
      Properties.Caption = 'Margem Bruta    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle5
      ID = 43
      ParentID = 39
      Index = 3
      Version = 1
    end
    object cxerPREVE4: TcxEditorRow
      Properties.Caption = 'Pre'#231'o de Venda    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle5
      ID = 44
      ParentID = 39
      Index = 4
      Version = 1
    end
    object cxvCustoRealTab5: TcxCategoryRow
      Properties.Caption = 'Tabela de Pre'#231'o 5'
      ID = 45
      ParentID = 19
      Index = 5
      Version = 1
    end
    object cxerDESOPE5: TcxEditorRow
      Properties.Caption = 'Despesas Operacionais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle8
      ID = 46
      ParentID = 45
      Index = 0
      Version = 1
    end
    object cxerICMSAI5: TcxEditorRow
      Properties.Caption = 'ICMS Sa'#237'da (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle8
      ID = 47
      ParentID = 45
      Index = 1
      Version = 1
    end
    object cxerOUTVAL5: TcxEditorRow
      Properties.Caption = 'Outros Valores (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle8
      ID = 48
      ParentID = 45
      Index = 2
      Version = 1
    end
    object cxerMARBR5: TcxEditorRow
      Properties.Caption = 'Margem Bruta    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle8
      ID = 49
      ParentID = 45
      Index = 3
      Version = 1
    end
    object cxerPREVE5: TcxEditorRow
      Properties.Caption = 'Pre'#231'o de Venda    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle8
      ID = 50
      ParentID = 45
      Index = 4
      Version = 1
    end
    object cxvCustoRealTab6: TcxCategoryRow
      Properties.Caption = 'Tabela de Pre'#231'o 6'
      ID = 51
      ParentID = 19
      Index = 6
      Version = 1
    end
    object cxerDESOPE6: TcxEditorRow
      Properties.Caption = 'Despesas Operacionais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle7
      ID = 52
      ParentID = 51
      Index = 0
      Version = 1
    end
    object cxerICMSAI6: TcxEditorRow
      Properties.Caption = 'ICMS Sa'#237'da (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle7
      ID = 53
      ParentID = 51
      Index = 1
      Version = 1
    end
    object cxerOUTVAL6: TcxEditorRow
      Properties.Caption = 'Outros Valores (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle7
      ID = 54
      ParentID = 51
      Index = 2
      Version = 1
    end
    object cxerMARBR6: TcxEditorRow
      Properties.Caption = 'Margem Bruta    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle7
      ID = 55
      ParentID = 51
      Index = 3
      Version = 1
    end
    object cxerPREVE6: TcxEditorRow
      Properties.Caption = 'Pre'#231'o de Venda    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle7
      ID = 56
      ParentID = 51
      Index = 4
      Version = 1
    end
    object cxvCustoRealTab7: TcxCategoryRow
      Properties.Caption = 'Tabela de Pre'#231'o 7'
      ID = 57
      ParentID = 19
      Index = 7
      Version = 1
    end
    object cxerDESOPE7: TcxEditorRow
      Properties.Caption = 'Despesas Operacionais (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle6
      ID = 58
      ParentID = 57
      Index = 0
      Version = 1
    end
    object cxerICMSAI7: TcxEditorRow
      Properties.Caption = 'ICMS Sa'#237'da (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle6
      ID = 59
      ParentID = 57
      Index = 1
      Version = 1
    end
    object cxerOUTVAL7: TcxEditorRow
      Properties.Caption = 'Outros Valores (+)   '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle6
      ID = 60
      ParentID = 57
      Index = 2
      Version = 1
    end
    object cxerMARBR7: TcxEditorRow
      Properties.Caption = 'Margem Bruta    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle6
      ID = 61
      ParentID = 57
      Index = 3
      Version = 1
    end
    object cxerPREVE7: TcxEditorRow
      Properties.Caption = 'Pre'#231'o de Venda    '
      Properties.HeaderAlignmentHorz = taRightJustify
      Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
      Properties.DataBinding.ValueType = 'String'
      Properties.Value = Null
      Styles.Header = cxStyle6
      ID = 62
      ParentID = 57
      Index = 4
      Version = 1
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 456
    Top = 480
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 248
  end
  object cdsAltGlo: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 248
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
      Size = 11
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
    object cdsAltGloITE_TABELA: TStringField
      FieldName = 'ITE_TABELA'
      Size = 1
    end
  end
  object dtsAltGlo: TDataSource
    DataSet = cdsAltGlo
    Left = 336
    Top = 216
  end
  object dspIteGlo: TUniDataSetProvider
    Options = []
    Left = 232
    Top = 264
  end
  object cdsIteGlo: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ITE_DESITE'
    Params = <>
    ProviderName = 'dspIteGlo'
    Left = 312
    Top = 272
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = 16443110
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor]
      Color = 13499135
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 12180223
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor]
      Color = 16777200
    end
    object cxStyle6: TcxStyle
      AssignedValues = [svColor]
      Color = 15128749
    end
    object cxStyle7: TcxStyle
      AssignedValues = [svColor]
      Color = 15134970
    end
    object cxStyle8: TcxStyle
      AssignedValues = [svColor]
      Color = 11920639
    end
  end
end
