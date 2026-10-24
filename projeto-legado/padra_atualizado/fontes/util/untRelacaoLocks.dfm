inherited frmRelacaoLocks: TfrmRelacaoLocks
  Width = 717
  Height = 387
  Caption = 'Relat'#243'rio de Documentos Travados Pelo Usu'#225'rio'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 717
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 14
  object lblMensagem: TLabel [0]
    Left = 0
    Top = 260
    Width = 711
    Height = 15
    Align = alBottom
    Alignment = taCenter
    Caption = 
      'Use ENTER ou DUPLO CLIQUE do mouse para selecionar mais de um re' +
      'gistro'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitTop = 245
    ExplicitWidth = 435
  end
  inherited pnlBotoes: TPanel
    Top = 316
    Width = 711
    Height = 26
    TabOrder = 1
    ExplicitTop = 301
    ExplicitWidth = 711
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 630
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 630
      ExplicitHeight = 22
      object btnLiberar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 126
        Height = 22
        Caption = '[F4] Liberar Registro'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FF0286BD30A4D745B0E13AAADA269ED134A6D8FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF038AC0058FC465C5ED89D5FE7FCFFA7A
          CEF862BFEA58BBE92FA4D7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          0892C70E9ACC69CCE989DAFA7ACFF768C2EE3FA9D776CBF482D1FA5BBCEBFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF109ACC1AA4D47BD5EA9DE9F88BE0FC49
          9EC42083AF54B7E57DCFFA82D1FA1F9DCFFF00FFFF00FFFF00FFFF00FFFF00FF
          19A1D328ACDC9DDDEDC1F6FCA3F0FF69BAD416658A4EABD77BD0FB7DCFF81E9C
          CEFF00FFFF00FFFF00FFFF00FFFF00FF23A9DA2FB0E1B5E1F0E6F8FCBBF2FA9F
          E6F24893AD72C1E181D5FE7BCCF81E9CCEFF00FFFF00FFFF00FFFF00FFFF00FF
          1A9FD02CB0D943AFD051B8D747B8D945B7D953C1E06CCCE986D9F78BD8FE1F9D
          CFFF00FFFF00FFFF00FFFF00FFFF00FF169FCC5AD1E01D728F23829F4ED8EB2C
          BDE011A1CE0995C6189ACA5EC2E7219FCFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF1C9ECA35A9C459CBDA80FCFF66EDF836C1DE078AB8017FB2088EC10B8F
          C2FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3AC1E031
          BBDC2DB0D30782B20680B1078FC2078BC1FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0684B5037BAFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0273A5016D9FFF00FFFF
          00FFFF00FF0382B60478AAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF1A9CCF0F88BBFF00FFFF00FFFF00FF0384B80479ABFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF33A1C94DC2E3FF00FFFF
          00FFFF00FF0381B50379ACFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF41B4CE5DD5E535A6C72799C50E90C4FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3BADC73B
          AFCA35A7CCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnLiberarClick
      end
      object btnRefresh: TBitBtnLocked
        Left = 126
        Top = 0
        Width = 126
        Height = 22
        Caption = '[F5] Atualizar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF033B8A033D90013D95023B91033A89033A89FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0357D30147B20051D0035CE007
          63E3035CE0004ED30042B7023A8F023A8FFF00FFFF00FFFF00FFFF00FFFF00FF
          0650BA0357D32781F278B4F7CAE2FCE9F4FFDCEDFF9CC7FA3F8FF20155DD0140
          A404367DFF00FFFF00FFFF00FF075DD70762E155A0F7F3F8FEFFFFFFE9F3FCC6
          DEFAD9E9FCFFFFFFFFFFFF99C5F8055DE70040A302398BFF00FFFF00FF075DD7
          529EF7FEFEFFE2EFFC0F65EB0558E70959E50250E20454E16FA6F0DEEBFC9CC9
          F80355DE02398BFF00FF0455C9207DF0E1EFFEFFFFFF116BF25198F4C2DCFBDA
          EAFCC4DCFA478BEE014EE16FA7F0FFFFFF3E8FF20043B7033E96085FDA56A1FA
          FFFFFF9ECBFB1573F7EDF4FE5199F4186EEE5297F2EAF3FE357FED0556E3DEEB
          FC9FCBFA0050D4033E960F6BE68BC1FCFFFFFF2987FCB6D8FE72B0FB1774F40F
          6AF20C65EF6EAAF4B0D0FA0455E5A0C5F6DEEFFF0560E202409C1B76EDA4CFFC
          FFFFFF2988FFCEE6FF4D9DFC1877FA60A6FA116CF31872F24690F2085DEA88BA
          F4EBF6FF0C68E60141A1207AEBA5CFFEFFFFFF3F97FF95C7FFA4D0FF1C7DFCFF
          FFFFB5D7FC378AF70F6AF00C65EEC6DEFBCEE5FE0763E203419E146FE79ACAFC
          FFFFFFB2D8FF2F8CFFCEE6FFD8EBFFFFFFFFFFFFFFFFFFFF64A7FA2C82F4E2EF
          FE81BAF80258D8033E96FF00FF237BEBEDF6FFFAFCFF5DA9FF1F81FF1F81FFFF
          FFFFF0F7FF84BDFE2782FAF0F8FFF2F8FE3089F4024FC0FF00FFFF00FF237BEB
          BFDEFFF3F8FFFAFCFFB0D5FF3E96FFB6D9FF308CFF6AB0FEFAFCFFFFFFFF5DA6
          F70860DE024FC0FF00FFFF00FFFF00FF4997F3C7E3FFF7FBFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFE0EFFE5CA5F80E6BE70552C2FF00FFFF00FFFF00FFFF00FF
          FF00FF2D82EB91C5FBCCE6FFD9EDFFDCEDFEC4E0FE86BFFC348BF40A65E10A65
          E1FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF247BEB4696F34A
          98F42F87F0116CE6075FDCFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnRefreshClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 632
      Top = 2
      Align = alRight
      ExplicitLeft = 632
      ExplicitTop = 2
    end
  end
  object pnlMensagem: TPanel [3]
    Left = 0
    Top = 275
    Width = 711
    Height = 41
    Align = alBottom
    Caption = 
      'Caso tenha algum registro para destravar entre em contato com o ' +
      'administrador'
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = 20
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    ExplicitTop = 260
  end
  object cxDados: TcxGrid [4]
    Left = 0
    Top = 0
    Width = 711
    Height = 260
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxDadosDBTableView1: TcxGridDBTableView
      OnKeyDown = cxDadosDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      OnCellDblClick = cxDadosDBTableView1CellDblClick
      OnCustomDrawCell = cxDadosDBTableView1CustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<N'#227'o h'#225' documentos travados>'
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object colDtaLck: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'LCK_DTALCK'
      end
      object colHraLck: TcxGridDBColumn
        Caption = 'Hora'
        DataBinding.FieldName = 'LCK_HRALCK'
      end
      object colCodOpe: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'LCK_CODOPE'
        Width = 58
      end
      object colCon_Id: TcxGridDBColumn
        Caption = 'Id Conex'#227'o'
        DataBinding.FieldName = 'LCK_CON_ID'
        SortIndex = 0
        SortOrder = soAscending
      end
      object colNum_Ip: TcxGridDBColumn
        Caption = 'Numero IP'
        DataBinding.FieldName = 'LCK_NUM_IP'
        Width = 97
      end
      object colChaAce: TcxGridDBColumn
        Caption = 'Chave Acesso'
        DataBinding.FieldName = 'LCK_CHAACE'
        Width = 305
      end
      object colSelecionado: TcxGridDBColumn
        DataBinding.FieldName = 'SELECIONADO'
        Visible = False
        IsCaptionAssigned = True
      end
    end
    object cxDadosLevel1: TcxGridLevel
      GridView = cxDadosDBTableView1
    end
  end
  inherited pnlStatus: TPanel
    Top = 342
    Width = 711
    TabOrder = 2
    ExplicitTop = 327
    ExplicitWidth = 711
    inherited pnlNomeForm: TPanel
      Left = 540
      ExplicitLeft = 540
    end
    inherited pnlInfo: TPanel
      Width = 540
      ExplicitWidth = 540
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 464
    Top = 448
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 432
    Top = 448
  end
end
