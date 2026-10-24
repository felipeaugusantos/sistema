inherited frmCadImobilizado: TfrmCadImobilizado
  Left = 260
  Top = 306
  Width = 792
  Height = 520
  Caption = 'Imobilizado/Patrim'#244'nio'
  OnDestroy = FormDestroy
  ExplicitWidth = 792
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 447
    Width = 786
    TabOrder = 1
    ExplicitTop = 447
    ExplicitWidth = 786
    inherited FlwBotoes: TFlowPanel
      Width = 705
      ExplicitTop = 2
      ExplicitWidth = 705
      inherited btnIncluir: TBitBtnLocked
        Height = 24
        ExplicitHeight = 24
      end
      inherited btnGravar: TBitBtnLocked
        Height = 24
        ExplicitHeight = 24
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 24
        ExplicitHeight = 24
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 24
        ExplicitHeight = 24
      end
      inherited btnCancela: TBitBtnLocked
        Height = 24
        ExplicitHeight = 24
      end
      inherited btnPesquisa: TBitBtnLocked
        Width = 77
        Height = 24
        ExplicitWidth = 77
        ExplicitHeight = 24
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 707
      Height = 24
      Align = alRight
      ExplicitLeft = 707
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 475
    Width = 786
    TabOrder = 2
    ExplicitTop = 475
    ExplicitWidth = 786
    inherited pnlNomeForm: TPanel
      Left = 439
      ExplicitLeft = 439
    end
    inherited pnlInfo: TPanel
      Width = 439
      ExplicitWidth = 439
    end
  end
  inherited pgcDados: TPageControl
    Width = 786
    Height = 447
    TabOrder = 3
    ExplicitWidth = 786
    ExplicitHeight = 447
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 778
      ExplicitHeight = 415
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 786
    Height = 447
    Align = alClient
    Caption = #39
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 784
      Height = 21
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label22: TLabel
        Left = 0
        Top = 0
        Width = 189
        Height = 21
        Align = alLeft
        Alignment = taRightJustify
        Caption = 'Tipo de Amortiza'#231#227'o Configurada: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 14
      end
      object lblConfiguracao: TLabel
        Left = 189
        Top = 0
        Width = 595
        Height = 21
        Align = alClient
        Caption = 'DEPIMO'
        ExplicitWidth = 37
        ExplicitHeight = 14
      end
    end
    object pctImobilizado: TPageControl
      Left = 1
      Top = 22
      Width = 784
      Height = 424
      ActivePage = tstBem
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 1
      StyleElements = []
      object tstBem: TTabSheet
        Caption = '01 - Cadastro do Bem'
        object Label1: TLabel
          Left = 94
          Top = 10
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object Label2: TLabel
          Left = 78
          Top = 34
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o:'
        end
        object lblEmpresa: TLabel
          Left = 85
          Top = 57
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label28: TLabel
          Left = 52
          Top = 80
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fun'#231#227'o do Bem:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label30: TLabel
          Left = 69
          Top = 116
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'd. Barras:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 0
          Top = 141
          Width = 130
          Height = 14
          Caption = 'Tipo Imobilizado/Patrim'#244'nio:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object dbeCodImo: TDBEditFocus
          Tag = 99
          Left = 131
          Top = 6
          Width = 68
          Height = 22
          CharCase = ecUpperCase
          DataField = 'IMO_CODIMO'
          DataSource = dtsCadImo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeDescri: TDBEditFocus
          Tag = 99
          Left = 131
          Top = 29
          Width = 493
          Height = 22
          CharCase = ecUpperCase
          DataField = 'IMO_DESCRI'
          DataSource = dtsCadImo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodEmp: TDBEditFocus
          Tag = 99
          Left = 131
          Top = 53
          Width = 42
          Height = 22
          CharCase = ecUpperCase
          DataField = 'IMO_CODEMP'
          DataSource = dtsCadImo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          OnKeyPress = dbeCodEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesEmpresa: TEditFocus
          Left = 174
          Top = 53
          Width = 302
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
        object dbcVendid: TDBCheckBox
          Tag = 99
          Left = 482
          Top = 58
          Width = 63
          Height = 14
          Alignment = taLeftJustify
          Caption = 'Vendido:'
          DataField = 'IMO_VENDID'
          DataSource = dtsCadImo
          ReadOnly = True
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dbeCODBAR: TDBEditFocus
          Tag = 99
          Left = 131
          Top = 114
          Width = 345
          Height = 22
          CharCase = ecUpperCase
          DataField = 'IMO_CODBAR'
          DataSource = dtsCadImo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 6
          OnKeyPress = dbeCodEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTIPIMO: TDBEditFocus
          Tag = 99
          Left = 131
          Top = 138
          Width = 68
          Height = 22
          DataField = 'IMO_TIPIMO'
          DataSource = dtsCadImo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          OnEnter = dbeTIPIMOEnter
          OnExit = dbeTIPIMOExit
          OnKeyPress = dbeTIPIMOKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesTipImo: TEditFocus
          Left = 202
          Top = 138
          Width = 422
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object gpInfoSped: TGroupBox
          Tag = 99
          Left = 0
          Top = 163
          Width = 498
          Height = 65
          Caption = 'Informa'#231#245'es SPED: '
          TabOrder = 9
          TabStop = True
          OnEnter = gpInfoSpedEnter
          object Label10: TLabel
            Left = 23
            Top = 41
            Width = 105
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fun'#231#227'o Centro Custo:'
          end
          object Label11: TLabel
            Left = 62
            Top = 18
            Width = 66
            Height = 14
            Alignment = taRightJustify
            Caption = 'Centro Custo:'
          end
          object dbeFunCta: TDBEditFocus
            Tag = 99
            Left = 131
            Top = 38
            Width = 225
            Height = 22
            CharCase = ecUpperCase
            DataField = 'IMO_FUNCTA'
            DataSource = dtsCadImo
            Enabled = False
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
          object lcbCentroCusto: TDBLookupComboBox
            Left = 131
            Top = 14
            Width = 225
            Height = 22
            DataField = 'IMO_CODSPE'
            DataSource = dtsCadImo
            KeyField = 'SPE_CODIGO'
            ListField = 'SPE_DESCRI'
            ListSource = dsIndicadorCentroCusto
            TabOrder = 0
          end
        end
        object dbeFUNCAO: TDBMemoFocus
          Tag = 99
          Left = 131
          Top = 77
          Width = 493
          Height = 35
          DataField = 'IMO_FUNCAO'
          DataSource = dtsCadImo
          ScrollBars = ssVertical
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object grbPlaConSped: TGroupBox
          Left = -1
          Top = 229
          Width = 500
          Height = 124
          Caption = 'Plano de Contas SPED:'
          TabOrder = 10
          object Label4: TLabel
            Left = 33
            Top = 24
            Width = 131
            Height = 14
            Alignment = taRightJustify
            Caption = 'Indicador do Tipo de Conta:'
          end
          object Label24: TLabel
            Left = 92
            Top = 48
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Conta Cont'#225'bil:'
          end
          object Label25: TLabel
            Left = 138
            Top = 71
            Width = 26
            Height = 14
            Alignment = taRightJustify
            Caption = 'N'#237'vel:'
          end
          object Label26: TLabel
            Left = 30
            Top = 94
            Width = 134
            Height = 14
            Alignment = taRightJustify
            Caption = 'Natureza da Conta Cont'#225'bil:'
          end
          object cbbIndicadorTipoConta: TComboBoxFocus
            Tag = 99
            Left = 170
            Top = 22
            Width = 225
            Height = 22
            Style = csDropDownList
            Enabled = False
            ItemIndex = 0
            TabOrder = 0
            Text = 'Anal'#237'tico - Conta'
            Items.Strings = (
              'Anal'#237'tico - Conta'
              'Sint'#233'tico - Grupo de Contas')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object dbeConCon: TDBEditFocus
            Tag = 99
            Left = 170
            Top = 45
            Width = 225
            Height = 22
            CharCase = ecUpperCase
            DataField = 'IMO_CONCON'
            DataSource = dtsCadImo
            Enabled = False
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
          object dbeNivel: TDBEditFocus
            Tag = 99
            Left = 170
            Top = 68
            Width = 225
            Height = 22
            CharCase = ecUpperCase
            DataField = 'IMO_NIVEL'
            DataSource = dtsCadImo
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object cbbNaturezaContaContabil: TComboBoxFocus
            Left = 170
            Top = 91
            Width = 225
            Height = 22
            Style = csDropDownList
            Enabled = False
            ItemIndex = 5
            TabOrder = 3
            Text = '09 - Outras'
            Items.Strings = (
              '01 - Contas de Ativo'
              '02 - Contas de Passivo'
              '03 - Patrim'#244'nio L'#237'quido'
              '04 - Contas de Resultado'
              '05 - Contas de Compensa'#231#227'o'
              '09 - Outras')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
      end
      object tstAquisicao: TTabSheet
        Caption = '02 - Dados de Aquisi'#231#227'o/Venda'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object gbDadosAquisicao: TGroupBox
          Left = 1
          Top = 6
          Width = 498
          Height = 175
          Caption = 'Dados de Aquisi'#231#227'o: '
          TabOrder = 0
          object Label43: TLabel
            Left = 166
            Top = 91
            Width = 72
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Aquisi'#231#227'o'
          end
          object Label3: TLabel
            Left = 271
            Top = 91
            Width = 90
            Height = 14
            Caption = 'Valor da Aquisi'#231#227'o'
          end
          object Label8: TLabel
            Left = 8
            Top = 131
            Width = 52
            Height = 14
            Caption = 'Valor ICMS'
          end
          object Label9: TLabel
            Left = 113
            Top = 131
            Width = 51
            Height = 14
            Caption = 'Qtd. Parc.:'
          end
          object lblDocumento: TLabel
            Left = 8
            Top = 15
            Width = 54
            Height = 14
            Caption = 'Documento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblEspecie: TLabel
            Left = 109
            Top = 15
            Width = 38
            Height = 14
            Caption = 'Esp'#233'cie'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblSerie: TLabel
            Left = 149
            Top = 15
            Width = 25
            Height = 14
            Caption = 'S'#233'rie'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblForNot: TLabel
            Left = 181
            Top = 15
            Width = 56
            Height = 14
            Caption = 'Fornecedor'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 8
            Top = 52
            Width = 37
            Height = 14
            Caption = 'Produto'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label16: TLabel
            Left = 424
            Top = 52
            Width = 55
            Height = 14
            Alignment = taRightJustify
            Caption = 'Quantidade'
          end
          object Label14: TLabel
            Left = 377
            Top = 92
            Width = 50
            Height = 14
            Caption = 'Valor Total'
          end
          object Label49: TLabel
            Left = 8
            Top = 91
            Width = 124
            Height = 14
            Alignment = taRightJustify
            Caption = 'NCM / Classifica'#231#227'o de IPI'
          end
          object Label21: TLabel
            Left = 139
            Top = 91
            Width = 20
            Height = 14
            Alignment = taRightJustify
            Caption = 'CST'
          end
          object Label27: TLabel
            Left = 377
            Top = 131
            Width = 103
            Height = 14
            Caption = 'Vlr Diferencial de Aliq'
          end
          object dbeDtaAqu: TDBEditFocus
            Tag = 99
            Left = 165
            Top = 106
            Width = 103
            Height = 22
            DataField = 'IMO_DTAAQU'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeValAqu: TDBEditFocus
            Tag = 99
            Left = 271
            Top = 106
            Width = 103
            Height = 22
            DataField = 'IMO_VALAQU'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 7
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeValIcm: TDBEditFocus
            Tag = 99
            Left = 8
            Top = 145
            Width = 103
            Height = 22
            DataField = 'IMO_VALICM'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 12
            TabOrder = 9
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeQtdParcel: TDBEditFocus
            Tag = 99
            Left = 113
            Top = 145
            Width = 68
            Height = 22
            DataField = 'IMO_QTDPAR'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 4
            TabOrder = 10
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object edtDesForNot: TEditFocus
            Left = 239
            Top = 29
            Width = 253
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 12
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesIte: TEditFocus
            Left = 67
            Top = 67
            Width = 354
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object dbeQtdImo: TDBEditFocus
            Tag = 99
            Left = 424
            Top = 67
            Width = 68
            Height = 22
            DataField = 'IMO_QTDIMO'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDocAqu: TDBEditFocus
            Tag = 99
            Left = 8
            Top = 29
            Width = 99
            Height = 22
            DataField = 'IMO_DOCAQU'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnKeyPress = dbeDocVenKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object dbeForAqu: TDBEditFocus
            Tag = 99
            Left = 180
            Top = 29
            Width = 58
            Height = 22
            DataField = 'IMO_FORAQU'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            OnExit = dbeForAquExit
            OnKeyPress = dbeForAquKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object dbeSerAqu: TDBEditFocus
            Tag = 99
            Left = 149
            Top = 29
            Width = 30
            Height = 22
            DataField = 'IMO_SERAQU'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeEspAqu: TDBEditFocus
            Tag = 99
            Left = 109
            Top = 29
            Width = 38
            Height = 22
            CharCase = ecUpperCase
            DataField = 'IMO_ESPAQU'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object dbeCodIte: TDBEditFocus
            Tag = 99
            Left = 8
            Top = 67
            Width = 58
            Height = 22
            DataField = 'IMO_CODITE'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 4
            OnKeyPress = dbeCodIteKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object dbeVlrTot: TDBEditFocus
            Tag = 99
            Left = 377
            Top = 106
            Width = 114
            Height = 22
            DataField = 'IMO_TOTAQU'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object edtNCM: TEditFocus
            Left = 8
            Top = 106
            Width = 126
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtCST: TEditFocus
            Left = 139
            Top = 106
            Width = 21
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ReadOnly = True
            TabOrder = 15
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object chkConsiderarFrete: TDBCheckBox
            Tag = 99
            Left = 193
            Top = 147
            Width = 178
            Height = 17
            Caption = 'Considerar Frete no Valor Total'
            DataField = 'IMO_CONFRE'
            DataSource = dtsCadImo
            Enabled = False
            TabOrder = 11
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkConsiderarFreteClick
          end
          object dbeDifAli: TDBEditFocus
            Tag = 99
            Left = 377
            Top = 145
            Width = 114
            Height = 22
            DataField = 'IMO_DIFALI'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 16
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object gpDadosVenda: TGroupBox
          Left = 1
          Top = 183
          Width = 498
          Height = 97
          Caption = 'Dados de Venda: '
          TabOrder = 1
          object Label12: TLabel
            Left = 10
            Top = 54
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data Venda:'
          end
          object Label13: TLabel
            Left = 112
            Top = 54
            Width = 77
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor de Venda:'
          end
          object Label15: TLabel
            Left = 211
            Top = 54
            Width = 55
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor ICMS:'
          end
          object Label17: TLabel
            Left = 10
            Top = 15
            Width = 54
            Height = 14
            Caption = 'Documento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label18: TLabel
            Left = 112
            Top = 15
            Width = 38
            Height = 14
            Caption = 'Esp'#233'cie'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label19: TLabel
            Left = 152
            Top = 15
            Width = 25
            Height = 14
            Caption = 'S'#233'rie'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label20: TLabel
            Left = 184
            Top = 16
            Width = 32
            Height = 14
            Caption = 'Cliente'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object dbeDtaVen: TDBEditFocus
            Tag = 99
            Left = 10
            Top = 68
            Width = 100
            Height = 22
            DataField = 'IMO_DTAVEN'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeValVen: TDBEditFocus
            Tag = 99
            Left = 112
            Top = 68
            Width = 96
            Height = 22
            DataField = 'IMO_VALVEN'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeValIcmVen: TDBEditFocus
            Tag = 99
            Left = 211
            Top = 68
            Width = 87
            Height = 22
            DataField = 'IMO_ICMVEN'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 12
            ReadOnly = True
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object edtDesCli: TEditFocus
            Left = 243
            Top = 29
            Width = 249
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object dbeDocVen: TDBEditFocus
            Tag = 99
            Left = 10
            Top = 29
            Width = 100
            Height = 22
            DataField = 'IMO_DOCVEN'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            OnKeyPress = dbeDocVenKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object dbeEspVen: TDBEditFocus
            Tag = 99
            Left = 112
            Top = 29
            Width = 38
            Height = 22
            CharCase = ecUpperCase
            DataField = 'IMO_ESPVEN'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object dbeSerVen: TDBEditFocus
            Tag = 99
            Left = 152
            Top = 29
            Width = 30
            Height = 22
            DataField = 'IMO_SERVEN'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeCliVen: TDBEditFocus
            Tag = 99
            Left = 183
            Top = 29
            Width = 58
            Height = 22
            DataField = 'IMO_CLIVEN'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 3
            OnExit = dbeCliVenExit
            OnKeyPress = dbeCliVenKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
        end
      end
      object tbsPatrimonio_locfis: TTabSheet
        Caption = '3 - N'#186' Patrim'#244'nio / Loc. F'#237'sica'
        ImageIndex = 3
        OnShow = tbsPatrimonio_locfisShow
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 776
          Height = 37
          Align = alTop
          ParentColor = True
          TabOrder = 0
          object Panel4: TPanel
            Left = 1
            Top = 18
            Width = 774
            Height = 17
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lblQtdAqu: TLabel
              Left = 123
              Top = 0
              Width = 3
              Height = 14
              Align = alClient
            end
            object Label5: TLabel
              Left = 0
              Top = 0
              Width = 123
              Height = 14
              Align = alLeft
              Caption = 'Quantidade de Aquisi'#231#227'o:'
            end
          end
          object Panel3: TPanel
            Left = 1
            Top = 1
            Width = 774
            Height = 17
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object lblDescIte: TLabel
              Left = 40
              Top = 0
              Width = 3
              Height = 14
              Align = alClient
            end
            object Label23: TLabel
              Left = 0
              Top = 0
              Width = 40
              Height = 14
              Align = alLeft
              Caption = 'Produto:'
            end
          end
        end
        object Panel5: TPanel
          Left = 0
          Top = 37
          Width = 776
          Height = 74
          Align = alTop
          TabOrder = 1
          object lbl1: TLabel
            Left = 63
            Top = 30
            Width = 55
            Height = 14
            Alignment = taRightJustify
            Caption = 'Loc. F'#237'sica:'
          end
          object Label29: TLabel
            Left = 51
            Top = 4
            Width = 67
            Height = 14
            Alignment = taRightJustify
            Caption = 'N'#186' Patrim'#244'nio:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object btnAdicionarPat: TBitBtnLocked
            Left = 287
            Top = 48
            Width = 89
            Height = 24
            Caption = '[ F10 ] Adicionar'
            TabOrder = 2
            OnClick = btnAdicionarPatClick
          end
          object btnExcluirPat: TBitBtnLocked
            Left = 376
            Top = 48
            Width = 89
            Height = 24
            Caption = '[ F11 ] Excluir'
            TabOrder = 3
            OnClick = btnExcluirPatClick
          end
          object edtNumPat: TEditFocus
            Tag = 99
            Left = 120
            Top = 2
            Width = 344
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 30
            TipoTexto = ttAlfanumerico
          end
          object edtLocFis: TEditFocus
            Tag = 99
            Left = 120
            Top = 26
            Width = 344
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 20
            TipoTexto = ttAlfanumerico
          end
        end
        object Panel6: TPanel
          Left = 0
          Top = 111
          Width = 776
          Height = 281
          Align = alClient
          TabOrder = 2
          object cxgPatLoc: TcxGrid
            Left = 1
            Top = 1
            Width = 774
            Height = 279
            Align = alClient
            TabOrder = 0
            object cxvPatLoc: TcxGridDBTableView
              OnKeyDown = cxvPatLocKeyDown
              Navigator.Buttons.CustomButtons = <>
              OnCellDblClick = cxvPatLocCellDblClick
              DataController.DataModeController.GridMode = True
              DataController.DataSource = dtsPatLoc
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
              OptionsView.GroupByBox = False
              object cxvPatLocColumn1: TcxGridDBColumn
                Caption = 'Sequencial'
                DataBinding.FieldName = 'PAT_SEQUEN'
              end
              object cxvPatLocColumn2: TcxGridDBColumn
                Caption = 'N'#250'mero do Patrim'#244'nio'
                DataBinding.FieldName = 'PAT_NUMPAT'
                Width = 201
              end
              object cxvPatLocColumn3: TcxGridDBColumn
                Caption = 'Loc. F'#237'sica'
                DataBinding.FieldName = 'PAT_LOCFIS'
                Width = 216
              end
            end
            object cxlPatLoc: TcxGridLevel
              GridView = cxvPatLoc
            end
          end
        end
      end
      object tstDepreciacao: TTabSheet
        Caption = '04 - Deprecia'#231#227'o/Amortiza'#231#227'o'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object grpDepreciacao: TGroupBox
          Left = 1
          Top = 6
          Width = 498
          Height = 94
          TabOrder = 0
          TabStop = True
          OnEnter = grpDepreciacaoEnter
          object lblVidUti: TLabel
            Left = 8
            Top = 16
            Width = 76
            Height = 14
            Alignment = taRightJustify
            Caption = 'Vida '#218'til (Anos)'
          end
          object lblDepAn: TLabel
            Left = 89
            Top = 16
            Width = 91
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deprecia'#231#227'o Anual'
          end
          object lblPerSimbDepAn: TLabel
            Left = 170
            Top = 33
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblPerRes: TLabel
            Left = 190
            Top = 16
            Width = 67
            Height = 14
            Alignment = taRightJustify
            Caption = 'Taxa Residual'
          end
          object lblSimbperResidual: TLabel
            Left = 244
            Top = 33
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblVlrRes: TLabel
            Left = 273
            Top = 16
            Width = 69
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Residual'
          end
          object lblVlrRepAn: TLabel
            Left = 10
            Top = 53
            Width = 94
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deprecia'#231#227'o Anual:'
          end
          object lblVlrRepMes: TLabel
            Left = 132
            Top = 53
            Width = 101
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deprecia'#231#227'o Mensal:'
          end
          object lblVlrRepAtu: TLabel
            Left = 256
            Top = 53
            Width = 91
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deprecia'#231#227'o Atual:'
          end
          object lblVlrRepRest: TLabel
            Left = 380
            Top = 53
            Width = 110
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deprecia'#231#227'o Restante:'
          end
          object dbeVIDUTI: TDBEditFocus
            Tag = 99
            Left = 8
            Top = 29
            Width = 60
            Height = 22
            DataField = 'IMO_VIDUTI'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDepAnu: TDBEditFocus
            Tag = 99
            Left = 89
            Top = 29
            Width = 77
            Height = 22
            DataField = 'IMO_DEPANU'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbePerRes: TDBEditFocus
            Tag = 99
            Left = 190
            Top = 29
            Width = 54
            Height = 22
            DataField = 'IMO_PERRES'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeVLRRES: TDBEditFocus
            Tag = 99
            Left = 273
            Top = 29
            Width = 70
            Height = 22
            DataField = 'IMO_VLRRES'
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtDepAnual: TEditFocus
            Left = 8
            Top = 67
            Width = 101
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtDepMensal: TEditFocus
            Left = 132
            Top = 67
            Width = 100
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
          object edtDepAtual: TEditFocus
            Left = 256
            Top = 67
            Width = 100
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtDepRest: TEditFocus
            Left = 380
            Top = 67
            Width = 110
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        end
        object chkTemDep: TDBCheckBox
          Tag = 99
          Left = 15
          Top = 0
          Width = 170
          Height = 17
          Caption = 'Possui deprecia'#231#227'o fiscal?'
          DataField = 'IMO_TEMDEP'
          DataSource = dtsCadImo
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = chkTemDepClick
        end
        object grpDepreciacaoSoc: TGroupBox
          Left = 1
          Top = 111
          Width = 498
          Height = 94
          TabOrder = 2
          TabStop = True
          Visible = False
          OnEnter = grpDepreciacaoEnter
          object lblVidUtiSoc: TLabel
            Left = 8
            Top = 16
            Width = 76
            Height = 14
            Alignment = taRightJustify
            Caption = 'Vida '#218'til (Anos)'
          end
          object lblDepAnSoc: TLabel
            Left = 89
            Top = 16
            Width = 91
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deprecia'#231#227'o Anual'
          end
          object lblPerSimbDepAnSoc: TLabel
            Left = 170
            Top = 33
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblPerResSoc: TLabel
            Left = 190
            Top = 16
            Width = 67
            Height = 14
            Alignment = taRightJustify
            Caption = 'Taxa Residual'
          end
          object lblSimbperResidualSoc: TLabel
            Left = 244
            Top = 33
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblVlrResSoc: TLabel
            Left = 273
            Top = 16
            Width = 69
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Residual'
          end
          object lblVlrRepAnSoc: TLabel
            Left = 10
            Top = 53
            Width = 94
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deprecia'#231#227'o Anual:'
          end
          object lblVlrRepMesSoc: TLabel
            Left = 132
            Top = 53
            Width = 101
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deprecia'#231#227'o Mensal:'
          end
          object lblVlrRepAtuSoc: TLabel
            Left = 256
            Top = 53
            Width = 91
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deprecia'#231#227'o Atual:'
          end
          object lblVlrRepRestSoc: TLabel
            Left = 380
            Top = 53
            Width = 110
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deprecia'#231#227'o Restante:'
          end
          object dbeVIDUTS: TDBEditFocus
            Left = 8
            Top = 29
            Width = 60
            Height = 22
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDEPANS: TDBEditFocus
            Left = 89
            Top = 29
            Width = 77
            Height = 22
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbePERRSS: TDBEditFocus
            Left = 190
            Top = 29
            Width = 54
            Height = 22
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeVLRRSS: TDBEditFocus
            Left = 273
            Top = 29
            Width = 70
            Height = 22
            DataSource = dtsCadImo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtDepAnualSoc: TEditFocus
            Left = 10
            Top = 67
            Width = 100
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtDepMensalSoc: TEditFocus
            Left = 132
            Top = 67
            Width = 100
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
          object edtDepAtualSoc: TEditFocus
            Left = 256
            Top = 67
            Width = 100
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object edtDepRestSoc: TEditFocus
            Left = 380
            Top = 67
            Width = 110
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
        end
        object chkTEMDPS: TDBCheckBox
          Left = 15
          Top = 104
          Width = 177
          Height = 17
          Caption = 'Possui deprecia'#231#227'o societ'#225'ria?'
          DataSource = dtsCadImo
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          Visible = False
          OnClick = chkTEMDPSClick
        end
      end
      object pctConfiguracoes: TTabSheet
        Caption = '05 - Configura'#231#245'es'
        ImageIndex = 4
        ExplicitLeft = 5
        ExplicitTop = 29
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label31: TLabel
          Left = 24
          Top = 20
          Width = 84
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo de Ajuste:'
        end
        object Label32: TLabel
          Left = 8
          Top = 42
          Width = 100
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o do Ajuste:'
        end
        object dbeCodAju: TDBEditFocus
          Tag = 99
          Left = 109
          Top = 14
          Width = 68
          Height = 22
          CharCase = ecUpperCase
          DataField = 'IMO_CODAJU'
          DataSource = dtsCadImo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object dbeDesAju: TDBEditFocus
          Tag = 99
          Left = 109
          Top = 37
          Width = 493
          Height = 22
          CharCase = ecUpperCase
          DataField = 'IMO_DESAJU'
          DataSource = dtsCadImo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 200
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 59
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 528
    Top = 59
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 466
    Top = 59
  end
  object dtsCadImo: TDataSource
    Left = 496
    Top = 59
  end
  object dsIndicadorCentroCusto: TDataSource
    Left = 592
    Top = 59
  end
  object dtsPatLoc: TDataSource
    Left = 624
    Top = 59
  end
end
