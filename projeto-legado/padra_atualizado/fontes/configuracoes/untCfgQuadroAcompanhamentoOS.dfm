inherited frmCfgQuadroAcompanhamentoOS: TfrmCfgQuadroAcompanhamentoOS
  Width = 578
  Height = 298
  Caption = 'Configura'#231#227'o do Painel de Acompanhamento Geral de OS'
  ExplicitWidth = 578
  ExplicitHeight = 298
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 227
    Width = 572
    ExplicitTop = 227
    ExplicitWidth = 572
    inherited FlwBotoes: TFlowPanel
      Width = 568
      ExplicitWidth = 568
      object btnAddQuadro: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 118
        Height = 22
        Caption = '&[F2] Adicionar Quadro'
        NumGlyphs = 2
        TabOrder = 1
        Visible = False
        OnClick = btnAddQuadroClick
      end
      object btnDelQuadro: TBitBtnLocked
        Left = 193
        Top = 0
        Width = 118
        Height = 22
        Caption = '&[DEL] Excluir Quadro'
        NumGlyphs = 2
        TabOrder = 2
        Visible = False
        OnClick = btnDelQuadroClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 489
      ExplicitLeft = 489
    end
  end
  inherited pnlStatus: TPanel
    Top = 253
    Width = 572
    ExplicitTop = 253
    ExplicitWidth = 572
    inherited pnlNomeForm: TPanel
      Left = 401
      ExplicitLeft = 401
    end
    inherited pnlInfo: TPanel
      Width = 401
      ExplicitWidth = 401
    end
  end
  object cxGrid: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 572
    Height = 227
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridDBTBV: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsGrid
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Filtering.MRUItemsList = False
      Filtering.ColumnMRUItemsList = False
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsBehavior.ImmediateEditor = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ShowEditButtons = gsebAlways
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridDBTBVQUADRO: TcxGridDBColumn
        Caption = 'Quadro'
        DataBinding.FieldName = 'QUADRO'
        Options.Sorting = False
        Width = 69
      end
      object cxGridDBTBVSTATUS: TcxGridDBColumn
        Caption = 'Fase/Situa'#231#227'o/Complemento'
        DataBinding.FieldName = 'DESCRI'
        Options.Sorting = False
        Width = 228
      end
      object cxGridDBTBVBTNADD: TcxGridDBColumn
        Caption = 'Selecionar'
        DataBinding.FieldName = 'BTNADD'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Glyph.SourceDPI = 96
            Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              6100000024744558745469746C6500496E736572743B506167653B4164643B49
              74656D3B4C6973743B506C7573581275E40000022849444154785EA5934D4815
              5118869FF18E974CA3859BDA05453F4416210479B14522288109120556AE0CB5
              685308D5AE459A2D14CA366A2004B5100B12DC8445E946FB11825AB8887EA002
              BB667A9D7B67CEF715E70C8DB871D10B73BEC3C0FBF09CE18CAFAAFC4F7CEF6F
              001F48011E6B93BC5340805055E51F0028EE1D7AF6D4F78B3300AA8A937253B1
              8BDD170AC164675BED5120BF1A90F28AFC4CC7E9C3AC974F5FB3559D6DA4FF4A
              87B191FA80678C01A010BA190B80A7A01EA0F8298F27339D5C1B3AB41885F2BC
              EBDC74CDE5FECAC80122754581FB63B3A0897E7DF54EA2C81086219F7FCC72F1
              CC756E0D5C390294F4B4CF040E20912D08CAA9FA0A5CD5B36BCA5306C73AF8F8
              FD2D6284370B7DE4F386F69BFB17F32B663236104011512E8CA4510361042684
              4B35E3CC7D794D6B4B2BEF7F3D6429CC51DDB4095565FC5EB6CA07888C380385
              DEC63C360A6ABF70C4D6CD15F4F5F76322257332CDC470808810E4CC0B671003
              8C5186475F593A60A18DB57B385E7D83856C963BA34DE40A4BE40B1E0FBA3F6C
              03E6E3231844D53ECD0D0771F50452BAB1842DE5A59497EE6662F01D412E9C02
              7E369CDFB1E4002256DF080C8F4C5B90C60CE2FD89BABD9C3DD6C3817DDB7701
              DF80DCE3DB732447104554686EAC04624022425949317D031300F3AABAB8FA26
              AA11C1A852B6C1F25C47138C2ACE4A942409205C59FEFDF26AD7A30CEA6E5E52
              B4D34155085696A780C25A4070B7BBA50E480345EBFC8D79204712FE002E7C42
              4C1A85BD580000000049454E44AE426082}
            Hint = 'Selecionar'
            Kind = bkGlyph
            Stretchable = False
          end>
        Properties.ViewStyle = vsButtonsOnly
        Properties.OnButtonClick = cxGridDBTBVBTNADDPropertiesButtonClick
        HeaderAlignmentHorz = taCenter
        Options.Sorting = False
        Width = 64
      end
      object cxGridDBTBVBTNLIM: TcxGridDBColumn
        Caption = 'Limpar'
        DataBinding.FieldName = 'BTNLIM'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Glyph.SourceDPI = 96
            Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000005A744558745469746C650044656C6574653B44656C6574654974656D
              3B52656D6F76653B52656D6F76654974656D3B44656C6574654C6973743B4C69
              73743B52656D6F76654C6973743B4974656D3B4C6973743B436C6561723B4572
              61736558E2170B0000025A49444154785E75514D68135110FEDE26246DB45A25
              956890A6554B4CD14320280A9A6A405B7F5A512A4A5BF1E045AC41AB3978E925
              15A445945E04ED45F1A7880729A4C550C1A306AA3DB40715C5D2B4B056441375
              93ECBEE7CE23592236B3CC0E3BF3ED3733DF3021041863CADDD1B7934C616190
              0980F20220B75E020CBCA0BF3ADF1DDA6FD60DCADA210DECE7AF42F8F2D910CA
              F0CBDAD0C89BBD84A74439010C43400840CBE9B22E2C16062A0806B8AAEC268E
              633902661806C89E25DFCB6139ADC1CD683A3DD98C86DEEE100C5E81205F30E4
              DEC7224DB231B7F6A6202791B97C4EAF4090D7256074625676169244AA29F399
              AC86E8991D205C050DB89CE078C40FABB760148B9A48D29206F86F024E04009E
              2466A8A32562F366371ABCABF0FD8706FFA63A9C68F563F01AEC747A005CF9E7
              0A1CE86C0DE024795B003DEDDBB0DDF60D467F0C6B934F51D07EC335F608EF0E
              B47D4886F7450028D6043AE7A0191E8ECD94DAE370B8117F6E0FC377AE03D9D9
              8FF87CA117753B035879A9CB938DDF1B01D06069205710C0A943CDE045826AA7
              822FF5F5584ABE803BE887AFB3054A46C562621C69F5EB64B906746FF9A3D369
              A384A581371AC5D4E91E93CCACAD7621935E422A3195BEB930D757AE012FE4B4
              97B1F804AE163D161F476A7A0ED3FDD7E1DB1580DD6143E6D33C1C5536048FEE
              F15E746F1C0260A3F394EEEA00E002B0A2CCD73C6F0AAAEA4054A43A5AC41D4F
              E3C2EB83BBC5FC952E71ABD6BB08C04904159D3A0CAFDF72E4B177AB3A58BBE1
              BEDFEE5C3750E37970A3C6A3F655BBDB490246C04AC64C03A014B522A041A4C5
              9C4EDF7F01B0BA3D657982DCCC0000000049454E44AE426082}
            Hint = 'Limpar'
            Kind = bkGlyph
          end>
        Properties.ReadOnly = True
        Properties.UseLeftAlignmentOnEditing = False
        Properties.ViewStyle = vsButtonsOnly
        Properties.OnButtonClick = cxGridDBTBVBTNLIMPropertiesButtonClick
        HeaderAlignmentHorz = taCenter
        Options.AutoWidthSizable = False
        Options.Sorting = False
        Width = 61
      end
      object cxGridDBTBVQTDIAS: TcxGridDBColumn
        Caption = 'Tempo (em dias) para exibir'
        DataBinding.FieldName = 'QTDIAS'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.MaxValue = 9999.000000000000000000
        Properties.MinValue = 1.000000000000000000
        Width = 142
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTBV
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 272
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 168
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 72
  end
  object dtsGrid: TDataSource
    Left = 376
    Top = 40
  end
end
