inherited frmQckFatDemonstracaoCamp: TfrmQckFatDemonstracaoCamp
  Left = 300
  Top = 199
  Width = 1062
  Caption = 'Demonstra'#231#227'o de Campanhas'
  Position = poScreenCenter
  ExplicitWidth = 1062
  PixelsPerInch = 96
  TextHeight = 13
  inherited qckPagina: TRLReport
    DataSource = nil
    inherited rlbCabecalho: TRLBand
      Height = 171
      ExplicitHeight = 171
      inherited rllOrdem: TRLLabel
        Top = 151
        Width = 734
        ExplicitTop = 151
        ExplicitWidth = 734
      end
      object rllRede: TRLLabel
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
      object rllCliente: TRLLabel
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
      object rllCampanha: TRLLabel
        Left = 4
        Top = 92
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
      object rllStatus: TRLLabel
        Left = 4
        Top = 111
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
        Top = 131
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
    inherited rlbTitulo: TRLBand
      Top = 209
      Height = 35
      ExplicitTop = 209
      ExplicitHeight = 35
      object RLLabel1: TRLLabel
        Left = 3
        Top = 18
        Width = 59
        Height = 13
        AutoSize = False
        Caption = 'PRODUTO'
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 195
        Top = 18
        Width = 46
        Height = 13
        AutoSize = False
        Caption = 'UNIDADE'
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 523
        Top = 18
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VLR. FAT.'
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 307
        Top = 18
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'QTD. CAM.'
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 379
        Top = 18
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VLR. CAM.'
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 451
        Top = 18
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'QTD. FAT.'
        Transparent = False
      end
      object RLLabel7: TRLLabel
        Left = 595
        Top = 18
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'QTD. SAL.'
        Transparent = False
      end
      object RLLabel8: TRLLabel
        Left = 667
        Top = 18
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VLR. SAL.'
        Transparent = False
      end
      object RLLabel12: TRLLabel
        Left = 647
        Top = 5
        Width = 56
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'SALDOS'
        Transparent = False
      end
    end
    inherited rlbGrupo: TRLGroup
      Top = 244
      Height = 65
      DataFields = 'DESCMG'
      ExplicitTop = 244
      ExplicitHeight = 65
      inherited rlbTituloGrupo: TRLBand
        Height = 19
        ParentColor = False
        Transparent = False
        ExplicitHeight = 19
        object RLDBText1: TRLDBText
          Left = 66
          Top = 4
          Width = 300
          Height = 13
          AutoSize = False
          DataField = 'DESCMG'
          Text = ''
        end
        object RLLabel9: TRLLabel
          Left = 3
          Top = 4
          Width = 62
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'CAMPANHA:'
          Transparent = False
        end
      end
      inherited rlbDetalheGrupo: TRLBand
        Top = 19
        Height = 19
        BeforePrint = rlbDetalheGrupoBeforePrint
        ExplicitTop = 19
        ExplicitHeight = 19
        object RLDBText2: TRLDBText
          Left = 3
          Top = 4
          Width = 190
          Height = 13
          AutoSize = False
          DataField = 'DESITE'
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 195
          Top = 4
          Width = 110
          Height = 13
          AutoSize = False
          DataField = 'DESUNI'
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 307
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'QTDCAM'
          DisplayMask = '#,###0.000'
          Text = ''
        end
        object RLDBText5: TRLDBText
          Left = 379
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VLRCAM'
          DisplayMask = '#,##0.00'
          Text = ''
        end
        object RLDBText6: TRLDBText
          Left = 451
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'QTDFAT'
          DisplayMask = '#,###0.000'
          Text = ''
        end
        object RLDBText7: TRLDBText
          Left = 523
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VLRFAT'
          DisplayMask = '#,##0.00'
          Text = ''
        end
        object RLDBText8: TRLDBText
          Left = 595
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'QTDSAL'
          DisplayMask = '#,###0.000'
          Text = ''
        end
        object RLDBText9: TRLDBText
          Left = 667
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VLRSAL'
          DisplayMask = '#,##0.00'
          Text = ''
        end
      end
      inherited rlbResumoGrupo: TRLBand
        Top = 38
        Height = 19
        Borders.Sides = sdCustom
        Borders.DrawBottom = True
        Borders.FixedBottom = True
        BeforePrint = rlbResumoGrupoBeforePrint
        ExplicitTop = 38
        ExplicitHeight = 19
        object RLDBResult1: TRLDBResult
          Left = 307
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'QTDCAM'
          DisplayMask = '#,###0.000'
          Info = riSum
          Text = ''
        end
        object RLDBResult2: TRLDBResult
          Left = 379
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VLRCAM'
          DisplayMask = '#,##0.00'
          Info = riSum
          Text = ''
        end
        object RLDBResult3: TRLDBResult
          Left = 451
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'QTDFAT'
          DisplayMask = '#,###0.000'
          Info = riSum
          Text = ''
        end
        object RLDBResult4: TRLDBResult
          Left = 523
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VLRFAT'
          DisplayMask = '#,##0.00'
          Info = riSum
          Text = ''
        end
        object RLLabel10: TRLLabel
          Left = 219
          Top = 4
          Width = 86
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'TOTAL PARCIAL:'
          Transparent = False
        end
        object rllQtdSalParc: TRLLabel
          Left = 595
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
        end
        object rllVlrSalParc: TRLLabel
          Left = 667
          Top = 4
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
        end
      end
    end
    inherited rlbDetalhe: TRLBand
      Top = 309
      Height = 19
      Visible = False
      ExplicitTop = 309
      ExplicitHeight = 19
    end
    inherited rlbResumo: TRLBand
      Top = 347
      Height = 19
      ExplicitTop = 347
      ExplicitHeight = 19
    end
    object rlbResumoTotal: TRLBand
      Left = 38
      Top = 328
      Width = 740
      Height = 19
      BandType = btSummary
      BeforePrint = rlbResumoTotalBeforePrint
      object RLLabel11: TRLLabel
        Left = 219
        Top = 4
        Width = 86
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'TOTAL:'
        Transparent = False
      end
      object RLDBResult7: TRLDBResult
        Left = 307
        Top = 4
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'QTDCAM'
        DisplayMask = '#,###0.000'
        Info = riSum
        Text = ''
      end
      object RLDBResult8: TRLDBResult
        Left = 379
        Top = 4
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VLRCAM'
        DisplayMask = '#,##0.00'
        Info = riSum
        Text = ''
      end
      object RLDBResult9: TRLDBResult
        Left = 451
        Top = 4
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'QTDFAT'
        DisplayMask = '#,###0.000'
        Info = riSum
        Text = ''
      end
      object RLDBResult10: TRLDBResult
        Left = 523
        Top = 4
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VLRFAT'
        DisplayMask = '#,##0.00'
        Info = riSum
        Text = ''
      end
      object rllQtdSalTotal: TRLLabel
        Left = 595
        Top = 4
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
      end
      object rllVlrSalTotal: TRLLabel
        Left = 667
        Top = 4
        Width = 70
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
      end
    end
    object RLDBResult5: TRLDBResult
      Left = 459
      Top = 380
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      DataField = 'QTDSAL'
      DisplayMask = '#,###0.000'
      Info = riSum
      Text = ''
      Visible = False
    end
    object RLDBResult6: TRLDBResult
      Left = 531
      Top = 380
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      DataField = 'VLRSAL'
      DisplayMask = '#,##0.00'
      Info = riSum
      Text = ''
      Visible = False
    end
    object RLDBResult11: TRLDBResult
      Left = 443
      Top = 404
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      DataField = 'QTDSAL'
      DisplayMask = '#,###0.000'
      Info = riSum
      Text = ''
      Visible = False
    end
    object RLDBResult12: TRLDBResult
      Left = 515
      Top = 404
      Width = 70
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      DataField = 'VLRSAL'
      DisplayMask = '#,##0.00'
      Info = riSum
      Text = ''
      Visible = False
    end
  end
  inherited RLExpressionParser1: TRLExpressionParser
    Left = 360
  end
end
