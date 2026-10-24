inherited frmCadProjetos: TfrmCadProjetos
  Width = 917
  Height = 559
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Cadastro de Projetos'
  OnDestroy = FormDestroy
  ExplicitWidth = 917
  ExplicitHeight = 559
  PixelsPerInch = 96
  TextHeight = 14
  object Label17: TLabel [0]
    Left = 6
    Top = 118
    Width = 64
    Height = 14
    Alignment = taRightJustify
    Caption = 'Valor Projeto:'
  end
  inherited pnlBotoes: TPanel
    Top = 487
    Width = 911
    Height = 27
    ExplicitTop = 487
    ExplicitWidth = 911
    ExplicitHeight = 27
    inherited FlwBotoes: TFlowPanel
      Width = 825
      Height = 23
      ExplicitTop = 2
      ExplicitWidth = 825
      ExplicitHeight = 23
      inherited btnIncluir: TBitBtnLocked
        Width = 83
        Height = 22
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnGravar: TBitBtnLocked
        Left = 83
        Width = 83
        Height = 22
        ExplicitLeft = 83
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 166
        Width = 83
        Height = 22
        ExplicitLeft = 166
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 249
        Width = 83
        Height = 22
        ExplicitLeft = 249
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnCancela: TBitBtnLocked
        Left = 332
        Width = 83
        Height = 22
        ExplicitLeft = 332
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 415
        Width = 83
        Height = 22
        ExplicitLeft = 415
        ExplicitWidth = 83
        ExplicitHeight = 22
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 827
      Width = 82
      Height = 23
      Align = alRight
      ExplicitLeft = 827
      ExplicitWidth = 82
      ExplicitHeight = 23
    end
  end
  inherited pnlStatus: TPanel
    Top = 514
    Width = 911
    ExplicitTop = 514
    ExplicitWidth = 911
    inherited pnlNomeForm: TPanel
      Left = 724
      Width = 187
      ExplicitLeft = 724
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 724
      ExplicitWidth = 724
    end
  end
  inherited pgcDados: TPageControl
    Width = 911
    Height = 487
    ActivePage = tbsContasPagar
    ExplicitWidth = 911
    ExplicitHeight = 487
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 903
      ExplicitHeight = 455
      object grbObservacao: TGroupBox
        Left = 0
        Top = 319
        Width = 903
        Height = 136
        Align = alClient
        Caption = '   Observa'#231#245'es'
        TabOrder = 1
        StyleElements = [seFont, seBorder]
        object mmoObserv: TDBMemoFocus
          Tag = 99
          Left = 2
          Top = 16
          Width = 899
          Height = 118
          TabStop = False
          Align = alClient
          DataField = 'PRJ_OBSERV'
          DataSource = dtsTabela
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
      object pnlCampos: TPanel
        Left = 0
        Top = 0
        Width = 903
        Height = 319
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          903
          319)
        object ColorLabel1: TColorLabel
          Left = 123
          Top = 87
          Width = 75
          Height = 14
          Caption = '(A)tivo (I)nativo'
          CorDestaque = clRed
        end
        object Label1: TLabel
          Left = 55
          Top = 17
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object Label12: TLabel
          Left = 39
          Top = 64
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data In'#237'cio:'
        end
        object Label2: TLabel
          Left = 61
          Top = 40
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome:'
        end
        object Label3: TLabel
          Left = 46
          Top = 85
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Situa'#231#227'o:'
        end
        object Label5: TLabel
          Left = 379
          Top = 64
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Previs'#227'o:'
        end
        object Label6: TLabel
          Left = 373
          Top = 87
          Width = 76
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Finalizado:'
        end
        object Label4: TLabel
          Left = 354
          Top = 110
          Width = 95
          Height = 14
          Alignment = taRightJustify
          Caption = 'Indicador Consumo:'
        end
        object lblMecCItPerVal: TLabel
          Left = 517
          Top = 110
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label10: TLabel
          Left = 581
          Top = 106
          Width = 73
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total Consumo:'
          Visible = False
        end
        object Label11: TLabel
          Left = 604
          Top = 3
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Recursos:'
          Visible = False
        end
        object Label13: TLabel
          Left = 608
          Top = 28
          Width = 46
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produtos:'
          Visible = False
        end
        object Label15: TLabel
          Left = 608
          Top = 53
          Width = 46
          Height = 14
          Alignment = taRightJustify
          Caption = 'Servi'#231'os:'
          Visible = False
        end
        object Label7: TLabel
          Left = 590
          Top = 81
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor Projeto:'
          Visible = False
        end
        object lblProjeto: TLabel
          Left = 205
          Top = 17
          Width = 23
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo:'
        end
        object lblOco: TLabel
          Left = 10
          Top = 133
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ocor. Inativa'#231#227'o:'
        end
        object dbeCodPrj: TDBEditFocus
          Tag = 99
          Left = 95
          Top = 13
          Width = 87
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRJ_CODPRJ'
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
        object dbeDesPrj: TDBEditFocus
          Tag = 99
          Left = 95
          Top = 36
          Width = 436
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRJ_DESPRJ'
          DataSource = dtsTabela
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
        object dbeDtaIni: TDBEditFocus
          Tag = 99
          Left = 95
          Top = 59
          Width = 79
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRJ_DTAINI'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaPre: TDBEditFocus
          Tag = 99
          Left = 452
          Top = 59
          Width = 79
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRJ_DTAPRE'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSituac: TDBEditFocus
          Tag = 99
          Left = 95
          Top = 82
          Width = 22
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRJ_SITUAC'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeDtaFin: TDBEditFocus
          Left = 452
          Top = 82
          Width = 79
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16770261
          DataField = 'PRJ_DTAFIN'
          DataSource = dtsTabela
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object GroupBox1: TGroupBox
          Left = 670
          Top = 156
          Width = 225
          Height = 161
          Caption = 'Totais do Projeto'
          TabOrder = 12
          object Label29: TLabel
            Left = 6
            Top = 21
            Width = 64
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Projeto:'
          end
          object Label30: TLabel
            Left = 6
            Top = 43
            Width = 71
            Height = 14
            Alignment = taRightJustify
            Caption = 'Total Faturado:'
          end
          object Label31: TLabel
            Left = 6
            Top = 67
            Width = 83
            Height = 14
            Alignment = taRightJustify
            Caption = 'Total dos Custos:'
          end
          object Label32: TLabel
            Left = 6
            Top = 91
            Width = 85
            Height = 14
            Alignment = taRightJustify
            Caption = 'Total Lucro Bruto:'
          end
          object Label33: TLabel
            Left = 6
            Top = 113
            Width = 97
            Height = 14
            Alignment = taRightJustify
            Caption = 'Total Margem Lucro:'
          end
          object Label34: TLabel
            Left = 6
            Top = 137
            Width = 121
            Height = 14
            Alignment = taRightJustify
            Caption = 'Total Representatividade:'
          end
          object dbeValPrj: TDBEditFocus
            Tag = 99
            Left = 130
            Top = 15
            Width = 80
            Height = 22
            CharCase = ecUpperCase
            Color = 16770261
            DataField = 'PRJ_VALPRJ'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtTotalFaturado: TEditFocus
            Left = 130
            Top = 40
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtTotalCustos: TEditFocus
            Left = 130
            Top = 64
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtTotalLucroBruto: TEditFocus
            Left = 130
            Top = 87
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            TabOrder = 3
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtTotalMargemLucro: TEditFocus
            Left = 130
            Top = 111
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            TabOrder = 4
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtTotalRepresentatividade: TEditFocus
            Left = 130
            Top = 135
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            TabOrder = 5
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
        end
        object dbeIndCon: TDBEditFocus
          Left = 452
          Top = 105
          Width = 59
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16770261
          DataField = 'PRJ_INDCON'
          DataSource = dtsTabela
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object GroupBox2: TGroupBox
          Left = 3
          Top = 156
          Width = 326
          Height = 161
          Caption = 'Produtos'
          TabOrder = 10
          object Label18: TLabel
            Left = 6
            Top = 21
            Width = 128
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Or'#231'ado de Produtos:'
          end
          object Label20: TLabel
            Left = 6
            Top = 43
            Width = 135
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Faturado de Produtos:'
          end
          object Label21: TLabel
            Left = 6
            Top = 67
            Width = 150
            Height = 14
            Alignment = taRightJustify
            Caption = 'Custo dos Produtos Faturados:'
          end
          object Label22: TLabel
            Left = 6
            Top = 113
            Width = 148
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem de Lucro de Produtos:'
          end
          object Label23: TLabel
            Left = 6
            Top = 137
            Width = 231
            Height = 14
            Alignment = taRightJustify
            Caption = 'Representatividade do Or'#231'amento de Produtos: '
          end
          object Label19: TLabel
            Left = 6
            Top = 88
            Width = 121
            Height = 14
            Alignment = taRightJustify
            Caption = 'Lucro Bruto de Produtos:'
          end
          object dbeValOrcProdutos: TDBEditFocus
            Tag = 99
            Left = 234
            Top = 15
            Width = 80
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRJ_ORCPRO'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtValorFatProd: TEditFocus
            Left = 234
            Top = 40
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValorCustoProd: TEditFocus
            Left = 234
            Top = 64
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValorMargemLucroProd: TEditFocus
            Left = 234
            Top = 111
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            TabOrder = 3
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValorRepreseOrcProd: TEditFocus
            Left = 234
            Top = 135
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            TabOrder = 4
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValorLucroBrutoProd: TEditFocus
            Left = 234
            Top = 87
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            TabOrder = 5
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
        end
        object GroupBox3: TGroupBox
          Left = 335
          Top = 156
          Width = 326
          Height = 161
          Caption = ' Servi'#231'os '
          TabOrder = 11
          object Label24: TLabel
            Left = 7
            Top = 21
            Width = 128
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Or'#231'ado de Servi'#231'os:'
          end
          object Label25: TLabel
            Left = 7
            Top = 43
            Width = 135
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor Faturado de Servi'#231'os:'
          end
          object Label26: TLabel
            Left = 7
            Top = 67
            Width = 98
            Height = 14
            Alignment = taRightJustify
            Caption = 'Recursos Alocados:'
          end
          object Label27: TLabel
            Left = 7
            Top = 113
            Width = 148
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem de Lucro de Servi'#231'os:'
          end
          object Label28: TLabel
            Left = 7
            Top = 136
            Width = 231
            Height = 14
            Alignment = taRightJustify
            Caption = 'Representatividade do Or'#231'amento de Servi'#231'os: '
          end
          object Label16: TLabel
            Left = 6
            Top = 88
            Width = 121
            Height = 14
            Alignment = taRightJustify
            Caption = 'Lucro Bruto de Servi'#231'os:'
          end
          object dbeValOrcServicos: TDBEditFocus
            Tag = 99
            Left = 238
            Top = 15
            Width = 80
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PRJ_ORCSER'
            DataSource = dtsTabela
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtValorFatServ: TEditFocus
            Left = 238
            Top = 40
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValorCustoServ: TEditFocus
            Left = 238
            Top = 64
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValorMargemLucroServ: TEditFocus
            Left = 238
            Top = 111
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            TabOrder = 3
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValorRepreseOrcServ: TEditFocus
            Left = 238
            Top = 134
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            TabOrder = 4
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtValorLucroBrutoServ: TEditFocus
            Left = 238
            Top = 87
            Width = 80
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            CharCase = ecUpperCase
            Color = 16770261
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
            TabOrder = 5
            Text = '0,00'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
        end
        object edtTotCon: TEditFocus
          Left = 660
          Top = 103
          Width = 59
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16770261
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
          TabOrder = 13
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object dbeTotRec: TDBEditFocus
          Left = 660
          Top = 0
          Width = 59
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16770261
          DataField = 'PRJ_TOTREC'
          DataSource = dtsTabela
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 14
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTotVen: TDBEditFocus
          Left = 660
          Top = 25
          Width = 59
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16770261
          DataField = 'PRJ_TOTVEN'
          DataSource = dtsTabela
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 15
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTotSer: TDBEditFocus
          Left = 660
          Top = 50
          Width = 59
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          Color = 16770261
          DataField = 'PRJ_TOTSER'
          DataSource = dtsTabela
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 16
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeValPrj_: TDBEditFocus
          Tag = 99
          Left = 660
          Top = 77
          Width = 59
          Height = 22
          CharCase = ecUpperCase
          Color = 16770261
          DataField = 'PRJ_VALPRJ'
          DataSource = dtsTabela
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 17
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtDesTip: TEditFocus
          Left = 295
          Top = 13
          Width = 236
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
        object dbeCodTip: TDBEditFocus
          Tag = 99
          Left = 231
          Top = 13
          Width = 63
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRJ_CODTIP'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnKeyPress = dbeCodTipKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
          OnChamaCadastro = dbeCodTipChamaCadastro
        end
        object dbeCodOco: TDBEditFocus
          Tag = 99
          Left = 95
          Top = 130
          Width = 47
          Height = 22
          CharCase = ecUpperCase
          DataField = 'PRJ_CODOCO'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnKeyPress = dbeCodOcoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
          OnChamaCadastro = dbeCodOcoChamaCadastro
        end
        object edtDesOco: TEditFocus
          Left = 144
          Top = 130
          Width = 387
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Anchors = [akLeft, akTop, akRight]
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
      end
    end
    object tbsClientes: TTabSheet
      Caption = '2 - Clientes'
      ImageIndex = 3
      object pnlCliPrj: TPanel
        Left = 0
        Top = 0
        Width = 903
        Height = 45
        Align = alTop
        Color = 16770261
        Enabled = False
        ParentBackground = False
        TabOrder = 0
        object lblCndPag: TLabel
          Left = 15
          Top = 18
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cliente:'
        end
        object btnIncCli: TBitBtnLocked
          Left = 379
          Top = 15
          Width = 74
          Height = 22
          Caption = 'C&onfirmar'
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
          OnClick = btnIncCliClick
        end
        object btnCancelCli: TBitBtnLocked
          Left = 459
          Top = 15
          Width = 74
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
          OnClick = btnCancelCliClick
        end
        object edtCodCli: TEditFocus
          Tag = 99
          Left = 52
          Top = 15
          Width = 66
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          TabOrder = 0
          OnExit = edtCodCliExit
          OnKeyPress = edtCodCliKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomCli: TEditFocus
          Left = 120
          Top = 15
          Width = 237
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
      end
      object cxgGridCliPrj: TcxGrid
        Left = 0
        Top = 45
        Width = 903
        Height = 410
        Align = alClient
        Enabled = False
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgGridCliPrjView: TcxGridDBTableView
          OnKeyDown = cxgGridCliPrjViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Appending = True
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxgColCodCnd: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CLI_CODCLI'
            Options.Editing = False
            Width = 59
          end
          object cxgColDescri: TcxGridDBColumn
            Caption = 'Cliente'
            DataBinding.FieldName = 'CLI_NOMCLI'
            Options.Editing = False
            Width = 372
          end
        end
        object cxgcxgGridCliPrj: TcxGridLevel
          GridView = cxgGridCliPrjView
        end
      end
    end
    object tbsRecursos: TTabSheet
      Caption = '3 - Recursos Alocados'
      ImageIndex = 1
      object cxGridProRec: TcxGrid
        Left = 0
        Top = 0
        Width = 903
        Height = 424
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridViewProRec: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = 'Tipo'
            DataBinding.FieldName = 'TIPREP'
            Options.Editing = False
            Width = 73
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Nome'
            DataBinding.FieldName = 'NOMREP'
            Options.Editing = False
            Width = 155
          end
          object cxGridViewProRecColumn1: TcxGridDBColumn
            Caption = 'Controle'
            DataBinding.FieldName = 'TIPCAP'
            Width = 53
          end
          object cxGridViewProRecQTDHOR: TcxGridDBColumn
            Caption = 'Horas(s)'
            DataBinding.FieldName = 'QTDHOR'
          end
          object cxGridViewProRecColumn2: TcxGridDBColumn
            Caption = 'Quant.'
            DataBinding.FieldName = 'QUANTI'
            Width = 45
          end
          object cxGridViewProRecColumn3: TcxGridDBColumn
            Caption = 'Val. Custo'
            DataBinding.FieldName = 'VALCUS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Width = 70
          end
          object cxGridViewProRecColumn4: TcxGridDBColumn
            Caption = 'Val. Tot.'
            DataBinding.FieldName = 'VALTOT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Width = 70
          end
          object cxGridViewProRecColumn5: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'DTACAD'
            Width = 90
          end
          object cxGridViewProRecColumn6: TcxGridDBColumn
            Caption = 'Operador'
            DataBinding.FieldName = 'CODOPE'
            Width = 56
          end
        end
        object cxGridLevelProRec: TcxGridLevel
          GridView = cxGridViewProRec
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 424
        Width = 903
        Height = 31
        Align = alBottom
        BevelInner = bvLowered
        TabOrder = 1
        DesignSize = (
          903
          31)
        object Label8: TLabel
          Left = 713
          Top = 11
          Width = 75
          Height = 14
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Total Recursos:'
        end
        object edtTotRec: TEditFocus
          Left = 794
          Top = 5
          Width = 90
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16770261
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
          TabOrder = 0
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
      end
    end
    object tbsProdutosVendidos: TTabSheet
      Caption = '4 - Produtos Vendidos'
      ImageIndex = 2
      object cxGridProVen: TcxGrid
        Left = 0
        Top = 0
        Width = 903
        Height = 424
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridViewProVen: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGridDBColumn3: TcxGridDBColumn
            Caption = 'Num. Doc.'
            DataBinding.FieldName = 'NUMDOC'
            Options.Editing = False
            Width = 80
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = 'Esp.'
            DataBinding.FieldName = 'ESPDOC'
            Options.Editing = False
            Width = 29
          end
          object cxGridDBColumn5: TcxGridDBColumn
            Caption = 'Emp.'
            DataBinding.FieldName = 'CODEMP'
            Width = 39
          end
          object cxGridViewProVenColumn1: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'DTAENT'
          end
          object cxGridViewProVenColumn2: TcxGridDBColumn
            Caption = 'Vend.'
            DataBinding.FieldName = 'CODVEN'
            Width = 48
          end
          object cxGridViewProVenColumn3: TcxGridDBColumn
            Caption = 'Produto'
            DataBinding.FieldName = 'CODITE'
            Width = 169
          end
          object cxGridDBColumn6: TcxGridDBColumn
            Caption = 'Quant.'
            DataBinding.FieldName = 'QTDITE'
            Width = 39
          end
          object cxGridDBColumn7: TcxGridDBColumn
            Caption = 'Vr. Unitar'
            DataBinding.FieldName = 'UNITAR'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Width = 70
          end
          object cxGridDBColumn8: TcxGridDBColumn
            Caption = 'Val. Tot.'
            DataBinding.FieldName = 'TOTITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Width = 69
          end
        end
        object cxGridLevelProVen: TcxGridLevel
          GridView = cxGridViewProVen
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 424
        Width = 903
        Height = 31
        Align = alBottom
        BevelInner = bvLowered
        TabOrder = 1
        DesignSize = (
          903
          31)
        object Label9: TLabel
          Left = 719
          Top = 10
          Width = 71
          Height = 14
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Total Produtos:'
          ExplicitLeft = 451
        end
        object DBEditFocus2: TDBEditFocus
          Left = 796
          Top = 5
          Width = 103
          Height = 22
          Anchors = [akTop, akRight]
          CharCase = ecUpperCase
          Color = 16770261
          DataField = 'PRJ_TOTVEN'
          DataSource = dtsTabela
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object tbsServicosFaturados: TTabSheet
      Caption = '5 - Servi'#231'os Faturados'
      ImageIndex = 4
      object cxGridServ: TcxGrid
        Left = 0
        Top = 0
        Width = 903
        Height = 424
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridViewServ: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGridDBColumn9: TcxGridDBColumn
            Caption = 'Num. Doc.'
            DataBinding.FieldName = 'NUMDOC'
            Options.Editing = False
            Width = 80
          end
          object cxGridDBColumn10: TcxGridDBColumn
            Caption = 'Esp.'
            DataBinding.FieldName = 'ESPDOC'
            Options.Editing = False
            Width = 29
          end
          object cxGridDBColumn11: TcxGridDBColumn
            Caption = 'Emp.'
            DataBinding.FieldName = 'CODEMP'
            Width = 39
          end
          object cxGridDBColumn12: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'DTAENT'
          end
          object cxGridDBColumn13: TcxGridDBColumn
            Caption = 'Vend.'
            DataBinding.FieldName = 'CODVEN'
            Width = 48
          end
          object cxGridDBColumn14: TcxGridDBColumn
            Caption = 'Servi'#231'o'
            DataBinding.FieldName = 'CODITE'
            Width = 169
          end
          object cxGridDBColumn15: TcxGridDBColumn
            Caption = 'Quant.'
            DataBinding.FieldName = 'QTDITE'
            Width = 39
          end
          object cxGridDBColumn16: TcxGridDBColumn
            Caption = 'Vr. Unitar'
            DataBinding.FieldName = 'UNITAR'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Width = 70
          end
          object cxGridDBColumn17: TcxGridDBColumn
            Caption = 'Val. Tot.'
            DataBinding.FieldName = 'TOTITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Width = 69
          end
        end
        object cxGridLevelServ: TcxGridLevel
          GridView = cxGridViewServ
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 424
        Width = 903
        Height = 31
        Align = alBottom
        BevelInner = bvLowered
        TabOrder = 1
        DesignSize = (
          903
          31)
        object Label14: TLabel
          Left = 718
          Top = 10
          Width = 71
          Height = 14
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Total Servi'#231'os:'
          ExplicitLeft = 450
        end
        object DBEditFocus3: TDBEditFocus
          Left = 795
          Top = 6
          Width = 103
          Height = 22
          Anchors = [akTop, akRight]
          CharCase = ecUpperCase
          Color = 16770261
          DataField = 'PRJ_TOTSER'
          DataSource = dtsTabela
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object tbsContasPagar: TTabSheet
      Caption = '6 - Contas a Pagar'
      ImageIndex = 5
      object Panel4: TPanel
        Left = 0
        Top = 424
        Width = 903
        Height = 31
        Align = alBottom
        BevelInner = bvLowered
        TabOrder = 0
        DesignSize = (
          903
          31)
        object Label35: TLabel
          Left = 761
          Top = 10
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Total Pago:'
        end
        object Label36: TLabel
          Left = 604
          Top = 9
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Total Original:'
        end
        object edtTotPago: TEditFocus
          Left = 813
          Top = 6
          Width = 79
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16770261
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
          TabOrder = 0
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtTotOri: TEditFocus
          Left = 672
          Top = 6
          Width = 79
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16770261
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
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
      end
      object cxGridCADPAG: TcxGrid
        Left = 0
        Top = 0
        Width = 903
        Height = 424
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridDBCADPAGVIEW: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGridDBCADPAGVIEWCTP_CODFOR: TcxGridDBColumn
            Caption = 'Fornecedor'
            DataBinding.FieldName = 'CODFOR'
            Width = 287
          end
          object cxGridDBCADPAGVIEWCTP_CODCTA: TcxGridDBColumn
            Caption = 'Plano de Conta'
            DataBinding.FieldName = 'CODCTA'
            OnGetDisplayText = cxGridDBCADPAGVIEWCTP_CODCTAGetDisplayText
            Width = 243
          end
          object cxGridDBCADPAGVIEWCTP_DTACAD: TcxGridDBColumn
            Caption = 'Data de Cad.'
            DataBinding.FieldName = 'CTP_DTACAD'
            Width = 69
          end
          object cxGridDBCADPAGVIEWCTP_DTAPAG: TcxGridDBColumn
            Caption = 'Data de Pagto'
            DataBinding.FieldName = 'CTP_DTAPAG'
            Width = 74
          end
          object cxGridDBCADPAGVIEWCTP_VALORI: TcxGridDBColumn
            Caption = 'Valor Original'
            DataBinding.FieldName = 'CTP_VALORI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Options.AutoWidthSizable = False
            Width = 119
          end
          object cxGridDBCADPAGVIEWCTP_VALPAG: TcxGridDBColumn
            Caption = 'Valor Pago'
            DataBinding.FieldName = 'CTP_VALPAG'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.Nullable = False
            Properties.Nullstring = 'R$ 0,00'
            Options.AutoWidthSizable = False
            Width = 109
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBCADPAGVIEW
        end
      end
    end
    object tbcCreditos: TTabSheet
      Caption = '7 - Cr'#233'ditos'
      ImageIndex = 7
      object pnlTotalCreditos: TPanel
        Left = 0
        Top = 424
        Width = 903
        Height = 31
        Align = alBottom
        BevelInner = bvLowered
        TabOrder = 0
        DesignSize = (
          903
          31)
        object Label37: TLabel
          Left = 740
          Top = 10
          Width = 73
          Height = 14
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Total Recebido:'
        end
        object Label38: TLabel
          Left = 548
          Top = 9
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          Caption = 'Total Original:'
        end
        object edtValRecCreditos: TEditFocus
          Left = 813
          Top = 6
          Width = 79
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16770261
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
          TabOrder = 0
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtValOriCreditos: TEditFocus
          Left = 616
          Top = 6
          Width = 79
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16770261
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
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
      end
      object cxGridCreditos: TcxGrid
        Left = 0
        Top = 0
        Width = 903
        Height = 424
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        ExplicitTop = 8
        object cxGridDBTableViewCreditos: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '  '
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGridDBTableViewCreditosCliente: TcxGridDBColumn
            Caption = 'Cliente'
            DataBinding.FieldName = 'CODCLI'
            Width = 287
          end
          object cxGridDBTableViewCreditosPlanoCta: TcxGridDBColumn
            Caption = 'Plano de Conta'
            DataBinding.FieldName = 'CODCTA'
            OnGetDisplayText = cxGridDBTableViewCreditosPlanoCtaGetDisplayText
            Width = 243
          end
          object cxGridDBTableViewCreditosDataCad: TcxGridDBColumn
            Caption = 'Data de Cad.'
            DataBinding.FieldName = 'CTR_DTACAD'
            Width = 69
          end
          object cxGridDBTableViewCreditosDataRec: TcxGridDBColumn
            Caption = 'Data de Rec.'
            DataBinding.FieldName = 'CTR_DTAREC'
            Width = 74
          end
          object cxGridDBTableViewCreditosValOri: TcxGridDBColumn
            Caption = 'Valor Original'
            DataBinding.FieldName = 'CTR_VALORI'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Options.AutoWidthSizable = False
            Width = 119
          end
          object cxGridDBTableViewCreditosValRec: TcxGridDBColumn
            Caption = 'Valor Recebido'
            DataBinding.FieldName = 'CTR_VALREC'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.Nullable = False
            Properties.Nullstring = 'R$ 0,00'
            Options.AutoWidthSizable = False
            Width = 109
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridDBTableViewCreditos
        end
      end
    end
    object tbDocProjetos: TTabSheet
      Caption = 'Documentos do Projeto'
      ImageIndex = 6
      TabVisible = False
      object pnlArquivoPasta: TPanel
        Left = 0
        Top = 0
        Width = 903
        Height = 414
        Align = alClient
        Caption = 
          'AQUI SERA EXIBIDO O FORM DE CADASTRO DE ENDERECOS DE ARQUIVOS, N' +
          'AO COLOCAR NADA NESTE PANEL....'
        ParentColor = True
        TabOrder = 0
      end
      object pnlButton: TPanel
        Left = 0
        Top = 414
        Width = 903
        Height = 41
        Align = alBottom
        ShowCaption = False
        TabOrder = 1
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 548
    Top = 372
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 516
    Top = 372
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 484
    Top = 372
  end
  object dtsTabela: TDataSource
    Left = 556
    Top = 80
  end
end
