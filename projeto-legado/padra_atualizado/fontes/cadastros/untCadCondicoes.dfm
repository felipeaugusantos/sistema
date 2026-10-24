inherited frmCadCondicoes: TfrmCadCondicoes
  Left = 383
  Top = 358
  Width = 974
  Height = 726
  Caption = 'Cadastro de Condi'#231#245'es de Pagamento'
  ExplicitWidth = 974
  ExplicitHeight = 726
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 672
    Width = 968
    Height = 25
    TabOrder = 1
    ExplicitTop = 672
    ExplicitWidth = 968
    ExplicitHeight = 25
    DesignSize = (
      968
      25)
    inherited FlwBotoes: TFlowPanel
      Width = 964
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 964
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 82
        ExplicitWidth = 82
      end
      inherited btnGravar: TBitBtnLocked
        Left = 82
        Width = 82
        ExplicitLeft = 82
        ExplicitWidth = 82
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 164
        Width = 82
        ExplicitLeft = 164
        ExplicitWidth = 82
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 246
        Width = 82
        ExplicitLeft = 246
        ExplicitWidth = 82
      end
      inherited btnCancela: TBitBtnLocked
        Left = 328
        Width = 79
        ExplicitLeft = 328
        ExplicitWidth = 79
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 407
        Width = 79
        ExplicitLeft = 407
        ExplicitWidth = 79
      end
      object btnDescMax: TBitBtnLocked
        Left = 486
        Top = 0
        Width = 203
        Height = 20
        Caption = 'Desc. Max. Linha/Grupo de Produtos'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000076767684848583838383838383838383838383
          8383838383838383838383838383838383848485767676000000000000848485
          C7C3C1C0BDBAC0BCBAC0BCBAC0BCBAC0BCBAC0BCBAC0BCBAC0BCBAC0BCBAC0BD
          BAC7C3C1848485000000000000838383C4C2BFB7B4B1B7B4B2B7B4B2B7B4B2B7
          B4B2B7B4B2B7B4B2B7B4B2B7B4B2B7B4B1C4C2BF838383000000000000828383
          C7C4C3B3B0AEB3B0AEB3B0AEB3B0AEFFFFFFFFFFFFB3B0AEB3B0AEB3B0AEB3B0
          AEC7C4C3828383000000000000828383CAC7C5ADAAA8ADAAA8ADAAA8ADAAA8FF
          FFFFFFFFFFADAAA8ADAAA8ADAAA8ADAAA8CAC7C5828383000000000000828283
          CCCAC8A7A3A1A4A19EA29F9DA29F9CFFFFFFFFFFFFA29F9CA29F9DA4A19EA7A3
          A1CCCAC8828283000000000000828282D0CECDA09C9AFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFA09C9AD0CECD828282000000000000828282
          D4D2D19B9895FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9B98
          95D4D2D1828282000000000000828282DAD9D69A9794989593979491979391FF
          FFFFFFFFFF9793919794919895939A9794DAD9D6828282000000000000818181
          E1DEDD9895939B98969C98969B9896FFFFFFFFFFFF9B98969C98969B98969895
          93E1DEDD818181000000000000818181E6E5E493908E979492989593989593FF
          FFFFFFFFFF98959398959397949293908EE6E5E4818181000000000000818181
          EEEDEC8D8987908D8B918D8B918D8B918D8B918D8B918D8B918D8B908D8B8D89
          87EEEDEC818181000000000000838383EEEDECEEEDECEEEDECEEEDECEEEDECEE
          EDECEEEDECEEEDECEEEDECEEEDECEEEDECEEEDEC838383000000000000808080
          8384848383838383838383838383838383838383838383838383838383838383
          8383848480808000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 6
        OnClick = btnDescMaxClick
      end
      object btnDescMaxGlobal: TBitBtnLocked
        Left = 689
        Top = 0
        Width = 182
        Height = 20
        Caption = 'Desc. Max. Linha/Grupo Global'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000076767684848583838383838383838383838383
          8383838383838383838383838383838383848485767676000000000000848485
          C7C3C1C0BDBAC0BCBAC0BCBAC0BCBAC0BCBAC0BCBAC0BCBAC0BCBAC0BCBAC0BD
          BAC7C3C1848485000000000000838383C4C2BFB7B4B1B7B4B2B7B4B2B7B4B2B7
          B4B2B7B4B2B7B4B2B7B4B2B7B4B2B7B4B1C4C2BF838383000000000000828383
          C7C4C3B3B0AEB3B0AEB3B0AEB3B0AEFFFFFFFFFFFFB3B0AEB3B0AEB3B0AEB3B0
          AEC7C4C3828383000000000000828383CAC7C5ADAAA8ADAAA8ADAAA8ADAAA8FF
          FFFFFFFFFFADAAA8ADAAA8ADAAA8ADAAA8CAC7C5828383000000000000828283
          CCCAC8A7A3A1A4A19EA29F9DA29F9CFFFFFFFFFFFFA29F9CA29F9DA4A19EA7A3
          A1CCCAC8828283000000000000828282D0CECDA09C9AFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFA09C9AD0CECD828282000000000000828282
          D4D2D19B9895FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9B98
          95D4D2D1828282000000000000828282DAD9D69A9794989593979491979391FF
          FFFFFFFFFF9793919794919895939A9794DAD9D6828282000000000000818181
          E1DEDD9895939B98969C98969B9896FFFFFFFFFFFF9B98969C98969B98969895
          93E1DEDD818181000000000000818181E6E5E493908E979492989593989593FF
          FFFFFFFFFF98959398959397949293908EE6E5E4818181000000000000818181
          EEEDEC8D8987908D8B918D8B918D8B918D8B918D8B918D8B918D8B908D8B8D89
          87EEEDEC818181000000000000838383EEEDECEEEDECEEEDECEEEDECEEEDECEE
          EDECEEEDECEEEDECEEEDECEEEDECEEEDECEEEDEC838383000000000000808080
          8384848383838383838383838383838383838383838383838383838383838383
          8383848480808000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 7
        OnClick = btnDescMaxGlobalClick
      end
      object btnHeranca: TBitBtnLocked
        Left = 871
        Top = 0
        Width = 84
        Height = 20
        Caption = '&Heran'#231'a'
        Enabled = False
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00070000000A0000000C0000000C0000000C0000000D0000000D0000000D0000
          000E0000000E0000000E0000000D000000090000000200000000000000068F6B
          4EBEC6956CFFC6946AFFC59369FFC49268FFC49167FFC39066FFC28F65FFC28E
          64FFC18D63FFC08D62FFC08C62FF8A6545C100000009000000000000000BD4AF
          91FFFDFDFDFFFAF3ECFFFAF3EBFFF9F3EBFFF9F2EBFFF9F3EBFFFAF2EAFFFAF2
          E9FFF9F1E9FFFAF1EAFFF9F1E9FFC08D62FF0000000D000000000000000DB670
          3DFFEFE8E3FFF8F2EBFFFAF4ECFFFAF3ECFFFAF3EBFFFAF3EBFFF9F2EBFFF9F2
          EAFFF9F2EAFFF9F2E9FFF9F2E9FFC18D63FF0000000E000000000000000EB873
          40FFBC7A49FFEBDED3FFF8F1EAFFFAF3ECFFFAF3ECFFF9F3EBFF5354C5FF5253
          C3FF5252C3FF5051C2FFF9F2EAFFC28E64FF0000000D000000000000000EBA76
          44FFCD905CFFBD7A48FFEFE3D6FFFAF4ECFFFAF3ECFFFAF4ECFFE3DDE7FFE3DD
          E6FFE2DCE6FFE2DCE5FFF9F3EAFFC29065FF0000000C000000000000000DBB79
          46FFBF7F4EFFEBE0D5FFF8F2ECFFFBF4EDFFFBF4ECFFFAF3EDFF5959CBFF5858
          C9FF5658C8FF5556C6FFFAF2EAFFC39067FF0000000C000000000000000BBD7B
          49FFF0E9E4FFF8F3ECFFFBF5EEFFFAF4EDFFFAF4EDFFFAF4EDFFE4DFE8FFE4DE
          E7FFE3DDE7FFE3DDE6FFFAF3EBFFC49168FF0000000B0000000000000008D9B6
          98FFFDFDFDFFC3926AFFC29167FFC28F66FFC18E65FFFAF5EDFF5F5FD0FF5E5E
          CFFF5C5DCDFF5A5BCCFFFAF3EBFFC59369FF0000000B0000000000000006CEA0
          78FFFFFFFFFFF3E8DDFFF2E7DDFFF3E7DBFFF3E7DBFFFAF5EEFFE5DFE9FFE4DF
          E9FFE4DFE9FFE3DFE9FFFAF4ECFFC5946BFF0000000A0000000000000005D0A0
          7AFFFFFFFFFFC7966FFFC5956EFFC4936CFFC4926AFFFAF5EEFF6565D7FF6363
          D5FF6262D4FF6161D3FFFAF4EDFFC6956CFF0000000A0000000000000005D0A2
          7BFFFFFFFFFFF4E9DFFFF4E9DEFFF3E8DDFFF3E7DEFFFAF5EFFFE5E1ECFFE6E1
          EBFFE5E0EAFFE5E0EAFFFAF4EDFFC7966DFF000000090000000000000004D1A3
          7DFFFFFFFFFFC99B75FFC89A73FFC79871FFC79770FFFBF5F0FF6869DBFF6868
          DAFF6667D9FF6666D8FFFAF4EDFFC9976FFF000000080000000000000004D1A4
          7EFFFFFFFFFFFBF7F1FFFBF7F1FFFBF7F1FFFBF6F1FFFBF6F0FFFBF5EFFFFBF5
          EFFFFBF5EFFFFBF5EEFFFBF5EEFFC99871FF000000080000000000000003D2A5
          7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFCA9A72FF0000000700000000000000029D7A
          5EBFD3A580FFD2A47EFFD2A47EFFD1A27DFFD0A27BFFD0A17AFFCFA079FFCE9F
          78FFCD9E77FFCC9D76FFCC9C75FF977356C10000000400000000}
        TabOrder = 8
        OnClick = btnHerancaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 879
      Width = 80
      Height = 21
      ExplicitLeft = 879
      ExplicitWidth = 80
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 656
    Width = 968
    TabOrder = 2
    ExplicitTop = 656
    ExplicitWidth = 968
    inherited pnlNomeForm: TPanel
      Left = 749
      Width = 219
      TabOrder = 1
      ExplicitLeft = 749
      ExplicitWidth = 219
    end
    inherited pnlInfo: TPanel
      Width = 749
      TabOrder = 0
      ExplicitWidth = 749
    end
  end
  inherited pgcDados: TPageControl
    Width = 968
    Height = 656
    TabOrder = 0
    ExplicitWidth = 968
    ExplicitHeight = 656
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 960
      ExplicitHeight = 624
      object pnlFundo: TPanel
        Left = 0
        Top = 0
        Width = 960
        Height = 624
        Align = alClient
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 0
        object pnlDados2: TPanel
          Left = 2
          Top = 118
          Width = 956
          Height = 504
          Align = alClient
          BevelOuter = bvNone
          Color = 16770261
          TabOrder = 2
          object lblPortador: TLabel
            Left = 95
            Top = 4
            Width = 44
            Height = 14
            Alignment = taRightJustify
            Caption = 'Portador:'
          end
          object lblAbaDes: TLabel
            Left = 635
            Top = 96
            Width = 175
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deduzir desconto automaticamente?'
          end
          object clbAbaDes: TColorLabel
            Left = 860
            Top = 96
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblAbDeCc: TLabel
            Left = 523
            Top = 142
            Width = 287
            Height = 14
            Alignment = taRightJustify
            Caption = 'Deduzir desconto automaticamente para Cart'#227'o de Cr'#233'dito?'
          end
          object clbAbDeCc: TColorLabel
            Left = 860
            Top = 142
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblTaxJuros: TLabel
            Left = 68
            Top = 74
            Width = 71
            Height = 14
            Alignment = taRightJustify
            Caption = 'Taxa de Juros:'
          end
          object lblPorTaxJur: TLabel
            Left = 221
            Top = 74
            Width = 33
            Height = 14
            Alignment = taRightJustify
            Caption = '% a.m.'
          end
          object lblPrzMedio: TLabel
            Left = 77
            Top = 97
            Width = 62
            Height = 14
            Alignment = taRightJustify
            Caption = 'Prazo M'#233'dio:'
          end
          object lblFatAca: TLabel
            Left = 657
            Top = 50
            Width = 153
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fator da condi'#231#227'o (Exp. Tablet):'
          end
          object lblValMin: TLabel
            Left = 684
            Top = 73
            Width = 126
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor M'#237'nimo (Exp. Tablet):'
          end
          object Label4: TLabel
            Left = 568
            Top = 205
            Width = 242
            Height = 26
            Alignment = taRightJustify
            AutoSize = False
            Caption = 
              'Influenciar no c'#225'lculo do prazo m'#233'dio do Rel. An'#225'lise de Resulta' +
              'dos?'
            WordWrap = True
          end
          object ColorLabel1: TColorLabel
            Left = 860
            Top = 211
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblPerCom: TLabel
            Left = 89
            Top = 143
            Width = 50
            Height = 14
            Alignment = taRightJustify
            Caption = 'Comiss'#227'o:'
          end
          object lblPercen: TLabel
            Left = 221
            Top = 143
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblPerDPo: TLabel
            Left = 26
            Top = 167
            Width = 113
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desconto Pontualidade:'
          end
          object lblPercn2: TLabel
            Left = 221
            Top = 167
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblTabPre: TLabel
            Left = 59
            Top = 120
            Width = 80
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tabela de Pre'#231'o:'
          end
          object lbl10: TLabel
            Left = 570
            Top = 119
            Width = 240
            Height = 14
            Alignment = taRightJustify
            Caption = 'Imprimir op'#231#227'o de valores nos documentos OR/PD'
            WordWrap = True
          end
          object lbl11: TColorLabel
            Left = 860
            Top = 119
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label10: TLabel
            Left = 368
            Top = 188
            Width = 439
            Height = 14
            Alignment = taRightJustify
            Caption = 
              'Aplicar juros configurados nesta condi'#231#227'o de pagamento, para ite' +
              'ns em promo'#231#227'o/combo?'
          end
          object ColorLabel7: TColorLabel
            Left = 860
            Top = 188
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblExpFSo: TLabel
            Left = 693
            Top = 236
            Width = 117
            Height = 14
            Alignment = taRightJustify
            Caption = 'Exportar para Full Soft ?'
          end
          object corExpFSo: TColorLabel
            Left = 860
            Top = 233
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblPraMin: TLabel
            Left = 568
            Top = 256
            Width = 242
            Height = 14
            Alignment = taRightJustify
            Caption = 'Utilizar prazo m'#233'dio m'#237'nimo para c'#225'lculo de juros ?'
          end
          object corPraMin: TColorLabel
            Left = 860
            Top = 256
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object Label17: TLabel
            Left = 306
            Top = 73
            Width = 135
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Qtd. M'#225'xima de Parcelas:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblExpB2B: TLabel
            Left = 707
            Top = 279
            Width = 103
            Height = 14
            Alignment = taRightJustify
            Caption = 'Exporta para o B2B ?'
          end
          object corExpB2B: TColorLabel
            Left = 860
            Top = 279
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblGeraCobrancaYapay: TLabel
            Left = 656
            Top = 326
            Width = 154
            Height = 14
            Alignment = taRightJustify
            Caption = 'Gerar Cobran'#231'a Online Yapay ?'
          end
          object clbGeraCobrancaYapay: TColorLabel
            Left = 861
            Top = 327
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblUsaDeps: TLabel
            Left = 663
            Top = 303
            Width = 144
            Height = 14
            Alignment = taRightJustify
            Caption = 'Integrar com o sistema DEPS?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lblUsaDeps_SN: TColorLabel
            Left = 860
            Top = 303
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object lblRcx_F3: TLabel
            Left = 624
            Top = 435
            Width = 188
            Height = 28
            Alignment = taRightJustify
            Caption = 
              'Permitir utilizar esta condi'#231#227'o de pagamento no F3 (checkout) do' +
              ' caixa?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object ColorLabel4: TColorLabel
            Left = 860
            Top = 441
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object lblPerVen: TLabel
            Left = 11
            Top = 222
            Width = 318
            Height = 14
            Alignment = taRightJustify
            Caption = 
              'Percentual sobre a venda para gerar a primeira parcela (Entrada)' +
              ':'
          end
          object lblPerPerVer: TLabel
            Left = 410
            Top = 223
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblCndEsp: TLabel
            Left = 645
            Top = 349
            Width = 165
            Height = 14
            Alignment = taRightJustify
            Caption = 'Condi'#231#227'o de Pagamento Especial?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object clbCndEsp: TColorLabel
            Left = 861
            Top = 349
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object lblDesMaxGer: TLabel
            Left = 8
            Top = 28
            Width = 131
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desc. M'#225'x. Gerente J'#250'nior:'
          end
          object lblDesMaxGerM: TLabel
            Left = 4
            Top = 51
            Width = 135
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desc. M'#225'x. Gerente Master:'
          end
          object Label28: TLabel
            Left = 218
            Top = 50
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label7: TLabel
            Left = 218
            Top = 27
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblDesMaxSub: TLabel
            Left = 274
            Top = 27
            Width = 167
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desc. M'#225'ximo Sub-Gerente J'#250'nior:'
          end
          object lblDesMaxSubM: TLabel
            Left = 267
            Top = 51
            Width = 171
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desc. M'#225'ximo Sub-Gerente Master:'
          end
          object Label13: TLabel
            Left = 520
            Top = 27
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object Label30: TLabel
            Left = 520
            Top = 50
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblDescMaxM: TLabel
            Left = 654
            Top = 27
            Width = 156
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desc. M'#225'ximo Vendedor Master:'
          end
          object lblDescMax: TLabel
            Left = 658
            Top = 4
            Width = 152
            Height = 14
            Alignment = taRightJustify
            Caption = 'Desc. M'#225'ximo Vendedor J'#250'nior:'
          end
          object Label25: TLabel
            Left = 889
            Top = 27
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblPorDesMax: TLabel
            Left = 889
            Top = 4
            Width = 10
            Height = 14
            Alignment = taRightJustify
            Caption = '%'
          end
          object lblGeraCobrancaPagarMe: TLabel
            Left = 646
            Top = 394
            Width = 164
            Height = 14
            Alignment = taRightJustify
            Caption = 'Gerar Cobran'#231'a Online Pagar.me?'
          end
          object clbGeraCobrancaPagarMe: TColorLabel
            Left = 860
            Top = 394
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object cllExpTab: TColorLabel
            Left = 860
            Top = 417
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object lblExpTab: TLabel
            Left = 736
            Top = 420
            Width = 74
            Height = 14
            Alignment = taRightJustify
            Caption = 'Exporta Tablet?'
          end
          object lblMoDiVn: TLabel
            Left = 293
            Top = 90
            Width = 147
            Height = 28
            Caption = 'Modalidades dispon'#237'veis para recebimento no Venda Normal:'
            WordWrap = True
          end
          object lblQtdDAV: TLabel
            Left = 23
            Top = 188
            Width = 201
            Height = 28
            Alignment = taRightJustify
            Caption = 
              'Qtde de Dias de Ant. do Vencimento para Concess'#227'o do Desc. Pontu' +
              'alidade:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object LblExpApp: TLabel
            Left = 676
            Top = 466
            Width = 133
            Height = 14
            Alignment = taRightJustify
            Caption = 'Exportar para o APP Sales?'
          end
          object clbExpApp: TColorLabel
            Left = 861
            Top = 467
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            CorDestaque = clRed
          end
          object gpbConfiguracoesYapay: TGroupBox
            Left = 295
            Top = 289
            Width = 339
            Height = 64
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 35
            object Label24: TLabel
              Left = 9
              Top = 42
              Width = 221
              Height = 14
              Alignment = taRightJustify
              Caption = 'Quantidade m'#225'xima de parcelas da cobran'#231'a:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object Label23: TLabel
              Left = 9
              Top = 11
              Width = 131
              Height = 28
              Caption = 'Formas de pagamento dispon'#237'veis para cobran'#231'a:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object edtYapPar: TDBEditFocus
              Tag = 99
              Left = 236
              Top = 37
              Width = 94
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CND_YAPPAR'
              DataSource = dtsCadCnd
              Enabled = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
              OnEnter = dbeGeraCobrancaYapayEnter
              OnExit = dbeGeraCobrancaYapayExit
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object cbYapDis: TcxCheckComboBox
              Tag = 99
              Left = 145
              Top = 13
              Properties.Delimiter = ','
              Properties.EmptySelectionText = 'Nenhum Selecionado'
              Properties.Items = <>
              Style.TextStyle = []
              TabOrder = 0
              Width = 185
            end
          end
          object dbeCodPor: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 0
            Width = 44
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_CODPOR'
            DataSource = dtsCadCnd
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnExit = dbeCodPorExit
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
          object edtNomPor: TEditFocus
            Left = 187
            Top = 0
            Width = 465
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
          object dbeAbaDes: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 92
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_ABADES'
            DataSource = dtsCadCnd
            TabOrder = 15
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeAbDeCc: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 138
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_ABDECC'
            DataSource = dtsCadCnd
            TabOrder = 20
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeTaxJur: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 69
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_TXJURO'
            DataSource = dtsCadCnd
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbePrzMed: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 93
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_PRZMED'
            DataSource = dtsCadCnd
            TabOrder = 11
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeFatAca: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 46
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_FATACA'
            DataSource = dtsCadCnd
            TabOrder = 10
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeValMin: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 69
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_VALMIN'
            DataSource = dtsCadCnd
            TabOrder = 13
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeInfAna: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 207
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_INFANA'
            DataSource = dtsCadCnd
            TabOrder = 24
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbePerCom: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 139
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_PERCOM'
            DataSource = dtsCadCnd
            TabOrder = 16
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbePerDPo: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 163
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_PERDPO'
            DataSource = dtsCadCnd
            TabOrder = 19
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeQtdDAV: TDBEditFocus
            Tag = 99
            Left = 230
            Top = 187
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_QTDDAV'
            DataSource = dtsCadCnd
            TabOrder = 22
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeImpFat: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 115
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_IMPFAT'
            DataSource = dtsCadCnd
            TabOrder = 18
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeJurPro: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 184
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_JURPRO'
            DataSource = dtsCadCnd
            TabOrder = 23
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbePraMin: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 253
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_PRAMIN'
            DataSource = dtsCadCnd
            TabOrder = 29
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeExpFSo: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 230
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_EXPFSO'
            DataSource = dtsCadCnd
            TabOrder = 25
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object gpbDestino: TGroupBox
            Left = 0
            Top = 235
            Width = 509
            Height = 43
            Caption = 'Destino:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 27
            object clblRetira: TColorLabel
              Left = 74
              Top = 18
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object lblRetira: TLabel
              Left = 6
              Top = 18
              Width = 31
              Height = 14
              Alignment = taRightJustify
              Caption = 'Retira:'
            end
            object clblEntregaImediata: TColorLabel
              Left = 449
              Top = 18
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object lblEntregaImediata: TLabel
              Left = 311
              Top = 18
              Width = 82
              Height = 14
              Alignment = taRightJustify
              Caption = 'Entrega Imediata:'
            end
            object lblEntregaFutura: TLabel
              Left = 139
              Top = 18
              Width = 74
              Height = 14
              Alignment = taRightJustify
              Caption = 'Entrega Futura:'
            end
            object clblEntregaFutura: TColorLabel
              Left = 253
              Top = 18
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              CorDestaque = clRed
            end
            object dbeRetira: TDBEditFocus
              Tag = 99
              Left = 43
              Top = 15
              Width = 27
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CND_RETIRA'
              DataSource = dtsCadCnd
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeEntregaImediata: TDBEditFocus
              Tag = 99
              Left = 399
              Top = 15
              Width = 27
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CND_ENTIME'
              DataSource = dtsCadCnd
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
            object dbeEntregaFutura: TDBEditFocus
              Tag = 99
              Left = 219
              Top = 15
              Width = 27
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CND_ENTFUT'
              DataSource = dtsCadCnd
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
          end
          object dbeQtdMax: TDBEditFocus
            Tag = 99
            Left = 444
            Top = 69
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_QTDMAX'
            DataSource = dtsCadCnd
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 9
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeExpB2B: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 276
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_EXPB2B'
            DataSource = dtsCadCnd
            TabOrder = 30
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object clbPreTab: TCheckListBox
            Tag = 99
            Left = 142
            Top = 119
            Width = 212
            Height = 17
            BorderStyle = bsNone
            Color = 16770261
            Columns = 7
            Ctl3D = True
            ItemHeight = 14
            Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7')
            ParentCtl3D = False
            TabOrder = 14
            StyleElements = [seFont, seBorder]
          end
          object dbeUsaDeps: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 299
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_USADEP'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 1
            ParentFont = False
            TabOrder = 31
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeGeraCobrancaYapay: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 322
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_COBYAP'
            DataSource = dtsCadCnd
            TabOrder = 32
            OnChange = dbeGeraCobrancaYapayChange
            OnEnter = dbeGeraCobrancaYapayEnter
            OnExit = dbeGeraCobrancaYapayExit
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeRcx_F3: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 437
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_RCX_F3'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 1
            ParentFont = False
            TabOrder = 40
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object gpbDespAcess: TGroupBox
            Left = 0
            Top = 279
            Width = 289
            Height = 182
            Caption = 'Despesas acess'#243'rias:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 28
            object Label8: TLabel
              Left = 81
              Top = 16
              Width = 110
              Height = 14
              Alignment = taRightJustify
              Caption = 'Despesas Acess'#243'rias:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label9: TLabel
              Left = 274
              Top = 16
              Width = 9
              Height = 14
              Alignment = taRightJustify
              Caption = '%'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblVrDeAc: TLabel
              Left = 33
              Top = 38
              Width = 158
              Height = 14
              Alignment = taRightJustify
              Caption = 'Vr. Desp. Acess'#243'ria por Parcela:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label16: TLabel
              Left = 9
              Top = 60
              Width = 182
              Height = 14
              Alignment = taRightJustify
              Caption = 'Vr. Desp. Acess'#243'ria '#250'nico por Venda:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object dbePeDeAc: TDBEditFocus
              Tag = 99
              Left = 194
              Top = 12
              Width = 74
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CND_PEDEAC'
              DataSource = dtsCadCnd
              Font.Charset = ANSI_CHARSET
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
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeVrDeAc: TDBEditFocus
              Tag = 99
              Left = 194
              Top = 34
              Width = 74
              Height = 22
              Hint = 'Valor da Despesa Acess'#243'ria por Parcela '#224' Prazo'
              CharCase = ecUpperCase
              DataField = 'CND_VRDEAC'
              DataSource = dtsCadCnd
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbeVrDaUv: TDBEditFocus
              Tag = 99
              Left = 194
              Top = 56
              Width = 74
              Height = 22
              Hint = 'Valor de Despesas Acess'#243'rias '#218'nico por Venda'
              CharCase = ecUpperCase
              DataField = 'CND_VRDAUV'
              DataSource = dtsCadCnd
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object gpbTpFtDa: TGroupBox
              Left = 9
              Top = 124
              Width = 260
              Height = 53
              Caption = 'Tipo de Faturamento:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              object chkTpFtDaA: TCheckBox
                Tag = 99
                Left = 10
                Top = 16
                Width = 97
                Height = 17
                Caption = '(A) - Nota Fiscal'
                TabOrder = 0
              end
              object chkTpFtDaB: TCheckBox
                Tag = 99
                Left = 10
                Top = 33
                Width = 97
                Height = 17
                Caption = '(B) - FF'
                TabOrder = 1
              end
              object chkTpFtDaC: TCheckBox
                Tag = 99
                Left = 114
                Top = 16
                Width = 110
                Height = 17
                Caption = '(C) - Cupom Fiscal'
                TabOrder = 2
              end
              object chkTpFtDaD: TCheckBox
                Tag = 99
                Left = 114
                Top = 33
                Width = 110
                Height = 17
                Caption = '(D) - Divis'#237'vel'
                TabOrder = 3
              end
            end
            object rdgMCobDa: TDBRadioGroup
              Tag = 99
              Left = 8
              Top = 76
              Width = 261
              Height = 49
              Caption = 'M'#233'todo de Cobran'#231'a:'
              DataField = 'CND_MCOBDA'
              DataSource = dtsCadCnd
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              Items.Strings = (
                '1) Cobrar em todos os documentos'
                '2) Cobrar apenas uma vez por dezena.')
              ParentFont = False
              TabOrder = 3
              TabStop = True
              Values.Strings = (
                '1'
                '2')
              OnEnter = rdgMCobDaEnter
            end
          end
          object cbYapTra: TDBCheckBox
            Tag = 99
            Left = 304
            Top = 279
            Width = 213
            Height = 22
            BiDiMode = bdLeftToRight
            Caption = 'Enviar condi'#231#227'o de pagamento travada'
            DataField = 'CND_YAPTRA'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 34
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = cbYapTraClick
          end
          object dbePerVen: TDBEditFocus
            Tag = 99
            Left = 331
            Top = 219
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_PERVEN'
            DataSource = dtsCadCnd
            TabOrder = 26
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeCondEsp: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 345
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_CNDESP'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 33
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeDesMGe: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 23
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_DESMGE'
            DataSource = dtsCadCnd
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeDesMGeM: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 46
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_DESMGM'
            DataSource = dtsCadCnd
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeDesMSuM: TDBEditFocus
            Tag = 99
            Left = 444
            Top = 46
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_DESMSM'
            DataSource = dtsCadCnd
            TabOrder = 6
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeDesMSu: TDBEditFocus
            Tag = 99
            Left = 444
            Top = 23
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_DESMSU'
            DataSource = dtsCadCnd
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeDesMax: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 0
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_DESMAX'
            DataSource = dtsCadCnd
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeDesMaxM: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 23
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_DESMVM'
            DataSource = dtsCadCnd
            TabOrder = 7
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object pnlLinkPgtoOnline: TPanel
            Left = 635
            Top = 368
            Width = 297
            Height = 26
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 36
            object lbGeraLinkPgtoOnline: TLabel
              Left = 83
              Top = -3
              Width = 92
              Height = 28
              Alignment = taRightJustify
              Caption = 'Gerar Link para Pagamento Online?'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object clbGeraLinkPgtoOnline: TColorLabel
              Left = 225
              Top = 5
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object dbeGeraLinkPgtoOnline: TDBEditFocus
              Tag = 99
              Left = 178
              Top = 0
              Width = 45
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CND_GERLNK'
              DataSource = dtsCadCnd
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = dbeGeraLinkPgtoOnlineChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
          end
          object dbeGeraCobrancaPagarMe: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 391
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_COBPME'
            DataSource = dtsCadCnd
            TabOrder = 37
            OnChange = dbeGeraCobrancaPagarMeChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeExpTab: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 414
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_EXPTAB'
            DataSource = dtsCadCnd
            TabOrder = 39
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object gpbPagarMe: TGroupBox
            Left = 295
            Top = 359
            Width = 339
            Height = 90
            TabOrder = 38
            object Label26: TLabel
              Left = 132
              Top = 18
              Width = 107
              Height = 14
              Alignment = taRightJustify
              Caption = 'Dias para vencimento:'
            end
            object Label32: TLabel
              Left = 297
              Top = 18
              Width = 20
              Height = 14
              Caption = 'dias'
            end
            object Label33: TLabel
              Left = 123
              Top = 41
              Width = 116
              Height = 14
              Alignment = taRightJustify
              Caption = 'Percentual juros ao m'#234's'
            end
            object Label34: TLabel
              Left = 297
              Top = 41
              Width = 10
              Height = 14
              Caption = '%'
            end
            object lblInfoPagarMe: TLabel
              Left = 9
              Top = 1
              Width = 140
              Height = 14
              Caption = 'Configura'#231#245'es PAGAR.ME'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object chkPermiteBoleto: TCheckBox
              Left = 9
              Top = 18
              Width = 97
              Height = 17
              Caption = 'Permite Boleto'
              TabOrder = 0
              OnClick = chkPermiteBoletoClick
            end
            object chkPermiteCartao: TCheckBox
              Left = 9
              Top = 41
              Width = 93
              Height = 17
              Caption = 'Permite Cart'#227'o'
              TabOrder = 2
              OnClick = chkPermiteCartaoClick
            end
            object cmbLimiteParcelas: TComboBoxFocus
              Tag = 99
              Left = 9
              Top = 64
              Width = 126
              Height = 22
              Style = csDropDownList
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ItemIndex = 0
              ParentFont = False
              TabOrder = 4
              Text = 'LIMITE DE PARCELAS'
              OnSelect = cmbLimiteParcelasSelect
              Items.Strings = (
                'LIMITE DE PARCELAS'
                'M'#225'ximo de 1 parcela'
                'M'#225'ximo de 2 parcela'
                'M'#225'ximo de 3 parcela'
                'M'#225'ximo de 4 parcela'
                'M'#225'ximo de 5 parcela'
                'M'#225'ximo de 6 parcela'
                'M'#225'ximo de 7 parcela'
                'M'#225'ximo de 8 parcela'
                'M'#225'ximo de 9 parcela'
                'M'#225'ximo de 10 parcela'
                'M'#225'ximo de 11 parcela'
                'M'#225'ximo de 12 parcela')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object cmbQtdeParcelasSemJuros: TComboBoxFocus
              Tag = 99
              Left = 138
              Top = 64
              Width = 192
              Height = 22
              Style = csDropDownList
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ItemIndex = 0
              ParentFont = False
              TabOrder = 5
              Text = 'QUANTIDADE PARCELAS SEM JUROS'
              Items.Strings = (
                'QUANTIDADE PARCELAS SEM JUROS')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object edtPmeJct: TEditFocus
              Tag = 99
              Left = 242
              Top = 41
              Width = 47
              Height = 22
              Alignment = taRightJustify
              CharCase = ecUpperCase
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
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtPmeDVc: TEditFocus
              Tag = 99
              Left = 242
              Top = 18
              Width = 47
              Height = 22
              Alignment = taRightJustify
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
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
          end
          object cbbMoDiVn: TComboBoxFocus
            Tag = 99
            Left = 444
            Top = 92
            Width = 74
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 12
            Items.Strings = (
              'A VISTA'
              'A PRAZO'
              'TODAS')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object rdgEmiBol: TDBRadioGroup
            Tag = 99
            Left = 237
            Top = 133
            Width = 280
            Height = 49
            Hint = 'Sugest'#227'o para o check-box '
            Caption = 'Emitir boletos p/ todos venc. cond. de pgto informada?'
            DataField = 'CND_EMIBOL'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            Items.Strings = (
              'Marcado'
              'Desmarcado')
            ParentFont = False
            TabOrder = 17
            TabStop = True
            Values.Strings = (
              '1'
              '2')
            OnChange = rdgEmiBolChange
          end
          object pnlLinkPgtoCielo: TPanel
            Left = 616
            Top = 161
            Width = 317
            Height = 23
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 21
            object clbGeraLinkPgtoCielo: TColorLabel
              Left = 244
              Top = 4
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object lbGeraLinkPgtoCielo: TLabel
              Left = 31
              Top = 3
              Width = 163
              Height = 14
              Alignment = taRightJustify
              Caption = 'Gerar Link para Pagamento Cielo?'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object dbeGeraLinkPgtoCielo: TDBEditFocus
              Tag = 99
              Left = 197
              Top = 0
              Width = 45
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CND_CIELNK'
              DataSource = dtsCadCnd
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = dbeGeraLinkPgtoCieloChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
          end
          object dbeExpApp: TDBEditFocus
            Tag = 99
            Left = 813
            Top = 463
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_EXPAPP'
            DataSource = dtsCadCnd
            TabOrder = 41
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object pnlLinkPgtoCredPay: TPanel
            Left = 267
            Top = 463
            Width = 328
            Height = 23
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 42
            object clbGeraLinkPgtoCredPay: TColorLabel
              Left = 268
              Top = 4
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object lbGeraLinkPgtoCredPay: TLabel
              Left = 37
              Top = 3
              Width = 181
              Height = 14
              Alignment = taRightJustify
              Caption = 'Gerar Link para Pagamento CredPay?'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object dbeGeraLinkPgtoCredPay: TDBEditFocus
              Tag = 99
              Left = 221
              Top = 0
              Width = 45
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CND_CPAYLK'
              DataSource = dtsCadCnd
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = dbeGeraLinkPgtoCrePayChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
          end
          object pnlLinkPgtoIpag: TPanel
            Left = 9
            Top = 463
            Width = 285
            Height = 23
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 43
            object clbGeraLinkPgtoIpag: TColorLabel
              Left = 220
              Top = 4
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object lbGeraLinkPgtoIpag: TLabel
              Left = 5
              Top = 3
              Width = 160
              Height = 14
              Alignment = taRightJustify
              Caption = 'Gerar Link para Pagamento Ipag?'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object dbeGeraLinkPgtoIpag: TDBEditFocus
              Tag = 99
              Left = 171
              Top = 0
              Width = 45
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CND_IPAGLK'
              DataSource = dtsCadCnd
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = dbeGeraLinkPgtoIpagChange
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
          end
        end
        object pnlDados1: TPanel
          Left = 2
          Top = 2
          Width = 956
          Height = 93
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label1: TLabel
            Left = 103
            Top = 5
            Width = 36
            Height = 14
            Alignment = taRightJustify
            Caption = 'C'#243'digo:'
          end
          object Label2: TLabel
            Left = 87
            Top = 27
            Width = 52
            Height = 14
            Alignment = taRightJustify
            Caption = 'Descri'#231#227'o:'
          end
          object Label3: TLabel
            Left = 114
            Top = 51
            Width = 25
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fora:'
          end
          object Label6: TLabel
            Left = 58
            Top = 74
            Width = 81
            Height = 14
            Alignment = taRightJustify
            Caption = 'Cnd. Pagamento:'
          end
          object Label14: TLabel
            Left = 671
            Top = 76
            Width = 110
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo Cond. Pagamento:'
          end
          object dbeCodigo: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 1
            Width = 67
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_CODIGO'
            DataSource = dtsCadCnd
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object dbeDescri: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 24
            Width = 745
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_DESCRI'
            DataSource = dtsCadCnd
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbcTipFor: TDBComboBoxFocus
            Tag = 99
            Left = 142
            Top = 47
            Width = 67
            Height = 22
            Style = csDropDownList
            DataField = 'CND_TIPFOR'
            DataSource = dtsCadCnd
            Items.Strings = (
              'NENHUM'
              'SEMANA'
              'DEZENA'
              'QUINZENA'
              'MES'
              'DIA FIXO'
              'OUTROS')
            TabOrder = 2
            OnChange = dbcTipForChange
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object dbeCndPag: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 70
            Width = 519
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_CNDPAG'
            DataSource = dtsCadCnd
            TabOrder = 4
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object pnlDiaFix: TPanel
            Left = 216
            Top = 46
            Width = 671
            Height = 23
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 3
            Visible = False
            object lblQtdPar: TLabel
              Left = 91
              Top = 5
              Width = 80
              Height = 14
              Alignment = taRightJustify
              Caption = 'Qtd de Parcelas:'
            end
            object Label5: TLabel
              Left = 214
              Top = 5
              Width = 111
              Height = 14
              Alignment = taRightJustify
              Caption = 'Dia fixo vencimento(s):'
            end
            object lblLimite: TLabel
              Left = 449
              Top = 5
              Width = 30
              Height = 14
              Alignment = taRightJustify
              Caption = 'Limite:'
            end
            object dbeQtdPar: TDBEditFocus
              Tag = 99
              Left = 172
              Top = 1
              Width = 38
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CND_QTDPAR'
              DataSource = dtsCadCnd
              MaxLength = 2
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttNumerico
            end
            object dbcSemEnt: TDBCheckBox
              Left = 1
              Top = 4
              Width = 87
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Sem Entrada:'
              DataField = 'CND_SEMENT'
              DataSource = dtsCadCnd
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
            object cbbDiaFix: TComboBoxFocus
              Tag = 99
              Left = 327
              Top = 1
              Width = 118
              Height = 22
              Style = csOwnerDrawFixed
              ItemIndex = 0
              MaxLength = 2
              TabOrder = 2
              Text = 'DIA DA VENDA'
              OnChange = cbbDiaFixChange
              Items.Strings = (
                'DIA DA VENDA'
                'DIA 01'
                'DIA 02'
                'DIA 03'
                'DIA 04'
                'DIA 05'
                'DIA 06'
                'DIA 07'
                'DIA 08'
                'DIA 09'
                'DIA 10'
                'DIA 11'
                'DIA 12'
                'DIA 13'
                'DIA 14'
                'DIA 15'
                'DIA 16'
                'DIA 17'
                'DIA 18'
                'DIA 19'
                'DIA 20'
                'DIA 21'
                'DIA 22'
                'DIA 23'
                'DIA 24'
                'DIA 25'
                'DIA 26'
                'DIA 27'
                'DIA 28'
                'DIA 29'
                'DIA 30'
                'DIA 31')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object spnLimite: TcxDBSpinEdit
              Left = 480
              Top = 1
              DataBinding.DataField = 'CND_LIMITE'
              DataBinding.DataSource = dtsCadCnd
              Properties.AssignedValues.MinValue = True
              Properties.MaxValue = 31.000000000000000000
              Properties.UseNullString = True
              TabOrder = 3
              Width = 45
            end
            object btnLimite: TBitBtnLocked
              Left = 653
              Top = 1
              Width = 18
              Height = 20
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000010000000800000010000000100000
                0008000000010000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
                0B60000000070000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
                27EA0000000E0000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
                30EC0000000D0000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
                1A51000000050000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000010000000600000011000000140000
                000A000000020000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000670503AA999532EFF4528
                187A000000070000000100000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
                4AF724150D490000000800000002000000000000000000000000000000000000
                0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
                9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
                000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
                AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
                00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
                76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
                000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
                70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
                000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
                C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
                0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
                77E570533B9A17100A2500000002000000000000000000000000000000000000
                0000000000000000000000000000000000010000000100000002000000030000
                0002000000020000000100000000000000000000000000000000}
              ParentFont = False
              TabOrder = 5
              TabStop = False
              OnClick = btnLimiteClick
            end
            object dbcDiaCor: TDBCheckBox
              Left = 528
              Top = 4
              Width = 130
              Height = 17
              Caption = 'Independente do m'#234's'
              DataField = 'CND_DIACOR'
              DataSource = dtsCadCnd
              TabOrder = 4
              ValueChecked = 'S'
              ValueUnchecked = 'N'
            end
          end
          object dbcTipCnd: TComboBoxFocus
            Tag = 99
            Left = 783
            Top = 70
            Width = 104
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 5
            Items.Strings = (
              'A VISTA'
              'A PRAZO')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
        object pnlFormaPagto: TPanel
          Left = 2
          Top = 95
          Width = 956
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          TabOrder = 1
          object lblFormPagto: TLabel
            Left = 76
            Top = 4
            Width = 63
            Height = 14
            Alignment = taRightJustify
            Caption = 'Forma Pagto:'
          end
          object dbeCodFpg: TDBEditFocus
            Tag = 99
            Left = 142
            Top = 0
            Width = 44
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_CODFPG'
            DataSource = dtsCadCnd
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnExit = dbeCodFpgExit
            OnKeyPress = dbeCodFpgKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            PanelInfo = pnlInfo
            TipoTexto = ttAlfanumerico
          end
          object edtDesFpg: TEditFocus
            Left = 187
            Top = 0
            Width = 700
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
      end
    end
    object tbsPerfil: TTabSheet
      Caption = '&2 - Perfil'
      ImageIndex = 2
      object pnlPerfil: TPanel
        Left = 0
        Top = 0
        Width = 960
        Height = 624
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object gpbPerfil: TGroupBox
          Left = 0
          Top = 0
          Width = 960
          Height = 624
          Align = alClient
          Caption = 'Perfil'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object lbl1: TLabel
            Left = 15
            Top = 12
            Width = 52
            Height = 14
            Alignment = taRightJustify
            Caption = 'Descri'#231#227'o:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl2: TLabel
            Left = 127
            Top = 118
            Width = 153
            Height = 14
            Alignment = taRightJustify
            Caption = 'Imprime Boleto no Faturamento?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object ColorLabel3: TColorLabel
            Left = 330
            Top = 118
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object lblAltPre: TLabel
            Left = 8
            Top = 365
            Width = 212
            Height = 14
            Alignment = taRightJustify
            Caption = 'Permite Alterar Pre'#231'o do Produto (Faturam.):'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl4: TLabel
            Left = 15
            Top = 140
            Width = 265
            Height = 14
            Alignment = taRightJustify
            Caption = 'Solicitar Senha para Alterar Cnd. Pagamento Sugerida?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object ColorLabel5: TColorLabel
            Left = 330
            Top = 140
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object lbl5: TLabel
            Left = 562
            Top = 30
            Width = 203
            Height = 14
            Alignment = taRightJustify
            Caption = 'Verifica Limite de Cr'#233'dito no Faturamento?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object ColorLabel6: TColorLabel
            Left = 815
            Top = 30
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object lbl6: TLabel
            Left = 106
            Top = 411
            Width = 114
            Height = 14
            Alignment = taRightJustify
            Caption = 'Margem/Markup M'#237'nimo:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl7: TLabel
            Left = 377
            Top = 411
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'M'#225'ximo:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl8: TLabel
            Left = 377
            Top = 389
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'M'#225'ximo:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object lbl9: TLabel
            Left = 79
            Top = 389
            Width = 141
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor de Faturamento M'#237'nimo:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 609
            Top = 141
            Width = 156
            Height = 14
            Alignment = taRightJustify
            Caption = 'Ativar trava de t'#237'tulos vencidos?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object ColorLabel8: TColorLabel
            Left = 815
            Top = 140
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object lblLbPdOb: TLabel
            Left = 512
            Top = 118
            Width = 253
            Height = 14
            Alignment = taRightJustify
            Caption = 'Passar obrigatoriamente pela Libera'#231#227'o de Pedidos?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object clbLbPdOb: TColorLabel
            Left = 815
            Top = 118
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object lblMaxCar: TLabel
            Left = 590
            Top = 94
            Width = 175
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Qtd. M'#225'xima de Parcelas (Cart'#227'o):'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label12: TLabel
            Left = 27
            Top = 163
            Width = 193
            Height = 14
            Alignment = taRightJustify
            Caption = 'Travar clientes sem consulta de cr'#233'dito:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 486
            Top = 164
            Width = 280
            Height = 14
            Alignment = taRightJustify
            Caption = 'Solicitar Senha para utilizar esta Condi'#231#227'o de Pagamento?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object ColorLabel2: TColorLabel
            Left = 815
            Top = 163
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object Label18: TLabel
            Left = 103
            Top = 434
            Width = 117
            Height = 14
            Alignment = taRightJustify
            Caption = 'Valor da Parcela M'#237'nima:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label19: TLabel
            Left = 377
            Top = 434
            Width = 39
            Height = 14
            Alignment = taRightJustify
            Caption = 'M'#225'xima:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label20: TLabel
            Left = 15
            Top = 181
            Width = 205
            Height = 28
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Travar clientes sem consulta de dados de cobran'#231'a:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label31: TLabel
            Left = 546
            Top = 211
            Width = 216
            Height = 14
            Alignment = taRightJustify
            Caption = 'Travar clientes que n'#227'o compram a XX dias?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object ColorLabel10: TColorLabel
            Left = 819
            Top = 211
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object lblPetrcd: TLabel
            Left = 34
            Top = 206
            Width = 246
            Height = 28
            Alignment = taRightJustify
            Caption = 
              'Perguntar se deseja manter os pre'#231'os originais ao fazer a troca ' +
              'para esta condi'#231#227'o?'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object clbPetrcd: TColorLabel
            Left = 334
            Top = 209
            Width = 55
            Height = 14
            Caption = '(S)im (N)'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            CorDestaque = clRed
          end
          object dbeImpBol: TDBEditFocus
            Tag = 99
            Left = 283
            Top = 114
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_IMPBOL'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
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
            TipoTexto = ttAlfabetico
          end
          object dbeSenCnd: TDBEditFocus
            Tag = 99
            Left = 283
            Top = 136
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_SENCND'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
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
            TipoTexto = ttAlfabetico
          end
          object dbeLimCre: TDBEditFocus
            Tag = 99
            Left = 768
            Top = 26
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_LIMCRE'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 17
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeDesPfl: TDBMemoFocus
            Tag = 99
            Left = 15
            Top = 26
            Width = 401
            Height = 79
            DataField = 'CND_DESPFL'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            MaxLength = 255
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 0
            OnKeyPress = dbeDesPflKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
          object dbeMarMin: TDBEditFocus
            Tag = 99
            Left = 222
            Top = 408
            Width = 94
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_MARMIN'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 11
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeMarMax: TDBEditFocus
            Tag = 99
            Left = 419
            Top = 408
            Width = 94
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_MARMAX'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 12
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeFatMin: TDBEditFocus
            Tag = 99
            Left = 222
            Top = 385
            Width = 94
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_FATMIN'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeFatMax: TDBEditFocus
            Tag = 99
            Left = 419
            Top = 385
            Width = 94
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_FATMAX'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 9
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object gpbTipFat: TGroupBox
            Left = 639
            Top = 237
            Width = 234
            Height = 70
            Caption = 'Tipo de Faturamento'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 25
            object chkTipFatA: TCheckBox
              Tag = 99
              Left = 10
              Top = 19
              Width = 97
              Height = 17
              Caption = '(A) - Nota Fiscal'
              TabOrder = 0
            end
            object chkTipFatB: TCheckBox
              Tag = 99
              Left = 10
              Top = 43
              Width = 97
              Height = 17
              Caption = '(B) - FF'
              TabOrder = 2
            end
            object chkTipFatC: TCheckBox
              Tag = 99
              Left = 114
              Top = 19
              Width = 110
              Height = 17
              Caption = '(C) - Cupom Fiscal'
              TabOrder = 1
            end
            object chkTipFatD: TCheckBox
              Tag = 99
              Left = 114
              Top = 43
              Width = 110
              Height = 17
              Caption = '(D) - Divis'#237'vel'
              TabOrder = 3
            end
          end
          object dbeTrTtVe: TDBEditFocus
            Tag = 99
            Left = 768
            Top = 137
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_TRTTVE'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 21
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeLbPdOb: TDBEditFocus
            Tag = 99
            Left = 768
            Top = 114
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_LBPDOB'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 20
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeMaxCar: TDBEditFocus
            Tag = 99
            Left = 768
            Top = 90
            Width = 74
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_MAXCAR'
            DataSource = dtsCadCnd
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 19
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbcTrClCr: TComboBoxFocus
            Tag = 99
            Left = 222
            Top = 159
            Width = 106
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 3
            Items.Strings = (
              'N'#195'O AVISA'
              'AVISA'
              'TRAVA')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object dbcAltPre: TComboBoxFocus
            Tag = 99
            Left = 222
            Top = 361
            Width = 291
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 7
            Items.Strings = (
              'N'#195'O.'
              'SIM, SOMENTE PARA CIMA DO PRE'#199'O SUGERIDO.'
              'SIM, SEMPRE.'
              'SIM, SOMENTE PARA PRODUTOS EM PROMO'#199#195'O.')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object gpbFpgNvl: TGroupBox
            Left = 636
            Top = 48
            Width = 221
            Height = 35
            Caption = 'N'#227'o validar Limite de cr'#233'dito para:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 18
            object chkNaoValidaDin: TCheckBox
              Left = 9
              Top = 15
              Width = 66
              Height = 17
              Caption = 'DINHEIRO'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object chkNaoValidaChq: TCheckBox
              Left = 82
              Top = 15
              Width = 61
              Height = 17
              Caption = 'CHEQUE'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object chkNaoValidaCar: TCheckBox
              Left = 152
              Top = 15
              Width = 65
              Height = 17
              Caption = 'CART'#195'O'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
          end
          object dbeSenTra: TDBEditFocus
            Tag = 99
            Left = 768
            Top = 160
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_SENTRA'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 22
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbeParMin: TDBEditFocus
            Tag = 99
            Left = 222
            Top = 431
            Width = 94
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_PARMIN'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 14
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbeParMax: TDBEditFocus
            Tag = 99
            Left = 419
            Top = 431
            Width = 94
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_PARMAX'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 15
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttNumerico
          end
          object dbcTrClCb: TComboBoxFocus
            Tag = 99
            Left = 222
            Top = 183
            Width = 106
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 4
            Items.Strings = (
              'N'#195'O AVISA'
              'AVISA'
              'TRAVA')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object GroupBox1: TGroupBox
            Left = 15
            Top = 237
            Width = 498
            Height = 118
            Caption = ' Or'#231'amento '
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            object Label21: TLabel
              Left = 71
              Top = 21
              Width = 193
              Height = 14
              Alignment = taRightJustify
              Caption = 'Travar clientes sem consulta de cr'#233'dito:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label22: TLabel
              Left = 10
              Top = 44
              Width = 254
              Height = 14
              Alignment = taRightJustify
              Caption = 'Travar clientes sem consulta de dados de cobran'#231'a:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object lblTravaOrcForaIntervalo: TLabel
              Left = 3
              Top = 69
              Width = 261
              Height = 14
              Alignment = taRightJustify
              Caption = 'Travar valor do documento fora do intervalo permitido:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lblTravaOrParcForaIntervalo: TLabel
              Left = 20
              Top = 92
              Width = 244
              Height = 14
              Alignment = taRightJustify
              Caption = 'Travar valor da parcela fora do intervalo permitido:'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object dbcTrOrCr: TComboBoxFocus
              Tag = 99
              Left = 267
              Top = 17
              Width = 106
              Height = 22
              Style = csDropDownList
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 0
              Items.Strings = (
                'N'#195'O AVISA'
                'AVISA'
                'TRAVA')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object dbcTrOrCb: TComboBoxFocus
              Tag = 99
              Left = 267
              Top = 41
              Width = 106
              Height = 22
              Style = csDropDownList
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 1
              Items.Strings = (
                'N'#195'O AVISA'
                'AVISA'
                'TRAVA')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object dbcTrOrFi: TComboBoxFocus
              Tag = 99
              Left = 267
              Top = 65
              Width = 106
              Height = 22
              Style = csDropDownList
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 2
              Items.Strings = (
                'N'#195'O AVISA'
                'AVISA'
                'TRAVA')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
            object dbcTrOrPf: TComboBoxFocus
              Tag = 99
              Left = 267
              Top = 89
              Width = 106
              Height = 22
              Style = csDropDownList
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 3
              Items.Strings = (
                'N'#195'O AVISA'
                'AVISA'
                'TRAVA')
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
            end
          end
          object dbcTraPar: TComboBoxFocus
            Tag = 99
            Left = 515
            Top = 431
            Width = 261
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemIndex = 0
            ParentFont = False
            TabOrder = 16
            Text = 'TRAVAR COM OP'#199#195'O DE LIBERAR COM SENHA'
            Items.Strings = (
              'TRAVAR COM OP'#199#195'O DE LIBERAR COM SENHA'
              'TRAVAR SEM OP'#199#195'O  DE LIBERAR COM SENHA')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object dbcTraMar: TComboBoxFocus
            Tag = 99
            Left = 515
            Top = 408
            Width = 261
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemIndex = 0
            ParentFont = False
            TabOrder = 13
            Text = 'TRAVAR COM OP'#199#195'O DE LIBERAR COM SENHA'
            Items.Strings = (
              'TRAVAR COM OP'#199#195'O DE LIBERAR COM SENHA'
              'TRAVAR SEM OP'#199#195'O  DE LIBERAR COM SENHA')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object dbcTraFat: TComboBoxFocus
            Tag = 99
            Left = 515
            Top = 385
            Width = 261
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemIndex = 0
            ParentFont = False
            TabOrder = 10
            Text = 'TRAVAR COM OP'#199#195'O DE LIBERAR COM SENHA'
            Items.Strings = (
              'TRAVAR COM OP'#199#195'O DE LIBERAR COM SENHA'
              'TRAVAR SEM OP'#199#195'O  DE LIBERAR COM SENHA')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object pnlRecebimentoPix: TPanel
            Left = 580
            Top = 183
            Width = 290
            Height = 24
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 23
            object Label27: TLabel
              Left = 0
              Top = 3
              Width = 182
              Height = 14
              Alignment = taRightJustify
              Caption = 'Ativar o recebimento por meio do Pix?'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object ColorLabel9: TColorLabel
              Left = 235
              Top = 3
              Width = 55
              Height = 14
              Caption = '(S)im (N)'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              CorDestaque = clRed
            end
            object dbeRecebimentoPix: TDBEditFocus
              Tag = 99
              Left = 188
              Top = 0
              Width = 45
              Height = 22
              CharCase = ecUpperCase
              DataField = 'CND_RECPIX'
              DataSource = dtsCadCnd
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TipoTexto = ttAlfabetico
            end
          end
          object dbeTravaCliCompra: TDBEditFocus
            Tag = 99
            Left = 768
            Top = 208
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_TRACNC'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 24
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
          object dbePetRcd: TDBEditFocus
            Tag = 99
            Left = 283
            Top = 206
            Width = 45
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CND_PETRCD'
            DataSource = dtsCadCnd
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfabetico
          end
        end
        object pnlEspFat: TPanel
          Left = 588
          Top = 311
          Width = 290
          Height = 24
          BevelOuter = bvNone
          TabOrder = 1
          object Label29: TLabel
            Left = 0
            Top = 4
            Width = 231
            Height = 14
            Alignment = taRightJustify
            Caption = 'Tipo de Faturamento Principal para a Expedi'#231#227'o:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object dbcEspFat: TComboBoxFocus
            Tag = 99
            Left = 236
            Top = 0
            Width = 49
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ParentFont = False
            TabOrder = 0
            Items.Strings = (
              'NF'
              'FF'
              'IF')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
        end
      end
    end
    object tbsEmpresas: TTabSheet
      Caption = '&3 - Empresas Acesso'
      ImageIndex = 1
      object pnlEmpresas: TPanel
        Left = 0
        Top = 0
        Width = 960
        Height = 624
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object clbEmpCnd: TCheckListBox
          Left = 0
          Top = 0
          Width = 960
          Height = 607
          OnClickCheck = clbEmpCndClickCheck
          Align = alClient
          ItemHeight = 14
          TabOrder = 0
        end
        object pnlSelEmp: TPanel
          Left = 0
          Top = 607
          Width = 960
          Height = 17
          Align = alBottom
          BevelOuter = bvNone
          Color = clGray
          ParentBackground = False
          TabOrder = 1
          Visible = False
          object lblLegenda: TLabel
            Left = 0
            Top = 0
            Width = 960
            Height = 17
            Align = alClient
            Alignment = taCenter
            Caption = '[F8] Marcar Todas       [F9] Desmarcar Todas'
            Color = clGray
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            ExplicitWidth = 237
            ExplicitHeight = 14
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 688
    Top = 1
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 624
    Top = 1
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 728
    Top = 0
  end
  object dtsCadCnd: TDataSource
    OnStateChange = dtsCadCndStateChange
    OnDataChange = dtsCadCndDataChange
    Left = 656
    Top = 1
  end
end
