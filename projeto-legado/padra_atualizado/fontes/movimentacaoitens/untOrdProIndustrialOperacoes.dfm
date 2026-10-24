inherited frmOrdProIndustrialOperacoes: TfrmOrdProIndustrialOperacoes
  Width = 800
  Height = 600
  BorderStyle = bsSingle
  Caption = 'Manuten'#231#227'o de Monitoramento'
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 528
    Width = 794
    TabOrder = 1
    ExplicitTop = 528
    ExplicitWidth = 794
    inherited btnSair: TBitBtnLocked
      Left = 711
      ExplicitLeft = 711
    end
    object btnCanOpe: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 199
      Height = 22
      Caption = '[ ENTER ] Solicitar Cancelamento'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF3333993333339993333377FF3333377FF3399993333339
        993337777FF3333377F3393999333333993337F777FF333337FF993399933333
        399377F3777FF333377F993339993333399377F33777FF33377F993333999333
        399377F333777FF3377F993333399933399377F3333777FF377F993333339993
        399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
        99333773FF3333777733339993333339933333773FFFFFF77333333999999999
        3333333777333777333333333999993333333333377777333333}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnCanOpeClick
    end
  end
  object cxgOperacoes: TcxGrid [2]
    Left = 0
    Top = 68
    Width = 794
    Height = 404
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgOperacoesView: TcxGridDBBandedTableView
      OnKeyDown = cxgOperacoesViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsOperacoes
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnSorting = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem opera'#231#245'es iniciadas'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Styles.ContentOdd = cxStyle1
      Bands = <
        item
          Width = 480
        end
        item
          Caption = 'In'#237'cio do Processo'
          Width = 150
        end
        item
          Caption = 'Final do Processo'
          Width = 150
        end>
      object cxgOperacoesViewColumn1: TcxGridDBBandedColumn
        Caption = 'Fase'
        DataBinding.FieldName = 'FAS_DESFAS'
        Width = 200
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgOperacoesViewColumn2: TcxGridDBBandedColumn
        Caption = 'Equipamento'
        DataBinding.FieldName = 'EQP_DESCRI'
        Width = 200
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgOperacoesViewColumn3: TcxGridDBBandedColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'MON_OPEINI'
        HeaderAlignmentHorz = taCenter
        Width = 60
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgOperacoesViewColumn4: TcxGridDBBandedColumn
        Caption = 'Data'
        DataBinding.FieldName = 'MON_DTAINI'
        HeaderAlignmentHorz = taCenter
        SortIndex = 1
        SortOrder = soAscending
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgOperacoesViewColumn5: TcxGridDBBandedColumn
        Caption = 'Hora'
        DataBinding.FieldName = 'MON_HORINI'
        HeaderAlignmentHorz = taCenter
        SortIndex = 2
        SortOrder = soAscending
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgOperacoesViewColumn6: TcxGridDBBandedColumn
        Caption = 'Data'
        DataBinding.FieldName = 'MON_DTAFIN'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgOperacoesViewColumn7: TcxGridDBBandedColumn
        Caption = 'Hora'
        DataBinding.FieldName = 'MON_HORFIN'
        HeaderAlignmentHorz = taCenter
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgOperacoesViewColumn8: TcxGridDBBandedColumn
        Caption = 'SEQFAS'
        DataBinding.FieldName = 'FAS_SEQFAS'
        Visible = False
        SortIndex = 0
        SortOrder = soAscending
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
    end
    object cxgOperacoesLevel1: TcxGridLevel
      GridView = cxgOperacoesView
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 68
    Align = alTop
    BevelOuter = bvLowered
    Enabled = False
    TabOrder = 3
    object Label2: TLabel
      Left = 16
      Top = 13
      Width = 40
      Height = 14
      AutoSize = False
      Caption = 'Produto:'
    end
    object Label3: TLabel
      Left = 612
      Top = 13
      Width = 60
      Height = 14
      AutoSize = False
      Caption = 'Volume (LT):'
    end
    object Label4: TLabel
      Left = 648
      Top = 41
      Width = 24
      Height = 14
      AutoSize = False
      Caption = 'Lote:'
    end
    object edtDesIte: TEditFocus
      Tag = 99
      Left = 62
      Top = 7
      Width = 531
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumOpe: TEditFocus
      Tag = 99
      Left = 62
      Top = 35
      Width = 108
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesEti: TEditFocus
      Tag = 99
      Left = 175
      Top = 35
      Width = 418
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtVolume: TEditFocus
      Tag = 99
      Left = 676
      Top = 8
      Width = 108
      Height = 22
      Alignment = taRightJustify
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNumLot: TEditFocus
      Tag = 99
      Left = 676
      Top = 35
      Width = 108
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object mmoAviso: TMemo [4]
    Left = 0
    Top = 472
    Width = 794
    Height = 56
    Align = alBottom
    Color = clInfoBk
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      
        '                                   H'#225' Fases n'#227'o iniciadas ou n'#227'o' +
        ' finalizadas para essa Ordem de Produ'#231#227'o!!')
    ParentFont = False
    TabOrder = 4
    Visible = False
  end
  inherited pnlStatus: TPanel
    Top = 556
    Width = 794
    TabOrder = 2
    ExplicitTop = 556
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 240
    Top = 352
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 352
    Top = 352
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 128
    Top = 352
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 56
    Top = 176
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object dtsOperacoes: TDataSource
    Left = 568
    Top = 208
  end
end
