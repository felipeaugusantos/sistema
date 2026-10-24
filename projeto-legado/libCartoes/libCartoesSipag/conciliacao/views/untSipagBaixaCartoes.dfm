inherited frmSipagBaixaCartoes: TfrmSipagBaixaCartoes
  Left = 293
  Top = 161
  Width = 1365
  Height = 841
  Caption = 'Baixa de Cart'#245'es (SIPAG)'
  Position = poMainFormCenter
  WindowState = wsMaximized
  ExplicitWidth = 1365
  ExplicitHeight = 841
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 771
    Width = 1359
    TabOrder = 5
    ExplicitTop = 771
    ExplicitWidth = 1359
    DesignSize = (
      1359
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1355
      ExplicitWidth = 1355
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 796
    Width = 1359
    ExplicitTop = 796
    ExplicitWidth = 1359
    inherited pnlNomeForm: TPanel
      Left = 1191
      Width = 168
      ExplicitLeft = 1191
      ExplicitWidth = 168
    end
    inherited pnlInfo: TPanel
      Width = 1191
      ExplicitWidth = 1191
      object shpMultSel: TShape
        Left = 610
        Top = 2
        Width = 16
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
    end
  end
  inherited pgcDados: TPageControl
    Width = 991
    Height = 771
    Visible = False
    ExplicitWidth = 991
    ExplicitHeight = 771
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 983
      ExplicitHeight = 739
    end
  end
  object pnlAux1: TPanel [3]
    Left = 991
    Top = 0
    Width = 368
    Height = 771
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 4
    object pnlDadosDup: TPanel
      Left = 0
      Top = 0
      Width = 368
      Height = 771
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object lblCliente: TLabel
        Left = 63
        Top = 14
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object lblOperadora: TLabel
        Left = 44
        Top = 60
        Width = 55
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operadora:'
      end
      object lblPerCar: TLabel
        Left = 56
        Top = 106
        Width = 42
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tx. Adm:'
      end
      object lblValorBruto: TLabel
        Left = 31
        Top = 129
        Width = 67
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Sem Taxa:'
      end
      object lblHistorico: TLabel
        Left = 53
        Top = 198
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object lblPerCarPercent: TLabel
        Left = 195
        Top = 106
        Width = 10
        Height = 14
        Caption = '%'
      end
      object lblValorTaxa: TLabel
        Left = 55
        Top = 152
        Width = 43
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vr. Taxa:'
      end
      object lblNome: TLabel
        Left = 68
        Top = 37
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object lblDataTransacao: TLabel
        Left = 27
        Top = 83
        Width = 71
        Height = 14
        Alignment = taRightJustify
        Caption = 'Dt. Transa'#231#227'o:'
      end
      object flbConciliacao: TFileListBox
        Left = 6
        Top = 331
        Width = 275
        Height = 112
        ItemHeight = 14
        TabOrder = 9
        Visible = False
      end
      object edtCodCli: TEditFocus
        Left = 99
        Top = 11
        Width = 252
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtNomCli: TEditFocus
        Left = 99
        Top = 34
        Width = 252
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtPerCar: TEditFocus
        Left = 99
        Top = 103
        Width = 94
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtValOri: TEditFocus
        Left = 99
        Top = 126
        Width = 94
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtValTax: TEditFocus
        Left = 99
        Top = 149
        Width = 94
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object edtHist01: TEditFocus
        Left = 99
        Top = 195
        Width = 252
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtHist02: TEditFocus
        Left = 99
        Top = 218
        Width = 252
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object edtOperad: TEditFocus
        Left = 99
        Top = 57
        Width = 252
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
      object pnlInformativos: TPanel
        Left = 2
        Top = 699
        Width = 364
        Height = 70
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 8
        object grpLegendaBaixas: TGroupBox
          Left = 16
          Top = 1
          Width = 336
          Height = 65
          Caption = 'Legenda'
          TabOrder = 0
          object Shape1: TShape
            Left = 8
            Top = 16
            Width = 14
            Height = 14
          end
          object Label21: TLabel
            Left = 27
            Top = 16
            Width = 65
            Height = 14
            Caption = 'Selecionados'
          end
          object Shape2: TShape
            Left = 8
            Top = 32
            Width = 14
            Height = 14
          end
          object Label24: TLabel
            Left = 27
            Top = 32
            Width = 62
            Height = 14
            Caption = 'Transferidos'
          end
          object Label25: TLabel
            Left = 11
            Top = 16
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
            StyleElements = [seClient, seBorder]
          end
          object Label26: TLabel
            Left = 11
            Top = 32
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
            StyleElements = [seClient, seBorder]
          end
          object Shape3: TShape
            Left = 8
            Top = 48
            Width = 14
            Height = 14
          end
          object lblNaoTransferidos: TLabel
            Left = 27
            Top = 48
            Width = 84
            Height = 14
            Caption = 'N'#227'o Transferidos'
          end
          object Label27: TLabel
            Left = 11
            Top = 48
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
            StyleElements = [seClient, seBorder]
          end
          object Shape4: TShape
            Left = 120
            Top = 16
            Width = 14
            Height = 14
          end
          object Label29: TLabel
            Left = 139
            Top = 16
            Width = 114
            Height = 14
            Caption = 'Cancelamentos/Ajustes'
          end
          object Label30: TLabel
            Left = 123
            Top = 16
            Width = 8
            Height = 14
            Caption = 'A'
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = True
            StyleElements = [seClient, seBorder]
          end
        end
      end
      object edtDtaCup: TEditFocus
        Left = 99
        Top = 80
        Width = 94
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
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
      object pnlDadosConcil: TPanel
        Left = 4
        Top = 263
        Width = 354
        Height = 283
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 11
        Visible = False
        object lblPontoDeVenda: TLabel
          Left = 13
          Top = 5
          Width = 79
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ponto de Venda:'
        end
        object lblPortadorBaixa: TLabel
          Left = 18
          Top = 28
          Width = 74
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador Baixa:'
        end
        object lblPlanoContasBaixa: TLabel
          Left = 31
          Top = 51
          Width = 61
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta Baixa:'
        end
        object lblPortadorTaxa: TLabel
          Left = 22
          Top = 97
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador Taxa:'
        end
        object lblFornecedorTaxa: TLabel
          Left = 7
          Top = 119
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fornecedor Taxa:'
        end
        object lblPlanoDeContasTaxa: TLabel
          Left = 35
          Top = 143
          Width = 57
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta Taxa:'
        end
        object lblPortadorDebito: TLabel
          Left = 15
          Top = 189
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador D'#233'bito:'
        end
        object lblPlanoContasDebito: TLabel
          Left = 28
          Top = 212
          Width = 64
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conta D'#233'bito:'
        end
        object lblCentroCustosDebito: TLabel
          Left = 9
          Top = 235
          Width = 83
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ctr. Custo D'#233'bito:'
        end
        object lblPlanoContasAntecipacao: TLabel
          Left = 7
          Top = 258
          Width = 85
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cta. Antecipa'#231#227'o:'
        end
        object lblCentroCustosBaixa: TLabel
          Left = 12
          Top = 74
          Width = 80
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ctr. Custo Baixa:'
        end
        object lblCentroDeCustosTaxa: TLabel
          Left = 17
          Top = 166
          Width = 76
          Height = 14
          Alignment = taRightJustify
          Caption = 'Ctr. Custo Taxa:'
        end
        object edtPonVen: TEditFocus
          Left = 93
          Top = 2
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtPorBai: TEditFocus
          Left = 93
          Top = 25
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtCtaBai: TEditFocus
          Left = 93
          Top = 48
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtPorTax: TEditFocus
          Left = 93
          Top = 94
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtForTax: TEditFocus
          Left = 93
          Top = 117
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtCtaTax: TEditFocus
          Left = 93
          Top = 140
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtPorDeb: TEditFocus
          Left = 93
          Top = 186
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtCtaDeb: TEditFocus
          Left = 93
          Top = 209
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtEveDeb: TEditFocus
          Left = 93
          Top = 232
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtCtaAnt: TEditFocus
          Left = 93
          Top = 255
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtEventoBaixa: TEditFocus
          Left = 93
          Top = 71
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
        object edtEventoTaxaBaixa: TEditFocus
          Left = 93
          Top = 163
          Width = 252
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
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
      end
      object pnlAntecipacao: TPanel
        Left = 195
        Top = 149
        Width = 162
        Height = 22
        BevelOuter = bvNone
        Caption = 'pnlAntecipacao'
        ShowCaption = False
        TabOrder = 13
        Visible = False
        object lblAntTax: TLabel
          Left = 1
          Top = 3
          Width = 65
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Taxa Ant.:'
        end
        object edtAntTax: TEditFocus
          Left = 68
          Top = 0
          Width = 88
          Height = 22
          Hint = 'Valor da taxa de Antecipa'#231#227'o.'
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
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
      object pnlMarketPlace: TPanel
        Left = 0
        Top = 172
        Width = 358
        Height = 22
        BevelOuter = bvNone
        Color = 16770261
        Constraints.MinWidth = 358
        ParentBackground = False
        TabOrder = 12
        Visible = False
        object lblFreteMkt: TLabel
          Left = 53
          Top = 3
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Frete:'
        end
        object lblAjustesMkt: TLabel
          Left = 203
          Top = 3
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Ajustes:'
        end
        object edtValorFrete: TEditFocus
          Left = 99
          Top = 0
          Width = 94
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtValorAjuste: TEditFocus
          Left = 263
          Top = 0
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
      object pnlCupomMarketPlace: TPanel
        Left = 195
        Top = 126
        Width = 162
        Height = 22
        BevelOuter = bvNone
        Caption = 'pnlAntecipacao'
        ShowCaption = False
        TabOrder = 14
        Visible = False
        object lblCupomMarketPlace: TLabel
          Left = 13
          Top = 3
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Cupom:'
        end
        object edtCupomMarketPlace: TEditFocus
          Left = 68
          Top = 0
          Width = 88
          Height = 22
          Hint = 'Valor do Cupom de Desconto.'
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
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
      object pnlPorcenTaxaAntecipacao: TPanel
        Left = 211
        Top = 84
        Width = 149
        Height = 42
        BevelOuter = bvNone
        TabOrder = 15
        Visible = False
        object lblPorcenTaxaAnt: TLabel
          Left = 13
          Top = 23
          Width = 37
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tx. Ant:'
        end
        object edtPorcentagemTaxaAntecipacao: TEditFocus
          Left = 52
          Top = 19
          Width = 88
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
    end
  end
  object pnlAux2: TPanel [4]
    Left = 0
    Top = 0
    Width = 991
    Height = 771
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlTotais: TPanel
      Left = 0
      Top = 699
      Width = 991
      Height = 72
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      object pnlAjustaTotal1: TPanel
        Left = 2
        Top = 2
        Width = 418
        Height = 68
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lblRecebendo: TLabel
          Left = 202
          Top = 42
          Width = 58
          Height = 14
          Alignment = taRightJustify
          Caption = 'Recebendo:'
        end
        object lblTotal: TLabel
          Left = 235
          Top = 22
          Width = 25
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total:'
        end
        object lblQtdTotal: TLabel
          Left = 281
          Top = 4
          Width = 55
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade'
        end
        object lblTotalBruto: TLabel
          Left = 375
          Top = 4
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Bruto'
        end
        object edtQtdDup: TEditFocus
          Left = 262
          Top = 18
          Width = 75
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtQtdSel: TEditFocus
          Left = 262
          Top = 39
          Width = 75
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtTotDup: TEditFocus
          Left = 336
          Top = 18
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtTotSel: TEditFocus
          Left = 336
          Top = 39
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
      object pnlAjustaTotal2: TPanel
        Left = 420
        Top = 2
        Width = 80
        Height = 68
        Align = alLeft
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        Visible = False
        object lblTotalAjustes: TLabel
          Left = 28
          Top = 4
          Width = 53
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr. Ajustes'
        end
        object edtAjuTot: TEditFocus
          Left = -1
          Top = 18
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtAjuSel: TEditFocus
          Left = -1
          Top = 39
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
      object pnlAjustaTotal3: TPanel
        Left = 500
        Top = 2
        Width = 489
        Height = 68
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object lblTotalLiquido: TLabel
          Left = 34
          Top = 4
          Width = 48
          Height = 14
          Alignment = taRightJustify
          Caption = 'Vr.L'#237'quido'
        end
        object edtTotDupLiq: TEditFocus
          Left = 0
          Top = 18
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
        object edtTotSelLiq: TEditFocus
          Left = 0
          Top = 39
          Width = 82
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
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
    object grdDuplic: TcxGridCitel
      Left = 0
      Top = 0
      Width = 991
      Height = 699
      Align = alClient
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdDuplicDados: TcxGridDBTableViewCitel
        OnKeyDown = grdDuplicDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCustomDrawCell = grdDuplicDadosCustomDrawCell
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.FocusRect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdDuplicDadosMCA_NUMCCD: TcxGridDBColumn
          Caption = 'N'#250'm. Libera'#231#227'o'
          DataBinding.FieldName = 'MCA_NUMCCD'
          Width = 81
        end
        object grdDuplicDadosMCA_NUMNSU: TcxGridDBColumn
          Caption = 'NSU'
          DataBinding.FieldName = 'MCA_NUMNSU'
          Width = 118
        end
        object grdDuplicDadosMCA_NUMPOK: TcxGridDBColumn
          Caption = 'N'#250'm. Pedido'
          DataBinding.FieldName = 'MCA_NUMPOK'
          Width = 90
        end
        object grdDuplicDadosMCA_CODEMP: TcxGridDBColumn
          Caption = 'Emp.Fat.'
          DataBinding.FieldName = 'MCA_CODEMP'
          Width = 42
        end
        object grdDuplicDadosMCA_EMPRCX: TcxGridDBColumn
          Caption = 'Emp.Ori.'
          DataBinding.FieldName = 'MCA_EMPRCX'
          Width = 42
        end
        object grdDuplicDadosMCA_DTAVEN: TcxGridDBColumn
          Caption = 'Vencimento'
          DataBinding.FieldName = 'MCA_DTAVEN'
          Width = 63
        end
        object grdDuplicDadosMCA_DTACAD: TcxGridDBColumn
          Caption = 'Cadastro'
          DataBinding.FieldName = 'MCA_DTACAD'
          Width = 67
        end
        object grdDuplicDadosMCA_VALTOT: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'MCA_VALTOT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Properties.EditFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 76
        end
        object grdDuplicDadosMCA_VALSTA: TcxGridDBColumn
          Caption = 'Vl. Bruto'
          DataBinding.FieldName = 'MCA_VALSTA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Properties.EditFormat = ',0.00;-,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 57
        end
        object grdDuplicDadosMCA_NUMNOT: TcxGridDBColumn
          Caption = 'N'#250'm. Nota'
          DataBinding.FieldName = 'MCA_NUMNOT'
          Width = 120
        end
        object grdDuplicDadosPARDUP: TcxGridDBColumn
          Caption = 'Parc.'
          DataBinding.FieldName = 'PARDUP'
          Width = 37
        end
        object grdDuplicDadosMCA_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'MCA_MARDES'
          Visible = False
          Width = 20
          IsCaptionAssigned = True
        end
        object grdDuplicDadosMCA_RESCAI: TcxGridDBColumn
          DataBinding.FieldName = 'MCA_RESCAI'
          Visible = False
          HeaderAlignmentHorz = taRightJustify
        end
        object grdDuplicDadosMCA_DTATRA: TcxGridDBColumn
          DataBinding.FieldName = 'MCA_DTATRA'
          Visible = False
        end
        object grdDuplicDadosMCA_AJUSTE: TcxGridDBColumn
          DataBinding.FieldName = 'MCA_AJUSTE'
          Visible = False
        end
        object grdDuplicDadosSIT_CAD: TcxGridDBColumn
          Caption = 'Sit. Cadastro'
          DataBinding.FieldName = 'SIT_CAD'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = imgSitCad
          Properties.Items = <
            item
              Description = 'Incompleto'
              ImageIndex = 1
              Value = 'INCOMPLETO'
            end
            item
              Description = 'Completo'
              ImageIndex = 2
              Value = 'COMPLETO'
            end>
          Properties.ShowDescriptions = False
          Width = 76
        end
        object grdDuplicDadosMCA_TRFLIB: TcxGridDBColumn
          DataBinding.FieldName = 'MCA_TRFLIB'
          Visible = False
          Options.Editing = False
          Options.Filtering = False
          Options.FilteringAddValueItems = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          VisibleForCustomization = False
        end
        object grdDuplicDadosNEGOCIACAO: TcxGridDBColumn
          DataBinding.FieldName = 'NEGOCIACAO'
          Visible = False
          VisibleForCustomization = False
        end
        object grdDuplicDadosNEGOCIADO_ANTERIORMENTE: TcxGridDBColumn
          Caption = 'NEGOCIACAO_ANT'
          DataBinding.FieldName = 'NEGOCIADO_ANTERIORMENTE'
          Visible = False
          VisibleForCustomization = False
        end
        object grdDuplicDadosBAN_NOMBAN: TcxGridDBColumn
          Caption = 'Bandeira'
          DataBinding.FieldName = 'BAN_NOMBAN'
          HeaderAlignmentHorz = taCenter
          Width = 57
        end
        object grdDuplicDadosCARTAO: TcxGridDBColumn
          Caption = 'Cart'#227'o'
          DataBinding.FieldName = 'CARTAO'
          HeaderAlignmentHorz = taCenter
        end
        object grdDuplicDadosESTABE: TcxGridDBColumn
          Caption = 'N'#186' Estabelecimento'
          DataBinding.FieldName = 'MCA_ESTABE'
          Visible = False
          VisibleForCustomization = False
          VisibleForEditForm = bFalse
        end
        object grdDuplicDadosREGISTROTRANSFERENCIA: TcxGridDBColumn
          DataBinding.FieldName = 'REGISTROTRANSFERENCIA'
          Visible = False
          VisibleForCustomization = False
          VisibleForEditForm = bFalse
        end
      end
      object grdDuplicNivel: TcxGridLevel
        GridView = grdDuplicDados
      end
    end
  end
  object pnlBotoesBaixa: TPanel [5]
    Left = 0
    Top = 771
    Width = 1359
    Height = 25
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    TabOrder = 3
    object FlwBotoesBaixa: TFlowPanel
      Left = 2
      Top = 2
      Width = 1258
      Height = 21
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 90
        Height = 21
        Caption = '[ F10 ] Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnAjuVal: TBitBtnLocked
        Left = 90
        Top = 0
        Width = 104
        Height = 21
        Caption = '[ F2 ] Ajustar Valor'
        TabOrder = 1
        Visible = False
        OnClick = btnAjuValClick
      end
      object btnRelatorio: TBitBtnLocked
        Left = 194
        Top = 0
        Width = 80
        Height = 21
        Caption = '[F3] Relat'#243'rio'
        TabOrder = 2
        Visible = False
        OnClick = btnRelatorioClick
      end
      object btnConfigurarGrid: TBitBtnLocked
        Left = 274
        Top = 0
        Width = 142
        Height = 21
        Align = alLeft
        Caption = 'Configurar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000900000012000000120000
          0009000000020000000000000000000000000000000000000000000000000000
          0000000000030000000A0000000A0000000B2519156F68473BFF67443BFF1D13
          0F700000000C0000000B0000000C000000050000000100000000000000000000
          00030403021A543B33C738251EB30D0907454C362DC4B5A198FFAB958AFF3E29
          23C50D080748311F1AB13A241ECE030202220000000400000000000000000000
          00085A4138C9C7B9B0FFA8958BFF6C4F47FF715044FECABAB0FFC6B5AAFF6142
          37FE6B5047FE9C857AFFA89388FF3B241FCB0000000B00000000000000000000
          00074C3930ABC0AEA7FFE3DBD5FFD2C3BAFFC1AFA6FFCFC0B7FFCEBEB5FFBCAA
          9FFFCAB9AEFFC9B8ADFF9F897FFF36221DB20000000A00000000000000010000
          0007110C0B368D6F65FCEAE3DFFFDACDC6FFD8CCC3FFE3D9D3FFE7E0DAFFE1D6
          D0FFD2C3B9FFCDBCB3FF705449FE0D0907410000000A00000002000000042A1E
          1A6B4C372EBB846356FED9CEC8FFE3DAD5FFCDBEB7FF8E6F62FF947567FFD0C0
          B9FFE3DAD3FFC8B7ADFF6A4940FF47312AC22418147100000007000000088D6D
          60FFD8CCC7FFEEE8E5FFEBE6E0FFEAE3DDFF7F6257FF2219155E241B175E9374
          67FFEBE4DFFFD6C8C0FFD3C6BDFFB9A59BFF78574BFF0000000D000000079373
          64FFD9CECAFFF6F3F2FFFAF7F6FFEFEAE5FF76574DFF1D1411551E1613568869
          5DFFEFE9E6FFDDD2CBFFD8CAC3FFC7B8B1FF7E5B4FFF0000000C000000033428
          245F665046B5937467FEECE6E3FFF0ECE8FFCEC2BDFF856961FF886D65FFD2C7
          C2FFECE4DFFFD9CFC9FF856458FD5A443AB92B201C6102010108000000000000
          000316110F2EA78B7EFDF6F4F1FFF3EFECFFF2EEEAFFF3EFECFFF0EBE7FFEFEA
          E6FFEFEBE7FFECE5E0FF83665BFD110C0B390000000600000001000000000000
          0003685349AADCD1CBFFF8F6F3FFF8F5F3FFEBE4E1FFFDFCFBFFF3EEECFFE2D8
          D3FFFAF9F8FFF9F7F5FFC8B9B3FF4E3931B00000000500000000000000000000
          0002776055BDE5DDD8FFDCD0CBFFAC9183FD9E7E6EFDFBF8F8FFF5F1EEFF9979
          6AFDA3897EFCD7CBC5FFE0D6D1FF6E564CC20000000500000000000000000000
          00010605040D7C6458BF69544BA51713102B6F594EB2E1D7D2FFE0D6D1FF6D57
          4DB314100E2B614D44A4775E53C7050404110000000100000000000000000000
          0000000000000000000100000002000000023B302A5EA68676FFA58375FF3A2F
          295F000000030000000300000003000000010000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000030000
          0001000000000000000000000000000000000000000000000000}
        TabOrder = 3
        OnClick = btnConfigurarGridClick
      end
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 1260
      Top = 2
      Width = 97
      Height = 21
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 1
      OnClick = btnSairBaixaClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 808
    Top = 24
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 896
    Top = 24
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 256
    Top = 304
  end
  object imgSitCad: TImageList
    Left = 644
    Top = 204
    Bitmap = {
      494C010103000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      F700000000000000000000000000000000000000000000000000000000000000
      0000BDBDF7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BE7000000
      CE008484E7000000000000000000000000000000000000000000000000008484
      E7000000CE006B6BE70000000000000000000000000000000000C6E7C60008A5
      390010AD420008AD420063AD7300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDEF000000CE000000
      CE000000CE008484E700000000000000000000000000000000008484E7000000
      CE000000CE000000CE00BDBDEF0000000000000000000000000052B56B004AE7
      9C005AEFAD005AEFAD0021C66B0052A56B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484E7000000
      C6000000C6000000C6008484E70000000000000000008484E7000000C6000000
      C6000000C6008484E7000000000000000000000000000000000018B55A0063FF
      CE006BFFCE0052FFC6004AFFBD0018C66B0052A5630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      DE000000BD000000BD000000BD008484DE008484DE000000BD000000BD000000
      BD008484DE00000000000000000000000000000000009CCEA50010DE840029FF
      B50029FFAD0018FFAD0000FFA50010FF9C0008BD5A00429C5200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484DE000000B5000000B5000000B5000000B5000000B5000000B5008484
      DE00000000000000000000000000000000000000000042AD5A0000FF940000FF
      9C0008FFA50010FF9C0021FFA50031F7A50042EF9C0010B552004AA55A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484DE000000B5000000B5000000B5000000B5008484DE000000
      0000000000000000000000000000000000000000000000AD420000F7940029F7
      A5004AF7AD0063C68C005AE7A50073F7B5006BEFAD0063E79C0018AD4A00399C
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484D6000000AD000000AD000000AD000000AD008484D6000000
      00000000000000000000000000000000000094C6940010CE63004AEFA50063F7
      B50052CE7B0000000000ADD6B50052BD7B0084EFB50084E7AD0084D69C0029AD
      4A0039A54A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484D6000000A5000000A5000000A5000000A5000000A5000000A5008484
      D600000000000000000000000000000000007BC6840052DE940073E7AD006BEF
      AD0094CE9C000000000000000000D6E7D60063B5730094E7B50094DEAD009CDE
      AD0039AD52002994310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      D60000009C0000009C0000009C008484D6008484D6000000A5000000A5000000
      A5008484D600000000000000000000000000000000008CBD8C005AB573004AB5
      6B0000000000000000000000000000000000D6E7D6006BB57300ADE7BD00ADDE
      B500B5DEB50052AD630029943100D6EFD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008484CE000000
      9C0000009C0000009C008484CE0000000000000000008484CE0000009C000000
      9C0000009C008484CE0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000073B57B00C6E7
      C600BDDEBD00CEE7CE006BBD7B0073B573000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDDE00000094000000
      9400000094008484CE00000000000000000000000000000000008484CE000000
      94000000940000009400BDBDE700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007BB5
      7B00DEEFDE00E7F7E700A5D6A500ADCEAD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6BBD000000
      8C008484CE000000000000000000000000000000000000000000000000008484
      CE0000008C006B6BBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000073A573008CBD8C00C6D6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      DE00000000000000000000000000000000000000000000000000000000000000
      0000BDBDDE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFEFF7FFFF0000
      FFFFC7E3C1FF0000FFFF83C1C0FF0000FFFFC183C07F0000FFFFE007803F0000
      FFFFF00F801F0000FFFFF81F800F0000FFFFF81F04070000FFFFF00F06030000
      FFFFE0078F000000FFFFC183FFC00000FFFF83C1FFE00000FFFFC7E3FFF10000
      FFFFEFF7FFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
end
