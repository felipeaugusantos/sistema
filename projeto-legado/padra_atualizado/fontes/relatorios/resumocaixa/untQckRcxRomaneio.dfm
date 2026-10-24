inherited frmQckRcxRomaneio: TfrmQckRcxRomaneio
  Left = 168
  Top = 189
  Width = 971
  VertScrollBar.Position = 8
  Caption = 'frmQckRcxRomaneio'
  ExplicitWidth = 971
  PixelsPerInch = 96
  TextHeight = 13
  inherited qckPagina: TRLReport
    Left = 8
    Top = 8
    ExplicitLeft = 8
    ExplicitTop = 8
    inherited rlbCabecalho: TRLBand
      Height = 87
      ExplicitHeight = 87
      inherited rllNomeRelatorio: TRLLabel
        Left = 301
        Width = 138
        Caption = 'RELAT'#211'RIO DE ROMANEIO'
        ExplicitLeft = 301
        ExplicitWidth = 138
      end
      inherited rllOrdem: TRLLabel
        Left = 3
        Top = 68
        Width = 734
        Height = 17
        BeforePrint = rllOrdemBeforePrint
        ExplicitLeft = 3
        ExplicitTop = 68
        ExplicitWidth = 734
        ExplicitHeight = 17
      end
      object rllRomaneio: TRLLabel
        Left = 3
        Top = 53
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
    end
    inherited rlbTitulo: TRLBand
      Top = 125
      Height = 19
      ExplicitTop = 125
      ExplicitHeight = 19
      object RLLabel1: TRLLabel
        Left = 19
        Top = 4
        Width = 24
        Height = 13
        AutoSize = False
        Caption = 'ESP.'
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 146
        Top = 4
        Width = 56
        Height = 13
        AutoSize = False
        Caption = 'CLIENTE'
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 362
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'DINHEI'
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 425
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CHQ A VISTA'
        Transparent = False
      end
      object RLLabel7: TRLLabel
        Left = 488
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CHQ PRE'
        Transparent = False
      end
      object RLLabel8: TRLLabel
        Left = 551
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'CARTAO'
        Transparent = False
      end
      object RLLabel9: TRLLabel
        Left = 703
        Top = 4
        Width = 35
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'TOTAL'
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 45
        Top = 4
        Width = 39
        Height = 13
        AutoSize = False
        Caption = 'N'#186' DOC.'
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 120
        Top = 4
        Width = 25
        Height = 13
        AutoSize = False
        Caption = 'EMP'
        Transparent = False
      end
      object RLLabel12: TRLLabel
        Left = 299
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'VR. DOC.'
        Transparent = False
      end
      object RLLabel13: TRLLabel
        Left = 617
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'FINANC.'
        Transparent = False
      end
    end
    inherited rlbGrupo: TRLGroup
      Top = 144
      Height = 82
      DataFields = 'RCX_NUMROM'
      ExplicitTop = 144
      ExplicitHeight = 82
      inherited rlbTituloGrupo: TRLBand
        Height = 19
        ParentColor = False
        Transparent = False
        ExplicitHeight = 19
        object RLDBText10: TRLDBText
          Left = 58
          Top = 3
          Width = 63
          Height = 13
          AutoSize = False
          DataField = 'RCX_NUMROM'
          DataSource = frmModuloSPR.dtsRelatorio
          Text = ''
        end
        object RLLabel11: TRLLabel
          Left = 4
          Top = 4
          Width = 53
          Height = 13
          AutoSize = False
          Caption = 'ROMANEIO:'
          Transparent = False
        end
      end
      inherited rlbDetalheGrupo: TRLBand
        Top = 19
        Height = 19
        ExplicitTop = 19
        ExplicitHeight = 19
        object RLDBText1: TRLDBText
          Left = 19
          Top = 2
          Width = 15
          Height = 13
          AutoSize = False
          DataField = 'ESPDOC'
          DataSource = frmModuloSPR.dtsRelatorio
          Text = ''
        end
        object RLDBText2: TRLDBText
          Left = 45
          Top = 2
          Width = 72
          Height = 13
          AutoSize = False
          DataField = 'NUMDOC'
          DataSource = frmModuloSPR.dtsRelatorio
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 120
          Top = 2
          Width = 25
          Height = 13
          AutoSize = False
          DataField = 'CODEMP'
          DataSource = frmModuloSPR.dtsRelatorio
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 146
          Top = 2
          Width = 150
          Height = 13
          AutoSize = False
          DataField = 'NOMCLI'
          DataSource = frmModuloSPR.dtsRelatorio
          Text = ''
        end
        object RLDBText5: TRLDBText
          Left = 362
          Top = 2
          Width = 60
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'DINHEI'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 11
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBText7: TRLDBText
          Left = 425
          Top = 2
          Width = 60
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'CHQAVI'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Text = ''
        end
        object RLDBText8: TRLDBText
          Left = 488
          Top = 2
          Width = 60
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'CHQPRE'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Text = ''
        end
        object RLDBText6: TRLDBText
          Left = 551
          Top = 2
          Width = 60
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'CARREC'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Text = ''
        end
        object RLDBText9: TRLDBText
          Left = 678
          Top = 2
          Width = 60
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'TOTALREG'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Text = ''
        end
        object RLDBText11: TRLDBText
          Left = 299
          Top = 2
          Width = 60
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VALDOC'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 11
          Font.Name = 'Arial'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentFont = False
          Text = ''
        end
        object RLDBText12: TRLDBText
          Left = 617
          Top = 2
          Width = 60
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          DataFormula = 'VALFIN'
          DataSource = frmModuloSPR.dtsRelatorio
          DisplayMask = '#,##0.00'
          Text = ''
        end
      end
      inherited rlbResumoGrupo: TRLBand
        Top = 38
        Visible = False
        ExplicitTop = 38
      end
    end
    inherited rlbDetalhe: TRLBand
      Top = 226
      Height = 19
      Visible = False
      ExplicitTop = 226
      ExplicitHeight = 19
    end
    inherited rlbResumo: TRLBand
      Top = 264
      ExplicitTop = 264
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 245
      Width = 740
      Height = 19
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLDBResult1: TRLDBResult
        Left = 362
        Top = 5
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'DINHEI'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Info = riSum
        Text = ''
      end
      object RLDBResult2: TRLDBResult
        Left = 425
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'CHQAVI'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Info = riSum
        Text = ''
      end
      object RLDBResult3: TRLDBResult
        Left = 488
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'CHQPRE'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Info = riSum
        Text = ''
      end
      object RLDBResult4: TRLDBResult
        Left = 551
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'CARREC'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Info = riSum
        Text = ''
      end
      object RLDBResult5: TRLDBResult
        Left = 678
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'TOTALREG'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Info = riSum
        Text = ''
      end
      object RLLabel10: TRLLabel
        Left = 250
        Top = 4
        Width = 43
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'TOTAIS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBResult6: TRLDBResult
        Left = 299
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VALDOC'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Info = riSum
        Text = ''
      end
      object RLDBResult7: TRLDBResult
        Left = 617
        Top = 4
        Width = 60
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VALFIN'
        DataSource = frmModuloSPR.dtsRelatorio
        DisplayMask = '#,##0.00'
        Info = riSum
        Text = ''
      end
    end
  end
end
