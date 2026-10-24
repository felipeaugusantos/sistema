inherited frmQckOrdProdProg: TfrmQckOrdProdProg
  Left = 281
  Top = 195
  Width = 842
  Caption = 'frmQckOrdProdProg'
  ExplicitWidth = 842
  PixelsPerInch = 96
  TextHeight = 13
  inherited qckPagina: TRLReport
    inherited rlbCabecalho: TRLBand
      Height = 123
      ExplicitHeight = 123
      inherited rllNomeRelatorio: TRLLabel
        Left = 271
        Width = 198
        Caption = 'RELATORIO DE ORDEM DE PRODUCAO'
        ExplicitLeft = 271
        ExplicitWidth = 198
      end
      inherited rllOrdem: TRLLabel
        Left = 40
        Top = 101
        Width = 697
        BeforePrint = rllOrdemBeforePrint
        ExplicitLeft = 40
        ExplicitTop = 101
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
        Top = 70
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
        Top = 101
        Width = 180
        Height = 15
      end
      object rllLinGru: TRLLabel
        Left = 4
        Top = 85
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
      Top = 161
      Height = 34
      ExplicitTop = 161
      ExplicitHeight = 34
      object RLLabel1: TRLLabel
        Left = 3
        Top = 2
        Width = 54
        Height = 13
        AutoSize = False
        Caption = 'COD.PR.'
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 60
        Top = 2
        Width = 137
        Height = 13
        AutoSize = False
        Caption = 'DESCRICAO PRODUTO'
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 199
        Top = 2
        Width = 47
        Height = 13
        AutoSize = False
        Caption = 'NUM. OP'
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 247
        Top = 2
        Width = 95
        Height = 13
        AutoSize = False
        Caption = 'DATA/HORA PREVIS.'
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 343
        Top = 2
        Width = 72
        Height = 13
        AutoSize = False
        Caption = 'DOCUMENTO'
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 416
        Top = 2
        Width = 124
        Height = 13
        AutoSize = False
        Caption = 'CLIENTE'
        Transparent = False
      end
      object RLLabel7: TRLLabel
        Left = 635
        Top = 2
        Width = 52
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
      object RLLabel11: TRLLabel
        Left = 541
        Top = 2
        Width = 93
        Height = 13
        AutoSize = False
        Caption = 'DATA/HORA BAIXA'
        Transparent = False
      end
    end
    inherited rlbGrupo: TRLGroup
      Top = 195
      Visible = False
      ExplicitTop = 195
    end
    inherited rlbDetalhe: TRLBand
      Top = 273
      Height = 34
      BeforePrint = rlbDetalheBeforePrint
      ExplicitTop = 273
      ExplicitHeight = 34
      object RLDBText1: TRLDBText
        Left = 3
        Top = 2
        Width = 54
        Height = 13
        AutoSize = False
        DataField = 'CODITE'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 60
        Top = 2
        Width = 137
        Height = 13
        AutoSize = False
        DataField = 'DESITE'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 199
        Top = 2
        Width = 47
        Height = 13
        AutoSize = False
        DataField = 'CODPRO'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 247
        Top = 2
        Width = 49
        Height = 13
        AutoSize = False
        DataField = 'DTAPRO'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 343
        Top = 2
        Width = 72
        Height = 13
        AutoSize = False
        DataField = 'NUMDOC'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText6: TRLDBText
        Left = 416
        Top = 2
        Width = 124
        Height = 13
        AutoSize = False
        DataField = 'NOMCLI'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText7: TRLDBText
        Left = 635
        Top = 2
        Width = 52
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
        Left = 379
        Top = 17
        Width = 362
        Height = 13
        AutoSize = False
        DataField = 'OBS002'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText9: TRLDBText
        Left = 295
        Top = 2
        Width = 47
        Height = 13
        AutoSize = False
        DataField = 'HPREVI'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText10: TRLDBText
        Left = 590
        Top = 2
        Width = 46
        Height = 13
        AutoSize = False
        DataField = 'HORBAI'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
      object RLDBText11: TRLDBText
        Left = 541
        Top = 2
        Width = 49
        Height = 13
        AutoSize = False
        DataField = 'DTABAI'
        DataSource = frmModuloSPR.dtsRelatorio
        Text = ''
      end
    end
    inherited rlbResumo: TRLBand
      Top = 329
      ExplicitTop = 329
    end
    object rlbTotais: TRLBand
      Left = 38
      Top = 307
      Width = 740
      Height = 22
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLLabel12: TRLLabel
        Left = 3
        Top = 4
        Width = 40
        Height = 13
        AutoSize = False
        Caption = 'TOTAIS:'
        Transparent = False
      end
      object RLDBResult1: TRLDBResult
        Left = 672
        Top = 4
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
        Left = 623
        Top = 4
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
