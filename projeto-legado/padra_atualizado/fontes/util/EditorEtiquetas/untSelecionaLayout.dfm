inherited frmSelecionaLayout: TfrmSelecionaLayout
  Width = 867
  Height = 558
  Caption = 'Selecione um Layout para altera'#231#227'o'
  ExplicitWidth = 867
  ExplicitHeight = 558
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 485
    Width = 861
    ExplicitTop = 485
    ExplicitWidth = 861
    DesignSize = (
      861
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 857
      TabOrder = 3
      ExplicitWidth = 857
    end
    inherited btnSair: TBitBtnLocked
      Left = 778
      TabOrder = 2
      ExplicitLeft = 778
    end
    object btnConfima: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 105
      Height = 22
      Caption = 'Confirma [F10]'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
    end
    object btnExcluir: TBitBtnLocked
      Left = 296
      Top = 3
      Width = 89
      Height = 22
      Caption = '&Excluir'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
        00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
        00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
        DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
        006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
        16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
        20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
        6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
        00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
        00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
        E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnExcluirClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 513
    Width = 861
    ExplicitTop = 513
    ExplicitWidth = 861
    inherited pnlNomeForm: TPanel
      Left = 690
      ExplicitLeft = 690
    end
    inherited pnlInfo: TPanel
      Width = 690
      ExplicitWidth = 690
    end
  end
  object cxGrid1: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 861
    Height = 485
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsLayEti
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      object colCodLay: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'LAY_CODLAY'
        Options.Editing = False
      end
      object colNomLay: TcxGridDBColumn
        Caption = 'Descri'#231'ao'
        DataBinding.FieldName = 'LAY_NOMLAY'
        Options.Editing = False
        Width = 241
      end
      object colDescri: TcxGridDBColumn
        Caption = 'Tipo do Layout'
        DataBinding.FieldName = 'LAY_DESCRI'
        Options.Editing = False
        Width = 243
      end
      object colDtaAlt: TcxGridDBColumn
        Caption = 'Data Altera'#231#227'o'
        DataBinding.FieldName = 'LAY_DTAALT'
        Options.Editing = False
        Width = 85
      end
      object colHorAlt: TcxGridDBColumn
        Caption = 'Hora Altera'#231#227'o'
        DataBinding.FieldName = 'LAY_HORALT'
        Options.Editing = False
        Width = 86
      end
      object colPadrao: TcxGridDBColumn
        Caption = 'Padr'#227'o'
        DataBinding.FieldName = 'LAY_PADRAO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Width = 46
      end
      object colEmpresa: TcxGridDBColumn
        Caption = 'Emp'
        DataBinding.FieldName = 'LAY_CODEMP'
        Options.Editing = False
        Width = 35
      end
      object colOpcional: TcxGridDBColumn
        Caption = 'Opcional'
        DataBinding.FieldName = 'LAY_OPCION'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = 'S'
        Properties.ValueUnchecked = 'N'
        Properties.OnChange = colOpcionalPropertiesChange
        Width = 50
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object dtsLayEti: TDataSource
    Left = 168
    Top = 112
  end
  object cxStyleRepositorio: TcxStyleRepository
    Left = 640
    Top = 128
    PixelsPerInch = 96
    object cxStyleSelecao: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clBlue
    end
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 16768443
    end
  end
end
