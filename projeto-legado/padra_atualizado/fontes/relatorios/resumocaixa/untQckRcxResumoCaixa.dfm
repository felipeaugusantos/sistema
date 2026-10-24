inherited frmQckRcxResumoCaixa: TfrmQckRcxResumoCaixa
  Left = 215
  Top = 209
  Width = 843
  Height = 748
  VertScrollBar.Position = 34
  Caption = 'frmQckRcxResumoCaixa'
  PixelsPerInch = 96
  TextHeight = 13
  inherited qckPagina: TRLReport
    Top = -34
    DataSource = frmModuloSPR.dtsTemporaria2
    inherited rlbCabecalho: TRLBand
      Height = 72
      inherited rllNomeRelatorio: TRLLabel
        Top = 13
      end
      inherited rllDataRelatorio: TRLSystemInfo
        Top = 13
      end
      inherited rllOrdem: TRLLabel
        Top = 58
        Height = 13
      end
      object rllOperador: TRLLabel
        Left = 4
        Top = 30
        Width = 733
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        Layout = tlJustify
        ParentFont = False
      end
      object rllSqFcRx: TRLLabel
        Left = 4
        Top = 44
        Width = 733
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        Layout = tlJustify
        ParentFont = False
      end
    end
    inherited rlbTitulo: TRLBand
      Top = 110
      object rllDocumento: TRLLabel
        Left = 3
        Top = 3
        Width = 55
        Height = 10
        Caption = 'DOCUMENTO'
        Transparent = False
      end
      object rllHistorico: TRLLabel
        Left = 77
        Top = 3
        Width = 46
        Height = 10
        Caption = 'HISTORICO'
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 649
        Top = 3
        Width = 28
        Height = 10
        Alignment = taRightJustify
        Caption = 'VALOR'
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 708
        Top = 3
        Width = 28
        Height = 10
        Alignment = taRightJustify
        Caption = 'SALDO'
        Transparent = False
      end
      object RLLabel1: TRLLabel
        Left = 291
        Top = 3
        Width = 41
        Height = 10
        Caption = 'DINHEIRO'
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 348
        Top = 3
        Width = 35
        Height = 10
        Caption = 'CARTAO'
        Transparent = False
      end
      object RLLabel7: TRLLabel
        Left = 405
        Top = 3
        Width = 44
        Height = 10
        Caption = 'CHQ.VISTA'
        Transparent = False
      end
      object RLLabel28: TRLLabel
        Left = 462
        Top = 3
        Width = 38
        Height = 10
        Caption = 'CHQ.PRE'
        Transparent = False
      end
      object RLLabel29: TRLLabel
        Left = 576
        Top = 3
        Width = 57
        Height = 10
        Caption = 'VALOR. CRED.'
        Transparent = False
      end
      object RLLabel40: TRLLabel
        Left = 520
        Top = 3
        Width = 42
        Height = 10
        Caption = 'ORD. PAG.'
        Transparent = False
      end
    end
    inherited rlbGrupo: TRLGroup
      Top = 160
      Height = 149
      DataFields = 'ESPDOC'
      Visible = False
      inherited rlbTituloGrupo: TRLBand
        Height = 17
        Visible = False
        object rdbEspecie: TRLDBText
          Left = 50
          Top = 3
          Width = 684
          Height = 10
          AutoSize = False
          DataField = 'ESPDOC'
          DataSource = frmModuloSPR.dtsRelatorio
        end
        object rllEspecie: TRLLabel
          Left = 3
          Top = 3
          Width = 38
          Height = 10
          AutoSize = False
          Caption = 'Especie:'
        end
      end
      inherited rlbDetalheGrupo: TRLBand
        Top = 17
        Height = 35
        AutoSize = True
        Visible = False
        object rdbNumDoc: TRLDBText
          Left = 4
          Top = 1
          Width = 61
          Height = 10
          AutoSize = False
          DataField = 'NUMDOC'
          DataSource = frmModuloSPR.dtsRelatorio
        end
        object rdbDescri: TRLDBText
          Left = 69
          Top = 1
          Width = 204
          Height = 10
          AutoSize = False
          DataField = 'DESCRI'
          DataSource = frmModuloSPR.dtsRelatorio
        end
        object rllSaldo: TRLLabel
          Left = 684
          Top = 1
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'SALDO'
          Transparent = False
        end
        object RLDBText9: TRLDBText
          Left = 277
          Top = 1
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'DINHEI'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
        end
        object RLDBText10: TRLDBText
          Left = 334
          Top = 1
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'CARREC'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
        end
        object RLDBText11: TRLDBText
          Left = 391
          Top = 1
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'CHQAVI'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
        end
        object RLDBText12: TRLDBText
          Left = 448
          Top = 1
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'CHQPRE'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
        end
        object rllNumCheque: TRLLabel
          Left = 116
          Top = 13
          Width = 51
          Height = 10
          AutoSize = False
          Caption = 'NUMERO'
        end
        object rllEmitente: TRLLabel
          Left = 227
          Top = 13
          Width = 180
          Height = 10
          AutoSize = False
          Caption = 'EMITENTE '
        end
        object rllVenCheque: TRLLabel
          Left = 476
          Top = 13
          Width = 65
          Height = 10
          AutoSize = False
          Caption = 'VENCIMENTO'
        end
        object rllValChq: TRLLabel
          Left = 627
          Top = 13
          Width = 42
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VALOR'
        end
        object rllTitNumChq: TRLLabel
          Left = 4
          Top = 13
          Width = 109
          Height = 10
          AutoSize = False
          Caption = 'NUM. CHEQUE:'
        end
        object rllTitEmiChq: TRLLabel
          Left = 173
          Top = 13
          Width = 52
          Height = 10
          AutoSize = False
          Caption = 'EMITENTE: '
        end
        object rllTitDtaVen: TRLLabel
          Left = 417
          Top = 13
          Width = 56
          Height = 10
          AutoSize = False
          Caption = 'DATA VEN.:'
        end
        object rllTitValChq: TRLLabel
          Left = 552
          Top = 13
          Width = 73
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VALOR CHEQUE:'
        end
        object RLDBText13: TRLDBText
          Left = 568
          Top = 1
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VALCRE'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
        end
        object rlbValor: TRLDBText
          Left = 625
          Top = 1
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VALDOC'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
        end
        object RLDBText14: TRLDBText
          Left = 508
          Top = 1
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'ORDREC'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
        end
        object rllTitMot: TRLLabel
          Left = 3
          Top = 25
          Width = 118
          Height = 10
          Caption = 'MOTIVO DO DESCONTO:'
          Transparent = False
        end
        object rlbMotDes: TRLDBText
          Left = 124
          Top = 25
          Width = 605
          Height = 10
          AutoSize = False
          DataField = 'MOTDES'
          DataSource = frmModuloSPR.dtsRelatorio
        end
      end
      inherited rlbResumoGrupo: TRLBand
        Top = 52
        Height = 19
        Borders.Sides = sdCustom
        Borders.DrawBottom = True
        Visible = False
        object rllTotDocs: TRLLabel
          Left = 164
          Top = 3
          Width = 108
          Height = 10
          Alignment = taRightJustify
          Caption = 'TOTAL DOS DOCUMENTOS:'
          Transparent = False
        end
        object rllSaldoTot: TRLLabel
          Left = 684
          Top = 2
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'SALDOTOT'
          Transparent = False
        end
        object rdbValorTot: TRLDBResult
          Left = 625
          Top = 2
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VALDOC'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Info = riSum
        end
        object RLDBResult3: TRLDBResult
          Left = 277
          Top = 2
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'DINHEI'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Info = riSum
        end
        object RLDBResult4: TRLDBResult
          Left = 334
          Top = 2
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'CARREC'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Info = riSum
        end
        object RLDBResult5: TRLDBResult
          Left = 391
          Top = 2
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'CHQAVI'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Info = riSum
        end
        object RLDBResult6: TRLDBResult
          Left = 448
          Top = 2
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'CHQPRE'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Info = riSum
        end
        object RLDBResult7: TRLDBResult
          Left = 508
          Top = 2
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'ORDREC'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Info = riSum
        end
        object RLDBResult8: TRLDBResult
          Left = 568
          Top = 2
          Width = 54
          Height = 10
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VALCRE'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Info = riSum
        end
      end
    end
    inherited rlbDetalhe: TRLBand
      Top = 309
      Height = 16
      Visible = False
      object RLDBText1: TRLDBText
        Left = 215
        Top = 2
        Width = 242
        Height = 10
        AutoSize = False
        DataField = 'ESPDOC'
        DataSource = frmModuloSPR.dtsRelatorio
      end
      object RLDBText8: TRLDBText
        Left = 464
        Top = 2
        Width = 54
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        DataFormula = 'VALDOC'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
      end
    end
    inherited rlbResumo: TRLBand
      Top = 627
    end
    object rlbSaldoInicial: TRLBand
      Left = 38
      Top = 144
      Width = 740
      Height = 16
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      Color = clWhite
      ParentColor = False
      Transparent = False
      object rllSalInicial: TRLLabel
        Left = 3
        Top = 2
        Width = 59
        Height = 10
        Caption = 'SALDO INICIAL:'
      end
    end
    object rlbTotGeralDocs: TRLBand
      Left = 38
      Top = 325
      Width = 740
      Height = 18
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLLabel4: TRLLabel
        Left = 483
        Top = 4
        Width = 136
        Height = 10
        Alignment = taRightJustify
        Caption = 'TOTAL GERAL DOS DOCUMENTOS:'
        Transparent = False
      end
      object rllSaldoGer: TRLLabel
        Left = 684
        Top = 3
        Width = 54
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDOGER'
        Transparent = False
      end
      object rdbTotValGer: TRLDBResult
        Left = 624
        Top = 3
        Width = 55
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        DataFormula = 'VALDOC'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Info = riSum
      end
    end
    object rlbTotGeralDocsSint: TRLBand
      Left = 38
      Top = 343
      Width = 740
      Height = 17
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLLabel5: TRLLabel
        Left = 402
        Top = 3
        Width = 57
        Height = 10
        Alignment = taRightJustify
        Caption = 'TOTAL GERAL:'
        Transparent = False
      end
      object RLDBResult1: TRLDBResult
        Left = 464
        Top = 3
        Width = 55
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        DataFormula = 'VALDOC'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Info = riSum
      end
    end
    object rlbTituloSint: TRLBand
      Left = 38
      Top = 127
      Width = 740
      Height = 17
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Color = clSilver
      ParentColor = False
      Transparent = False
      object RLLabel9: TRLLabel
        Left = 215
        Top = 3
        Width = 60
        Height = 10
        Caption = 'DOCUMENTOS'
        Transparent = False
      end
      object RLLabel11: TRLLabel
        Left = 464
        Top = 3
        Width = 54
        Height = 10
        Alignment = taRightJustify
        Caption = 'SALDO'
        Transparent = False
      end
    end
    object rlbResumoDados: TRLBand
      Left = 38
      Top = 360
      Width = 740
      Height = 135
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object rllSalEnt: TRLLabel
        Left = 317
        Top = 29
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
      end
      object RLLabel8: TRLLabel
        Left = 192
        Top = 29
        Width = 121
        Height = 10
        AutoSize = False
        Caption = 'SALDO INICIAL:'
      end
      object rllSalFin: TRLLabel
        Left = 393
        Top = 29
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
      end
      object RLLabel12: TRLLabel
        Left = 192
        Top = 41
        Width = 121
        Height = 10
        AutoSize = False
        Caption = 'DINHEIRO:'
      end
      object RLLabel13: TRLLabel
        Left = 192
        Top = 53
        Width = 121
        Height = 10
        AutoSize = False
        Caption = 'CHEQUE A VISTA:'
      end
      object RLLabel14: TRLLabel
        Left = 192
        Top = 65
        Width = 121
        Height = 10
        AutoSize = False
        Caption = 'CHEQUE PRE:'
      end
      object RLLabel15: TRLLabel
        Left = 192
        Top = 89
        Width = 121
        Height = 10
        AutoSize = False
        Caption = 'CARTAO DE CREDITO:'
      end
      object RLLabel17: TRLLabel
        Left = 192
        Top = 101
        Width = 121
        Height = 10
        AutoSize = False
        Caption = 'OUTROS:'
      end
      object rllDinEnt: TRLLabel
        Left = 317
        Top = 41
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ENTRADA'
      end
      object rllDinSai: TRLLabel
        Left = 393
        Top = 41
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SAIDAS'
      end
      object rllChqVistaEnt: TRLLabel
        Left = 317
        Top = 53
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ENTRADA'
      end
      object rllChqVistaSai: TRLLabel
        Left = 393
        Top = 53
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SAIDAS'
      end
      object rllChqPreEnt: TRLLabel
        Left = 317
        Top = 65
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ENTRADA'
      end
      object rllChqPreSai: TRLLabel
        Left = 393
        Top = 65
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SAIDAS'
      end
      object rllCarCreEnt: TRLLabel
        Left = 317
        Top = 89
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ENTRADA'
      end
      object rllCarCreSai: TRLLabel
        Left = 393
        Top = 89
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SAIDAS'
      end
      object rllOutrasEnt: TRLLabel
        Left = 317
        Top = 101
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ENTRADA'
      end
      object rllOutrasSai: TRLLabel
        Left = 393
        Top = 101
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SAIDAS'
      end
      object RLLabel39: TRLLabel
        Left = 192
        Top = 77
        Width = 121
        Height = 10
        AutoSize = False
        Caption = 'ORDEM DE PAGAMENTO:'
      end
      object rllOrdRecEnt: TRLLabel
        Left = 317
        Top = 77
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ENTRADA'
      end
      object rllOrdRecSai: TRLLabel
        Left = 393
        Top = 77
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SAIDAS'
      end
      object RLLabel41: TRLLabel
        Left = 317
        Top = 13
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'ENTRADA'
      end
      object RLLabel42: TRLLabel
        Left = 393
        Top = 13
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SAIDA'
      end
      object rllOutrasSal: TRLLabel
        Left = 469
        Top = 101
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO'
      end
      object rllCarCreSal: TRLLabel
        Left = 469
        Top = 89
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO'
      end
      object rllOrdRecSal: TRLLabel
        Left = 469
        Top = 77
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO'
      end
      object rllChqPreSal: TRLLabel
        Left = 469
        Top = 65
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO'
      end
      object rllChqVistaSal: TRLLabel
        Left = 469
        Top = 53
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO'
      end
      object rllDinSal: TRLLabel
        Left = 469
        Top = 41
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO'
      end
      object rllSalInicialResumo: TRLLabel
        Left = 469
        Top = 29
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO'
      end
      object RLDraw1: TRLDraw
        Left = 192
        Top = 113
        Width = 350
        Height = 1
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Brush.Style = bsClear
        DrawKind = dkLine
        Pen.Style = psClear
      end
      object RLLabel10: TRLLabel
        Left = 469
        Top = 13
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO'
      end
      object rllTotEnt: TRLLabel
        Left = 317
        Top = 117
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO INICIAL'
      end
      object rllTotSai: TRLLabel
        Left = 393
        Top = 117
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SAIDAS'
      end
      object rllTotSal: TRLLabel
        Left = 469
        Top = 117
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 11
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
      end
      object RLDraw2: TRLDraw
        Left = 192
        Top = 27
        Width = 350
        Height = 1
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Brush.Style = bsClear
        DrawKind = dkLine
        Pen.Style = psClear
      end
      object RLLabel31: TRLLabel
        Left = 192
        Top = 13
        Width = 121
        Height = 10
        AutoSize = False
        Caption = 'OPERACOES'
      end
      object RLDraw4: TRLDraw
        Left = 0
        Top = 137
        Width = 740
        Height = 1
        Brush.Style = bsClear
        DrawKind = dkLine
      end
      object RLLabel43: TRLLabel
        Left = 192
        Top = 117
        Width = 121
        Height = 10
        AutoSize = False
        Caption = 'SALDO FINAL:'
      end
    end
    object rlbDadosInf: TRLBand
      Left = 38
      Top = 495
      Width = 740
      Height = 132
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLLabel33: TRLLabel
        Left = 192
        Top = 4
        Width = 350
        Height = 10
        Alignment = taCenter
        Caption = 'DADOS INFORMATIVOS'
      end
      object RLLabel35: TRLLabel
        Left = 192
        Top = 32
        Width = 273
        Height = 10
        AutoSize = False
        Caption = 
          'DESCONTO:.......................................................' +
          '........................................................'
      end
      object RLLabel36: TRLLabel
        Left = 192
        Top = 44
        Width = 273
        Height = 10
        AutoSize = False
        Caption = 
          'JUROS:..........................................................' +
          '...............................................................'
      end
      object rllDesconto: TRLLabel
        Left = 469
        Top = 32
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO INICIAL'
      end
      object rllJuros: TRLLabel
        Left = 469
        Top = 44
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO INICIAL'
      end
      object RLLabel30: TRLLabel
        Left = 192
        Top = 56
        Width = 273
        Height = 10
        AutoSize = False
        Caption = 
          'VENDAS A PRAZO:.................................................' +
          '...................................................'
      end
      object rllVendaPrazo: TRLLabel
        Left = 469
        Top = 56
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VENDAPRAZO'
      end
      object RLLabel32: TRLLabel
        Left = 192
        Top = 68
        Width = 273
        Height = 10
        AutoSize = False
        Caption = 
          'VENDAS A VISTA:.................................................' +
          '.....................................................'
      end
      object rllVendaVista: TRLLabel
        Left = 469
        Top = 68
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VENDAVISTA'
      end
      object RLLabel37: TRLLabel
        Left = 192
        Top = 92
        Width = 273
        Height = 10
        AutoSize = False
        Caption = 
          'VENDAS DO PERIODO:..............................................' +
          '..............................................'
      end
      object rllVendasDia: TRLLabel
        Left = 469
        Top = 92
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VENDADIA'
      end
      object RLLabel16: TRLLabel
        Left = 192
        Top = 20
        Width = 273
        Height = 10
        AutoSize = False
        Caption = 
          'FATURADO:.......................................................' +
          '.........................................................'
      end
      object rllVenPreEnt: TRLLabel
        Left = 469
        Top = 20
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'SALDO INICIAL'
      end
      object RLDraw3: TRLDraw
        Left = 192
        Top = 18
        Width = 350
        Height = 1
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Brush.Style = bsClear
        DrawKind = dkLine
        Pen.Style = psClear
      end
      object RLLabel44: TRLLabel
        Left = 192
        Top = 80
        Width = 273
        Height = 10
        AutoSize = False
        Caption = 
          'TROCAS E DEVOLU'#199#213'ES:............................................' +
          '...............................................'
      end
      object rllTrocaDevolucao: TRLLabel
        Left = 469
        Top = 80
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'TROCADEVOLUCAO'
      end
      object RLLabel45: TRLLabel
        Left = 192
        Top = 104
        Width = 273
        Height = 10
        AutoSize = False
        Caption = 
          'QUANTIDADE DE DOCS CANCELADOS:..................................' +
          '.........................................................'
      end
      object rllQtdCan: TRLLabel
        Left = 469
        Top = 104
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'TROCADEVOLUCAO'
      end
      object RLLabel47: TRLLabel
        Left = 192
        Top = 116
        Width = 273
        Height = 10
        AutoSize = False
        Caption = 
          'VALOR TOTAL DOS DOCS CANCELADOS:................................' +
          '............................................................'
      end
      object rllValCan: TRLLabel
        Left = 469
        Top = 116
        Width = 72
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VENDADIA'
      end
    end
  end
  object qckPagina2: TRLReport [1]
    Left = 8
    Top = 674
    Width = 816
    Height = 1056
    DataSource = dtsCadRec
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 10
    Font.Name = 'Arial'
    Font.Pitch = fpFixed
    Font.Style = []
    PageSetup.PaperSize = fpLetter
    PreviewOptions.Position = poDefault
    ExpressionParser = RLExpressionParser2
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 740
      Height = 96
      BandType = btHeader
      object RLLabel18: TRLLabel
        Left = 4
        Top = 4
        Width = 733
        Height = 18
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        Layout = tlJustify
        ParentFont = False
        BeforePrint = rllNomeEmpresaBeforePrint
      end
      object RLLabel19: TRLLabel
        Left = 4
        Top = 21
        Width = 653
        Height = 19
        AutoSize = False
        Caption = 'DUPLICATAS EMITIDAS NAO BAIXADAS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        Layout = tlJustify
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 4
        Top = 39
        Width = 733
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        Info = itNow
        ParentFont = False
        BeforePrint = rllDataRelatorioBeforePrint
      end
      object RLLabel20: TRLLabel
        Left = 4
        Top = 73
        Width = 733
        Height = 19
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        Layout = tlJustify
        ParentFont = False
      end
      object RLLabel21: TRLLabel
        Left = 706
        Top = 21
        Width = 31
        Height = 10
        Alignment = taRightJustify
        Caption = 'PAGINA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        Layout = tlJustify
        ParentFont = False
        BeforePrint = rllPaginaBeforePrint
      end
      object RLLabel22: TRLLabel
        Left = 4
        Top = 54
        Width = 733
        Height = 19
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        Layout = tlJustify
        ParentFont = False
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 134
      Width = 740
      Height = 17
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Color = clSilver
      ParentColor = False
      Transparent = False
      object rllDuplicata: TRLLabel
        Left = 3
        Top = 3
        Width = 46
        Height = 10
        Caption = 'DUPLICATA'
        Transparent = False
      end
      object RLLabel24: TRLLabel
        Left = 395
        Top = 3
        Width = 46
        Height = 10
        Caption = 'HISTORICO'
        Transparent = False
      end
      object RLLabel25: TRLLabel
        Left = 86
        Top = 3
        Width = 18
        Height = 10
        Caption = 'VEN'
        Transparent = False
      end
      object RLLabel26: TRLLabel
        Left = 692
        Top = 3
        Width = 44
        Height = 10
        Alignment = taRightJustify
        Caption = 'VR.DUPLIC'
        Transparent = False
      end
      object RLLabel23: TRLLabel
        Left = 58
        Top = 3
        Width = 19
        Height = 10
        Caption = 'EMP'
        Transparent = False
      end
      object RLLabel27: TRLLabel
        Left = 112
        Top = 3
        Width = 35
        Height = 10
        Caption = 'CLIENTE'
        Transparent = False
      end
    end
    object RLBand6: TRLBand
      Left = 38
      Top = 151
      Width = 740
      Height = 19
      object RLDBText6: TRLDBText
        Left = 4
        Top = 5
        Width = 49
        Height = 10
        AutoSize = False
        DataField = 'NUMDUP'
        DataSource = dtsCadRec
      end
      object RLDBText2: TRLDBText
        Left = 58
        Top = 5
        Width = 20
        Height = 10
        AutoSize = False
        DataField = 'CODEMP'
        DataSource = dtsCadRec
      end
      object RLDBText3: TRLDBText
        Left = 86
        Top = 5
        Width = 20
        Height = 10
        AutoSize = False
        DataField = 'CODVEN'
        DataSource = dtsCadRec
      end
      object RLDBText4: TRLDBText
        Left = 112
        Top = 5
        Width = 281
        Height = 10
        AutoSize = False
        DataField = 'CODCLI'
        DataSource = dtsCadRec
      end
      object RLDBText5: TRLDBText
        Left = 395
        Top = 5
        Width = 284
        Height = 10
        AutoSize = False
        DataField = 'HISTOR'
        DataSource = dtsCadRec
      end
      object RLDBText7: TRLDBText
        Left = 682
        Top = 5
        Width = 54
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        DataFormula = 'VALDUP'
        DataSource = dtsCadRec
        DisplayMask = '#,##0.00'
      end
    end
    object RLBand7: TRLBand
      Left = 38
      Top = 192
      Width = 740
      Height = 22
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLLabel34: TRLLabel
        Left = 3
        Top = 3
        Width = 199
        Height = 15
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        Layout = tlJustify
        ParentFont = False
        BeforePrint = rllNomeFormBeforePrint
      end
      object RLPanel2: TRLPanel
        Left = 684
        Top = 3
        Width = 48
        Height = 15
        Alignment = taRightJustify
        AutoSize = True
        object RLSystemInfo2: TRLSystemInfo
          Left = 0
          Top = 0
          Width = 48
          Height = 15
          Align = faRight
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          Info = itDetailCount
          ParentFont = False
          BeforePrint = rllQtdRegBeforePrint
        end
      end
    end
    object RLBand9: TRLBand
      Left = 38
      Top = 170
      Width = 740
      Height = 22
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLLabel38: TRLLabel
        Left = 543
        Top = 5
        Width = 136
        Height = 10
        Alignment = taRightJustify
        Caption = 'TOTAL GERAL DOS DOCUMENTOS:'
        Transparent = False
      end
      object RLDBResult2: TRLDBResult
        Left = 682
        Top = 4
        Width = 53
        Height = 10
        Alignment = taRightJustify
        AutoSize = False
        DataFormula = 'VALDUP'
        DataSource = dtsCadRec
        DisplayMask = '#,##0.00'
        Info = riSum
      end
    end
  end
  inherited RLExpressionParser1: TRLExpressionParser
    Left = 168
    Top = 52
  end
  inherited rpsSetup: TRLPreviewSetup
    Left = 264
    Top = 52
  end
  object RLExpressionParser2: TRLExpressionParser
    Left = 200
    Top = 52
  end
  object dtsCadRec: TDataSource
    Left = 296
    Top = 52
  end
end
