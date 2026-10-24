inherited frmCadCashback: TfrmCadCashback
  Left = 578
  Top = 392
  Width = 900
  Height = 678
  Caption = 'Cadastro de Regras para Cashback'
  ExplicitWidth = 900
  ExplicitHeight = 678
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 608
    Width = 894
    Height = 25
    ExplicitTop = 608
    ExplicitWidth = 894
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 890
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 890
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 74
        ExplicitWidth = 74
      end
      inherited btnGravar: TBitBtnLocked
        Left = 74
        Width = 74
        ExplicitLeft = 74
        ExplicitWidth = 74
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 148
        Width = 74
        ExplicitLeft = 148
        ExplicitWidth = 74
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 222
        Width = 74
        ExplicitLeft = 222
        ExplicitWidth = 74
      end
      inherited btnCancela: TBitBtnLocked
        Left = 296
        Width = 74
        ExplicitLeft = 296
        ExplicitWidth = 74
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 370
        Width = 74
        ExplicitLeft = 370
        ExplicitWidth = 74
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 809
      Width = 74
      Height = 20
      ExplicitLeft = 809
      ExplicitWidth = 74
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 633
    Width = 894
    ExplicitTop = 633
    ExplicitWidth = 894
    inherited pnlNomeForm: TPanel
      Left = 715
      Width = 179
      ExplicitLeft = 715
      ExplicitWidth = 179
    end
    inherited pnlInfo: TPanel
      Width = 715
      ExplicitWidth = 715
    end
  end
  inherited pgcDados: TPageControl
    Width = 894
    Height = 608
    ExplicitWidth = 894
    ExplicitHeight = 608
    inherited tbsGeral: TTabSheet
      Caption = 'Geral'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 886
      ExplicitHeight = 576
      object pnlCentral: TPanel
        Left = 0
        Top = 0
        Width = 886
        Height = 576
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 47
          Top = 42
          Width = 52
          Height = 14
          Caption = 'Descri'#231#227'o:'
        end
        object Label1: TLabel
          Left = 63
          Top = 18
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object lbl1: TLabel
          Left = 27
          Top = 88
          Width = 73
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Cliente:'
        end
        object lbl2: TColorLabel
          Left = 143
          Top = 87
          Width = 308
          Height = 14
          Caption = '(F) Pessoa F'#237'sica   (J) Pessoa Jur'#237'dica   (A) Ambos   (M) Manual'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label3: TLabel
          Left = 53
          Top = 65
          Width = 46
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Vig'#234'ncia:'
        end
        object Label4: TLabel
          Left = 175
          Top = 65
          Width = 6
          Height = 14
          Alignment = taRightJustify
          Caption = #224
        end
        object Label10: TLabel
          Left = 12
          Top = 111
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cond. Pagamento:'
        end
        object ColorLabel3: TColorLabel
          Left = 143
          Top = 111
          Width = 86
          Height = 14
          Caption = '(T)odos   (D)efinir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label14: TLabel
          Left = 267
          Top = 111
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Canal de Acesso:'
        end
        object ColorLabel5: TColorLabel
          Left = 395
          Top = 111
          Width = 86
          Height = 14
          Caption = '(T)odos   (D)efinir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object Label17: TLabel
          Left = 507
          Top = 111
          Width = 101
          Height = 14
          Alignment = taRightJustify
          Caption = 'Departamento Vend.:'
        end
        object ColorLabel6: TColorLabel
          Left = 651
          Top = 111
          Width = 86
          Height = 14
          Caption = '(T)odos   (D)efinir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object dbeDescri: TDBEditFocus
          Tag = 99
          Left = 101
          Top = 35
          Width = 424
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CSH_DESCRI'
          DataSource = dtsCadCsh
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
          Left = 101
          Top = 11
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CSH_CODIGO'
          DataSource = dtsCadCsh
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeTipPes: TDBEditFocus
          Tag = 99
          Left = 101
          Top = 83
          Width = 37
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CSH_TIPPES'
          DataSource = dtsCadCsh
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeIniVig: TDBEditFocus
          Tag = 99
          Left = 101
          Top = 59
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CSH_INIVIG'
          DataSource = dtsCadCsh
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbeFinVig: TDBEditFocus
          Tag = 99
          Left = 186
          Top = 59
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CSH_FINVIG'
          DataSource = dtsCadCsh
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object gpbGeracao: TGroupBox
          Left = 19
          Top = 131
          Width = 845
          Height = 216
          Caption = 'Gera'#231#227'o:'
          TabOrder = 9
          object Label37: TLabel
            Left = 458
            Top = 50
            Width = 270
            Height = 14
            Alignment = taRightJustify
            Caption = 'Gerar cashback em uma compra que utilizou cashback?'
          end
          object ColorLabel2: TColorLabel
            Left = 779
            Top = 50
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
          object Label11: TLabel
            Left = 519
            Top = 78
            Width = 209
            Height = 14
            Alignment = taRightJustify
            Caption = 'Gerar cashback sobre itens em Promo'#231#227'o?'
          end
          object ColorLabel4: TColorLabel
            Left = 779
            Top = 78
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
          object Label13: TLabel
            Left = 517
            Top = 24
            Width = 211
            Height = 14
            Alignment = taRightJustify
            Caption = 'Gerar cashback em compras a partir de R$:'
          end
          object dbeChsBch: TDBEditFocus
            Tag = 99
            Left = 734
            Top = 43
            Width = 39
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CSH_CHSBCH'
            DataSource = dtsCadCsh
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeItePro: TDBEditFocus
            Tag = 99
            Left = 734
            Top = 71
            Width = 39
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CSH_ITEPRO'
            DataSource = dtsCadCsh
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            ParentFont = False
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeGerCsh: TDBEditFocus
            Tag = 99
            Left = 734
            Top = 17
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CSH_GERCSH'
            DataSource = dtsCadCsh
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object grbTipoGeracao: TGroupBox
            Left = 10
            Top = 17
            Width = 430
            Height = 193
            Caption = 'Tipo'
            TabOrder = 0
            object rdbValFix: TRadioButton
              Left = 5
              Top = 17
              Width = 350
              Height = 24
              Caption = 
                'Valor fixo de                            sobre o valor da compra' +
                '.'
              TabOrder = 0
              OnClick = rdbValFixClick
            end
            object dbeValFix: TDBEditFocus
              Tag = 99
              Left = 90
              Top = 17
              Width = 73
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CSH_VALFIX'
              DataSource = dtsCadCsh
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object rdbPerDes: TRadioButton
              Left = 5
              Top = 45
              Width = 350
              Height = 24
              Caption = 'Percentual de                      % sobre o valor da compra.'
              TabOrder = 2
              OnClick = rdbValFixClick
            end
            object dbePerDes: TDBEditFocus
              Tag = 99
              Left = 92
              Top = 45
              Width = 57
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CSH_PERDES'
              DataSource = dtsCadCsh
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object rdbValCom: TRadioButton
              Left = 5
              Top = 73
              Width = 350
              Height = 24
              Caption = 
                'A cada                            em compras, acumulo de        ' +
                '                    .'
              TabOrder = 4
              OnClick = rdbValFixClick
            end
            object dbeValCom: TDBEditFocus
              Tag = 99
              Left = 61
              Top = 73
              Width = 73
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CSH_VALCOM'
              DataSource = dtsCadCsh
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 5
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeValAcu: TDBEditFocus
              Tag = 99
              Left = 265
              Top = 73
              Width = 73
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CSH_VALACU'
              DataSource = dtsCadCsh
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 6
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object rdbPerIte: TRadioButton
              Left = 5
              Top = 102
              Width = 350
              Height = 24
              Caption = 
                'Percentual de                      % sobre o valor dos itens inf' +
                'ormados.'
              TabOrder = 7
              OnClick = rdbValFixClick
            end
            object dbePerIte: TDBEditFocus
              Tag = 99
              Left = 92
              Top = 102
              Width = 57
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CSH_PERITE'
              DataSource = dtsCadCsh
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object rdbValIte: TRadioButton
              Left = 5
              Top = 131
              Width = 350
              Height = 24
              Caption = 
                'Valor fixo de                            sobre os itens informad' +
                'os.'
              TabOrder = 9
              OnClick = rdbValFixClick
            end
            object dbeValIte: TDBEditFocus
              Tag = 99
              Left = 88
              Top = 131
              Width = 73
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CSH_VALITE'
              DataSource = dtsCadCsh
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object rdbValDve: TRadioButton
              Left = 5
              Top = 160
              Width = 350
              Height = 24
              Caption = 'Devolu'#231#227'o de Embalagem - A cada unidade devolvida, ac'#250'mulo de'
              TabOrder = 11
              OnClick = rdbValFixClick
            end
            object dbeValDve: TDBEditFocus
              Tag = 99
              Left = 347
              Top = 160
              Width = 73
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CSH_VALDVE'
              DataSource = dtsCadCsh
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 12
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
          end
        end
        object gpbUtilizacaoCashback: TGroupBox
          Left = 19
          Top = 349
          Width = 845
          Height = 122
          Caption = 'Utiliza'#231#227'o:'
          TabOrder = 10
          object Label5: TLabel
            Left = 18
            Top = 26
            Width = 252
            Height = 14
            Alignment = taRightJustify
            Caption = 'Permitir utilizar cashback em compras a partir de R$:'
          end
          object Label6: TLabel
            Left = 18
            Top = 50
            Width = 334
            Height = 14
            Caption = 
              'Aplicar cashback no m'#225'ximo                             % do valo' +
              'r da compra.'
          end
          object Label9: TLabel
            Left = 18
            Top = 76
            Width = 181
            Height = 14
            Caption = 'Definir itens para utilizar o cashback?'
          end
          object ColorLabel1: TColorLabel
            Left = 246
            Top = 76
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
          object Label12: TLabel
            Left = 18
            Top = 101
            Width = 268
            Height = 14
            Caption = 'Permitir utilizar cashback ap'#243's quantos dias da compra:'
          end
          object dbeMinVen: TDBEditFocus
            Tag = 99
            Left = 275
            Top = 19
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CSH_MINVEN'
            DataSource = dtsCadCsh
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbePerMax: TDBEditFocus
            Tag = 99
            Left = 162
            Top = 43
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CSH_PERMAX'
            DataSource = dtsCadCsh
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeUtiIte: TDBEditFocus
            Tag = 99
            Left = 204
            Top = 69
            Width = 37
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CSH_UTIITE'
            DataSource = dtsCadCsh
            TabOrder = 2
            OnChange = dbeUtiIteChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeDiaUti: TDBEditFocus
            Tag = 99
            Left = 290
            Top = 95
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CSH_DIAUTI'
            DataSource = dtsCadCsh
            MaxLength = 5
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object grbValidade: TGroupBox
          Left = 19
          Top = 472
          Width = 845
          Height = 80
          Caption = 'Validade'
          TabOrder = 11
          object Label7: TLabel
            Left = 421
            Top = 23
            Width = 176
            Height = 14
            Alignment = taCenter
            Caption = '(Valor Zero Cashback nunca expira)'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label8: TLabel
            Left = 355
            Top = 55
            Width = 6
            Height = 14
            Alignment = taRightJustify
            Caption = #224
          end
          object rdbDiaExp: TRadioButton
            Left = 16
            Top = 18
            Width = 322
            Height = 27
            Caption = 'Quantidade de dias para expirar o Cashback a partir da venda:'
            TabOrder = 0
            OnClick = rdbDiaExpClick
          end
          object dbeDiaExp: TDBEditFocus
            Tag = 99
            Left = 340
            Top = 18
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CSH_DIAEXP'
            DataSource = dtsCadCsh
            MaxLength = 5
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object rdbDtaVal: TRadioButton
            Left = 16
            Top = 49
            Width = 265
            Height = 27
            Caption = 'Permitir utilizar o Cashback somente no per'#237'odo de:'
            TabOrder = 2
            OnClick = rdbDiaExpClick
          end
          object dbeIniVal: TDBEditFocus
            Tag = 99
            Left = 281
            Top = 49
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CSH_INIVAL'
            DataSource = dtsCadCsh
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeFinVal: TDBEditFocus
            Tag = 99
            Left = 366
            Top = 49
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CSH_FINVAL'
            DataSource = dtsCadCsh
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object chkCliCon: TCheckBox
          Left = 528
          Top = 84
          Width = 249
          Height = 17
          Caption = 'N'#227'o gerar cashback para cliente consumidor'
          TabOrder = 5
        end
        object dbeConPag: TDBEditFocus
          Tag = 99
          Left = 101
          Top = 107
          Width = 37
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CSH_CONPAG'
          DataSource = dtsCadCsh
          TabOrder = 6
          OnChange = dbeConPagChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeCnlAce: TDBEditFocus
          Tag = 99
          Left = 352
          Top = 107
          Width = 37
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CSH_CNLACE'
          DataSource = dtsCadCsh
          TabOrder = 7
          OnChange = dbeCnlAceChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
        object dbeDepart: TDBEditFocus
          Tag = 99
          Left = 608
          Top = 107
          Width = 37
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CSH_DEPART'
          DataSource = dtsCadCsh
          TabOrder = 8
          OnChange = dbeDepartChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfabetico
        end
      end
    end
    object tbsItensCashback: TTabSheet
      Caption = 'Itens do Cashback'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlFiltroItens: TPanel
        Left = 0
        Top = 0
        Width = 886
        Height = 268
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblItemItens: TLabel
          Left = -2
          Top = 14
          Width = 85
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Produto:'
        end
        object lblGrupoLinhaItens: TLabel
          Left = 18
          Top = 38
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblMarcaItens: TLabel
          Left = 54
          Top = 61
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblFornecedorItens: TLabel
          Left = 28
          Top = 84
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDepartamentoItens: TLabel
          Left = 17
          Top = 107
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Departamento:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDescriIniItens: TLabel
          Left = 6
          Top = 130
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o Inicial:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDescriFinItens: TLabel
          Left = 10
          Top = 152
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o Final:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblRefereItens: TLabel
          Left = 31
          Top = 176
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Refer'#234'ncia:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblImpLisItens: TLabel
          Left = 22
          Top = 199
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Imprime Lista:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object cllImpLisItens: TColorLabel
          Left = 130
          Top = 200
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblUnidadeItens: TLabel
          Left = 44
          Top = 222
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object cllProAtiItens: TColorLabel
          Left = 130
          Top = 246
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblProAtiItens: TLabel
          Left = 20
          Top = 245
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto Ativo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCodIteItens: TEditFocus
          Tag = 99
          Left = 89
          Top = 11
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnExit = edtCodIteItensExit
          OnKeyPress = edtCodIteItensKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesIteItens: TEditFocus
          Left = 160
          Top = 11
          Width = 373
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
        object mskLinhaGrupoItens: TMaskEditFocus
          Tag = 99
          Left = 89
          Top = 34
          Width = 70
          Height = 22
          EditMask = '999.999;0;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          ParentFont = False
          TabOrder = 2
          Text = ''
          OnExit = mskLinhaGrupoItensExit
          OnKeyPress = mskLinhaGrupoItensKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGrupoItens: TEditFocus
          Left = 160
          Top = 34
          Width = 373
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtMarcaItens: TEditFocus
          Tag = 99
          Left = 89
          Top = 57
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          ParentFont = False
          TabOrder = 4
          OnExit = edtMarcaItensExit
          OnKeyPress = edtMarcaItensKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesMarcaItens: TEditFocus
          Left = 160
          Top = 57
          Width = 373
          Height = 22
          TabStop = False
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
        object edtFornecedorItens: TEditFocus
          Tag = 99
          Left = 89
          Top = 80
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 6
          OnExit = edtFornecedorItensExit
          OnKeyPress = edtFornecedorItensKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDesFornecedorItens: TEditFocus
          Left = 160
          Top = 80
          Width = 373
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDepartamentoItens: TEditFocus
          Tag = 99
          Left = 89
          Top = 103
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 8
          OnExit = edtDepartamentoItensExit
          OnKeyPress = edtDepartamentoItensKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesDepartamentoItens: TEditFocus
          Left = 160
          Top = 103
          Width = 373
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDescriIniItens: TEditFocus
          Tag = 99
          Left = 89
          Top = 126
          Width = 444
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
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
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDescriFinItens: TEditFocus
          Tag = 99
          Left = 89
          Top = 149
          Width = 444
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRefereItens: TEditFocus
          Tag = 99
          Left = 89
          Top = 172
          Width = 444
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtImpLisItens: TEditFocus
          Tag = 99
          Left = 89
          Top = 195
          Width = 37
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 13
          OnExit = edtImpLisItensExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfanumerico
        end
        object edtUnidadeItens: TEditFocus
          Tag = 99
          Left = 89
          Top = 218
          Width = 37
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 14
          OnExit = edtUnidadeItensExit
          OnKeyPress = edtUnidadeItensKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        object edtProAtiItens: TEditFocus
          Tag = 99
          Left = 89
          Top = 241
          Width = 37
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 15
          OnExit = edtProAtiItensExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfanumerico
        end
        object btnConfirmarItens: TBitBtnLocked
          Left = 456
          Top = 243
          Width = 77
          Height = 22
          Caption = 'C&onfirma'
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
          TabOrder = 16
          OnClick = btnConfirmarItensClick
        end
        object edtDesUnidadeItens: TEditFocus
          Left = 127
          Top = 218
          Width = 406
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 17
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object grdItens: TcxGrid
        Left = 0
        Top = 268
        Width = 886
        Height = 308
        Align = alClient
        TabOrder = 1
        object grdItensDBTableView: TcxGridDBTableView
          OnKeyDown = grdItensDBTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsItens
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object grdItensDBTableViewCODITE: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODITE'
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 48
          end
          object grdItensDBTableViewDESITE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESITE'
            Options.Editing = False
            Width = 302
          end
          object grdItensDBTableViewUNIDAD: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'UNIDAD'
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 46
          end
          object grdItensDBTableViewMARCA_: TcxGridDBColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'MARCA_'
            Options.Editing = False
          end
          object grdItensDBTableViewREFERE: TcxGridDBColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'REFERE'
            Options.Editing = False
            Width = 152
          end
          object grdItensDBTableViewNOMFOR: TcxGridDBColumn
            Caption = 'Fornecedor'
            DataBinding.FieldName = 'NOMFOR'
            Options.Editing = False
            Width = 247
          end
          object grdItensDBTableViewCODFOR: TcxGridDBColumn
            DataBinding.FieldName = 'CODFOR'
            Visible = False
            Options.Editing = False
          end
          object grdItensDBTableViewCODMAR: TcxGridDBColumn
            DataBinding.FieldName = 'CODMAR'
            Visible = False
            Options.Editing = False
          end
        end
        object grdItensLevel: TcxGridLevel
          GridView = grdItensDBTableView
        end
      end
    end
    object tbsClientesCashback: TTabSheet
      Caption = 'Clientes do Cashback'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlFiltroClientes: TPanel
        Left = 0
        Top = 0
        Width = 886
        Height = 253
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblCliente: TLabel
          Left = 0
          Top = 14
          Width = 99
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Cliente:'
        end
        object lblAtividade: TLabel
          Left = 0
          Top = 38
          Width = 99
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Atividade:'
        end
        object lblCidade: TLabel
          Left = 0
          Top = 63
          Width = 99
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Cidade:'
        end
        object lblEstado: TLabel
          Left = 0
          Top = 87
          Width = 99
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Estado:'
        end
        object lblRegiao: TLabel
          Left = 0
          Top = 111
          Width = 99
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Regi'#227'o:'
        end
        object lblSubRegiao: TLabel
          Left = 0
          Top = 134
          Width = 99
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Sub-Regi'#227'o:'
        end
        object lblRedeLoja: TLabel
          Left = 0
          Top = 158
          Width = 99
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Rede de Lojas:'
        end
        object lblCanalAcesso: TLabel
          Left = 0
          Top = 182
          Width = 99
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Canal de Acesso:'
        end
        object lblVendedor: TLabel
          Left = 0
          Top = 206
          Width = 99
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Vendedor:'
        end
        object lblCnpjCpf: TLabel
          Left = 11
          Top = 231
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = '1 - CNPJ / 2 - CPF:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCodCli: TEditFocus
          Tag = 99
          Left = 102
          Top = 11
          Width = 70
          Height = 22
          Alignment = taLeftJustify
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
          Left = 173
          Top = 11
          Width = 373
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
        object btnConfirmaClientes: TBitBtnLocked
          Left = 469
          Top = 227
          Width = 77
          Height = 22
          Caption = 'C&onfirma'
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
          TabOrder = 20
          OnClick = btnConfirmaClientesClick
        end
        object edtCodAti: TEditFocus
          Tag = 99
          Left = 102
          Top = 35
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 2
          OnExit = edtCodAtiExit
          OnKeyPress = edtCodAtiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesAti: TEditFocus
          Left = 173
          Top = 35
          Width = 373
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
        object edtCodCid: TEditFocus
          Tag = 99
          Left = 102
          Top = 59
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 4
          OnExit = edtCodCidExit
          OnKeyPress = edtCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtNomCid: TEditFocus
          Left = 173
          Top = 59
          Width = 373
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
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
        object edtCodEst: TEditFocus
          Tag = 99
          Left = 102
          Top = 83
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          TabOrder = 6
          OnExit = edtCodEstExit
          OnKeyPress = edtCodEstKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 2
          TipoTexto = ttAlfabetico
        end
        object edtNomEst: TEditFocus
          Left = 173
          Top = 83
          Width = 373
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
        object edtCodReg: TEditFocus
          Tag = 99
          Left = 102
          Top = 107
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 8
          OnExit = edtCodRegExit
          OnKeyPress = edtCodRegKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesReg: TEditFocus
          Left = 173
          Top = 107
          Width = 373
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodSub: TEditFocus
          Tag = 99
          Left = 102
          Top = 131
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 10
          OnExit = edtCodSubExit
          OnKeyPress = edtCodSubKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesSub: TEditFocus
          Left = 173
          Top = 131
          Width = 373
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 11
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodRed: TEditFocus
          Tag = 99
          Left = 102
          Top = 155
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 12
          OnExit = edtCodRedExit
          OnKeyPress = edtCodRedKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesRed: TEditFocus
          Left = 173
          Top = 155
          Width = 373
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
        object edtCodCac: TEditFocus
          Tag = 99
          Left = 102
          Top = 179
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 14
          OnExit = edtCodCacExit
          OnKeyPress = edtCodCacKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesCac: TEditFocus
          Left = 173
          Top = 179
          Width = 373
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtCodVen: TEditFocus
          Tag = 99
          Left = 102
          Top = 203
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 16
          OnExit = edtCodVenExit
          OnKeyPress = edtCodVenKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtNomVen: TEditFocus
          Left = 173
          Top = 203
          Width = 373
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 17
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCgcCpf: TEditFocus
          Tag = 99
          Left = 102
          Top = 227
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentFont = False
          TabOrder = 18
          OnExit = edtCgcCpfExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttInteiro
        end
        object mskCgcCpf: TMaskEditC_G_C_
          Tag = 99
          Left = 173
          Top = 227
          Width = 172
          Height = 22
          CharCase = ecUpperCase
          EditMask = '999.999.999-99;0;'
          MaxLength = 14
          TabOrder = 19
          Text = ''
          OnExit = mskCgcCpfExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
      object grdClientes: TcxGrid
        Left = 0
        Top = 253
        Width = 886
        Height = 323
        Align = alClient
        TabOrder = 1
        object grdClientesDBTableView1: TcxGridDBTableView
          OnKeyDown = grdClientesDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsClientes
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object grdClientesDBTableViewCODCLI: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODCLI'
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 90
          end
          object grdClientesDBTableViewNOMCLI: TcxGridDBColumn
            Caption = 'Cliente'
            DataBinding.FieldName = 'NOMCLI'
            Options.Editing = False
            Width = 411
          end
        end
        object grdClientesLevel1: TcxGridLevel
          GridView = grdClientesDBTableView1
        end
      end
    end
    object tbsItensUtilizacaoCashback: TTabSheet
      Caption = 'Itens para Utiliza'#231#227'o'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlFiltroItensUtilizacao: TPanel
        Left = 0
        Top = 0
        Width = 886
        Height = 268
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblItemItensUtilizacao: TLabel
          Left = -2
          Top = 14
          Width = 85
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Produto:'
        end
        object lblGrupoLinhaItensUtilizacao: TLabel
          Left = 18
          Top = 38
          Width = 68
          Height = 14
          Alignment = taRightJustify
          Caption = 'Linha / Grupo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblMarcaItensUtilizacao: TLabel
          Left = 54
          Top = 61
          Width = 33
          Height = 14
          Alignment = taRightJustify
          Caption = 'Marca:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblFornecedorItensUtilizacao: TLabel
          Left = 28
          Top = 84
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDepartamentoItensUtilizacao: TLabel
          Left = 17
          Top = 107
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Departamento:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDescriIniItensUtilizacao: TLabel
          Left = 6
          Top = 130
          Width = 81
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o Inicial:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDescriFinItensUtilizacao: TLabel
          Left = 10
          Top = 152
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Descri'#231#227'o Final:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblRefereItensUtilizacao: TLabel
          Left = 31
          Top = 176
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Refer'#234'ncia:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblImpLisItensUtilizacao: TLabel
          Left = 22
          Top = 199
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Imprime Lista:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object cllImpLisItensUtilizacao: TColorLabel
          Left = 130
          Top = 200
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblUnidadeItensUtilizacao: TLabel
          Left = 44
          Top = 222
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object cllProAtiItensUtilizacao: TColorLabel
          Left = 130
          Top = 246
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblProAtiItensUtilizacao: TLabel
          Left = 20
          Top = 245
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto Ativo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCodIteItensUtilizacao: TEditFocus
          Tag = 99
          Left = 89
          Top = 11
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnExit = edtCodIteItensUtilizacaoExit
          OnKeyPress = edtCodIteItensUtilizacaoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesIteItensUtilizacao: TEditFocus
          Left = 160
          Top = 11
          Width = 373
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
        object mskLinhaGrupoItensUtilizacao: TMaskEditFocus
          Tag = 99
          Left = 89
          Top = 34
          Width = 70
          Height = 22
          EditMask = '999.999;0;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          ParentFont = False
          TabOrder = 2
          Text = ''
          OnExit = mskLinhaGrupoItensUtilizacaoExit
          OnKeyPress = mskLinhaGrupoItensUtilizacaoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGrupoItensUtilizacao: TEditFocus
          Left = 160
          Top = 34
          Width = 373
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtMarcaItensUtilizacao: TEditFocus
          Tag = 99
          Left = 89
          Top = 57
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnExit = edtMarcaItensUtilizacaoExit
          OnKeyPress = edtMarcaItensUtilizacaoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesMarcaItensUtilizacao: TEditFocus
          Left = 160
          Top = 57
          Width = 373
          Height = 22
          TabStop = False
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
        object edtFornecedorItensUtilizacao: TEditFocus
          Tag = 99
          Left = 89
          Top = 80
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 6
          OnExit = edtFornecedorItensUtilizacaoExit
          OnKeyPress = edtFornecedorItensUtilizacaoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDesFornecedorItensUtilizacao: TEditFocus
          Left = 160
          Top = 80
          Width = 373
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDepartamentoItensUtilizacao: TEditFocus
          Tag = 99
          Left = 89
          Top = 103
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 8
          OnExit = edtDepartamentoItensUtilizacaoExit
          OnKeyPress = edtDepartamentoItensUtilizacaoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesDepartamentoItensUtilizacao: TEditFocus
          Left = 160
          Top = 103
          Width = 373
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDescriIniItensUtilizacao: TEditFocus
          Tag = 99
          Left = 89
          Top = 126
          Width = 444
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
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
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDescriFinItensUtilizacao: TEditFocus
          Tag = 99
          Left = 89
          Top = 149
          Width = 444
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRefereItensUtilizacao: TEditFocus
          Tag = 99
          Left = 89
          Top = 172
          Width = 444
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 12
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtImpLisItensUtilizacao: TEditFocus
          Tag = 99
          Left = 89
          Top = 195
          Width = 37
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 13
          OnExit = edtImpLisItensUtilizacaoExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfanumerico
        end
        object edtUnidadeItensUtilizacao: TEditFocus
          Tag = 99
          Left = 89
          Top = 218
          Width = 37
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 14
          OnExit = edtUnidadeItensUtilizacaoExit
          OnKeyPress = edtUnidadeItensUtilizacaoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        object edtProAtiItensUtilizacao: TEditFocus
          Tag = 99
          Left = 89
          Top = 241
          Width = 37
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 15
          OnExit = edtProAtiItensUtilizacaoExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfanumerico
        end
        object btnConfirmarItensUtilizacao: TBitBtnLocked
          Left = 456
          Top = 243
          Width = 77
          Height = 22
          Caption = 'C&onfirma'
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
          TabOrder = 16
          OnClick = btnConfirmarItensUtilizacaoClick
        end
        object edtDesUnidadeItensUtilizacao: TEditFocus
          Left = 127
          Top = 218
          Width = 406
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 17
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object grdItensUtilizacao: TcxGrid
        Left = 0
        Top = 268
        Width = 886
        Height = 308
        Align = alClient
        TabOrder = 1
        object grdItensUtilizacaoDBTableView: TcxGridDBTableView
          OnKeyDown = grdItensUtilizacaoDBTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsItensUtilizacao
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object grdItensUtilizacaoDBTableViewCODITE: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODITE'
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 48
          end
          object grdItensUtilizacaoDBTableViewDESITE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESITE'
            Options.Editing = False
            Width = 302
          end
          object grdItensUtilizacaoDBTableViewUNIDAD: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'UNIDAD'
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 46
          end
          object grdItensUtilizacaoDBTableViewMARCA_: TcxGridDBColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'MARCA_'
            Options.Editing = False
          end
          object grdItensUtilizacaoDBTableViewREFERE: TcxGridDBColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'REFERE'
            Options.Editing = False
            Width = 152
          end
          object grdItensUtilizacaoDBTableViewNOMFOR: TcxGridDBColumn
            Caption = 'Fornecedor'
            DataBinding.FieldName = 'NOMFOR'
            Options.Editing = False
            Width = 247
          end
          object grdItensUtilizacaoDBTableViewCODFOR: TcxGridDBColumn
            DataBinding.FieldName = 'CODFOR'
            Visible = False
            Options.Editing = False
          end
          object grdItensUtilizacaoDBTableViewCODMAR: TcxGridDBColumn
            DataBinding.FieldName = 'CODMAR'
            Visible = False
            Options.Editing = False
          end
        end
        object grdItensUtilizacaoLevel: TcxGridLevel
          GridView = grdItensUtilizacaoDBTableView
        end
      end
    end
    object tbsCondicaoPagamento: TTabSheet
      Caption = 'Condi'#231#245'es de Pagamento'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object FlowPanel1: TFlowPanel
        Left = 0
        Top = 548
        Width = 886
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        Padding.Left = 2
        Padding.Top = 2
        Padding.Right = 2
        Padding.Bottom = 2
        ParentBackground = False
        TabOrder = 0
        object btnIncluirTodasCndPag: TBitBtnLocked
          Left = 2
          Top = 2
          Width = 216
          Height = 24
          Align = alLeft
          Caption = 'Incluir todas as condi'#231#245'es de pagamento'
          Enabled = False
          TabOrder = 0
          OnClick = btnIncluirTodasCndPagClick
        end
        object btnExcluirTodasCndPag: TBitBtnLocked
          Left = 218
          Top = 2
          Width = 216
          Height = 24
          Align = alLeft
          Caption = 'Excluir todas as condi'#231#245'es de pagamento'
          Enabled = False
          TabOrder = 1
          OnClick = btnExcluirTodasCndPagClick
        end
      end
      object grdCondicaoPagamento: TcxGridCitel
        Left = 0
        Top = 41
        Width = 886
        Height = 507
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdCondicaoPagamentoTableView: TcxGridDBTableViewCitel
          OnKeyDown = grdCondicaoPagamentoTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCondicaoPagamento
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdCondicaoPagamentoTableViewCODCND: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODCND'
          end
          object grdCondicaoPagamentoTableViewDESCND: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESCND'
            Width = 280
          end
          object grdCondicaoPagamentoTableViewCNDPAG: TcxGridDBColumn
            Caption = 'Condi'#231#227'o de Pagamento'
            DataBinding.FieldName = 'CNDPAG'
            Width = 400
          end
        end
        object grdCondicaoPagamentoLevel: TcxGridLevel
          GridView = grdCondicaoPagamentoTableView
        end
      end
      object pnlCndPag: TPanel
        Left = 0
        Top = 0
        Width = 886
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object lblCndPag: TLabel
          Left = 99
          Top = 16
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cond. Pagto:'
        end
        object edtCodCnd: TEditFocus
          Tag = 99
          Left = 162
          Top = 13
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          OnExit = edtCodCndExit
          OnKeyPress = edtCodCndKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object btnIncCndPag: TBitBtnLocked
          Left = 646
          Top = 13
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
          OnClick = btnIncCndPagClick
        end
        object btnCancelCndPag: TBitBtnLocked
          Left = 724
          Top = 13
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
          OnClick = btnCancelCndPagClick
        end
        object edtDesCnd: TEditFocus
          Left = 232
          Top = 13
          Width = 410
          Height = 22
          HelpType = htKeyword
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
    end
    object tbsCanalAcesso: TTabSheet
      Caption = 'Canal de Acesso'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlCnlAce: TPanel
        Left = 0
        Top = 0
        Width = 886
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label15: TLabel
          Left = 75
          Top = 16
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Canal de Acesso:'
        end
        object edtFilCodCac: TEditFocus
          Tag = 99
          Left = 162
          Top = 13
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnExit = edtFilCodCacExit
          OnKeyPress = edtFilCodCacKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
        object btnIncCnlAce: TBitBtnLocked
          Left = 646
          Top = 13
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
          OnClick = btnIncCnlAceClick
        end
        object btnCancelCnlAce: TBitBtnLocked
          Left = 724
          Top = 13
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
          OnClick = btnCancelCnlAceClick
        end
        object edtFilNomCac: TEditFocus
          Left = 232
          Top = 13
          Width = 410
          Height = 22
          HelpType = htKeyword
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
      object grdCanalAcesso: TcxGridCitel
        Left = 0
        Top = 41
        Width = 886
        Height = 507
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdCanalAcessoTableView: TcxGridDBTableViewCitel
          OnKeyDown = grdCanalAcessoTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCanalAcesso
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdCancaAcessoTableViewCODCAC: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODCAC'
          end
          object grdCancaAcessoTableViewNOMCAC: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'NOMCAC'
            Width = 280
          end
        end
        object grdCanalAcessoLevel: TcxGridLevel
          GridView = grdCanalAcessoTableView
        end
      end
      object FlowPanel2: TFlowPanel
        Left = 0
        Top = 548
        Width = 886
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        Padding.Left = 2
        Padding.Top = 2
        Padding.Right = 2
        Padding.Bottom = 2
        ParentBackground = False
        TabOrder = 2
        object btnIncluirTodosCnlAce: TBitBtnLocked
          Left = 2
          Top = 2
          Width = 216
          Height = 24
          Align = alLeft
          Caption = 'Incluir todos os Canais de Acesso'
          Enabled = False
          TabOrder = 0
          OnClick = btnIncluirTodosCnlAceClick
        end
        object btnExcluirTodosCnlAce: TBitBtnLocked
          Left = 218
          Top = 2
          Width = 216
          Height = 24
          Align = alLeft
          Caption = 'Excluir todos os Canais de Acesso'
          Enabled = False
          TabOrder = 1
          OnClick = btnExcluirTodosCnlAceClick
        end
      end
    end
    object tbsDepartamento: TTabSheet
      Caption = 'Departamento'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlDepartamento: TPanel
        Left = 0
        Top = 0
        Width = 886
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label16: TLabel
          Left = 90
          Top = 16
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Departamento:'
        end
        object edtCodDep: TEditFocus
          Tag = 99
          Left = 162
          Top = 13
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 0
          OnExit = edtCodDepExit
          OnKeyPress = edtCodDepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object btnIncCadDep: TBitBtnLocked
          Left = 646
          Top = 13
          Width = 72
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
          OnClick = btnIncCadDepClick
        end
        object btnCancelCadDep: TBitBtnLocked
          Left = 724
          Top = 13
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
          OnClick = btnCancelCadDepClick
        end
        object edtDesDep: TEditFocus
          Left = 232
          Top = 13
          Width = 410
          Height = 22
          HelpType = htKeyword
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
      object grdDepartamento: TcxGridCitel
        Left = 0
        Top = 41
        Width = 886
        Height = 507
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdDepartamentoTableView: TcxGridDBTableViewCitel
          OnKeyDown = grdDepartamentoTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsDepartamento
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdDepartamentoTableViewCODDEP: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODDEP'
          end
          object grdDepartamentoTableViewDESDEP: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESDEP'
            Width = 280
          end
        end
        object grdDepartamentoLevel: TcxGridLevel
          GridView = grdDepartamentoTableView
        end
      end
      object FlowPanel3: TFlowPanel
        Left = 0
        Top = 548
        Width = 886
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        Color = clGray
        Padding.Left = 2
        Padding.Top = 2
        Padding.Right = 2
        Padding.Bottom = 2
        ParentBackground = False
        TabOrder = 2
        object btnIncluirTodosDepartamentos: TBitBtnLocked
          Left = 2
          Top = 2
          Width = 216
          Height = 24
          Align = alLeft
          Caption = 'Incluir todos os Departamentos'
          Enabled = False
          TabOrder = 0
          OnClick = btnIncluirTodosDepartamentosClick
        end
        object btnExcluirTodosDepartamentos: TBitBtnLocked
          Left = 218
          Top = 2
          Width = 216
          Height = 24
          Align = alLeft
          Caption = 'Excluir todos os Departamentos'
          Enabled = False
          TabOrder = 1
          OnClick = btnExcluirTodosDepartamentosClick
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 828
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 824
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 816
  end
  object dtsCadCsh: TDataSource
    Left = 816
    Top = 92
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 676
    Top = 108
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 676
    Top = 44
    object cdsItensCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 2
    end
    object cdsItensCODMAR: TStringField
      FieldName = 'CODMAR'
      Size = 6
    end
    object cdsItensMARCA_: TStringField
      FieldName = 'MARCA_'
      Size = 30
    end
    object cdsItensREFERE: TStringField
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsItensCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 60
    end
    object cdsItensNOMFOR: TStringField
      FieldName = 'NOMFOR'
      Size = 69
    end
  end
  object cdsClientes: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 588
    Top = 44
    object cdsClientesCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsClientesNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 100
    end
  end
  object dtsClientes: TDataSource
    DataSet = cdsClientes
    Left = 588
    Top = 108
  end
  object cdsItensUtilizacao: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 588
    Top = 164
    object cdsItensUtilizacaoCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
    object cdsItensUtilizacaoDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensUtilizacaoUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 2
    end
    object cdsItensUtilizacaoCODMAR: TStringField
      FieldName = 'CODMAR'
      Size = 6
    end
    object cdsItensUtilizacaoMARCA_: TStringField
      FieldName = 'MARCA_'
      Size = 30
    end
    object cdsItensUtilizacaoREFERE: TStringField
      FieldName = 'REFERE'
      Size = 16
    end
    object cdsItensUtilizacaoCODFOR: TStringField
      FieldName = 'CODFOR'
      Size = 60
    end
    object cdsItensUtilizacaoNOMFOR: TStringField
      FieldName = 'NOMFOR'
      Size = 69
    end
  end
  object dtsItensUtilizacao: TDataSource
    DataSet = cdsItensUtilizacao
    Left = 532
    Top = 204
  end
  object dtsCondicaoPagamento: TDataSource
    DataSet = cdsCondicaoPagamento
    Left = 673
    Top = 227
  end
  object cdsCondicaoPagamento: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 673
    Top = 163
    object cdsCondicaoPagamentoCODCND: TStringField
      FieldName = 'CODCND'
      Size = 10
    end
    object cdsCondicaoPagamentoCNDPAG: TStringField
      FieldName = 'CNDPAG'
      Size = 100
    end
    object cdsCondicaoPagamentoDESCND: TStringField
      FieldName = 'DESCND'
      Size = 50
    end
  end
  object cdsCanalAcesso: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 673
    Top = 291
    object cdsCanalAcessoCODCAC: TStringField
      FieldName = 'CODCAC'
      Size = 10
    end
    object cdsCanalAcessoNOMCAC: TStringField
      FieldName = 'NOMCAC'
      Size = 50
    end
  end
  object dtsCanalAcesso: TDataSource
    DataSet = cdsCanalAcesso
    Left = 673
    Top = 355
  end
  object cdsDepartamento: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 537
    Top = 291
    object cdsDepartamentoCODDEP: TStringField
      FieldName = 'CODDEP'
      Size = 10
    end
    object cdsDepartamentoDESDEP: TStringField
      FieldName = 'DESDEP'
      Size = 50
    end
  end
  object dtsDepartamento: TDataSource
    DataSet = cdsDepartamento
    Left = 537
    Top = 355
  end
end
