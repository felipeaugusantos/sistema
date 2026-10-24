inherited frmCadLoteItens: TfrmCadLoteItens
  Left = 242
  Top = 388
  Width = 652
  Height = 658
  Caption = 'Cadastro de Lotes'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 652
  ExplicitHeight = 658
  PixelsPerInch = 96
  TextHeight = 14
  object Label5: TLabel [0]
    Left = 344
    Top = 71
    Width = 92
    Height = 14
    Alignment = taRightJustify
    Caption = 'Valor Total M'#178' (R$):'
  end
  object Label9: TLabel [1]
    Left = 361
    Top = 48
    Width = 75
    Height = 14
    Alignment = taRightJustify
    Caption = 'Qtd. M'#178' L'#237'quido:'
  end
  object Label11: TLabel [2]
    Left = 368
    Top = 25
    Width = 67
    Height = 14
    Alignment = taRightJustify
    Caption = 'Pre'#231'o M'#178'(R$):'
  end
  inherited pnlBotoes: TPanel
    Top = 585
    Width = 646
    ExplicitTop = 585
    ExplicitWidth = 646
    inherited FlwBotoes: TFlowPanel
      Width = 565
      ExplicitTop = 2
      ExplicitWidth = 565
      inherited btnIncluir: TBitBtnLocked
        Width = 79
        Height = 24
        Align = alLeft
        ExplicitWidth = 79
        ExplicitHeight = 24
      end
      inherited btnGravar: TBitBtnLocked
        Left = 79
        Width = 79
        Height = 24
        Align = alLeft
        ExplicitLeft = 79
        ExplicitWidth = 79
        ExplicitHeight = 24
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 158
        Width = 79
        Height = 24
        Align = alLeft
        ExplicitLeft = 158
        ExplicitWidth = 79
        ExplicitHeight = 24
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 237
        Width = 79
        Height = 24
        Align = alLeft
        ExplicitLeft = 237
        ExplicitWidth = 79
        ExplicitHeight = 24
      end
      inherited btnCancela: TBitBtnLocked
        Left = 316
        Width = 79
        Height = 24
        Align = alLeft
        ExplicitLeft = 316
        ExplicitWidth = 79
        ExplicitHeight = 24
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 395
        Width = 79
        Height = 24
        Align = alLeft
        ExplicitLeft = 395
        ExplicitWidth = 79
        ExplicitHeight = 24
      end
      object btnImprimir: TBitBtnLocked
        Left = 474
        Top = 0
        Width = 86
        Height = 24
        Align = alLeft
        Caption = '&Imp. Etiqueta'
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
        TabOrder = 6
        OnClick = btnImprimirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 567
      Height = 24
      Align = alRight
      ExplicitLeft = 567
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 613
    Width = 646
    ExplicitTop = 613
    ExplicitWidth = 646
    inherited pnlNomeForm: TPanel
      Left = 299
      ExplicitLeft = 299
    end
    inherited pnlInfo: TPanel
      Width = 299
      ExplicitWidth = 299
      object ProgressBar1: TProgressBar
        Left = 2
        Top = 2
        Width = 295
        Height = 12
        Align = alClient
        TabOrder = 0
        Visible = False
      end
    end
  end
  inherited pgcDados: TPageControl
    Width = 646
    Height = 585
    ExplicitWidth = 646
    ExplicitHeight = 585
    inherited tbsGeral: TTabSheet
      Caption = 'Geral'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 638
      ExplicitHeight = 553
      object pnlDados: TPanel
        Left = 0
        Top = 0
        Width = 638
        Height = 553
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object dbeCodEmp: TDBEditFocus
          Left = 531
          Top = 28
          Width = 89
          Height = 22
          DataField = 'LOT_CODEMP'
          DataSource = dtsCadLot
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 17
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object pnlCtlArmazem: TPanel
          Left = 0
          Top = 217
          Width = 638
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 4
          object Label12: TLabel
            Left = 32
            Top = 3
            Width = 60
            Height = 14
            Alignment = taRightJustify
            Caption = 'Capacidade:'
          end
          object Label13: TLabel
            Left = 245
            Top = 4
            Width = 99
            Height = 14
            Alignment = taRightJustify
            Caption = 'Ponto de Reposi'#231#227'o:'
          end
          object dbeCapaci: TDBEditFocus
            Tag = 99
            Left = 98
            Top = 0
            Width = 134
            Height = 22
            DataField = 'LOT_CAPACI'
            DataSource = dtsCadLot
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbePonRep: TDBEditFocus
            Tag = 99
            Left = 345
            Top = 0
            Width = 134
            Height = 22
            DataField = 'LOT_PONREP'
            DataSource = dtsCadLot
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlCodItem: TPanel
          Left = 0
          Top = 49
          Width = 638
          Height = 49
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object lbl1: TLabel
            Left = 39
            Top = 8
            Width = 58
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo Item:'
          end
          object dbeCodIte: TDBEditFocus
            Tag = 99
            Left = 98
            Top = 4
            Width = 50
            Height = 22
            DataField = 'LOT_CODITE'
            DataSource = dtsCadLot
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            TabOrder = 0
            OnKeyPress = dbeCodIteKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtDesIte: TEditFocus
            Left = 149
            Top = 4
            Width = 383
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
          object dbcLotApr: TDBCheckBox
            Left = 90
            Top = 30
            Width = 331
            Height = 17
            Caption = 'Lote Aprovado / Liberado para venda ou Lote em garantia?'
            DataField = 'LOT_LOTAPR'
            DataSource = dtsCadLot
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbcLotAprClick
          end
          object dbcVenTdo: TDBCheckBox
            Left = 423
            Top = 30
            Width = 214
            Height = 17
            Caption = 'Obrigat'#243'ria venda da quantidade total?'
            DataField = 'LOT_VENTDO'
            DataSource = dtsCadLot
            TabOrder = 2
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dbeStatus: TDBComboBoxFocus
            Tag = 99
            Left = 533
            Top = 4
            Width = 94
            Height = 22
            Style = csDropDownList
            DataField = 'LOT_STATUS'
            DataSource = dtsCadLot
            Items.Strings = (
              'ATIVO'
              'INATIVO'
              'BLOQUEADO')
            TabOrder = 4
            OnChange = dbeStatusChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlNumLot: TPanel
          Left = 0
          Top = 26
          Width = 638
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object lblNumLot: TLabel
            Left = 16
            Top = 5
            Width = 81
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Lote:'
          end
          object dbeNumLot: TDBEditFocus
            Tag = 99
            Left = 98
            Top = 1
            Width = 134
            Height = 22
            CharCase = ecUpperCase
            DataField = 'LOT_NUMLOT'
            DataSource = dtsCadLot
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 30
            TabOrder = 0
            OnKeyPress = dbeNumLotKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtDescArmazem: TEditFocus
            Left = 233
            Top = 1
            Width = 394
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
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
        object pnlOutrasInform: TPanel
          Left = 0
          Top = 98
          Width = 638
          Height = 95
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object lbl2: TLabel
            Left = 0
            Top = 4
            Width = 97
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data de Fabrica'#231#227'o:'
          end
          object lbl3: TLabel
            Left = 214
            Top = 4
            Width = 84
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data de Validade:'
          end
          object lbl4: TLabel
            Left = 474
            Top = 27
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'Saldos:'
          end
          object lbl5: TLabel
            Left = 212
            Top = 28
            Width = 87
            Height = 14
            Alignment = taRightJustify
            Caption = 'Saldo de Balan'#231'o:'
          end
          object lbl6: TLabel
            Left = 15
            Top = 27
            Width = 82
            Height = 14
            Alignment = taRightJustify
            Caption = 'Data de Balan'#231'o:'
          end
          object dbeDtaFab: TDBEditFocus
            Tag = 99
            Left = 98
            Top = 0
            Width = 89
            Height = 22
            DataField = 'LOT_DTAFAB'
            DataSource = dtsCadLot
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDtaVal: TDBEditFocus
            Tag = 99
            Left = 300
            Top = 0
            Width = 89
            Height = 22
            DataField = 'LOT_DTAVAL'
            DataSource = dtsCadLot
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeSaldos: TDBEditFocus
            Tag = 99
            Left = 511
            Top = 22
            Width = 116
            Height = 22
            TabStop = False
            Color = 16768952
            DataField = 'LOT_SALDOS'
            DataSource = dtsCadLot
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
          object dbeSalBal: TDBEditFocus
            Tag = 99
            Left = 300
            Top = 23
            Width = 117
            Height = 22
            TabStop = False
            Color = 16768952
            DataField = 'LOT_SALBAL'
            DataSource = dtsCadLot
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDtaBal: TDBEditFocus
            Tag = 99
            Left = 98
            Top = 22
            Width = 89
            Height = 22
            TabStop = False
            Color = 16768952
            DataField = 'LOT_DTABAL'
            DataSource = dtsCadLot
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
          object pnlLocFis: TPanel
            Left = 0
            Top = 70
            Width = 638
            Height = 25
            Align = alBottom
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 6
            object lblLocFis: TLabel
              Left = 4
              Top = 5
              Width = 92
              Height = 14
              Alignment = taRightJustify
              Caption = 'Localiza'#231#227'o F'#237'sica:'
            end
            object dbeLocFis: TDBEditFocus
              Tag = 99
              Left = 98
              Top = 1
              Width = 134
              Height = 22
              CharCase = ecUpperCase
              DataField = 'LOT_LOCFIS'
              DataSource = dtsCadLot
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 30
              TabOrder = 0
              OnKeyPress = dbeLocFisKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
              OnChamaCadastro = dbeLocFisChamaCadastro
            end
            object edtDesLoc: TEditFocus
              Left = 233
              Top = 1
              Width = 394
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
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
          object pnlSal_ML: TPanel
            Left = 0
            Top = 47
            Width = 638
            Height = 23
            Align = alBottom
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 5
            object Label2: TLabel
              Left = 169
              Top = 5
              Width = 130
              Height = 14
              Alignment = taRightJustify
              Caption = 'Saldo de Balan'#231'o (ML/GR):'
            end
            object Label3: TLabel
              Left = 431
              Top = 5
              Width = 79
              Height = 14
              Alignment = taRightJustify
              Caption = 'Saldos (ML/GR):'
            end
            object dbeSal_ML: TDBEditFocus
              Tag = 99
              Left = 300
              Top = 1
              Width = 117
              Height = 22
              TabStop = False
              Color = 16768952
              DataField = 'LOT_SAL_ML'
              DataSource = dtsCadLot
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
            object dbeML_Bal: TDBEditFocus
              Tag = 99
              Left = 511
              Top = 1
              Width = 116
              Height = 22
              TabStop = False
              Color = 16768952
              DataField = 'LOT_ML_BAL'
              DataSource = dtsCadLot
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
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
        object pnlArmLotCheckout: TPanel
          Left = 0
          Top = 319
          Width = 638
          Height = 15
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 9
          object chkArmPri: TDBCheckBox
            Left = 98
            Top = 1
            Width = 319
            Height = 14
            Caption = 'Armaz'#233'm/Lote Principal para vendas no check-out/Tablet.'
            DataField = 'LOT_ARMPRI'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkArmPriClick
          end
        end
        object pnlLocSep: TPanel
          Left = 0
          Top = 193
          Width = 638
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object Label1: TLabel
            Left = 2
            Top = 5
            Width = 95
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Local Separa'#231#227'o:'
          end
          object dbeLocSep: TDBEditFocus
            Tag = 99
            Left = 98
            Top = 1
            Width = 134
            Height = 22
            CharCase = ecUpperCase
            DataField = 'LOT_LOCSEP'
            DataSource = dtsCadLot
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 0
            OnKeyPress = dbeLocSepKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtDesLocSep: TEditFocus
            Left = 233
            Top = 1
            Width = 394
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
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
        object pnlPriTin: TPanel
          Left = 0
          Top = 350
          Width = 638
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 11
          object chkPriTin: TDBCheckBox
            Left = 98
            Top = 1
            Width = 215
            Height = 14
            Caption = 'Lote principal para Tinta M'#225'quina'
            DataField = 'LOT_PRITIN'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkPriTinClick
          end
        end
        object pnlAbsAut: TPanel
          Left = 0
          Top = 398
          Width = 638
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 14
          object chkAbsAut: TDBCheckBox
            Left = 98
            Top = 1
            Width = 398
            Height = 14
            Caption = 
              'Permitir abastecimento autom'#225'tico pelo Relat'#243'rio de Itens Abaixo' +
              ' do M'#237'nimo'
            DataField = 'LOT_ABSAUT'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkPriTinClick
          end
        end
        object pnlArmPrC: TPanel
          Left = 0
          Top = 254
          Width = 638
          Height = 14
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 6
          object chkArmPrC: TDBCheckBox
            Left = 98
            Top = 0
            Width = 319
            Height = 14
            Caption = 'Armaz'#233'm Principal para compras'
            DataField = 'LOT_ARMPRC'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkArmPrCClick
          end
        end
        object pnlOrdPro: TPanel
          Left = 0
          Top = 240
          Width = 638
          Height = 14
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 5
          object chkPriPro: TDBCheckBox
            Left = 98
            Top = 0
            Width = 246
            Height = 14
            Caption = 'Armaz'#233'm principal para Ordem de Produ'#231#227'o'
            DataField = 'LOT_PRIPRO'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkArmPriClick
          end
        end
        object pnlGarantia: TPanel
          Left = 0
          Top = 291
          Width = 638
          Height = 14
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 7
          object chkGarPri: TDBCheckBox
            Left = 98
            Top = 0
            Width = 311
            Height = 14
            Caption = 'Armaz'#233'm Principal para Recebimento de Garantia do Cliente'
            DataField = 'LOT_GARPRI'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkGarPriClick
          end
        end
        object pnlMotBlo: TPanel
          Left = 0
          Top = 268
          Width = 638
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 18
          object Label4: TLabel
            Left = 19
            Top = 3
            Width = 78
            Height = 14
            Alignment = taRightJustify
            Caption = 'Motivo Bloqueio:'
          end
          object edtMotBlo: TEditFocus
            Left = 98
            Top = 0
            Width = 529
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 0
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlBroker: TPanel
          Left = 0
          Top = 366
          Width = 638
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 12
          object chkBroker: TDBCheckBox
            Left = 98
            Top = 0
            Width = 97
            Height = 14
            Caption = 'Lote Broker'
            DataField = 'LOT_BROKER'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
        object pnlCroDoc: TPanel
          Left = 0
          Top = 382
          Width = 638
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 13
          object dbeCroDoc: TDBCheckBox
            Left = 98
            Top = 0
            Width = 147
            Height = 14
            Caption = 'Lote Crossdocking'
            DataField = 'LOT_CRODOC'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dbeCroDocClick
          end
        end
        object pnlCodbar: TPanel
          Left = 0
          Top = 0
          Width = 638
          Height = 26
          Align = alTop
          BevelOuter = bvNone
          Caption = 'pnlCodbar'
          ParentColor = True
          TabOrder = 20
          object lblCodbar: TLabel
            Left = 55
            Top = 8
            Width = 41
            Height = 14
            Alignment = taRightJustify
            Caption = 'Etiqueta:'
          end
          object edtCodbar: TEditFocus
            Tag = 99
            Left = 98
            Top = 4
            Width = 529
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 0
            OnEnter = edtCodbarEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlArmLotOrPedVen: TPanel
          Left = 0
          Top = 305
          Width = 638
          Height = 14
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 8
          object chkArmOPV: TDBCheckBox
            Left = 98
            Top = 0
            Width = 423
            Height = 14
            Caption = 
              'Armaz'#233'm/Lote Principal para vendas no Or'#231'amento/Pedido/Venda Nor' +
              'mal/Brindes'
            DataField = 'LOT_ARMOPV'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkArmOPVClick
          end
        end
        object pnlPrincipalParaAluguelDeEquipamentos: TPanel
          Left = 0
          Top = 334
          Width = 638
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 10
          object chkEqpPri: TDBCheckBox
            Left = 98
            Top = 2
            Width = 265
            Height = 14
            Caption = 'Armazem principal para Aluguel de Equipamentos'
            DataField = 'LOT_EQPPRI'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkPriTinClick
          end
        end
        object pnlArmPce: TPanel
          Left = 0
          Top = 414
          Width = 638
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 15
          object chkArmPce: TDBCheckBox
            Left = 98
            Top = 0
            Width = 398
            Height = 14
            Caption = 'Armaz'#233'm principal para conserto de equipamentos'
            DataField = 'LOT_ARMPCE'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkArmPceClick
          end
        end
        object grpChapas: TGroupBox
          Left = 0
          Top = 463
          Width = 638
          Height = 90
          Align = alBottom
          Caption = 'Dados da Chapa'
          TabOrder = 19
          DesignSize = (
            638
            90)
          object lblChapa: TLabel
            Left = 72
            Top = 17
            Width = 34
            Height = 14
            Alignment = taRightJustify
            Caption = 'Chapa:'
          end
          object Label6: TLabel
            Left = 12
            Top = 40
            Width = 94
            Height = 14
            Alignment = taRightJustify
            Caption = 'Medida Bruta(LxA):'
          end
          object Label7: TLabel
            Left = 4
            Top = 63
            Width = 102
            Height = 14
            Alignment = taRightJustify
            Caption = 'Medida L'#237'quida(LxA):'
          end
          object Label14: TLabel
            Left = 336
            Top = 18
            Width = 55
            Height = 14
            Alignment = taRightJustify
            Caption = 'Espessura:'
          end
          object Label15: TLabel
            Left = 200
            Top = 40
            Width = 7
            Height = 14
            Alignment = taRightJustify
            Caption = 'X'
          end
          object Label16: TLabel
            Left = 200
            Top = 63
            Width = 7
            Height = 14
            Alignment = taRightJustify
            Caption = 'X'
          end
          object Label18: TLabel
            Left = 316
            Top = 41
            Width = 75
            Height = 14
            Alignment = taRightJustify
            Caption = 'Qtd. M'#178' L'#237'quido:'
          end
          object edtLOT_NCHAPA: TEditFocus
            Left = 108
            Top = 13
            Width = 88
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtLOT_MEDB_L: TEditFocus
            Left = 108
            Top = 36
            Width = 88
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtLOT_ESPESS: TEditFocus
            Left = 393
            Top = 14
            Width = 88
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtLOT_MEDL_L: TEditFocus
            Left = 108
            Top = 59
            Width = 88
            Height = 22
            TabStop = False
            Alignment = taRightJustify
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
          object edtLOT_MEDL_A: TEditFocus
            Left = 211
            Top = 59
            Width = 88
            Height = 22
            TabStop = False
            Alignment = taRightJustify
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
          object edtLOT_MEDB_A: TEditFocus
            Left = 211
            Top = 36
            Width = 88
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtValM2Liquido: TEditFocus
            Left = 393
            Top = 37
            Width = 88
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            ReadOnly = True
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object btnImprimirEtiquetas: TBitBtnLocked
            Left = 338
            Top = 65
            Width = 196
            Height = 22
            Anchors = [akTop, akRight]
            Caption = 'Reimprimir Etiquetas Chapas'
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
            TabOrder = 7
            OnClick = btnImprimirEtiquetasClick
          end
          object btnDividirChapa: TBitBtnLocked
            Left = 535
            Top = 65
            Width = 100
            Height = 22
            Anchors = [akTop, akRight]
            Caption = 'Dividir Chapa'
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000080000
              000C0000000D0000000D0000000D0000000D0000000D0000000D0000000D0000
              000E0000000E0000000E0000000E0000000E0000000D000000097B5A50BFAB7D
              6FFFAA7D6FFFAA7C6FFFAA7C6EFFAA7C6DFFA97B6DFFA97B6DFFA87B6DFFA97A
              6CFFA97A6CFFA8796CFFA87A6BFFA7796BFFA8786AFF78564CC0AC8072FFF9F2
              EEFFF9F3EEFFF9F1EEFFF9F1EEFFCFB2A8FFF9F1EEFFF8F1EEFFF8F2EEFFF8F1
              EDFFCEB0A6FFF9F1EDFFF9F2EDFFF9F1EDFFF9F1EEFFA87A6CFFAE8274FFF9F3
              F0FFF7EFEAFFF7EFEAFFF8F2EEFFD2B7AFFFF9F2EFFFF9F2EFFFF9F3EFFFF9F3
              EFFFD1B7AEFFF8F3EFFFF8F3EFFFF9F3EEFFFAF5F2FFBE9B91FFAF8375FFD3B8
              B0FFC5A399FFC5A298FFD3B9B1FF2B8758FF2B8758FF2A8658FF2A8657FF2A84
              58FF2A8457FF298456FF298357FF298254FF298256FF298254FFB18578FFFAF4
              F0FFF8F0EBFFF7F0EBFFF9F3F0FF2C895BFF71DBBDFF71DBBDFF71DBBDFF71DB
              BCFF71DBBDFF71DBBCFF70DBBCFF70DBBCFF70DBBCFF298455FFB28779FFF9F5
              F1FFF8F0ECFFF8F1EBFFFAF4F1FF2E8B5DFF72DCBDFF58D0A7FF56D0A6FF56CF
              A5FF56CFA5FF56CFA4FF56CFA4FF55CFA5FF71DBBDFF2B8758FFB4887CFFD8C0
              B8FFC8A79DFFC8A79DFFD5BCB4FF2E8E5EFF73DCBEFF59D1A8FF59D0A8FF59D1
              A7FF59D0A8FF58D0A7FF59D0A7FF58D0A7FF72DCBDFF2C885AFFB48A7EFFFAF5
              F3FFF8F2EDFFF8F1EDFFFAF4F1FF2F9062FF74DDBFFF5CD2A9FF5BD1A9FF5BD1
              AAFF5BD1A9FF5BD1A9FF5BD1A8FF5AD1A9FF73DCBEFF2E8A5CFFB68D7FFFFAF6
              F3FFF9F2EDFFF9F2EDFFFAF4F1FF309264FF75DDC0FF75DDC0FF75DDC0FF74DD
              C0FF74DDC0FF74DCC0FF74DCBFFF74DDBFFF74DCBFFF2E8D5EFFB78E81FFDDC6
              BFFFCBABA2FFCBACA2FFD7C0B8FF329566FF339366FF329265FF309265FF3292
              64FF329164FF309163FF2F9062FF2F9062FF2F8F60FF2E8F60FFB88F82FFFAF7
              F4FFF8F3EFFFF8F2EEFFF9F4F1FFD8C0B9FFFAF6F2FFFAF5F3FFFAF5F2FFFAF5
              F2FFD7C0B8FFFAF6F2FFFAF5F2FFFAF5F2FFFCF8F6FFC7A79DFFB99085FFFBF8
              F5FFFAF8F5FFFBF8F4FFFBF6F4FFDFCAC3FFFBF6F5FFFBF7F4FFFBF7F4FFFBF6
              F4FFDDC8C1FFFAF6F4FFFBF7F5FFFBF6F5FFFBF7F5FFB68C80FF8A6C63C0BA91
              85FFBA9185FFBA9185FFBA9084FFB99185FFB99084FFB99084FFB99084FFB990
              83FFB89083FFB98F83FFB78F83FFB88E82FFB78E82FF876960C1000000030000
              0004000000050000000500000005000000050000000500000005000000050000
              0005000000050000000500000006000000060000000500000004}
            TabOrder = 8
            OnClick = btnDividirChapaClick
          end
        end
        object pnlArmFul: TPanel
          Left = 0
          Top = 430
          Width = 638
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 16
          object chkArmFul: TDBCheckBox
            Left = 98
            Top = -1
            Width = 539
            Height = 17
            Caption = 
              'Armaz'#233'm/Lote Principal para vendas de sub-produtos no Fulfillmen' +
              't (Quando vende item estrutura no Ful)'
            DataField = 'LOT_ARMFUL'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            Visible = False
          end
        end
        object pnlPriInd: TPanel
          Left = 0
          Top = 446
          Width = 638
          Height = 16
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 21
          object chkLotPriInd: TDBCheckBox
            Left = 98
            Top = 1
            Width = 398
            Height = 14
            Caption = 'Armaz'#233'm/Lote principal para Ordem de Produ'#231#227'o Industrial'
            DataField = 'LOT_PRIIND'
            DataSource = dtsCadLot
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = chkLotPriIndClick
          end
        end
      end
    end
    object tbsPreVen: TTabSheet
      Caption = 'Pre'#231'o para Venda'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 540
      object pnlCtlLote: TPanel
        Left = 0
        Top = 0
        Width = 638
        Height = 401
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object grbPrecoVendaParcial: TGroupBox
          Left = 74
          Top = 0
          Width = 240
          Height = 369
          Caption = 'Pre'#231'o para venda parcial do lote'
          TabOrder = 0
          object pnlPreCusParcial: TPanel
            Left = 2
            Top = 16
            Width = 236
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            DesignSize = (
              236
              23)
            object lblPreCus: TLabel
              Left = 7
              Top = 5
              Width = 77
              Height = 14
              Alignment = taRightJustify
              Caption = 'Pre'#231'o de Custo:'
            end
            object dbePreCus: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_PRECUS'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda1Parcial: TPanel
            Left = 2
            Top = 39
            Width = 236
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 1
            DesignSize = (
              236
              23)
            object lblPreVe1: TLabel
              Left = 7
              Top = 5
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 1:'
            end
            object dbePreVe1: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_PREVE1'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda2Parcial: TPanel
            Left = 2
            Top = 62
            Width = 236
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 2
            DesignSize = (
              236
              23)
            object lblPreVe2: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 2:'
            end
            object dbePreVe2: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_PREVE2'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda3Parcial: TPanel
            Left = 2
            Top = 85
            Width = 236
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 3
            DesignSize = (
              236
              23)
            object lblPreVe3: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 3:'
            end
            object dbePreVe3: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_PREVE3'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda4Parcial: TPanel
            Left = 2
            Top = 108
            Width = 236
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 4
            DesignSize = (
              236
              23)
            object lblPreVe4: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 4:'
            end
            object dbePreVe4: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_PREVE4'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda5Parcial: TPanel
            Left = 2
            Top = 131
            Width = 236
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 5
            DesignSize = (
              236
              23)
            object lblPreVe5: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 5:'
            end
            object dbePreVe5: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_PREVE5'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda6Parcial: TPanel
            Left = 2
            Top = 154
            Width = 236
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 6
            DesignSize = (
              236
              23)
            object lblPreVe6: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 6:'
            end
            object dbePreVe6: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_PREVE6'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda7Parcial: TPanel
            Left = 2
            Top = 177
            Width = 236
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 7
            DesignSize = (
              236
              23)
            object lblPreVe7: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 7:'
            end
            object dbePreVe7: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_PREVE7'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPrecoVendaParcialEntrega: TPanel
            Left = 2
            Top = 200
            Width = 236
            Height = 167
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 8
            Visible = False
            object pnlPreVendaEnt6Parcial: TPanel
              Left = 0
              Top = 115
              Width = 236
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 5
              DesignSize = (
                236
                23)
              object lblPrVeE6: TLabel
                Left = 7
                Top = 5
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 6:'
              end
              object dbePrVeE6: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_PRVEE6'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt7Parcial: TPanel
              Left = 0
              Top = 138
              Width = 236
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 6
              DesignSize = (
                236
                23)
              object lblPrVeE7: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 7:'
              end
              object dbePrVeE7: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_PRVEE7'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt1Parcial: TPanel
              Left = 0
              Top = 0
              Width = 236
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 0
              DesignSize = (
                236
                23)
              object lblPrVeE1: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 1:'
              end
              object dbePrVeE1: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_PRVEE1'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt2Parcial: TPanel
              Left = 0
              Top = 23
              Width = 236
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 1
              DesignSize = (
                236
                23)
              object lblPrVeE2: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 2:'
              end
              object dbePrVeE2: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_PRVEE2'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt3Parcial: TPanel
              Left = 0
              Top = 46
              Width = 236
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 2
              DesignSize = (
                236
                23)
              object lblPrVeE3: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 3:'
              end
              object dbePrVeE3: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_PRVEE3'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt4Parcial: TPanel
              Left = 0
              Top = 69
              Width = 236
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 3
              DesignSize = (
                236
                23)
              object lblPrVeE4: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 4:'
              end
              object dbePrVeE4: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_PRVEE4'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt5Parcial: TPanel
              Left = 0
              Top = 92
              Width = 236
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 4
              DesignSize = (
                236
                23)
              object lblPrVeE5: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 5:'
              end
              object dbePrVeE5: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_PRVEE5'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
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
        end
        object grbPrecoVendaTotal: TGroupBox
          Left = 320
          Top = 0
          Width = 239
          Height = 369
          Caption = 'Pre'#231'o para venda total do lote'
          TabOrder = 1
          object pnlPrecoVendaTotalEntrega: TPanel
            Left = 2
            Top = 200
            Width = 235
            Height = 167
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 8
            Visible = False
            object pnlPreVendaEnt6Total: TPanel
              Left = 0
              Top = 115
              Width = 235
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 5
              DesignSize = (
                235
                23)
              object lblVeToE6: TLabel
                Left = 7
                Top = 5
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 6:'
              end
              object dbeVeToE6: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_VETOE6'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt7Total: TPanel
              Left = 0
              Top = 138
              Width = 235
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 6
              DesignSize = (
                235
                23)
              object lblVeToE7: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 7:'
              end
              object dbeVeToE7: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_VETOE7'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt1Total: TPanel
              Left = 0
              Top = 0
              Width = 235
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 0
              DesignSize = (
                235
                23)
              object lblVeToE1: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 1:'
              end
              object dbeVeToE1: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_VETOE1'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt2Total: TPanel
              Left = 0
              Top = 23
              Width = 235
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 1
              DesignSize = (
                235
                23)
              object lblVeToE2: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 2:'
              end
              object dbeVeToE2: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_VETOE2'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt3Total: TPanel
              Left = 0
              Top = 46
              Width = 235
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 2
              DesignSize = (
                235
                23)
              object lblVeToE3: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 3:'
              end
              object dbeVeToE3: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_VETOE3'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt4Total: TPanel
              Left = 0
              Top = 69
              Width = 235
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 3
              DesignSize = (
                235
                23)
              object lblVeToE4: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 4:'
              end
              object dbeVeToE4: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_VETOE4'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
                TabOrder = 0
                NormalColor = clWindow
                FocusColor = clInfoBk
                RequeridoColor = clRed
                Requerido = False
                CompZeros = False
                TipoTexto = ttAlfanumerico
              end
            end
            object pnlPreVendaEnt5Total: TPanel
              Left = 0
              Top = 92
              Width = 235
              Height = 23
              Align = alTop
              BevelOuter = bvNone
              Color = 16770261
              ParentBackground = False
              TabOrder = 4
              DesignSize = (
                235
                23)
              object lblVeToE5: TLabel
                Left = 7
                Top = 4
                Width = 136
                Height = 14
                Caption = 'Pre'#231'o de Venda - Entrega 5:'
              end
              object dbeVeToE5: TDBEditFocus
                Tag = 99
                Left = 143
                Top = 1
                Width = 89
                Height = 22
                Anchors = [akTop, akRight]
                CharCase = ecUpperCase
                Ctl3D = True
                DataField = 'LOT_VETOE5'
                DataSource = dtsCadLot
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ImeName = 'Portugu'#234's (Brasil ABNT)'
                ParentCtl3D = False
                ParentFont = False
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
          object pnlPreVenda7Total: TPanel
            Left = 2
            Top = 177
            Width = 235
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 7
            DesignSize = (
              235
              23)
            object lblVenTo7: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 7:'
            end
            object dbeVenTo7: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_VENTO7'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda6Total: TPanel
            Left = 2
            Top = 154
            Width = 235
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 6
            DesignSize = (
              235
              23)
            object lblVenTo6: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 6:'
            end
            object dbeVenTo6: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_VENTO6'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda5Total: TPanel
            Left = 2
            Top = 131
            Width = 235
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 5
            DesignSize = (
              235
              23)
            object lblVenTo5: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 5:'
            end
            object dbeVenTo5: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_VENTO5'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda4Total: TPanel
            Left = 2
            Top = 108
            Width = 235
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 4
            DesignSize = (
              235
              23)
            object lblVenTo4: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 4:'
            end
            object dbeVenTo4: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_VENTO4'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda3Total: TPanel
            Left = 2
            Top = 85
            Width = 235
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 3
            DesignSize = (
              235
              23)
            object lblVenTo3: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 3:'
            end
            object dbeVenTo3: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_VENTO3'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda2Total: TPanel
            Left = 2
            Top = 62
            Width = 235
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 2
            DesignSize = (
              235
              23)
            object lblVenTo2: TLabel
              Left = 7
              Top = 4
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 2:'
            end
            object dbeVenTo2: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_VENTO2'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreVenda1Total: TPanel
            Left = 2
            Top = 39
            Width = 235
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 1
            DesignSize = (
              235
              23)
            object lblVenTo1: TLabel
              Left = 7
              Top = 5
              Width = 127
              Height = 14
              Caption = 'Pre'#231'o de Venda - Retira 1:'
            end
            object dbeVenTo1: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_VENTO1'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfanumerico
            end
          end
          object pnlPreCusTotal: TPanel
            Left = 2
            Top = 16
            Width = 235
            Height = 23
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            DesignSize = (
              235
              23)
            object lblCusTot: TLabel
              Left = 7
              Top = 6
              Width = 77
              Height = 14
              Alignment = taRightJustify
              Caption = 'Pre'#231'o de Custo:'
            end
            object dbeCusTot: TDBEditFocus
              Tag = 99
              Left = 143
              Top = 1
              Width = 89
              Height = 22
              Anchors = [akTop, akRight]
              CharCase = ecUpperCase
              Ctl3D = True
              DataField = 'LOT_CUSTOT'
              DataSource = dtsCadLot
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ParentFont = False
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
        object Panel1: TPanel
          Left = 0
          Top = 380
          Width = 638
          Height = 21
          Align = alBottom
          BevelOuter = bvNone
          Caption = 
            'Informar zero no pre'#231'o de custo e pre'#231'o de venda quando desejar ' +
            'utilizar os pre'#231'os do cadastro de produtos'
          Color = clInfoBk
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
          StyleElements = [seBorder]
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 368
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 544
    Top = 368
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 572
    Top = 276
  end
  object dtsCadLot: TDataSource
    Left = 512
    Top = 368
  end
  object qryCadLot: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM CADLOT')
    Left = 576
    Top = 368
    object qryCadLotAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
      Required = True
    end
    object qryCadLotLOT_NUMLOT: TStringField
      FieldName = 'LOT_NUMLOT'
      Required = True
    end
    object qryCadLotLOT_CODEMP: TStringField
      FieldName = 'LOT_CODEMP'
      Required = True
      Size = 3
    end
    object qryCadLotLOT_CODITE: TStringField
      FieldName = 'LOT_CODITE'
      Required = True
      Size = 5
    end
    object qryCadLotLOT_DTAFAB: TDateField
      FieldName = 'LOT_DTAFAB'
      OnSetText = qryCadLotLOT_DTAFABSetText
    end
    object qryCadLotLOT_DTAVAL: TDateField
      FieldName = 'LOT_DTAVAL'
      OnSetText = qryCadLotLOT_DTAVALSetText
    end
    object qryCadLotLOT_DTABAL: TDateField
      FieldName = 'LOT_DTABAL'
    end
    object qryCadLotLOT_SALBAL: TFloatField
      FieldName = 'LOT_SALBAL'
    end
    object qryCadLotLOT_SALDOS: TFloatField
      FieldName = 'LOT_SALDOS'
    end
    object qryCadLotLOT_PRECUS: TFloatField
      FieldName = 'LOT_PRECUS'
    end
    object qryCadLotLOT_PREVEN: TFloatField
      FieldName = 'LOT_PREVEN'
    end
    object qryCadLotLOT_LOCFIS: TStringField
      FieldName = 'LOT_LOCFIS'
      Size = 10
    end
    object qryCadLotLOT_CUSTOT: TFloatField
      FieldName = 'LOT_CUSTOT'
    end
    object qryCadLotLOT_VENTOT: TFloatField
      FieldName = 'LOT_VENTOT'
    end
    object qryCadLotLOT_CAPACI: TFloatField
      FieldName = 'LOT_CAPACI'
    end
    object qryCadLotLOT_PONREP: TFloatField
      FieldName = 'LOT_PONREP'
    end
    object qryCadLotLOT_ARMPRI: TStringField
      FieldName = 'LOT_ARMPRI'
    end
    object qryCadLotLOT_ARMOPV: TStringField
      FieldName = 'LOT_ARMOPV'
    end
    object qryCadLotLOT_STATUS: TStringField
      FieldName = 'LOT_STATUS'
      Size = 1
    end
    object qryCadLotLOT_ARMPRC: TStringField
      FieldName = 'LOT_ARMPRC'
      Size = 1
    end
    object qryCadLotLOT_VENTDO: TStringField
      FieldName = 'LOT_VENTDO'
      Size = 1
    end
    object qryCadLotLOT_GARPRI: TStringField
      FieldName = 'LOT_GARPRI'
      Size = 1
    end
    object qryCadLotLOT_PRIPRO: TStringField
      FieldName = 'LOT_PRIPRO'
      Size = 1
    end
    object qryCadLotLOT_LOCSEP: TStringField
      FieldName = 'LOT_LOCSEP'
      Size = 10
    end
    object qryCadLotLOT_PRITIN: TStringField
      FieldName = 'LOT_PRITIN'
      Size = 1
    end
    object qryCadLotLOT_SAL_ML: TFloatField
      FieldName = 'LOT_SAL_ML'
    end
    object qryCadLotLOT_ML_BAL: TFloatField
      FieldName = 'LOT_ML_BAL'
    end
    object qryCadLotLOT_ABSAUT: TStringField
      FieldName = 'LOT_ABSAUT'
      Size = 1
    end
    object qryCadLotLOT_LOTAPR: TStringField
      FieldName = 'LOT_LOTAPR'
      Size = 1
    end
    object qryCadLotLOT_MOTBLO: TStringField
      FieldName = 'LOT_MOTBLO'
      Size = 255
    end
    object qryCadLotLOT_BROKER: TStringField
      FieldName = 'LOT_BROKER'
      Size = 1
    end
    object qryCadLotLOT_CRODOC: TStringField
      FieldName = 'LOT_CRODOC'
    end
    object qryCadLotLOT_EQPPRI: TStringField
      FieldName = 'LOT_EQPPRI'
      Size = 1
    end
    object qryCadLotLOT_ARMPCE: TStringField
      FieldName = 'LOT_ARMPCE'
      Size = 1
    end
    object qryCadLotLOT_CHAPA_: TStringField
      FieldName = 'LOT_CHAPA_'
      FixedChar = True
      Size = 1
    end
    object qryCadLotLOT_NCHAPA: TIntegerField
      FieldName = 'LOT_NCHAPA'
    end
    object qryCadLotLOT_MEDB_L: TFloatField
      FieldName = 'LOT_MEDB_L'
    end
    object qryCadLotLOT_MEDB_A: TFloatField
      FieldName = 'LOT_MEDB_A'
    end
    object qryCadLotLOT_MEDL_L: TFloatField
      FieldName = 'LOT_MEDL_L'
    end
    object qryCadLotLOT_MEDL_A: TFloatField
      FieldName = 'LOT_MEDL_A'
    end
    object qryCadLotLOT_ESPESS: TFloatField
      FieldName = 'LOT_ESPESS'
    end
    object qryCadLotLOT_PREVEE: TFloatField
      FieldName = 'LOT_PREVEE'
    end
    object qryCadLotLOT_VENTOE: TFloatField
      FieldName = 'LOT_VENTOE'
    end
    object qryCadLotLOT_ARMFUL: TStringField
      FieldName = 'LOT_ARMFUL'
      Size = 1
    end
    object qryCadLotLOT_CODBAR: TStringField
      FieldName = 'LOT_CODBAR'
    end
    object qryCadLotLOT_PREVE1: TFloatField
      FieldName = 'LOT_PREVE1'
    end
    object qryCadLotLOT_PREVE2: TFloatField
      FieldName = 'LOT_PREVE2'
    end
    object qryCadLotLOT_PREVE3: TFloatField
      FieldName = 'LOT_PREVE3'
    end
    object qryCadLotLOT_PREVE4: TFloatField
      FieldName = 'LOT_PREVE4'
    end
    object qryCadLotLOT_PREVE5: TFloatField
      FieldName = 'LOT_PREVE5'
    end
    object qryCadLotLOT_PREVE6: TFloatField
      FieldName = 'LOT_PREVE6'
    end
    object qryCadLotLOT_PREVE7: TFloatField
      FieldName = 'LOT_PREVE7'
    end
    object qryCadLotLOT_PRVEE1: TFloatField
      FieldName = 'LOT_PRVEE1'
    end
    object qryCadLotLOT_PRVEE2: TFloatField
      FieldName = 'LOT_PRVEE2'
    end
    object qryCadLotLOT_PRVEE3: TFloatField
      FieldName = 'LOT_PRVEE3'
    end
    object qryCadLotLOT_PRVEE4: TFloatField
      FieldName = 'LOT_PRVEE4'
    end
    object qryCadLotLOT_PRVEE5: TFloatField
      FieldName = 'LOT_PRVEE5'
    end
    object qryCadLotLOT_PRVEE6: TFloatField
      FieldName = 'LOT_PRVEE6'
    end
    object qryCadLotLOT_PRVEE7: TFloatField
      FieldName = 'LOT_PRVEE7'
    end
    object qryCadLotLOT_VENTO1: TFloatField
      FieldName = 'LOT_VENTO1'
    end
    object qryCadLotLOT_VENTO2: TFloatField
      FieldName = 'LOT_VENTO2'
    end
    object qryCadLotLOT_VENTO3: TFloatField
      FieldName = 'LOT_VENTO3'
    end
    object qryCadLotLOT_VENTO4: TFloatField
      FieldName = 'LOT_VENTO4'
    end
    object qryCadLotLOT_VENTO5: TFloatField
      FieldName = 'LOT_VENTO5'
    end
    object qryCadLotLOT_VENTO6: TFloatField
      FieldName = 'LOT_VENTO6'
    end
    object qryCadLotLOT_VENTO7: TFloatField
      FieldName = 'LOT_VENTO7'
    end
    object qryCadLotLOT_VETOE1: TFloatField
      FieldName = 'LOT_VETOE1'
    end
    object qryCadLotLOT_VETOE2: TFloatField
      FieldName = 'LOT_VETOE2'
    end
    object qryCadLotLOT_VETOE3: TFloatField
      FieldName = 'LOT_VETOE3'
    end
    object qryCadLotLOT_VETOE4: TFloatField
      FieldName = 'LOT_VETOE4'
    end
    object qryCadLotLOT_VETOE5: TFloatField
      FieldName = 'LOT_VETOE5'
    end
    object qryCadLotLOT_VETOE6: TFloatField
      FieldName = 'LOT_VETOE6'
    end
    object qryCadLotLOT_VETOE7: TFloatField
      FieldName = 'LOT_VETOE7'
    end
    object qryCadLotLOT_TRANSI: TStringField
      FieldName = 'LOT_TRANSI'
      Size = 1
    end
    object qryCadLotLOT_OPELLA: TStringField
      FieldName = 'LOT_OPELLA'
    end
    object qryCadLotLOT_PRIIND: TStringField
      FieldName = 'LOT_PRIIND'
      Size = 1
    end
  end
end
