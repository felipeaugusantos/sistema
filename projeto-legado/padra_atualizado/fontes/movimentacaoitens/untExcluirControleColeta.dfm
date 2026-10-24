inherited frmExcluirControleColeta: TfrmExcluirControleColeta
  Width = 1024
  Height = 561
  Caption = 'Excluir Controle de Coleta'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 561
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 488
    Width = 1018
    ExplicitTop = 488
    ExplicitWidth = 887
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 883
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 90
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 938
      ExplicitLeft = 807
    end
    object btnDesmarcaTodos: TBitBtnLocked
      Left = 208
      Top = 3
      Width = 141
      Height = 22
      Caption = '&Desmarca Todos'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        300033FFFFFF3333377739999993333333333777777F3333333F399999933333
        3300377777733333337733333333333333003333333333333377333333333333
        3333333333333333333F333333333333330033333F33333333773333C3333333
        330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
        333333377F33333333FF3333C333333330003333733333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnDesmarcaTodosClick
    end
    object btnMarcaTodos: TBitBtnLocked
      Left = 92
      Top = 3
      Width = 116
      Height = 22
      Caption = '&Marca Todos'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnMarcaTodosClick
    end
    object btnTrocarLocOrigem: TBitBtnLocked
      Left = 349
      Top = 3
      Width = 156
      Height = 22
      Caption = '[ F11 ] Trocar Loc.Origem.'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000003827174DB8824DFF00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000003827174DB8824DFFB8824DFF00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000003827174DB8824DFFB8824DFFB8824DFFB5804CFB9F7042DC7955
        32A747321E630E0A061400000000000000000000000000000000000000000000
        00003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
        4DFFB8824DFF7C5834AC2B1E123B000000000000000000000000000000000000
        0000000000003827174DB8824DFFB8824DFFB8824DFFB8824DFFB8824DFFB882
        4DFFB8824DFFB8824DFF855E38B91E150C290000000000000000000000000000
        0000484F3879212419373827174DB8824DFFB8824DFF060402082A1E123A6144
        2886A27344E1B8824DFFB8824DFF5D4227810000000000000000000000000000
        000077845DC98E9D6FF0212419373827174DB8824DFF00000000000000000000
        00004C36206AB8824DFFB8824DFF91663DC90000000000000000000000000000
        000093A273F897A776FF8E9D6FF0020302040000000000000000000000000000
        000003020104AD7A48F0B8824DFFB37E4BF80000000000000000000000000000
        000077845DC997A776FF97A776FF3F45316A00000000000000000000000097A7
        76FF2E32244D281C1137AD7A48F091663DC90000000000000000000000000000
        00004C543C8197A776FF97A776FF859368E14F583E8622261B3A0505040897A7
        76FF97A776FF2E32244D281C1137573E25790000000000000000000000000000
        0000181B13296E7956B997A776FF97A776FF97A776FF97A776FF97A776FF97A7
        76FF97A776FF97A776FF2E32244D000000000000000000000000000000000000
        00000000000023271B3B667150AC97A776FF97A776FF97A776FF97A776FF97A7
        76FF97A776FF97A776FF97A776FF2E32244D0000000000000000000000000000
        000000000000000000000C0D09143B412E63636D4DA7829066DC95A474FB97A7
        76FF97A776FF97A776FF2E32244D000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000000000000097A7
        76FF97A776FF2E32244D00000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000000000000097A7
        76FF2E32244D0000000000000000000000000000000000000000}
      TabOrder = 4
      OnClick = btnTrocarLocOrigemClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 516
    Width = 1475
    ExplicitTop = 516
    ExplicitWidth = 1475
    inherited pnlNomeForm: TPanel
      Left = 1304
      ExplicitLeft = 1304
    end
    inherited pnlInfo: TPanel
      Width = 1304
      ExplicitWidth = 1304
    end
  end
  object cxgDados: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1475
    Height = 488
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxvDadosColumn1: TcxGridDBColumn
        Caption = 'Excluir'
        DataBinding.FieldName = 'EXCLUIR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        MinWidth = 45
        Options.HorzSizing = False
        Width = 45
      end
      object cxvDadosColumn2: TcxGridDBColumn
        Caption = 'Data/Hora    '
        DataBinding.FieldName = 'MLT_DTACAD'
        Options.Editing = False
      end
      object cxvDadosColumn3: TcxGridDBColumn
        Caption = 'Operador Cria'#231#227'o'
        DataBinding.FieldName = 'OPEMOV'
        Options.Editing = False
      end
      object cxvDadosColumn4: TcxGridDBColumn
        Caption = 'Operador de Destino'
        DataBinding.FieldName = 'OPEDES'
        Options.Editing = False
      end
      object cxvDadosColumn5: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'MLT_CODITE'
        Options.Editing = False
      end
      object cxvDadosColumn6: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'ITE_DESITE'
        Options.Editing = False
      end
      object cxvDadosColumn7: TcxGridDBColumn
        AlternateCaption = 'Unidade'
        Caption = 'unidade'
        DataBinding.FieldName = 'UNI_DESUNI'
        Options.Editing = False
      end
      object cxvDadosColumn8: TcxGridDBColumn
        Caption = 'Referencia'
        DataBinding.FieldName = 'ITE_REFERE'
        Options.Editing = False
      end
      object cxvDadosColumn9: TcxGridDBColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'MAR_DESMAR'
        Options.Editing = False
      end
      object cxvDadosColumn10: TcxGridDBColumn
        Caption = 'Lote Origem'
        DataBinding.FieldName = 'LOT_ORIGEM'
        Options.Editing = False
      end
      object cxvDadosColumn11: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o F'#237'sica Origem'
        DataBinding.FieldName = 'LOCFIS_ORIGEM'
        Options.Editing = False
      end
      object cxvDadosColumn12: TcxGridDBColumn
        Caption = 'Origem '#233' Picking?'
        DataBinding.FieldName = 'ORIGEM_PICKING'
        OnGetDisplayText = cxvDadosColumn12GetDisplayText
        Options.Editing = False
      end
      object cxvDadosColumn13: TcxGridDBColumn
        Caption = 'Lote Destino'
        DataBinding.FieldName = 'LOT_DESTINO'
        Options.Editing = False
      end
      object cxvDadosColumn14: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o F'#237'sica Destino'
        DataBinding.FieldName = 'LOCFIS_DESTINO'
        Options.Editing = False
      end
      object cxvDadosColumn15: TcxGridDBColumn
        Caption = 'Destino '#233' Picking?'
        DataBinding.FieldName = 'DESTINO_PICKING'
        OnGetDisplayText = cxvDadosColumn15GetDisplayText
        Options.Editing = False
      end
      object cxvDadosColumn16: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'MLT_QTDMOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
        Width = 65
      end
      object cxvDadosColumn17: TcxGridDBColumn
        Caption = 'Quantidade Atend.'
        DataBinding.FieldName = 'MLT_QTDCNF'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        Options.Editing = False
        Width = 95
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxvDados
    end
  end
  object dtsDados: TDataSource
    Left = 432
    Top = 264
  end
end
