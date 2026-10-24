object frmQckRcxReciboBai2: TfrmQckRcxReciboBai2
  Left = 227
  Top = 54
  Caption = 'frmQckRcxReciboBai2'
  ClientHeight = 636
  ClientWidth = 828
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object qckPagina: TRLReport
    Left = 4
    Top = 2
    Width = 816
    Height = 624
    Margins.TopMargin = 5.000000000000000000
    DataSource = dtsImpRec
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 10
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxBands = 15
    MinBands = 15
    PageSetup.PaperSize = fpCustom
    PageSetup.PaperWidth = 215.900000000000000000
    PageSetup.PaperHeight = 165.000000000000000000
    ShowProgress = False
    ExpressionParser = RLExpressionParser1
    BeforePrint = qckPaginaBeforePrint
    object rlbHeader1: TRLBand
      Left = 38
      Top = 19
      Width = 740
      Height = 118
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      BeforePrint = rlbHeader1BeforePrint
      object rllNomEmp: TRLLabel
        Left = 343
        Top = 21
        Width = 54
        Height = 16
        Alignment = taCenter
        Caption = 'RECIBO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = rllNomEmpBeforePrint
      end
      object rllNomRel: TRLLabel
        Left = 6
        Top = 41
        Width = 133
        Height = 13
        AutoSize = False
        Caption = 'RECEBEMOS DE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = rllNomRelBeforePrint
      end
      object rllNomCli: TRLLabel
        Left = 143
        Top = 41
        Width = 505
        Height = 13
        AutoSize = False
        Caption = '000000 - NOME DO CLIENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rllEndCli: TRLLabel
        Left = 143
        Top = 60
        Width = 562
        Height = 13
        AutoSize = False
        Caption = 'ENDERE'#199'O - CEP - CIDADE DO CLIENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rllImportancia: TRLLabel
        Left = 8
        Top = 79
        Width = 180
        Height = 13
        AutoSize = False
        Caption = 'A IMPORTANCIA ACIMA DE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = rllImportanciaBeforePrint
      end
      object rllValorExtenso: TRLLabel
        Left = 191
        Top = 79
        Width = 545
        Height = 13
        AutoSize = False
        Caption = 'VALOR POR EXTENSO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = rllValorExtensoBeforePrint
      end
      object rllParcelas: TRLLabel
        Left = 8
        Top = 98
        Width = 572
        Height = 13
        AutoSize = False
        Caption = 'REFERENTE AO PAGAMENTO DA(S) PARCELA(S):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = rllParcelasBeforePrint
      end
      object rllTotRec: TRLLabel
        Left = 583
        Top = 21
        Width = 123
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'R$ XXXXXX,XX'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentFont = False
        BeforePrint = rllTotRecBeforePrint
      end
      object rllCaixa: TRLLabel
        Left = 605
        Top = 99
        Width = 131
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CAIXA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Transparent = False
        BeforePrint = rllCaixaBeforePrint
      end
    end
    object hedCabDoc: TRLBand
      Left = 38
      Top = 137
      Width = 740
      Height = 24
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 10
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      object RLPanel1: TRLPanel
        Left = 0
        Top = 4
        Width = 370
        Height = 18
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = True
        Borders.DrawBottom = False
        object rllDescri: TRLLabel
          Left = 2
          Top = 3
          Width = 66
          Height = 10
          AutoSize = False
          Caption = 'DOCUMENTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object rllVencimento1: TRLLabel
          Left = 126
          Top = 3
          Width = 40
          Height = 10
          AutoSize = False
          Caption = 'VENC.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
          BeforePrint = rllVencimento1BeforePrint
        end
        object RLLabel3: TRLLabel
          Left = 213
          Top = 3
          Width = 77
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VR. DOCUM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object RLLabel17: TRLLabel
          Left = 292
          Top = 3
          Width = 77
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VR. RECEB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object rll1: TRLLabel
          Left = 92
          Top = 3
          Width = 30
          Height = 10
          AutoSize = False
          Caption = 'VEND.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object RLLabel11: TRLLabel
          Left = 170
          Top = 3
          Width = 40
          Height = 10
          AutoSize = False
          Caption = 'REC.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
          BeforePrint = rllVencimento1BeforePrint
        end
      end
      object RLPanel2: TRLPanel
        Left = 370
        Top = 3
        Width = 367
        Height = 18
        object RLLabel1: TRLLabel
          Left = 290
          Top = 3
          Width = 77
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VR. RECEB'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object RLLabel18: TRLLabel
          Left = 211
          Top = 3
          Width = 77
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VR. DOCUM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object rllVencimento2: TRLLabel
          Left = 126
          Top = 3
          Width = 40
          Height = 10
          AutoSize = False
          Caption = 'VENC.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
          BeforePrint = rllVencimento1BeforePrint
        end
        object RLLabel20: TRLLabel
          Left = 3
          Top = 3
          Width = 65
          Height = 10
          AutoSize = False
          Caption = 'DOCUMENTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object rll2: TRLLabel
          Left = 93
          Top = 3
          Width = 30
          Height = 10
          AutoSize = False
          Caption = 'VEND.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
        end
        object RLLabel12: TRLLabel
          Left = 169
          Top = 3
          Width = 40
          Height = 10
          AutoSize = False
          Caption = 'REC.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          Transparent = False
          BeforePrint = rllVencimento1BeforePrint
        end
      end
    end
    object rlbFooter1: TRLBand
      Left = 38
      Top = 599
      Width = 740
      Height = 18
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 10
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      AfterPrint = rlbFooter1AfterPrint
      BeforePrint = rlbFooter1BeforePrint
      object rllImpressao: TRLLabel
        Left = 2
        Top = 4
        Width = 231
        Height = 13
        Caption = 'IMPRESSAO CONTINUA NA PROXIMA PAGINA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = rllImpressaoBeforePrint
      end
    end
    object rlbAssinatura: TRLBand
      Left = 38
      Top = 369
      Width = 740
      Height = 96
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 10
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      AfterPrint = rlbAssinaturaAfterPrint
      object RLPanel5: TRLPanel
        Left = 1
        Top = 1
        Width = 738
        Height = 92
        Align = faTop
        object RLLabel6: TRLLabel
          Left = 8
          Top = 8
          Width = 353
          Height = 13
          AutoSize = False
          Caption = 'COPIA PADRAO DA CITEL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          BeforePrint = RLLabel6BeforePrint
        end
        object RLLabel8: TRLLabel
          Left = 8
          Top = 24
          Width = 353
          Height = 13
          AutoSize = False
          Caption = 'COPIA PADRAO DA CITEL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          BeforePrint = RLLabel8BeforePrint
        end
        object RLLabel10: TRLLabel
          Left = 8
          Top = 40
          Width = 353
          Height = 13
          AutoSize = False
          Caption = 'COPIA PADRAO DA CITEL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          BeforePrint = RLLabel10BeforePrint
        end
        object rllCPFCNPJ: TRLLabel
          Left = 8
          Top = 56
          Width = 353
          Height = 13
          AutoSize = False
          Caption = 'COPIA PADRAO DA CITEL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          BeforePrint = rllCPFCNPJBeforePrint
        end
        object rllInsEst: TRLLabel
          Left = 9
          Top = 72
          Width = 465
          Height = 13
          AutoSize = False
          Caption = 'COPIA PADRAO DA CITEL'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          BeforePrint = rllInsEstBeforePrint
        end
        object RLLabel4: TRLLabel
          Left = 480
          Top = 60
          Width = 235
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 
            '________________________________________________________________' +
            '______________________'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object RLLabel5: TRLLabel
          Left = 480
          Top = 74
          Width = 234
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '- ASSINATURA -'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          BeforePrint = RLLabel5BeforePrint
        end
        object rllLocalData: TRLLabel
          Left = 392
          Top = 8
          Width = 329
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'CIDADE DA EMPRESA, DATA DO RECEBIMENTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          BeforePrint = rllLocalDataBeforePrint
        end
      end
    end
    object rlbDuplicatas: TRLBand
      Left = 38
      Top = 161
      Width = 740
      Height = 208
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 10
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      BeforePrint = rlbDuplicatasBeforePrint
      object pnlCheques: TRLPanel
        Left = 1
        Top = 137
        Width = 738
        Height = 71
        Align = faClient
        object RLPanel4: TRLPanel
          Left = 0
          Top = 18
          Width = 738
          Height = 18
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = False
          Borders.DrawRight = True
          Borders.DrawBottom = True
          object RLLabel9: TRLLabel
            Left = 4
            Top = 2
            Width = 37
            Height = 10
            AutoSize = False
            Caption = 'AGEN'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLLabel21: TRLLabel
            Left = 44
            Top = 2
            Width = 93
            Height = 10
            AutoSize = False
            Caption = 'C. CORRENTE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLLabel22: TRLLabel
            Left = 140
            Top = 2
            Width = 69
            Height = 10
            AutoSize = False
            Caption = 'NUM. CHEQUE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLLabel23: TRLLabel
            Left = 212
            Top = 2
            Width = 69
            Height = 10
            AutoSize = False
            Caption = 'VENCIMENTO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLLabel24: TRLLabel
            Left = 284
            Top = 2
            Width = 77
            Height = 10
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'VALOR'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLLabel25: TRLLabel
            Left = 364
            Top = 2
            Width = 237
            Height = 10
            AutoSize = False
            Caption = 'EMITENTE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object RLLabel26: TRLLabel
            Left = 604
            Top = 2
            Width = 133
            Height = 10
            AutoSize = False
            Caption = 'CNPJ/CGC'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
        end
        object pnlLinChe: TRLPanel
          Left = 0
          Top = 36
          Width = 738
          Height = 17
          Align = faClient
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = False
          Borders.DrawRight = True
          Borders.DrawBottom = False
          object rllNumAge: TRLLabel
            Left = 4
            Top = 3
            Width = 37
            Height = 10
            AutoSize = False
            Caption = 'AGEN'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllConCor: TRLLabel
            Left = 44
            Top = 3
            Width = 93
            Height = 10
            AutoSize = False
            Caption = 'C. CORRENTE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllNumChq: TRLLabel
            Left = 140
            Top = 3
            Width = 69
            Height = 10
            AutoSize = False
            Caption = 'NUM. CHEQUE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllDtaVen: TRLLabel
            Left = 212
            Top = 3
            Width = 69
            Height = 10
            AutoSize = False
            Caption = 'VENCIMENTO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllValChq: TRLLabel
            Left = 284
            Top = 3
            Width = 77
            Height = 10
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'VALOR'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllNomEmi: TRLLabel
            Left = 364
            Top = 3
            Width = 237
            Height = 10
            AutoSize = False
            Caption = 'EMITENTE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllC_G_C_: TRLLabel
            Left = 604
            Top = 3
            Width = 133
            Height = 10
            AutoSize = False
            Caption = 'CNPJ/CGC'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel3: TRLPanel
          Left = 0
          Top = 53
          Width = 738
          Height = 18
          Align = faBottom
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = True
          Borders.DrawRight = True
          Borders.DrawBottom = True
          object RLLabel7: TRLLabel
            Left = 4
            Top = 3
            Width = 397
            Height = 10
            AutoSize = False
            Caption = 'ESSE RECIBO SOMENTE SERA VALIDO NA COMPENSACAO DO CHEQUE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
        end
        object RLPanel6: TRLPanel
          Left = 0
          Top = 0
          Width = 738
          Height = 18
          Align = faTop
          Borders.Sides = sdCustom
          Borders.DrawLeft = True
          Borders.DrawTop = True
          Borders.DrawRight = True
          Borders.DrawBottom = True
          object rllRelacCheques: TRLLabel
            Left = 1
            Top = 3
            Width = 736
            Height = 11
            Alignment = taCenter
            AutoSize = False
            Caption = 'RELACAO DE CHEQUES'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
            BeforePrint = rllRelacChequesBeforePrint
          end
        end
      end
      object pnlDocume: TRLPanel
        Left = 1
        Top = 1
        Width = 738
        Height = 136
        Align = faTop
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        object rlpColuna1: TRLPanel
          Left = 0
          Top = 0
          Width = 369
          Height = 136
          Align = faLeft
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = True
          Borders.DrawBottom = False
          object rllNumDoc1: TRLLabel
            Left = 1
            Top = 3
            Width = 89
            Height = 10
            AutoSize = False
            Caption = 'DOCUMENTO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllDtaVen1: TRLLabel
            Left = 124
            Top = 3
            Width = 40
            Height = 10
            AutoSize = False
            Caption = 'VENCIMENTO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllValDoc1: TRLLabel
            Left = 211
            Top = 3
            Width = 77
            Height = 10
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'VR. DOCUM'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllValRec1: TRLLabel
            Left = 290
            Top = 3
            Width = 77
            Height = 10
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'VR. RECEB'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllCodVen1: TRLLabel
            Left = 91
            Top = 3
            Width = 30
            Height = 10
            AutoSize = False
            Caption = 'VENDEDOR'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
          object rllDtaRec1: TRLLabel
            Left = 168
            Top = 3
            Width = 40
            Height = 10
            AutoSize = False
            Caption = 'RECEBIMENTO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
        end
        object rlpColuna2: TRLPanel
          Left = 371
          Top = 0
          Width = 367
          Height = 136
          Align = faRight
          object rllNumDoc2: TRLLabel
            Left = 2
            Top = 3
            Width = 89
            Height = 10
            AutoSize = False
            Caption = 'DOCUMENTO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object rllDtaVen2: TRLLabel
            Left = 125
            Top = 3
            Width = 40
            Height = 10
            AutoSize = False
            Caption = 'VENCIMENTO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object rllValDoc2: TRLLabel
            Left = 210
            Top = 3
            Width = 77
            Height = 10
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'VR. DOCUM'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object rllValRec2: TRLLabel
            Left = 289
            Top = 3
            Width = 77
            Height = 10
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'VR. RECEB'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object rllCodVen2: TRLLabel
            Left = 92
            Top = 3
            Width = 30
            Height = 10
            AutoSize = False
            Caption = 'VENDEDOR'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
            Visible = False
          end
          object rllDtaRec2: TRLLabel
            Left = 168
            Top = 3
            Width = 40
            Height = 10
            AutoSize = False
            Caption = 'RECEBIMENTO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 10
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
            Transparent = False
          end
        end
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 617
      Width = 740
      Height = 1
    end
    object rlbAssinatura2: TRLBand
      Left = 38
      Top = 465
      Width = 740
      Height = 134
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = rlbAssinatura2BeforePrint
      object RLLabel2: TRLLabel
        Left = 16
        Top = 51
        Width = 353
        Height = 13
        AutoSize = False
        Caption = 'COPIA PADRAO DA CITEL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = RLLabel2BeforePrint
      end
      object RLLabel13: TRLLabel
        Left = 16
        Top = 67
        Width = 353
        Height = 13
        AutoSize = False
        Caption = 'COPIA PADRAO DA CITEL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = RLLabel13BeforePrint
      end
      object RLLabel14: TRLLabel
        Left = 16
        Top = 83
        Width = 353
        Height = 13
        AutoSize = False
        Caption = 'COPIA PADRAO DA CITEL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = RLLabel14BeforePrint
      end
      object rllCPFCNPJ2: TRLLabel
        Left = 16
        Top = 99
        Width = 353
        Height = 13
        AutoSize = False
        Caption = 'COPIA PADRAO DA CITEL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = rllCPFCNPJ2BeforePrint
      end
      object rllInsEst2: TRLLabel
        Left = 17
        Top = 115
        Width = 465
        Height = 13
        AutoSize = False
        Caption = 'COPIA PADRAO DA CITEL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = rllInsEst2BeforePrint
      end
      object rllLocalData2: TRLLabel
        Left = 400
        Top = 51
        Width = 329
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CIDADE DA EMPRESA, DATA DO RECEBIMENTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = rllLocalData2BeforePrint
      end
      object rllAssinatura: TRLLabel
        Left = 488
        Top = 117
        Width = 234
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '- ASSINATURA -'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        BeforePrint = rllAssinaturaBeforePrint
      end
      object RLLabel28: TRLLabel
        Left = 488
        Top = 103
        Width = 235
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 
          '________________________________________________________________' +
          '______________________'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = -1
        Top = 27
        Width = 741
        Height = 2
        DrawKind = dkLine
      end
      object RLDraw2: TRLDraw
        Left = -1
        Top = 49
        Width = 741
        Height = 1
        DrawKind = dkLine
      end
      object rllValCar: TRLLabel
        Left = 14
        Top = 33
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CART'#195'O:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rllValOrd: TRLLabel
        Left = 304
        Top = 33
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ORDEM DE PGTO.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rllValCre: TRLLabel
        Left = 588
        Top = 33
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CR'#201'DITO UTILIZADO:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rllValDin: TRLLabel
        Left = 14
        Top = 12
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'DINHEIRO:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rllValChv: TRLLabel
        Left = 304
        Top = 12
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CHEQUE A VISTA:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
      object rllValChp: TRLLabel
        Left = 588
        Top = 12
        Width = 121
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CHEQUE-PR'#201':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object RLExpressionParser1: TRLExpressionParser
    Left = 784
    Top = 8
  end
  object dtsImpRec: TDataSource
    Left = 11
    Top = 34
  end
  object rldMatricial: TRLDraftFilter
    CPPSelection = csFixed20CPP
    DisplayName = 'Impressora Matricial'
    Left = 400
    Top = 32
  end
  object dtsCadChq: TDataSource
    DataSet = cdsCadChq
    Left = 11
    Top = 386
  end
  object cdsCadChq: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 11
    Top = 346
    object cdsCadChqCHQ_CONCOR: TStringField
      FieldName = 'CHQ_CONCOR'
      Size = 12
    end
    object cdsCadChqCHQ_NUMCHQ: TStringField
      FieldName = 'CHQ_NUMCHQ'
      Size = 10
    end
    object cdsCadChqCHQ_NOMEMI: TStringField
      FieldName = 'CHQ_NOMEMI'
      Size = 40
    end
    object cdsCadChqCHQ_C_G_C_: TStringField
      FieldName = 'CHQ_C_G_C_'
      Size = 18
    end
    object cdsCadChqCHQ_DTAVEN: TDateField
      FieldName = 'CHQ_DTAVEN'
    end
    object cdsCadChqCHQ_VALCHQ: TFloatField
      FieldName = 'CHQ_VALCHQ'
    end
    object cdsCadChqCHQ_NUMAGE: TStringField
      FieldName = 'CHQ_NUMAGE'
      Size = 5
    end
  end
  object rpsSetup: TRLPreviewSetup
    Left = 396
    Top = 12
  end
end
