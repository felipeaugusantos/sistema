inherited frmCadCheques: TfrmCadCheques
  Left = 242
  Top = 93
  Width = 630
  Height = 720
  VertScrollBar.Range = 71
  Caption = 'Manuten'#231#227'o de Cheque'
  OnDestroy = FormDestroy
  ExplicitWidth = 630
  ExplicitHeight = 720
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 632
    Width = 624
    Height = 43
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    BevelInner = bvNone
    ExplicitTop = 632
    ExplicitWidth = 624
    ExplicitHeight = 43
    inherited FlwBotoes: TFlowPanel
      Left = 1
      Top = 1
      Width = 624
      Height = 41
      Align = alLeft
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 624
      ExplicitHeight = 41
      inherited btnIncluir: TBitBtnLocked
        Width = 102
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ExplicitWidth = 102
      end
      inherited btnGravar: TBitBtnLocked
        Left = 102
        Width = 102
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ExplicitLeft = 102
        ExplicitWidth = 102
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 204
        Width = 102
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ExplicitLeft = 204
        ExplicitWidth = 102
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 306
        Width = 102
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ExplicitLeft = 306
        ExplicitWidth = 102
      end
      inherited btnCancela: TBitBtnLocked
        Left = 408
        Width = 102
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ExplicitLeft = 408
        ExplicitWidth = 102
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 510
        Width = 105
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        ExplicitLeft = 510
        ExplicitWidth = 105
      end
      object btnImprimir: TBitBtnLocked
        Left = 0
        Top = 20
        Width = 102
        Height = 20
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = 'Comprovante'
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
      object btnDepositoCheque: TBitBtnLocked
        Left = 102
        Top = 20
        Width = 102
        Height = 20
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = '&Dep.Cheques'
        TabOrder = 7
        OnClick = btnDepositoChequeClick
      end
      object btnHistRecebLOG: TBitBtnLocked
        Left = 204
        Top = 20
        Width = 204
        Height = 20
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = '&Hist. Documento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
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
        ParentFont = False
        TabOrder = 8
        OnClick = btnHistRecebLOGClick
      end
      object btnCancelaDeposito: TBitBtnLocked
        Left = 408
        Top = 20
        Width = 102
        Height = 20
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Anchors = [akRight, akBottom]
        Caption = '&Cancelar Dep.'
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 9
        OnClick = btnCancelaDepositoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 511
      Top = 21
      Width = 105
      Margins.Left = 0
      Margins.Top = 20
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alCustom
      TabOrder = 1
      ExplicitLeft = 511
      ExplicitTop = 21
      ExplicitWidth = 105
    end
  end
  inherited pnlStatus: TPanel
    Top = 675
    Width = 624
    ExplicitTop = 675
    ExplicitWidth = 624
    inherited pnlNomeForm: TPanel
      Left = 463
      Width = 161
      ExplicitLeft = 463
      ExplicitWidth = 161
    end
    inherited pnlInfo: TPanel
      Width = 463
      ExplicitWidth = 463
    end
  end
  inherited pgcDados: TPageControl
    Width = 624
    Height = 586
    TabOrder = 3
    OnChange = pgcDadosChange
    ExplicitWidth = 624
    ExplicitHeight = 586
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 616
      ExplicitHeight = 554
      object pnlDados1: TPanel
        Left = 0
        Top = 50
        Width = 616
        Height = 50
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object Label1: TLabel
          Left = 49
          Top = 6
          Width = 34
          Height = 14
          Alignment = taRightJustify
          Caption = 'Banco:'
        end
        object Label2: TLabel
          Left = 504
          Top = 6
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ag'#234'ncia:'
        end
        object Label3: TLabel
          Left = 16
          Top = 28
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cta. Corrente:'
        end
        object Label4: TLabel
          Left = 180
          Top = 28
          Width = 78
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nro. do Cheque:'
        end
        object lblCMC7: TLabel
          Left = 353
          Top = 28
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'CMC7:'
        end
        object dbeNumAge: TDBEditFocus
          Tag = 99
          Left = 549
          Top = 2
          Width = 55
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_NUMAGE'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeConCor: TDBEditFocus
          Tag = 99
          Left = 85
          Top = 24
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_CONCOR'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeNumChq: TDBEditFocus
          Tag = 99
          Left = 260
          Top = 24
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_NUMCHQ'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtNomBan: TEditFocus
          Left = 129
          Top = 2
          Width = 364
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
        object dbeCodCmc: TDBEditFocus
          Tag = 99
          Left = 386
          Top = 24
          Width = 218
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_CODCMC'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodBco: TDBEditFocus
          Tag = 99
          Left = 85
          Top = 2
          Width = 42
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_CODBCO'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnKeyPress = dbeCodBcoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
          OnChamaCadastro = dbeCodBcoChamaCadastro
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 100
        Width = 616
        Height = 95
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object Label5: TLabel
          Left = 48
          Top = 5
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cliente:'
        end
        object dbeCodCli: TDBEditFocus
          Tag = 99
          Left = 85
          Top = 1
          Width = 71
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_CODCLI'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnEnter = dbeCodCliEnter
          OnKeyPress = dbeCodCliKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
          OnChamaCadastro = dbeCodCliChamaCadastro
        end
        object edtNomCli: TEditFocus
          Left = 156
          Top = 1
          Width = 448
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
        object grpEmitente: TGroupBox
          Left = 17
          Top = 25
          Width = 587
          Height = 65
          Caption = 'Dados do Emitente:'
          TabOrder = 2
          object Label6: TLabel
            Left = 31
            Top = 41
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'Endere'#231'o:'
          end
          object Label8: TLabel
            Left = 391
            Top = 42
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Telefone:'
          end
          object Label7: TLabel
            Left = 228
            Top = 20
            Width = 30
            Height = 14
            Alignment = taRightJustify
            Caption = 'Nome:'
          end
          object LabelCgcCpf1: TLabelCgcCpf
            Left = 6
            Top = 20
            Width = 74
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = '1-CNPJ/2-CPF:'
            Pais = opcBrasil
          end
          object dbeEndere: TDBEditFocus
            Tag = 99
            Left = 82
            Top = 38
            Width = 305
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CHQ_ENDERE'
            DataSource = dtsTabela
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeTelEmi: TDBEditFocus
            Tag = 99
            Left = 435
            Top = 38
            Width = 146
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CHQ_TELEMI'
            DataSource = dtsTabela
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeNomEmi: TDBEditFocus
            Tag = 99
            Left = 262
            Top = 16
            Width = 319
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CHQ_NOMEMI'
            DataSource = dtsTabela
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeNumCgc: TDBEditCgcCpf
            Tag = 99
            Left = 103
            Top = 16
            Width = 119
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CHQ_C_G_C_'
            DataSource = dtsTabela
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 1
            OnChange = dbeNumCgcChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
            Tipo = C_G_C_
          end
          object dbeCgcCpf: TDBEditTipoCgcCpf
            Tag = 99
            Left = 82
            Top = 16
            Width = 22
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CHQ_CGCCPF'
            DataSource = dtsTabela
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 1
            ParentFont = False
            TabOrder = 0
            OnExit = dbeCgcCpfExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 195
        Width = 616
        Height = 190
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 3
        object Label10: TLabel
          Left = 31
          Top = 30
          Width = 72
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Cadastro:'
        end
        object Label11: TLabel
          Left = 456
          Top = 30
          Width = 28
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor:'
        end
        object Label12: TLabel
          Left = 58
          Top = 119
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Hist'#243'rico:'
        end
        object Label13: TLabel
          Left = 196
          Top = 30
          Width = 59
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vencimento:'
        end
        object lblNumNot: TLabel
          Left = 40
          Top = 52
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nro. da Nota:'
        end
        object Label32: TLabel
          Left = 398
          Top = 52
          Width = 86
          Height = 14
          Alignment = taRightJustify
          Caption = 'Telecheque (S/N):'
        end
        object Label33: TLabel
          Left = 508
          Top = 52
          Width = 63
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'd.Acesso:'
        end
        object Label34: TLabel
          Left = 56
          Top = 8
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Digitador:'
        end
        object Label14: TLabel
          Left = 72
          Top = 97
          Width = 31
          Height = 14
          Alignment = taRightJustify
          Caption = 'Pra'#231'a:'
        end
        object Label28: TLabel
          Left = 541
          Top = 96
          Width = 4
          Height = 14
          Alignment = taRightJustify
          Caption = '-'
        end
        object dbeValChq: TDBEditFocus
          Tag = 99
          Left = 486
          Top = 26
          Width = 118
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_VALCHQ'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaCad: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 26
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_DTACAD'
          DataSource = dtsTabela
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
        object dbeHist02: TDBEditFocus
          Tag = 99
          Left = 345
          Top = 115
          Width = 259
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_HIST02'
          DataSource = dtsTabela
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
          TipoTexto = ttAlfanumerico
        end
        object dbeHist01: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 115
          Width = 240
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_HIST01'
          DataSource = dtsTabela
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
          TipoTexto = ttAlfanumerico
        end
        object dbeNumNot: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 48
          Width = 88
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_NUMNOT'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaVen: TDBEditFocus
          Tag = 99
          Left = 257
          Top = 26
          Width = 118
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_DTAVEN'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 2
          OnExit = dbeDtaVenExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTelChe: TDBEditFocus
          Tag = 99
          Left = 486
          Top = 48
          Width = 19
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_TELCHE'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 5
          OnExit = dbeTelCheExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeTelNum: TDBEditFocus
          Tag = 99
          Left = 572
          Top = 48
          Width = 32
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_TELNUM'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtDigChq: TEditFocus
          Left = 105
          Top = 4
          Width = 499
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object dbeCodCid: TDBEditFocus
          Tag = 99
          Left = 105
          Top = 93
          Width = 44
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_CODCID'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 8
          OnKeyPress = dbeCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object edtDesCid: TEditFocus
          Left = 150
          Top = 93
          Width = 389
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtEstado: TEditFocus
          Left = 547
          Top = 93
          Width = 57
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object pnlDocume: TPanel
          Left = 4
          Top = 71
          Width = 600
          Height = 22
          BevelOuter = bvNone
          Enabled = False
          ParentColor = True
          TabOrder = 7
          object Label27: TLabel
            Left = 42
            Top = 4
            Width = 57
            Height = 14
            Alignment = taRightJustify
            Caption = 'Documento:'
          end
          object dbeDocume: TDBEditFocus
            Tag = 99
            Left = 101
            Top = 0
            Width = 499
            Height = 22
            CharCase = ecUpperCase
            Color = 16768952
            DataField = 'CHQ_DOCUME'
            DataSource = dtsTabela
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnExit = dbeCgcCpfExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object grbMovBan: TGroupBox
          Left = 10
          Top = 138
          Width = 594
          Height = 46
          Caption = 'Movimento Banc'#225'rio'
          TabOrder = 13
          Visible = False
          object Label9: TLabel
            Left = 12
            Top = 20
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Portador:'
          end
          object dbePorChq: TDBEditFocus
            Tag = 99
            Left = 62
            Top = 17
            Width = 44
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CHQ_PORCHQ'
            DataSource = dtsTabela
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            OnKeyPress = dbePorChqKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttNumerico
          end
          object edtDesPorChq: TEditFocus
            Left = 106
            Top = 17
            Width = 167
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
          inline fraPlanoDeContasMov: TfraPlanoDeContasDBEditFocus
            Left = 301
            Top = 17
            Width = 289
            Height = 22
            TabOrder = 2
            ExplicitLeft = 301
            ExplicitTop = 17
            ExplicitWidth = 289
            inherited lblPlaContas: TLabel
              Left = 1
              Top = 3
              Width = 51
              Height = 14
              Caption = 'Pl. Contas:'
              ExplicitLeft = 1
              ExplicitTop = 3
              ExplicitWidth = 51
              ExplicitHeight = 14
            end
            inherited dbeCodCta: TDBEditFocus
              Left = 58
              Height = 22
              DataField = 'CHQ_CTACHQ'
              DataSource = dtsTabela
              OnKeyPress = fraPlanoDeContasMovdbeCodCtaKeyPress
              PanelInfo = pnlInfo
              ExplicitLeft = 58
              ExplicitHeight = 22
            end
            inherited edtDesCta: TEditFocus
              Left = 113
              Width = 174
              Height = 22
              ExplicitLeft = 113
              ExplicitWidth = 174
              ExplicitHeight = 22
            end
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 405
        Width = 616
        Height = 123
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 5
        object Label15: TLabel
          Left = 16
          Top = 9
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cta. Deposito:'
        end
        object Label16: TLabel
          Left = 13
          Top = 31
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Deposito:'
        end
        object Label17: TLabel
          Left = 16
          Top = 53
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Devol. 1:'
        end
        object Label20: TLabel
          Left = 274
          Top = 53
          Width = 97
          Height = 14
          Alignment = taRightJustify
          Caption = 'Motivo Devolu'#231#227'o 1:'
        end
        object Label21: TLabel
          Left = 282
          Top = 31
          Width = 89
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador da Baixa:'
        end
        object Label29: TLabel
          Left = 10
          Top = 75
          Width = 73
          Height = 14
          Alignment = taRightJustify
          Caption = 'Dt. Redep'#243'sito:'
        end
        object Label30: TLabel
          Left = 16
          Top = 97
          Width = 67
          Height = 14
          Alignment = taRightJustify
          Caption = 'Data Devol. 2:'
        end
        object Label31: TLabel
          Left = 274
          Top = 97
          Width = 97
          Height = 14
          Alignment = taRightJustify
          Caption = 'Motivo Devolu'#231#227'o 2:'
        end
        object lblDupDev: TLabel
          Left = 223
          Top = 75
          Width = 148
          Height = 14
          Alignment = taRightJustify
          Caption = 'Duplicata relativa a Devolu'#231#227'o:'
          Visible = False
        end
        object dbeDtaDev: TDBEditFocus
          Tag = 99
          Left = 85
          Top = 49
          Width = 71
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_DTADEV'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 4
          OnExit = dbeDtaDevExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCtaDep: TDBEditFocus
          Tag = 99
          Left = 85
          Top = 5
          Width = 71
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'CHQ_CTADEP'
          DataSource = dtsTabela
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaDep: TDBEditFocus
          Tag = 99
          Left = 85
          Top = 27
          Width = 71
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'CHQ_DTADEP'
          DataSource = dtsTabela
          Enabled = False
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
        object dbeMotDev: TDBEditFocus
          Tag = 99
          Left = 373
          Top = 49
          Width = 231
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_MOTDEV'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodPor: TDBEditFocus
          Tag = 99
          Left = 373
          Top = 27
          Width = 44
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'CHQ_CODPOR'
          DataSource = dtsTabela
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          PanelInfo = pnlInfo
          TipoTexto = ttAlfanumerico
        end
        object edtNomPor: TEditFocus
          Left = 418
          Top = 27
          Width = 186
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object dbeDtaDp2: TDBEditFocus
          Tag = 99
          Left = 85
          Top = 71
          Width = 71
          Height = 22
          TabStop = False
          CharCase = ecUpperCase
          DataField = 'CHQ_DTADP2'
          DataSource = dtsTabela
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDtaDV2: TDBEditFocus
          Tag = 99
          Left = 85
          Top = 93
          Width = 71
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_DTADV2'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 9
          OnExit = dbeDtaDV2Exit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeMotDv2: TDBEditFocus
          Tag = 99
          Left = 373
          Top = 93
          Width = 231
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_MOTDV2'
          DataSource = dtsTabela
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
        object dbeDevDef: TDBCheckBox
          Left = 162
          Top = 52
          Width = 72
          Height = 17
          Caption = 'Definitiva?'
          TabOrder = 5
          ValueChecked = '1'
          ValueUnchecked = '0'
          OnClick = dbeDevDefClick
          OnExit = dbeDevDefExit
        end
        object dbeDupDev: TDBEditFocus
          Left = 373
          Top = 71
          Width = 231
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CHQ_DUPDEV'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 11
          Visible = False
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        inline fraPlanoDeContasPla: TfraPlanoDeContasDBEditFocus
          Left = 312
          Top = 5
          Width = 293
          Height = 22
          Enabled = False
          TabOrder = 2
          ExplicitLeft = 312
          ExplicitTop = 5
          ExplicitWidth = 293
          inherited lblPlaContas: TLabel
            Left = 4
            Top = 3
            Width = 51
            Height = 14
            Caption = 'Pl. Contas:'
            ExplicitLeft = 4
            ExplicitTop = 3
            ExplicitWidth = 51
            ExplicitHeight = 14
          end
          inherited dbeCodCta: TDBEditFocus
            Left = 61
            Height = 22
            DataField = 'CHQ_CODCTA'
            DataSource = dtsTabela
            ReadOnly = True
            PanelInfo = pnlInfo
            ExplicitLeft = 61
            ExplicitHeight = 22
          end
          inherited edtDesCta: TEditFocus
            Left = 117
            Width = 175
            Height = 22
            ExplicitLeft = 117
            ExplicitWidth = 175
            ExplicitHeight = 22
          end
        end
      end
      object pnlLeitor: TPanel
        Left = 0
        Top = 0
        Width = 616
        Height = 50
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblCheque: TLabel
          Left = 379
          Top = 5
          Width = 172
          Height = 17
          Caption = 'Passe o Cheque desejado'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCheque: TEditFocus
          Tag = 99
          Left = 379
          Top = 21
          Width = 225
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object grbCMC7: TGroupBox
          Left = 8
          Top = 5
          Width = 362
          Height = 40
          Caption = 'C'#243'digo CMC7'
          TabOrder = 1
          object chkLeitor: TCheckBox
            Left = 8
            Top = 17
            Width = 140
            Height = 17
            Caption = 'Leitor de Cheque'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = chkLeitorClick
          end
          object chkInfMan: TCheckBox
            Left = 176
            Top = 17
            Width = 172
            Height = 17
            Caption = 'Informar manualmente'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = chkInfManClick
          end
        end
      end
      object pnlInfos: TPanel
        Left = 0
        Top = 528
        Width = 616
        Height = 26
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 6
        object lblInfo: TcxLabel
          Left = 0
          Top = 2
          AutoSize = False
          Caption = 'lblInfo'
          ParentFont = False
          Style.BorderStyle = ebsNone
          Style.Font.Charset = ANSI_CHARSET
          Style.Font.Color = clBlack
          Style.Font.Height = 14
          Style.Font.Name = 'Arial'
          Style.Font.Pitch = fpVariable
          Style.Font.Style = []
          Style.LookAndFeel.Kind = lfUltraFlat
          Style.TextColor = clRed
          Style.TextStyle = [fsBold]
          Style.IsFontAssigned = True
          StyleDisabled.LookAndFeel.Kind = lfUltraFlat
          StyleFocused.LookAndFeel.Kind = lfUltraFlat
          StyleHot.LookAndFeel.Kind = lfUltraFlat
          Properties.Alignment.Vert = taVCenter
          Properties.LabelStyle = cxlsRaised
          Visible = False
          Height = 27
          Width = 297
          AnchorY = 16
        end
        object pnlTotais: TPanel
          Left = 289
          Top = 0
          Width = 327
          Height = 26
          Align = alRight
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          Visible = False
          object lbl7: TLabel
            Left = 12
            Top = 7
            Width = 66
            Height = 14
            Caption = 'Total Digitado:'
          end
          object lbl8: TLabel
            Left = 179
            Top = 7
            Width = 54
            Height = 14
            Caption = 'Total Geral:'
          end
          object edtTotDig: TEditFocus
            Left = 84
            Top = 3
            Width = 78
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 9
            ReadOnly = True
            TabOrder = 0
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
            EditFormat = '#,##0.00'
          end
          object edtTotGer: TEditFocus
            Left = 239
            Top = 2
            Width = 78
            Height = 22
            TabStop = False
            Alignment = taRightJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 9
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
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
      object Panel4: TPanel
        Left = 0
        Top = 385
        Width = 616
        Height = 20
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 4
        object dbcNaoDep: TDBCheckBox
          Left = 12
          Top = 1
          Width = 91
          Height = 17
          Alignment = taLeftJustify
          Caption = 'N'#227'o Depositar:'
          DataField = 'CHQ_NAODEP'
          DataSource = dtsTabela
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnExit = dbcNaoDepExit
        end
      end
    end
    object tbsRepasse: TTabSheet
      Caption = '&2 - Dados do Repasse'
      ImageIndex = 1
      object Label23: TLabel
        Left = 27
        Top = 18
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object Label24: TLabel
        Left = 454
        Top = 40
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data:'
      end
      object Label25: TLabel
        Left = 23
        Top = 40
        Width = 63
        Height = 14
        Alignment = taRightJustify
        Caption = 'Observa'#231#227'o:'
      end
      object dbeObsRep: TDBEditFocus
        Left = 90
        Top = 36
        Width = 359
        Height = 22
        TabStop = False
        DataField = 'CHQ_OBSREP'
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
      object dbeForRep: TDBEditFocus
        Left = 90
        Top = 14
        Width = 60
        Height = 22
        TabStop = False
        DataField = 'CHQ_FORREP'
        DataSource = dtsTabela
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeDtaRep: TDBEditFocus
        Left = 482
        Top = 36
        Width = 71
        Height = 22
        TabStop = False
        DataField = 'CHQ_DTAREP'
        DataSource = dtsTabela
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtNomFor: TEditFocus
        Left = 150
        Top = 14
        Width = 403
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
    object tbsCustodia: TTabSheet
      Caption = '&3 - Dados da Cust'#243'dia'
      ImageIndex = 2
      object Label22: TLabel
        Left = 43
        Top = 18
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object Label26: TLabel
        Left = 62
        Top = 40
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data:'
      end
      object Label18: TLabel
        Left = 30
        Top = 62
        Width = 57
        Height = 14
        Alignment = taRightJustify
        Caption = 'Documento:'
      end
      object dbeCodPo2: TDBEditFocus
        Left = 90
        Top = 14
        Width = 50
        Height = 22
        TabStop = False
        DataField = 'CHQ_PORCUS'
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
      object dbeDtaCus: TDBEditFocus
        Left = 90
        Top = 36
        Width = 71
        Height = 22
        TabStop = False
        DataField = 'CHQ_DTACUS'
        DataSource = dtsTabela
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtNomPo2: TEditFocus
        Left = 140
        Top = 14
        Width = 413
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
      object dbeDocCus: TDBEditFocus
        Left = 90
        Top = 58
        Width = 71
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        DataField = 'CHQ_DOCCUS'
        DataSource = dtsTabela
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
    object tbs1: TTabSheet
      Caption = '&4 - Dados Enviados Telecheque'
      ImageIndex = 3
      object lbl6: TLabel
        Left = 57
        Top = 128
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador:'
      end
      object lbl5: TLabel
        Left = 61
        Top = 106
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object lbl1: TLabel
        Left = 62
        Top = 18
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object lbl2: TLabel
        Left = 37
        Top = 40
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data do Envio:'
      end
      object lbl3: TLabel
        Left = 28
        Top = 62
        Width = 78
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo Border'#244':'
      end
      object lbl4: TLabel
        Left = 12
        Top = 84
        Width = 94
        Height = 14
        Alignment = taRightJustify
        Caption = 'C'#243'digo Telecheque:'
      end
      object edtNomOpe: TEditFocus
        Left = 160
        Top = 124
        Width = 413
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
      object edtNomEmp: TEditFocus
        Left = 160
        Top = 102
        Width = 413
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
      object DBEditFocus5: TDBEditFocus
        Left = 110
        Top = 102
        Width = 50
        Height = 22
        TabStop = False
        DataField = 'CHQ_CODEMP'
        DataSource = dtsConTel
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus6: TDBEditFocus
        Left = 110
        Top = 124
        Width = 50
        Height = 22
        TabStop = False
        DataField = 'CHQ_CODOPE'
        DataSource = dtsConTel
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus4: TDBEditFocus
        Left = 110
        Top = 80
        Width = 163
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        DataField = 'CHQ_DOCUME'
        DataSource = dtsConTel
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus3: TDBEditFocus
        Left = 110
        Top = 58
        Width = 163
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        DataField = 'CHQ_SEQTEL'
        DataSource = dtsConTel
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 5
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus2: TDBEditFocus
        Left = 110
        Top = 36
        Width = 71
        Height = 22
        TabStop = False
        DataField = 'CHQ_DTAENV'
        DataSource = dtsConTel
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 6
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object DBEditFocus1: TDBEditFocus
        Left = 110
        Top = 14
        Width = 50
        Height = 22
        TabStop = False
        DataField = 'CHQ_CODPOR'
        DataSource = dtsConTel
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtNomTel: TEditFocus
        Left = 160
        Top = 14
        Width = 413
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
    end
  end
  object pnlAcoes: TPanel [3]
    Left = 0
    Top = 586
    Width = 624
    Height = 46
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object btnCorrigeCheque: TBitBtnLocked
      Left = 173
      Top = 23
      Width = 291
      Height = 21
      Caption = '[ F8 ] Altera Banco / Ag'#234'ncia / Cta. Corrente / Nro. Cheque'
      TabOrder = 4
      OnClick = btnCorrigeChequeClick
    end
    object btnHistorico: TBitBtnLocked
      Left = 466
      Top = 23
      Width = 147
      Height = 21
      Caption = '[ F9 ] Hist'#243'rico de Dep'#243'sitos'
      TabOrder = 5
      OnClick = btnHistoricoClick
    end
    object btnHistReceb: TBitBtnLocked
      Left = 5
      Top = 23
      Width = 166
      Height = 21
      Caption = '[ F7 ] Hist'#243'rico de Recebimento'
      TabOrder = 3
      OnClick = btnHistRecebClick
    end
    object btnTransfereCtR: TBitBtnLocked
      Left = 397
      Top = 2
      Width = 216
      Height = 21
      Caption = '[ F6 ] Transferir para o Contas a Receber'
      TabOrder = 2
      OnClick = btnTransfereCtRClick
    end
    object btnAltPortador: TBitBtnLocked
      Left = 5
      Top = 2
      Width = 109
      Height = 21
      Caption = '[ F4 ] Altera Portador'
      Enabled = False
      TabOrder = 0
      OnClick = btnAltPortadorClick
    end
    object btnCancelTransfCtR: TBitBtnLocked
      Left = 117
      Top = 2
      Width = 277
      Height = 21
      Caption = '[ F5 ] Cancelar Transfer'#234'ncia para o Contas a Receber'
      TabOrder = 1
      OnClick = btnCancelTransfCtRClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 760
    Top = 0
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 472
    Top = 232
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 48
    Top = 136
  end
  inherited dtsTabela: TDataSource
    Left = 456
    Top = 188
  end
  inherited cdsTabela: TUniClientDataSet
    Left = 424
    Top = 188
  end
  inherited dspTabela: TUniDataSetProvider
    UpdateMode = upWhereKeyOnly
    Left = 392
    Top = 188
  end
  object dtsConTel: TDataSource
    Left = 520
  end
  object frxChqPreJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40822.587279363430000000
    ReportOptions.LastChange = 40822.681852569450000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo36OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxDBChqPre."CHQ_DTADP2"> = 0 Then'
      
        '    Memo36.Text := '#39#39';                                          ' +
        '              '
      'end;'
      ''
      'begin'
      ''
      'end.                '
      '')
    Left = 520
    Top = 188
    Datasets = <
      item
        DataSet = frxDBChqPre
        DataSetName = 'frxDBChqPre'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 148.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 41.574830000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo2: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 41.574830000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 13.559060000000000000
          Top = 11.338582680000000000
          Width = 521.575140000000000000
          Height = 18.897650000000000000
          DataSet = frxDBChqPre
          DataSetName = 'frxDBChqPre'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'CHEQUE DEVOLVIDO Nro.: [frxDBChqPre."CHQ_NUMCHQ"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 60.472480000000000000
        Top = 120.944960000000000000
        Width = 755.906000000000000000
        object Memo9: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 60.472480000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 37.795300000000000000
          Top = 7.559060000000003000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Banco..:')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 37.795300000000000000
          Top = 34.015769999999990000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Ag'#234'ncia:')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 325.157700000000000000
          Top = 34.015769999999990000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Conta Corrente:')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 117.165430000000000000
          Top = 7.559060000000003000
          Width = 600.945270000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_CODBCO"] - [NOMBCO]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 117.165430000000000000
          Top = 34.015769999999990000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_NUMAGE"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 476.220780000000000000
          Top = 34.015769999999990000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Courier New'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_CONCOR"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 313.700990000000000000
        Top = 204.094620000000000000
        Width = 755.906000000000000000
        DataSet = frxDBChqPre
        DataSetName = 'frxDBChqPre'
        RowCount = 0
        object Memo40: TfrxMemoView
          Align = baClient
          Width = 755.906000000000000000
          Height = 313.700990000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 37.795300000000000000
          Top = 15.118120000000010000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Data Entrada:')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 37.795300000000000000
          Top = 41.574829999999990000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Emitente....:')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 340.157480310000000000
          Top = 94.488250000000030000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Valor do Cheque:')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 37.795300000000000000
          Top = 68.031539999999970000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Cliente.....:')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 37.795300000000000000
          Top = 94.488250000000030000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'CPF/CNPJ....:')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 340.157480310000000000
          Top = 120.944960000000000000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Operador.......:')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 340.157480310000000000
          Top = 15.118120000000010000
          Width = 136.063080000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Data Vencimento:')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 37.795300000000000000
          Top = 147.401670000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Hist'#243'rico...:')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 37.795300000000000000
          Top = 196.535560000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Data Dep'#243'sito...:')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 37.795300000000000000
          Top = 222.992270000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Data 1a Devoluc.:')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 37.795300000000000000
          Top = 249.448980000000000000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Data Redep'#243'sito.:')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          Left = 37.795300000000000000
          Top = 275.905690000000100000
          Width = 143.622140000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Data 2a Devoluc.:')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 340.157700000000000000
          Top = 222.992270000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Motivo.:')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 340.157700000000000000
          Top = 275.905690000000100000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Motivo.:')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 37.795300000000000000
          Top = 120.944960000000000000
          Width = 113.385900000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Portador....:')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 158.740260000000000000
          Top = 15.118120000000010000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTACAD"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 158.740260000000000000
          Top = 41.574829999999990000
          Width = 559.370440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_NOMEMI"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 158.740260000000000000
          Top = 68.031539999999970000
          Width = 559.370440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_CODCLI"] - [NOMCLI]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 158.740260000000000000
          Top = 94.488250000000030000
          Width = 154.960730000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            
              '[FormatMaskText(IIF(<frxDBChqPre."CHQ_CGCCPF">=1,'#39'99.999.999/999' +
              '9-99;0;'#39','#39'999.999.999-99;0;'#39'),<frxDBChqPre."CHQ_C_G_C_">)]')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 158.740260000000000000
          Top = 120.944960000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_CODPOR"]')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 158.740260000000000000
          Top = 147.401670000000000000
          Width = 559.370440000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_HIST01"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo31: TfrxMemoView
          Left = 483.779527560000000000
          Top = 15.118120000000010000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTAVEN"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 483.779527560000000000
          Top = 94.488250000000030000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_VALCHQ"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 483.779527560000000000
          Top = 120.944960000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_CODOPE"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 188.976500000000000000
          Top = 196.535560000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTADEP"]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 188.976500000000000000
          Top = 222.992270000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTADEV"]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 188.976500000000000000
          Top = 249.448980000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          OnBeforePrint = 'Memo36OnBeforePrint'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTADP2"]')
          ParentFont = False
        end
        object Memo37: TfrxMemoView
          Left = 188.976500000000000000
          Top = 275.905690000000100000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTADV2"]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 415.748300000000000000
          Top = 222.992270000000000000
          Width = 302.362400000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_MOTDEV"]')
          ParentFont = False
        end
        object Memo39: TfrxMemoView
          Left = 415.748300000000000000
          Top = 275.905690000000100000
          Width = 302.362400000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_MOTDV2"]')
          ParentFont = False
        end
        object Memo41: TfrxMemoView
          Left = 158.740260000000000000
          Top = 164.078850000000000000
          Width = 559.370440000000000000
          Height = 15.118110240000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_HIST02"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 340.157700000000000000
          Top = 195.535560000000000000
          Width = 147.401670000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            'Telecheque (S/N):')
          ParentFont = False
        end
        object Memo43: TfrxMemoView
          Left = 491.338900000000000000
          Top = 195.535560000000000000
          Width = 98.267780000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_TELCHE"]')
          ParentFont = False
        end
      end
    end
  end
  object frxDBChqPre: TfrxDBDataset
    UserName = 'frxDBChqPre'
    CloseDataSource = False
    DataSource = dtsTabela
    BCDToCurrency = False
    Left = 488
    Top = 188
  end
  object frxChqPreM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40822.587279363400000000
    ReportOptions.LastChange = 40823.564782256930000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo36OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If <frxDBChqPre."CHQ_DTADP2"> = 0 Then'
      
        '    Memo36.Text := '#39#39';                                          ' +
        '                      '
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 552
    Top = 188
    Datasets = <
      item
        DataSet = frxDBChqPre
        DataSetName = 'frxDBChqPre'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxDMPPage
      PaperWidth = 241.299844160517300000
      PaperHeight = 143.933240376448900000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      FontStyle = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 17.000000000000000000
        Width = 892.800000000000000000
        object Memo1: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 34.000000000000000000
          Width = 393.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxDBChqPre
          DataSetName = 'frxDBChqPre'
          FontStyle = []
          Memo.UTF8W = (
            'CHEQUE DEVOLVIDO Nro.: [frxDBChqPre."CHQ_NUMCHQ"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine1: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 25.500000000000000000
          Width = 873.600000000000000000
          Color = clBlack
        end
        object DMPLine2: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 59.500000000000000000
          Width = 873.600000000000000000
          Color = clBlack
        end
        object dmpComando: TfrxDMPCommand
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#67#32#27#77'
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 883.200000000000000000
          Top = 17.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#87#1'
        end
        object DMPCommand2: TfrxDMPCommand
          Left = 403.200000000000000000
          Top = 34.000000000000000000
          Width = 9.600000000000000000
          Height = 17.000000000000000000
          Command = '#27#87#0'
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Height = 85.000000000000000000
        Top = 119.000000000000000000
        Width = 892.800000000000000000
        object Memo3: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Banco....:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo4: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 34.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Ag'#234'ncia..:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo5: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 34.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Conta Corrente:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo6: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 17.000000000000000000
          Width = 662.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_CODBCO"] - [NOMBCO]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo7: TfrxDMPMemoView
          Left = 134.400000000000000000
          Top = 34.000000000000000000
          Width = 192.000000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_NUMAGE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo8: TfrxDMPMemoView
          Left = 499.200000000000000000
          Top = 34.000000000000000000
          Width = 297.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_CONCOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine3: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 76.500000000000000000
          Width = 873.600000000000000000
          Color = clBlack
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 340.000000000000000000
        Top = 221.000000000000000000
        Width = 892.800000000000000000
        DataSet = frxDBChqPre
        DataSetName = 'frxDBChqPre'
        RowCount = 0
        object Memo10: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Data Entrada:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo11: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 68.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Emitente....:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo12: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 102.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Valor do Cheque:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo13: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 85.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Cliente.....:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo14: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 102.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'CPF/CNPJ....:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo15: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 153.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Operador.......:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo16: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Data Vencimento:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo17: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 170.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Hist'#243'rico...:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo18: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 238.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Data Dep'#243'sito...:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo19: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 255.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Data 1a Devoluc.:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo20: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 272.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Data Redep'#243'sito.:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo21: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 289.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Data 2a Devoluc.:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo22: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 255.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Motivo.:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo23: TfrxDMPMemoView
          Left = 345.600000000000000000
          Top = 289.000000000000000000
          Width = 86.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Motivo.:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo24: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 153.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Portador....:')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo25: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTACAD"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo26: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 68.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_NOMEMI"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo27: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 85.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_CODCLI"] - [NOMCLI]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo28: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 102.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            
              '[FormatMaskText(IIF(<frxDBChqPre."CHQ_CGCCPF">=1,'#39'99.999.999/999' +
              '9-99;0;'#39','#39'999.999.999-99;0;'#39'),<frxDBChqPre."CHQ_C_G_C_">)]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo29: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 153.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_CODPOR"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo30: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 170.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_HIST01"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object Memo31: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTAVEN"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo32: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 102.000000000000000000
          Width = 163.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_VALCHQ"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo33: TfrxDMPMemoView
          Left = 556.800000000000000000
          Top = 153.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_CODOPE"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo34: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 238.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTADEP"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo35: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 255.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTADEV"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo36: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 272.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'Memo36OnBeforePrint'
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTADP2"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo37: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 289.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_DTADV2"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo38: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 255.000000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_MOTDEV"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object Memo39: TfrxDMPMemoView
          Left = 441.600000000000000000
          Top = 289.000000000000000000
          Width = 422.400000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_MOTDV2"]')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPLine4: TfrxDMPLineView
          Left = 4.800000000000000000
          Top = 331.500000000000000000
          Width = 873.600000000000000000
          Color = clBlack
        end
        object DMPMemo1: TfrxDMPMemoView
          Left = 172.800000000000000000
          Top = 187.000000000000000000
          Width = 691.200000000000000000
          Height = 17.000000000000000000
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_HIST02"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo2: TfrxDMPMemoView
          Left = 28.800000000000000000
          Top = 221.000000000000000000
          Width = 172.800000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            'Telecheque (S/N):')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 211.200000000000000000
          Top = 221.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          FontStyle = []
          Memo.UTF8W = (
            '[frxDBChqPre."CHQ_TELCHE"]')
          ParentFont = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxMatricial: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 584
    Top = 188
  end
end
