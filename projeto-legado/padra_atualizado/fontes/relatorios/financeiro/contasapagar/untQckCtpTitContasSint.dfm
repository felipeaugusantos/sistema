inherited frmQckCtpTitContasSint: TfrmQckCtpTitContasSint
  Left = 199
  Top = 199
  Width = 792
  Caption = 'frmQckCtpTitContasSint'
  WindowState = wsMaximized
  ExplicitWidth = 792
  PixelsPerInch = 96
  TextHeight = 13
  inherited qckPagina: TRLReport
    Left = -24
    DataSource = dtsRelatorio
    ExplicitLeft = -24
    inherited rlbCabecalho: TRLBand
      Height = 229
      ExplicitHeight = 229
      inherited rllNomeRelatorio: TRLLabel
        Left = 285
        Width = 170
        Caption = 'TITULOS POR CONTA (SINTETICO) '
        ExplicitLeft = 285
        ExplicitWidth = 170
      end
      inherited rllDataRelatorio: TRLSystemInfo
        Top = 32
        ExplicitTop = 32
      end
      inherited rllOrdem: TRLLabel
        Top = 211
        Width = 734
        BeforePrint = rllOrdemBeforePrint
        ExplicitTop = 211
        ExplicitWidth = 734
      end
      object rllConta: TRLLabel
        Left = 4
        Top = 63
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
      object rllEmpresa: TRLLabel
        Left = 4
        Top = 81
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
      end
      object rllEventos: TRLLabel
        Left = 4
        Top = 98
        Width = 733
        Height = 19
        AutoSize = False
      end
      object rllOrdenacao: TRLLabel
        Left = 4
        Top = 116
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
      object rllFimCta: TRLLabel
        Left = 4
        Top = 45
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
      object rllIncPrevis: TRLLabel
        Left = 4
        Top = 134
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
      object rllFornecedor: TRLLabel
        Left = 4
        Top = 153
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
      object rllPorBai: TRLLabel
        Left = 4
        Top = 172
        Width = 369
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
      object rllValorExibido: TRLLabel
        Left = 378
        Top = 172
        Width = 359
        Height = 19
        Alignment = taRightJustify
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
      object rllPortador: TRLLabel
        Left = 4
        Top = 192
        Width = 369
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
    inherited rlbTitulo: TRLBand
      Top = 267
      Height = 21
      ExplicitTop = 267
      ExplicitHeight = 21
      object RLLabel1: TRLLabel
        Left = 2
        Top = 4
        Width = 30
        Height = 10
        Caption = 'CONTA'
        Transparent = False
      end
      object RLLabel7: TRLLabel
        Left = 421
        Top = 4
        Width = 50
        Height = 10
        Alignment = taRightJustify
        Caption = 'VL ORIGINAL'
        Transparent = False
      end
      object RLLabel8: TRLLabel
        Left = 523
        Top = 4
        Width = 35
        Height = 10
        Alignment = taRightJustify
        Caption = 'VL PAGO'
        Transparent = False
      end
      object rllJuros: TRLLabel
        Left = 605
        Top = 4
        Width = 40
        Height = 10
        Alignment = taRightJustify
        Caption = 'VL JUROS'
        Transparent = False
        BeforePrint = rllJurosBeforePrint
      end
      object rllDesconto: TRLLabel
        Left = 674
        Top = 4
        Width = 58
        Height = 10
        Alignment = taRightJustify
        Caption = 'VL DESCONTO'
        Transparent = False
        BeforePrint = rllDescontoBeforePrint
      end
    end
    inherited rlbGrupo: TRLGroup
      Top = 288
      Height = 119
      DataFields = 'GRUPO'
      ExplicitTop = 288
      ExplicitHeight = 119
      inherited rlbTituloGrupo: TRLBand
        Height = 38
        BeforePrint = rlbTituloGrupoBeforePrint
        ExplicitHeight = 38
        object rllLinha: TRLLabel
          Left = 2
          Top = 4
          Width = 25
          Height = 10
          Caption = 'LINHA'
          Transparent = False
          BeforePrint = rllLinhaBeforePrint
        end
        object rllGrupo: TRLLabel
          Left = 2
          Top = 22
          Width = 31
          Height = 10
          Caption = 'GRUPO'
          Transparent = False
          BeforePrint = rllGrupoBeforePrint
        end
      end
      inherited rlbDetalheGrupo: TRLBand
        Top = 38
        Height = 15
        ExplicitTop = 38
        ExplicitHeight = 15
        object RLDBText4: TRLDBText
          Left = 27
          Top = 2
          Width = 361
          Height = 11
          AutoSize = False
          DataField = 'CTA_DESCTA'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 11
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText4BeforePrint
        end
        object RLDBText9: TRLDBText
          Left = 389
          Top = 2
          Width = 82
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALOR'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 11
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText9BeforePrint
        end
        object RLDBText3: TRLDBText
          Left = 476
          Top = 2
          Width = 82
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALPAG'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 11
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText3BeforePrint
        end
        object RLDBText5: TRLDBText
          Left = 563
          Top = 2
          Width = 82
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALJUR'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 11
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText5BeforePrint
        end
        object RLDBText7: TRLDBText
          Left = 650
          Top = 2
          Width = 81
          Height = 11
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALDES'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 11
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText7BeforePrint
        end
      end
      inherited rlbResumoGrupo: TRLBand
        Top = 53
        Height = 21
        Borders.Sides = sdCustom
        Borders.DrawBottom = True
        AfterPrint = rlbResumoGrupoAfterPrint
        ExplicitTop = 53
        ExplicitHeight = 21
        object RLLabel18: TRLLabel
          Left = 313
          Top = 3
          Width = 75
          Height = 12
          AutoSize = False
          Caption = 'Total Grupo:'
          Transparent = False
        end
        object RLLabel19: TRLLabel
          Left = 389
          Top = 3
          Width = 82
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VL ORI'
          Transparent = False
          BeforePrint = RLLabel19BeforePrint
        end
        object RLLabel20: TRLLabel
          Left = 476
          Top = 3
          Width = 82
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VL PAG'
          Transparent = False
          BeforePrint = RLLabel20BeforePrint
        end
        object RLLabel21: TRLLabel
          Left = 563
          Top = 3
          Width = 82
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VL JUR'
          Transparent = False
          BeforePrint = RLLabel21BeforePrint
        end
        object RLLabel22: TRLLabel
          Left = 650
          Top = 3
          Width = 81
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VL DES'
          Transparent = False
          BeforePrint = RLLabel22BeforePrint
        end
      end
      object rlbTotalLinha: TRLBand
        Left = 0
        Top = 74
        Width = 740
        Height = 20
        BandType = btSummary
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        object RLLabel24: TRLLabel
          Left = 313
          Top = 3
          Width = 75
          Height = 12
          AutoSize = False
          Caption = 'Total Linha:'
          Transparent = False
        end
        object RLLabel25: TRLLabel
          Left = 389
          Top = 3
          Width = 82
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VL ORI'
          Transparent = False
          BeforePrint = RLLabel25BeforePrint
        end
        object RLLabel26: TRLLabel
          Left = 476
          Top = 3
          Width = 82
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VL PAG'
          Transparent = False
          BeforePrint = RLLabel26BeforePrint
        end
        object RLLabel27: TRLLabel
          Left = 563
          Top = 3
          Width = 82
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VL JUR'
          Transparent = False
          BeforePrint = RLLabel27BeforePrint
        end
        object RLLabel28: TRLLabel
          Left = 650
          Top = 3
          Width = 81
          Height = 12
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'VL DES'
          Transparent = False
          BeforePrint = RLLabel28BeforePrint
        end
      end
    end
    inherited rlbDetalhe: TRLBand
      Top = 472
      Height = 20
      Visible = False
      ExplicitTop = 472
      ExplicitHeight = 20
    end
    inherited rlbResumo: TRLBand
      Top = 512
      ExplicitTop = 512
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 492
      Width = 740
      Height = 20
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object rllTotalGeral: TRLLabel
        Left = 313
        Top = 3
        Width = 75
        Height = 12
        AutoSize = False
        Caption = 'Total Geral:'
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 389
        Top = 3
        Width = 82
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VL ORI'
        Transparent = False
        BeforePrint = RLLabel4BeforePrint
      end
      object RLLabel5: TRLLabel
        Left = 476
        Top = 3
        Width = 82
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VL PAG'
        Transparent = False
        BeforePrint = RLLabel5BeforePrint
      end
      object RLLabel6: TRLLabel
        Left = 563
        Top = 3
        Width = 82
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VL JUR'
        Transparent = False
        BeforePrint = RLLabel6BeforePrint
      end
      object RLLabel11: TRLLabel
        Left = 650
        Top = 3
        Width = 81
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VL DES'
        Transparent = False
        BeforePrint = RLLabel11BeforePrint
      end
    end
    object rlbGrupo2: TRLGroup
      Left = 38
      Top = 407
      Width = 740
      Height = 65
      DataFields = 'DESCRE;CTA_TIPCTA'
      Visible = False
      object rlbTituloGrupo2: TRLBand
        Left = 0
        Top = 0
        Width = 740
        Height = 18
        BandType = btHeader
        object RLDBText10: TRLDBText
          Left = 120
          Top = 2
          Width = 280
          Height = 13
          AutoSize = False
          DataField = 'DESCRE'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object rllTitRes: TRLLabel
          Left = 3
          Top = 2
          Width = 116
          Height = 13
          AutoSize = False
          Caption = 'CONTA DE RESULTADO:'
        end
      end
      object rlbSumarioGrupo2: TRLBand
        Left = 0
        Top = 49
        Width = 740
        Height = 19
        BandType = btSummary
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Borders.FixedBottom = True
        object rllTotRes: TRLLabel
          Left = 270
          Top = 3
          Width = 118
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total Conta de Resultado:'
        end
        object RLDBResult5: TRLDBResult
          Left = 389
          Top = 3
          Width = 82
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VALOR'
          DataSource = dtsRelatorio
          DisplayMask = '#,##0.00'
          Info = riSum
          Text = ''
        end
        object RLDBResult6: TRLDBResult
          Left = 476
          Top = 3
          Width = 82
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VALPAG'
          DataSource = dtsRelatorio
          DisplayMask = '#,##0.00'
          Info = riSum
          Text = ''
        end
        object RLDBResult7: TRLDBResult
          Left = 650
          Top = 3
          Width = 82
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VALDES'
          DataSource = dtsRelatorio
          DisplayMask = '#,##0.00'
          Info = riSum
          Text = ''
          BeforePrint = RLDBResult7BeforePrint
        end
        object RLDBResult8: TRLDBResult
          Left = 563
          Top = 3
          Width = 82
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VALJUR'
          DataSource = dtsRelatorio
          DisplayMask = '#,##0.00'
          Info = riSum
          Text = ''
          BeforePrint = RLDBResult8BeforePrint
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 33
        Width = 740
        Height = 16
        AfterPrint = rlbDetalheGrupoAfterPrint
        object RLDBText17: TRLDBText
          Left = 389
          Top = 1
          Width = 82
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALOR'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText9BeforePrint
        end
        object RLDBText18: TRLDBText
          Left = 476
          Top = 1
          Width = 82
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALPAG'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText3BeforePrint
        end
        object RLDBText19: TRLDBText
          Left = 563
          Top = 1
          Width = 82
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALJUR'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText5BeforePrint
        end
        object RLDBText20: TRLDBText
          Left = 650
          Top = 1
          Width = 82
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALDES'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
          BeforePrint = RLDBText7BeforePrint
        end
        object RLDBText1: TRLDBText
          Left = 24
          Top = 1
          Width = 363
          Height = 13
          AutoSize = False
          DataField = 'DESCTA'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 11
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
        end
      end
      object rlbTituloGrupo3: TRLBand
        Left = 0
        Top = 18
        Width = 740
        Height = 15
        BandType = btHeader
        object RLLabel9: TRLLabel
          Left = 3
          Top = 0
          Width = 116
          Height = 13
          AutoSize = False
          Caption = 'TIPO DE CONTA:'
        end
        object RLDBText8: TRLDBText
          Left = 120
          Top = 0
          Width = 280
          Height = 13
          AutoSize = False
          DataField = 'CTA_TIPCTA'
          DataSource = dtsRelatorio
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 10
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
        end
      end
    end
  end
  object dtsRelatorio: TDataSource
    Left = 144
    Top = 24
  end
end
