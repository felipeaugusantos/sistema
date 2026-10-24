inherited frmQckOrdPro: TfrmQckOrdPro
  Left = 281
  Top = 195
  Width = 842
  Caption = 'frmQckOrdPro'
  ExplicitWidth = 842
  PixelsPerInch = 96
  TextHeight = 13
  inherited qckPagina: TRLReport
    Left = -4
    ExplicitLeft = -4
    inherited rlbCabecalho: TRLBand
      Height = 118
      ExplicitHeight = 118
      inherited rllNomeRelatorio: TRLLabel
        Left = 271
        Width = 198
        Caption = 'RELATORIO DE ORDEM DE PRODUCAO'
        ExplicitLeft = 271
        ExplicitWidth = 198
      end
      inherited rllOrdem: TRLLabel
        Left = 40
        Top = 100
        Width = 697
        BeforePrint = rllOrdemBeforePrint
        ExplicitLeft = 40
        ExplicitTop = 100
        ExplicitWidth = 697
      end
      object rllCliente: TRLLabel
        Left = 4
        Top = 38
        Width = 733
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
      end
      object rllVendedor: TRLLabel
        Left = 4
        Top = 54
        Width = 733
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
      end
      object rllEmpresa: TRLLabel
        Left = 4
        Top = 69
        Width = 733
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
      end
      object rllFiltro: TRLLabel
        Left = 4
        Top = 100
        Width = 180
        Height = 15
      end
      object rllLinGru: TRLLabel
        Left = 4
        Top = 84
        Width = 733
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
      end
    end
    inherited rlbTitulo: TRLBand
      Top = 156
      Height = 34
      ExplicitTop = 156
      ExplicitHeight = 34
      object RLLabel1: TRLLabel
        Left = 3
        Top = 2
        Width = 60
        Height = 13
        AutoSize = False
        Caption = 'COD.PROD.'
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 69
        Top = 2
        Width = 160
        Height = 13
        AutoSize = False
        Caption = 'DESCRICAO PRODUTO'
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 232
        Top = 2
        Width = 78
        Height = 13
        AutoSize = False
        Caption = 'NUM. OP'
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 311
        Top = 2
        Width = 69
        Height = 13
        AutoSize = False
        Caption = 'DTA PREVISAO'
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 384
        Top = 2
        Width = 76
        Height = 13
        AutoSize = False
        Caption = 'DOCUMENTO'
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 461
        Top = 2
        Width = 173
        Height = 13
        AutoSize = False
        Caption = 'CLIENTE'
        Transparent = False
      end
      object RLLabel7: TRLLabel
        Left = 636
        Top = 2
        Width = 50
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'QTD A PRO'
        Transparent = False
      end
      object RLLabel8: TRLLabel
        Left = 688
        Top = 2
        Width = 49
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'QTD PRO'
        Transparent = False
      end
      object RLLabel9: TRLLabel
        Left = 3
        Top = 17
        Width = 370
        Height = 13
        AutoSize = False
        Caption = 'OBSERVACAO 1'
        Transparent = False
      end
      object RLLabel10: TRLLabel
        Left = 375
        Top = 17
        Width = 362
        Height = 13
        AutoSize = False
        Caption = 'OBSERVACAO 2'
        Transparent = False
      end
    end
    inherited rlbGrupo: TRLGroup
      Top = 190
      Visible = False
      ExplicitTop = 190
    end
    inherited rlbDetalhe: TRLBand
      Top = 268
      Height = 34
      BeforePrint = rlbDetalheBeforePrint
      ExplicitTop = 268
      ExplicitHeight = 34
      object RLDBText1: TRLDBText
        Left = 3
        Top = 2
        Width = 60
        Height = 13
        AutoSize = False
        DataField = 'CODITE'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 69
        Top = 2
        Width = 160
        Height = 13
        AutoSize = False
        DataField = 'DESITE'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 232
        Top = 2
        Width = 78
        Height = 13
        AutoSize = False
        DataField = 'CODPRO'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 311
        Top = 2
        Width = 69
        Height = 13
        AutoSize = False
        DataField = 'DTAPRO'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 384
        Top = 2
        Width = 76
        Height = 13
        AutoSize = False
        DataField = 'NUMDOC'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText6: TRLDBText
        Left = 461
        Top = 2
        Width = 173
        Height = 13
        AutoSize = False
        DataField = 'NOMCLI'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText7: TRLDBText
        Left = 636
        Top = 2
        Width = 50
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataFormula = 'QTDAPR'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Text = ''
      end
      object RLDBText8: TRLDBText
        Left = 688
        Top = 2
        Width = 49
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataFormula = 'QTDPRO'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Text = ''
      end
      object rllObs001: TRLDBText
        Left = 3
        Top = 17
        Width = 370
        Height = 13
        AutoSize = False
        DataField = 'OBS001'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object rllObs002: TRLDBText
        Left = 375
        Top = 17
        Width = 362
        Height = 13
        AutoSize = False
        DataField = 'OBS002'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
    end
    inherited rlbResumo: TRLBand
      Top = 324
      ExplicitTop = 324
    end
    object rlbTotais: TRLBand
      Left = 38
      Top = 302
      Width = 740
      Height = 22
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLLabel11: TRLLabel
        Left = 3
        Top = 3
        Width = 52
        Height = 13
        AutoSize = False
        Caption = 'TOTAIS:'
        Transparent = False
      end
      object RLDBResult1: TRLDBResult
        Left = 671
        Top = 3
        Width = 65
        Height = 10
        Alignment = taRightJustify
        DataField = 'QTDPRO'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Info = riSum
        Text = ''
      end
      object RLDBResult2: TRLDBResult
        Left = 622
        Top = 3
        Width = 64
        Height = 10
        Alignment = taRightJustify
        DataField = 'QTDAPR'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Info = riSum
        Text = ''
      end
    end
  end
end
