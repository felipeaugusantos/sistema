inherited frmCfgModeloSMS: TfrmCfgModeloSMS
  Width = 1024
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Configura'#231#227'o do Modelo de SMS'
  WindowState = wsMaximized
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 1008
    TabOrder = 2
    ExplicitTop = 519
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 832
      ExplicitTop = 2
      ExplicitWidth = 832
      inherited btnConfirma: TBitBtnLocked
        TabStop = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      Top = 2
      Align = alRight
      TabStop = False
      ExplicitLeft = 929
      ExplicitTop = 2
    end
    object btnRegraSMS: TBitBtnLocked
      Left = 834
      Top = 2
      Width = 95
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = '&Regras'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      TabOrder = 2
      Visible = False
      OnClick = btnRegraSMSClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1008
    TabOrder = 3
    ExplicitTop = 545
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object pnlCamDis: TPanel [3]
    Left = 0
    Top = 0
    Width = 185
    Height = 519
    Align = alLeft
    Caption = 'pnlCamDis'
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object cxGrid1: TcxGrid
      Left = 1
      Top = 1
      Width = 183
      Height = 517
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxGrid1DBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel
        OnKeyDown = cxGrid1DBBandedTableViewCitel1KeyDown
        Navigator.Buttons.CustomButtons = <>
        OnCellDblClick = cxGrid1DBBandedTableViewCitel1CellDblClick
        DataController.DataSource = dtsCamDis
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
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        Styles.Background = cxStyle2
        Bands = <
          item
            Caption = 'Campos Dispon'#237'veis'
            Styles.Header = cxStyle1
          end>
        Zebra = True
        Destaque = False
        DestacarRegistro = False
        CorZebra = clMoneyGreen
        object cxGrid1DBBandedTableViewCitel1Column1: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CAMDIS'
          SortIndex = 0
          SortOrder = soAscending
          Width = 180
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
          IsCaptionAssigned = True
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBBandedTableViewCitel1
      end
    end
  end
  object pnlFundo: TPanel [4]
    Left = 185
    Top = 0
    Width = 823
    Height = 519
    Align = alClient
    TabOrder = 1
    object pnlEditor: TPanel
      Left = 1
      Top = 1
      Width = 821
      Height = 517
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object mmoMensagem: TMemoFocus
        Left = 1
        Top = 1
        Width = 819
        Height = 497
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = mmoMensagemChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object pnlContagem: TPanel
        Left = 1
        Top = 498
        Width = 819
        Height = 18
        Align = alBottom
        BevelOuter = bvNone
        BorderWidth = 1
        Caption = 'A mensagem ter'#225' 000 caracretes aproximadamente'
        Color = clInfoBk
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 600
    Top = 80
  end
  object dtsCamDis: TDataSource
    Left = 80
    Top = 256
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 528
    Top = 80
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = 16770261
    end
  end
end
