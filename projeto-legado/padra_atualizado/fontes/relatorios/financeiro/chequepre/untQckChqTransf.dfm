inherited frmQckChqTransf: TfrmQckChqTransf
  Left = 364
  Top = 211
  Width = 792
  Caption = 'frmQckChqTransf'
  WindowState = wsMaximized
  ExplicitWidth = 792
  PixelsPerInch = 96
  TextHeight = 13
  inherited qckPagina: TRLReport
    Left = -26
    DataSource = dtsCheque
    ExplicitLeft = -26
    inherited rlbCabecalho: TRLBand
      Height = 93
      ExplicitHeight = 93
      inherited rllNomeRelatorio: TRLLabel
        Left = 215
        Width = 310
        Caption = 'RELATORIO DE CHEQUES TRANSFERIDOS ENTRE EMPRESAS'
        ExplicitLeft = 215
        ExplicitWidth = 310
      end
      inherited rllOrdem: TRLLabel
        Top = 80
        Width = 734
        Height = 9
        BeforePrint = rllOrdemBeforePrint
        ExplicitTop = 80
        ExplicitWidth = 734
        ExplicitHeight = 9
      end
      object rllEmpresa: TRLLabel
        Left = 4
        Top = 45
        Width = 733
        Height = 16
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
      object rllEmpDestino: TRLLabel
        Left = 4
        Top = 62
        Width = 733
        Height = 16
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
      Top = 131
      Height = 19
      ExplicitTop = 131
      ExplicitHeight = 19
      object RLLabel1: TRLLabel
        Left = 1
        Top = 3
        Width = 19
        Height = 10
        Caption = 'BCO'
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 27
        Top = 3
        Width = 15
        Height = 10
        Caption = 'AG.'
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 63
        Top = 3
        Width = 38
        Height = 10
        Caption = 'CTA COR'
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 132
        Top = 3
        Width = 31
        Height = 10
        Caption = 'Nr.CHQ'
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 197
        Top = 3
        Width = 35
        Height = 10
        Caption = 'CLIENTE'
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 334
        Top = 2
        Width = 42
        Height = 10
        Caption = 'EMITENTE'
        Transparent = False
      end
      object RLLabel7: TRLLabel
        Left = 483
        Top = 3
        Width = 24
        Height = 10
        Caption = 'FONE'
        Transparent = False
      end
      object lblDataCampo: TRLLabel
        Left = 609
        Top = 3
        Width = 37
        Height = 10
        Caption = 'DTA CAD'
        Transparent = False
      end
      object RLLabel10: TRLLabel
        Left = 704
        Top = 3
        Width = 28
        Height = 10
        Alignment = taRightJustify
        Caption = 'VALOR'
        Transparent = False
      end
      object RLLabel8: TRLLabel
        Left = 548
        Top = 3
        Width = 24
        Height = 10
        Caption = 'Nr NF'
        Transparent = False
      end
    end
    inherited rlbGrupo: TRLGroup
      Top = 150
      Height = 2
      DataFields = 'CHQ_DTATRF'
      Visible = False
      ExplicitTop = 150
      ExplicitHeight = 2
      inherited rlbTituloGrupo: TRLBand
        Height = 5
        Visible = False
        ExplicitHeight = 5
      end
      inherited rlbDetalheGrupo: TRLBand
        Top = 5
        Height = 5
        Visible = False
        ExplicitTop = 5
        ExplicitHeight = 5
      end
      inherited rlbResumoGrupo: TRLBand
        Top = 10
        Height = 5
        Borders.Sides = sdCustom
        Borders.DrawBottom = True
        Visible = False
        ExplicitTop = 10
        ExplicitHeight = 5
      end
    end
    inherited rlbDetalhe: TRLBand
      Top = 152
      Height = 21
      ExplicitTop = 152
      ExplicitHeight = 21
      object RLDBText1: TRLDBText
        Left = 669
        Top = 4
        Width = 66
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'CHQ_VALCHQ'
        DataSource = dtsCheque
        Text = ''
        BeforePrint = RLDBText1BeforePrint
      end
      object rdbDtaVen: TRLDBText
        Left = 609
        Top = 4
        Width = 57
        Height = 12
        AutoSize = False
        DataField = 'CHQ_DTACAD'
        DataSource = dtsCheque
        Text = ''
        BeforePrint = rdbDtaVenBeforePrint
      end
      object RLDBText4: TRLDBText
        Left = 483
        Top = 4
        Width = 63
        Height = 12
        AutoSize = False
        DataField = 'CHQ_TELEMI'
        DataSource = dtsCheque
        Text = ''
        BeforePrint = RLDBText4BeforePrint
      end
      object RLDBText5: TRLDBText
        Left = 334
        Top = 4
        Width = 147
        Height = 12
        AutoSize = False
        DataField = 'CHQ_NOMEMI'
        DataSource = dtsCheque
        Text = ''
      end
      object RLDBText6: TRLDBText
        Left = 1
        Top = 4
        Width = 24
        Height = 12
        AutoSize = False
        DataField = 'CHQ_CODBCO'
        DataSource = dtsCheque
        Text = ''
      end
      object RLDBText7: TRLDBText
        Left = 27
        Top = 4
        Width = 33
        Height = 12
        AutoSize = False
        DataField = 'CHQ_NUMAGE'
        DataSource = dtsCheque
        Text = ''
      end
      object RLDBText8: TRLDBText
        Left = 63
        Top = 4
        Width = 66
        Height = 12
        AutoSize = False
        DataField = 'CHQ_CONCOR'
        DataSource = dtsCheque
        Text = ''
      end
      object RLDBText9: TRLDBText
        Left = 132
        Top = 4
        Width = 61
        Height = 12
        AutoSize = False
        DataField = 'CHQ_NUMCHQ'
        DataSource = dtsCheque
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 10
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText10: TRLDBText
        Left = 197
        Top = 4
        Width = 135
        Height = 12
        AutoSize = False
        DataField = 'CHQ_CODCLI'
        DataSource = dtsCheque
        Text = ''
        BeforePrint = RLDBText10BeforePrint
      end
      object RLDBText2: TRLDBText
        Left = 548
        Top = 4
        Width = 58
        Height = 12
        AutoSize = False
        DataField = 'CHQ_NUMNOT'
        DataSource = dtsCheque
        Text = ''
      end
    end
    inherited rlbResumo: TRLBand
      Top = 192
      Height = 21
      ExplicitTop = 192
      ExplicitHeight = 21
      inherited rllNomeForm: TRLLabel
        Left = 0
        ExplicitLeft = 0
      end
      inherited RLPanel1: TRLPanel
        Left = 686
        ExplicitLeft = 686
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 173
      Width = 740
      Height = 19
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLLabel15: TRLLabel
        Left = 617
        Top = 3
        Width = 45
        Height = 10
        Alignment = taRightJustify
        Caption = 'Total do Dia:'
        BeforePrint = RLLabel15BeforePrint
      end
      object RLLabel16: TRLLabel
        Left = 664
        Top = 3
        Width = 71
        Height = 12
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Total do Dia: 99/99/9999'
        BeforePrint = RLLabel16BeforePrint
      end
      object RLLabel17: TRLLabel
        Left = 0
        Top = 3
        Width = 42
        Height = 10
        Caption = 'Total Geral:'
      end
    end
  end
  object dtsCheque: TDataSource
    Left = 464
    Top = 72
  end
end
