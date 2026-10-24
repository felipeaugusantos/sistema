inherited frmResumoQuantidadeVendasPerdidas: TfrmResumoQuantidadeVendasPerdidas
  Width = 778
  Height = 480
  Caption = 'Resumo Quantidade Vendas Perdidas '
  ExplicitWidth = 778
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 407
    Width = 772
    ExplicitTop = 407
    ExplicitWidth = 772
    inherited FlwBotoes: TFlowPanel
      Width = 768
      ExplicitWidth = 768
    end
    inherited btnSair: TBitBtnLocked
      Left = 692
      Caption = '&Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      ModalResult = 8
      ExplicitLeft = 692
    end
  end
  inherited pnlStatus: TPanel
    Top = 435
    Width = 772
    ExplicitTop = 435
    ExplicitWidth = 772
    inherited pnlNomeForm: TPanel
      Left = 601
      ExplicitLeft = 601
    end
    inherited pnlInfo: TPanel
      Width = 601
      ExplicitWidth = 601
    end
  end
  object cxgVendas: TcxGrid [2]
    Left = 0
    Top = 25
    Width = 772
    Height = 382
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgVendasDB: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsVendas
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.ColumnHidingOnGrouping = False
      OptionsCustomize.ColumnMoving = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxgGiroEMPCOD: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODEMP'
        Visible = False
        GroupIndex = 0
      end
      object cxgGiroNOMEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'NOMEMP'
        Visible = False
        GroupIndex = 1
        IsChildInMergedGroup = True
      end
      object cxgGiroDTACAD: TcxGridDBColumn
        Caption = 'Data Cad.'
        DataBinding.FieldName = 'DTACAD'
        Width = 65
      end
      object cxgGiroCODIGO: TcxGridDBColumn
        Caption = 'Venda'
        DataBinding.FieldName = 'CODIGO'
        Width = 70
      end
      object cxgGiroCODCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CODCLI'
        Visible = False
      end
      object cxgGiroNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Width = 300
      end
      object cxgGiroDESMOT: TcxGridDBColumn
        Caption = 'Motivo'
        DataBinding.FieldName = 'DESMOT'
        Width = 250
      end
      object cxgGiroCODITE: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'CODITE'
        Visible = False
      end
      object cxgGiroQTDITE: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        Width = 65
      end
    end
    object cxgVendasLevel1: TcxGridLevel
      GridView = cxgVendasDB
    end
  end
  object pnlLegendas: TPanel [3]
    Left = 0
    Top = 0
    Width = 772
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    object Label5: TLabel
      Left = 7
      Top = 6
      Width = 47
      Height = 14
      Caption = 'Produto:'
      Color = clMedGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblProduto: TLabel
      Left = 60
      Top = 6
      Width = 37
      Height = 14
      Caption = 'Produto'
    end
    object Label1: TLabel
      Left = 639
      Top = 6
      Width = 47
      Height = 14
      Caption = 'Unidade:'
      Color = clMedGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblUnidade: TLabel
      Left = 692
      Top = 6
      Width = 49
      Height = 14
      Caption = 'lblUnidade'
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Top = 112
  end
  object dtsVendas: TDataSource
    Left = 376
    Top = 224
  end
end
