inherited frmCadCupomDesconto: TfrmCadCupomDesconto
  Left = 578
  Top = 392
  Width = 883
  Height = 527
  Caption = 'Cupom de Desconto para Pr'#243'ximas Vendas'
  ExplicitWidth = 883
  ExplicitHeight = 527
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 457
    Width = 877
    Height = 25
    ExplicitTop = 385
    ExplicitWidth = 562
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 873
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 558
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
      Left = 792
      Width = 74
      Height = 20
      ExplicitLeft = 477
      ExplicitWidth = 74
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 482
    Width = 877
    ExplicitTop = 410
    ExplicitWidth = 562
    inherited pnlNomeForm: TPanel
      Left = 698
      Width = 179
      ExplicitLeft = 383
      ExplicitWidth = 179
    end
    inherited pnlInfo: TPanel
      Width = 698
      ExplicitWidth = 383
    end
  end
  inherited pgcDados: TPageControl
    Width = 877
    Height = 457
    ActivePage = tbsItensCupom
    ExplicitWidth = 877
    ExplicitHeight = 457
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 554
      ExplicitHeight = 353
      object pnlCentral: TPanel
        Left = 0
        Top = 0
        Width = 869
        Height = 425
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 877
        ExplicitHeight = 457
        object Label2: TLabel
          Left = 31
          Top = 42
          Width = 52
          Height = 14
          Caption = 'Descri'#231#227'o:'
        end
        object Label1: TLabel
          Left = 47
          Top = 18
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object lbl1: TLabel
          Left = 11
          Top = 88
          Width = 73
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Cliente:'
        end
        object lbl2: TColorLabel
          Left = 127
          Top = 87
          Width = 246
          Height = 14
          Caption = '(F) Pessoa F'#237'sica   (J) Pessoa Jur'#237'dica   (A) Ambos'
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
          Left = 37
          Top = 65
          Width = 46
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Vig'#234'ncia:'
        end
        object Label4: TLabel
          Left = 159
          Top = 65
          Width = 6
          Height = 14
          Alignment = taRightJustify
          Caption = #224
        end
        object dbeDescri: TDBEditFocus
          Tag = 99
          Left = 85
          Top = 35
          Width = 424
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CUP_DESCRI'
          DataSource = dtsCadCup
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodCup: TDBEditFocus
          Tag = 99
          Left = 85
          Top = 11
          Width = 64
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CUP_CODCUP'
          DataSource = dtsCadCup
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
          Left = 85
          Top = 83
          Width = 37
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CUP_TIPPES'
          DataSource = dtsCadCup
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
          Left = 85
          Top = 59
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CUP_INIVIG'
          DataSource = dtsCadCup
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
          Left = 170
          Top = 59
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CUP_FINVIG'
          DataSource = dtsCadCup
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object gpbTipoCupom: TGroupBox
          Left = 35
          Top = 113
          Width = 510
          Height = 171
          Caption = 'Tipo de Cupom:'
          TabOrder = 5
          object rdbValFix: TRadioButton
            Left = 24
            Top = 19
            Width = 387
            Height = 27
            Caption = 'Cupom no valor fixo de                           .'
            TabOrder = 0
            OnClick = rdbValFixClick
          end
          object rdbPerDes: TRadioButton
            Left = 24
            Top = 51
            Width = 387
            Height = 27
            Caption = 'Cupom com                     % sobre o valor da compra.'
            TabOrder = 1
            OnClick = rdbValFixClick
          end
          object rdbValCom: TRadioButton
            Left = 24
            Top = 81
            Width = 387
            Height = 27
            Caption = 
              'A cada                           em compras, acumulo de         ' +
              '                  no cupom.'
            TabOrder = 2
            OnClick = rdbValFixClick
          end
          object dbeValFix: TDBEditFocus
            Tag = 99
            Left = 156
            Top = 21
            Width = 73
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CUP_VALFIX'
            DataSource = dtsCadCup
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbePerDes: TDBEditFocus
            Tag = 99
            Left = 100
            Top = 53
            Width = 57
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CUP_PERDES'
            DataSource = dtsCadCup
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeValCom: TDBEditFocus
            Tag = 99
            Left = 77
            Top = 83
            Width = 73
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CUP_VALCOM'
            DataSource = dtsCadCup
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
            Left = 280
            Top = 83
            Width = 73
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CUP_VALACU'
            DataSource = dtsCadCup
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object rdbVlItFi: TRadioButton
            Left = 24
            Top = 143
            Width = 473
            Height = 17
            Caption = 
              'Cupom no valor fixo de                           sobre os itens ' +
              'informados.'
            TabOrder = 7
            OnClick = rdbValFixClick
          end
          object rdbVlItPe: TRadioButton
            Left = 24
            Top = 114
            Width = 465
            Height = 17
            Caption = 
              'Cupom com                      % sobre o valor dos itens informa' +
              'dos.'
            TabOrder = 8
            OnClick = rdbValFixClick
          end
          object dbeVlItPe: TDBEditFocus
            Tag = 99
            Left = 101
            Top = 111
            Width = 57
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CUP_VLITPE'
            DataSource = dtsCadCup
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 9
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeVlItFi: TDBEditFocus
            Tag = 99
            Left = 156
            Top = 140
            Width = 73
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CUP_VLITFI'
            DataSource = dtsCadCup
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 10
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
        object gpbUtilizacaoCupom: TGroupBox
          Left = 35
          Top = 288
          Width = 510
          Height = 127
          Caption = 'Utiliza'#231#227'o do cupom:'
          TabOrder = 6
          object Label5: TLabel
            Left = 16
            Top = 31
            Width = 307
            Height = 14
            Alignment = taRightJustify
            Caption = 'Permitir utilizar desconto de desconto em vendas a partir de R$:'
          end
          object Label7: TLabel
            Left = 408
            Top = 55
            Width = 90
            Height = 28
            Alignment = taCenter
            Caption = '(Valor Zero cupom nunca expira)'
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
            Left = 346
            Top = 97
            Width = 6
            Height = 14
            Alignment = taRightJustify
            Caption = #224
          end
          object rdbDiaExp: TRadioButton
            Left = 24
            Top = 58
            Width = 313
            Height = 27
            Caption = 'Quantidade de dias para expirar o cupom a partir da venda:'
            TabOrder = 1
            OnClick = rdbDiaExpClick
          end
          object dbeMinVen: TDBEditFocus
            Tag = 99
            Left = 326
            Top = 24
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CUP_MINVEN'
            DataSource = dtsCadCup
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeDiaExp: TDBEditFocus
            Tag = 99
            Left = 329
            Top = 58
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CUP_DIAEXP'
            DataSource = dtsCadCup
            MaxLength = 5
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object rdbDtaVal: TRadioButton
            Left = 24
            Top = 91
            Width = 249
            Height = 27
            Caption = 'Permitir utilizar o cupom somente no per'#237'odo de:'
            TabOrder = 3
            OnClick = rdbDiaExpClick
          end
          object dbeIniVal: TDBEditFocus
            Tag = 99
            Left = 272
            Top = 91
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CUP_INIVAL'
            DataSource = dtsCadCup
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeFinVal: TDBEditFocus
            Tag = 99
            Left = 357
            Top = 91
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CUP_FINVAL'
            DataSource = dtsCadCup
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
      end
    end
    object tbsItensCupom: TTabSheet
      Caption = '2 - Itens do Cupom'
      ImageIndex = 1
      object pnlFiltro: TPanel
        Left = 0
        Top = 0
        Width = 869
        Height = 268
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        ExplicitTop = 8
        object lblItem: TLabel
          Left = -2
          Top = 14
          Width = 85
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Produto:'
        end
        object lblGrupoLinha: TLabel
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
        object lblMarca: TLabel
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
        object lblFornecedor: TLabel
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
        object lblDepartamento: TLabel
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
        object lblDescriIni: TLabel
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
        object lblDescriFin: TLabel
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
        object lblRefere: TLabel
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
        object lblImpLis: TLabel
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
        object cllImpLis: TColorLabel
          Left = 130
          Top = 200
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblUnidade: TLabel
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
        object cllProAti: TColorLabel
          Left = 130
          Top = 246
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          CorDestaque = clRed
        end
        object lblProAti: TLabel
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
        object edtCodIte: TEditFocus
          Tag = 99
          Left = 89
          Top = 11
          Width = 70
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 0
          OnExit = edtCodIteExit
          OnKeyPress = edtCodIteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesIte: TEditFocus
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
        object mskLinhaGrupo: TMaskEditFocus
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
          OnExit = mskLinhaGrupoExit
          OnKeyPress = mskLinhaGrupoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGrupo: TEditFocus
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
        object edtMarca: TEditFocus
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
          OnExit = edtMarcaExit
          OnKeyPress = edtMarcaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesMarca: TEditFocus
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
        object edtFornecedor: TEditFocus
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
          OnExit = edtFornecedorExit
          OnKeyPress = edtFornecedorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtDesFornecedor: TEditFocus
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
        object edtDepartamento: TEditFocus
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
          OnExit = edtDepartamentoExit
          OnKeyPress = edtDepartamentoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesDepartamento: TEditFocus
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
        object edtDescriIni: TEditFocus
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
        object edtDescriFin: TEditFocus
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
        object edtRefere: TEditFocus
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
        object edtImpLis: TEditFocus
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
          OnExit = edtImpLisExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfanumerico
        end
        object edtUnidade: TEditFocus
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
          OnExit = edtUnidadeExit
          OnKeyPress = edtUnidadeKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        object edtProAti: TEditFocus
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
          OnExit = edtProAtiExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfanumerico
        end
        object btnConfirmar: TBitBtnLocked
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
          OnClick = btnConfirmarClick
        end
        object edtDesUnidade: TEditFocus
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
        Width = 869
        Height = 157
        Align = alClient
        TabOrder = 1
        object grdItensDBTableView1: TcxGridDBTableView
          OnKeyDown = grdItensDBTableView1KeyDown
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
          object cxGrid1DBTableViewCODITE: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODITE'
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 48
          end
          object cxGrid1DBTableViewDESITE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESITE'
            Options.Editing = False
            Width = 302
          end
          object cxGrid1DBTableViewUNIDAD: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'UNIDAD'
            Options.Editing = False
            Options.AutoWidthSizable = False
            Width = 46
          end
          object cxGrid1DBTableViewMARCA_: TcxGridDBColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'MARCA_'
            Options.Editing = False
          end
          object cxGrid1DBTableViewREFERE: TcxGridDBColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'REFERE'
            Options.Editing = False
            Width = 152
          end
          object cxGrid1DBTableViewNOMFOR: TcxGridDBColumn
            Caption = 'Fornecedor'
            DataBinding.FieldName = 'NOMFOR'
            Options.Editing = False
            Width = 247
          end
          object cxGrid1DBTableViewCODFOR: TcxGridDBColumn
            DataBinding.FieldName = 'CODFOR'
            Visible = False
            Options.Editing = False
          end
          object cxGrid1DBTableViewCODMAR: TcxGridDBColumn
            DataBinding.FieldName = 'CODMAR'
            Visible = False
            Options.Editing = False
          end
        end
        object grdItensLevel1: TcxGridLevel
          GridView = grdItensDBTableView1
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
  object dtsCadCup: TDataSource
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
end
