inherited frmConfigLucroPresumido: TfrmConfigLucroPresumido
  Width = 1091
  Height = 563
  Caption = 'Par'#226'metros Lucro Presumido'
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitWidth = 1091
  ExplicitHeight = 563
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 490
    Width = 1085
    TabOrder = 1
    ExplicitTop = 490
    ExplicitWidth = 1085
    inherited FlwBotoes: TFlowPanel
      Width = 1081
      ExplicitWidth = 1081
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 124
        Height = 20
        Caption = '&Gravar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnGravarClick
      end
      object btnCancela: TBitBtnLocked
        Left = 124
        Top = 0
        Width = 124
        Height = 20
        Caption = '&Cancelar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
          015603015603FF00FF0000820000820000820000820000820000820000820000
          820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
          27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
          30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
          FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
          0082000082000082000082000082000082000082000082000082FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
          00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
          0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
          50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
          5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
          8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnCancelaClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 248
        Top = 0
        Width = 124
        Height = 20
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
        TabOrder = 2
        OnClick = btnExcluirClick
      end
      object BtnCopiar: TBitBtnLocked
        Left = 372
        Top = 0
        Width = 124
        Height = 20
        Caption = 'Copiar Par'#226'metros'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          00070000000A0000000C0000000C0000000C0000000D0000000D0000000D0000
          000E0000000E0000000E0000000D000000090000000200000000000000068F6B
          4EBEC6956CFFC6946AFFC59369FFC49268FFC49167FFC39066FFC28F65FFC28E
          64FFC18D63FFC08D62FFC08C62FF8A6545C100000009000000000000000BD4AF
          91FFFDFDFDFFFAF3ECFFFAF3EBFFF9F3EBFFF9F2EBFFF9F3EBFFFAF2EAFFFAF2
          E9FFF9F1E9FFFAF1EAFFF9F1E9FFC08D62FF0000000D000000000000000DB670
          3DFFEFE8E3FFF8F2EBFFFAF4ECFFFAF3ECFFFAF3EBFFFAF3EBFFF9F2EBFFF9F2
          EAFFF9F2EAFFF9F2E9FFF9F2E9FFC18D63FF0000000E000000000000000EB873
          40FFBC7A49FFEBDED3FFF8F1EAFFFAF3ECFFFAF3ECFFF9F3EBFF5354C5FF5253
          C3FF5252C3FF5051C2FFF9F2EAFFC28E64FF0000000D000000000000000EBA76
          44FFCD905CFFBD7A48FFEFE3D6FFFAF4ECFFFAF3ECFFFAF4ECFFE3DDE7FFE3DD
          E6FFE2DCE6FFE2DCE5FFF9F3EAFFC29065FF0000000C000000000000000DBB79
          46FFBF7F4EFFEBE0D5FFF8F2ECFFFBF4EDFFFBF4ECFFFAF3EDFF5959CBFF5858
          C9FF5658C8FF5556C6FFFAF2EAFFC39067FF0000000C000000000000000BBD7B
          49FFF0E9E4FFF8F3ECFFFBF5EEFFFAF4EDFFFAF4EDFFFAF4EDFFE4DFE8FFE4DE
          E7FFE3DDE7FFE3DDE6FFFAF3EBFFC49168FF0000000B0000000000000008D9B6
          98FFFDFDFDFFC3926AFFC29167FFC28F66FFC18E65FFFAF5EDFF5F5FD0FF5E5E
          CFFF5C5DCDFF5A5BCCFFFAF3EBFFC59369FF0000000B0000000000000006CEA0
          78FFFFFFFFFFF3E8DDFFF2E7DDFFF3E7DBFFF3E7DBFFFAF5EEFFE5DFE9FFE4DF
          E9FFE4DFE9FFE3DFE9FFFAF4ECFFC5946BFF0000000A0000000000000005D0A0
          7AFFFFFFFFFFC7966FFFC5956EFFC4936CFFC4926AFFFAF5EEFF6565D7FF6363
          D5FF6262D4FF6161D3FFFAF4EDFFC6956CFF0000000A0000000000000005D0A2
          7BFFFFFFFFFFF4E9DFFFF4E9DEFFF3E8DDFFF3E7DEFFFAF5EFFFE5E1ECFFE6E1
          EBFFE5E0EAFFE5E0EAFFFAF4EDFFC7966DFF000000090000000000000004D1A3
          7DFFFFFFFFFFC99B75FFC89A73FFC79871FFC79770FFFBF5F0FF6869DBFF6868
          DAFF6667D9FF6666D8FFFAF4EDFFC9976FFF000000080000000000000004D1A4
          7EFFFFFFFFFFFBF7F1FFFBF7F1FFFBF7F1FFFBF6F1FFFBF6F0FFFBF5EFFFFBF5
          EFFFFBF5EFFFFBF5EEFFFBF5EEFFC99871FF000000080000000000000003D2A5
          7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFCA9A72FF0000000700000000000000029D7A
          5EBFD3A580FFD2A47EFFD2A47EFFD1A27DFFD0A27BFFD0A17AFFCFA079FFCE9F
          78FFCD9E77FFCC9D76FFCC9C75FF977356C10000000400000000}
        TabOrder = 3
        OnClick = BtnCopiarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1005
      ExplicitLeft = 1005
    end
  end
  inherited pnlStatus: TPanel
    Top = 518
    Width = 1085
    TabOrder = 2
    ExplicitTop = 518
    ExplicitWidth = 1085
    inherited pnlNomeForm: TPanel
      Left = 914
      ExplicitLeft = 914
    end
    inherited pnlInfo: TPanel
      Width = 914
      ExplicitWidth = 914
    end
  end
  object pgcParametros: TPageControl [2]
    Left = 0
    Top = 57
    Width = 1085
    Height = 433
    ActivePage = tbsLancamentosContabeis
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    object tbsCsll: TTabSheet
      Caption = 'CSLL'
      object GridDetalheCsll: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1077
        Height = 401
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object GridTabDetalheCsll: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsDetalheCsll
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.ColumnFilteredItemsList = True
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.ShowEditButtons = gsebAlways
          OptionsView.Indicator = True
          Styles.OnGetContentStyle = GridTabDetalheCsllStylesGetContentStyle
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object GridTabDetalheCsllDESCOD: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'DESCOD'
            Options.Editing = False
          end
          object GridTabDetalheCsllGRUPO_: TcxGridDBColumn
            Caption = 'Grupo'
            DataBinding.FieldName = 'GRUPO_'
            Visible = False
            GroupIndex = 0
            SortIndex = 0
            SortOrder = soDescending
          end
          object GridTabDetalheCsllDESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESCRI'
            Options.Editing = False
            Width = 849
          end
          object GridTabDetalheCsllPLANCO: TcxGridDBColumn
            Caption = 'Plano Cont'#225'bil'
            DataBinding.FieldName = 'PLANCO'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Caption = 'Incluir'
                Default = True
                Kind = bkText
              end>
            Properties.ViewStyle = vsButtonsAutoWidth
            Properties.OnButtonClick = GridTabDetalheCsllPLANCOPropertiesButtonClick
            Width = 97
          end
        end
        object GridDetalheCsllLevel1: TcxGridLevel
          GridView = GridTabDetalheCsll
        end
      end
    end
    object tbsIrpj: TTabSheet
      Caption = 'IRPJ'
      ImageIndex = 1
      object GridDetalheIrpj: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1077
        Height = 401
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object GridTabDetalheIrpj: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsDetalheIrpj
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Filtering.ColumnFilteredItemsList = True
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.ShowEditButtons = gsebAlways
          OptionsView.Indicator = True
          Styles.OnGetContentStyle = GridTabDetalheCsllStylesGetContentStyle
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object GridTabDetalheIrpjDESCOD: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'DESCOD'
            Options.Editing = False
          end
          object GridTabDetalheIrpjGRUPO_: TcxGridDBColumn
            Caption = 'Grupo'
            DataBinding.FieldName = 'GRUPO_'
            Visible = False
            GroupIndex = 0
            SortIndex = 0
            SortOrder = soDescending
          end
          object GridTabDetalheIrpjDESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESCRI'
            Options.Editing = False
            Width = 849
          end
          object GridTabDetalheIrpjPLANCO: TcxGridDBColumn
            Caption = 'Plano Cont'#225'bil'
            DataBinding.FieldName = 'PLANCO'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Caption = 'Incluir'
                Default = True
                Kind = bkText
              end>
            Properties.ViewStyle = vsButtonsAutoWidth
            Properties.OnButtonClick = GridTabDetalheIrpjPLANCOPropertiesButtonClick
            Width = 97
          end
        end
        object GridDetalheIrpjLevel1: TcxGridLevel
          GridView = GridTabDetalheIrpj
        end
      end
    end
    object tbsLancamentosContabeis: TTabSheet
      Caption = 'Lan'#231'amentos Cont'#225'beis - CSLL/IRPJ'
      ImageIndex = 2
      object gbParametrosCsll: TGroupBox
        Left = 3
        Top = 19
        Width = 1071
        Height = 158
        Caption = 'CSLL a Recolher'
        TabOrder = 0
        object Label12: TLabel
          Left = 14
          Top = 22
          Width = 72
          Height = 14
          Caption = 'Conta Cont'#225'bil:'
        end
        object Label13: TLabel
          Left = 14
          Top = 78
          Width = 149
          Height = 14
          Caption = 'Hist'#243'rico Padr'#227'o/Complemento:'
        end
        object dbe_CODCON_csll: TDBEditFocus
          Tag = 99
          Left = 10
          Top = 39
          Width = 109
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CODCON'
          DataSource = dsGeralLanconCsll
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnKeyPress = dbe_CODCON_csllKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object edt_Descri_csll: TEditFocus
          Left = 125
          Top = 39
          Width = 335
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbe_HISPAD_csll: TDBEditFocus
          Tag = 99
          Left = 14
          Top = 95
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'HISPAD'
          DataSource = dsGeralLanconCsll
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 2
          OnKeyPress = dbe_HISPAD_csllKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbe_HISTOR_csll: TDBMemoFocus
          Left = 76
          Top = 95
          Width = 384
          Height = 51
          DataField = 'HISTOR'
          DataSource = dsGeralLanconCsll
          MaxLength = 40
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
      object gbParametrosIrpj: TGroupBox
        Left = 1
        Top = 183
        Width = 1073
        Height = 154
        Caption = 'IRPJ a Recolher'
        TabOrder = 1
        object Label1: TLabel
          Left = 15
          Top = 19
          Width = 72
          Height = 14
          Caption = 'Conta Cont'#225'bil:'
        end
        object Label2: TLabel
          Left = 15
          Top = 75
          Width = 149
          Height = 14
          Caption = 'Hist'#243'rico Padr'#227'o/Complemento:'
        end
        object dbe_CODCON_irpj: TDBEditFocus
          Tag = 99
          Left = 11
          Top = 36
          Width = 109
          Height = 22
          CharCase = ecUpperCase
          DataField = 'CODCON'
          DataSource = dsGeralLanconIrpj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          OnKeyPress = dbe_CODCON_csllKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object edt_Descri_irpj: TEditFocus
          Left = 126
          Top = 36
          Width = 335
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object dbe_HISPAD_irpj: TDBEditFocus
          Tag = 99
          Left = 15
          Top = 92
          Width = 60
          Height = 22
          CharCase = ecUpperCase
          DataField = 'HISPAD'
          DataSource = dsGeralLanconIrpj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 2
          OnKeyPress = dbe_HISPAD_csllKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttNumerico
        end
        object dbe_HISTOR_irpj: TDBMemoFocus
          Left = 77
          Top = 92
          Width = 384
          Height = 51
          DataField = 'HISTOR'
          DataSource = dsGeralLanconIrpj
          MaxLength = 40
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
    end
  end
  object pnlAbrirExercicio: TPanel [3]
    Left = 0
    Top = 0
    Width = 1085
    Height = 57
    Align = alTop
    TabOrder = 0
    object cxLabel1: TcxLabel
      Left = 5
      Top = 8
      Caption = 'Exercicio:'
      Transparent = True
    end
    object edtExercicio: TEditFocus
      Left = 60
      Top = 4
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 4
      TabOrder = 0
      OnKeyPress = edtExercicioKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
    object cxLabel7: TcxLabel
      Left = 4
      Top = 30
      Caption = 'Empresa:'
      Transparent = True
    end
    object edtEmpSel: TEditFocus
      Tag = 99
      Left = 60
      Top = 28
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtEmpSelKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpSel: TEditFocus
      Left = 120
      Top = 28
      Width = 372
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object btnAbrir: TcxButton
      Left = 498
      Top = 26
      Width = 153
      Height = 25
      Caption = 'Carregar Configura'#231#227'o'
      OptionsImage.Glyph.SourceDPI = 96
      OptionsImage.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C0000000B744558745469746C65004F70656E3B49C97792000002
        8849444154785E7D934F68545718C57FEFCD4B63CBB45D64A3ADD0952D45B40B
        D12E3428044A70530ADDE8AA94820B1BD09D10442D0A0117225D28A5C9AA0B6D
        A14BDB458B055B4C2853D4A869689A2131FFCC4C26C9CCBCCCBCB9F7FBBE4E2E
        1310D11E38F7703F2EE770E07E9199F1324451C4A12FE9EE7E9D736A7C117B70
        19C3A529BE9AF8890CB098FF4794BCC669DFE4F6ED21DEAA57F9D4B78DDED8C9
        C50327102017E5F3F91888003A6A1D6ABD5E8F9E33CCEDFB9CF351CCA0291446
        E84EEE5E3DF86B1C730423C014D2A63FDE7766EC26A0070740141018BD1E0206
        D581582771FCDB8F6CF767C30460F8668DC91F06577E199BF9E0EC77FF947806
        22123BE7726DB5360470893805A9829BC3544910DEFBF8648FB8AFE77E7BFF4D
        3030B3A06A11CED99DFE8B85BE5AADE60012F10A262019917A304F4E53F61C3B
        45F4CA7620025340311346AF0CF402B93F2EF53A5548D44930C03731DF40DB44
        1CA40B98FD05CE612A8004A35A3905C8F70FDD8B0189EE0E1DB60F072EA3EB0F
        28FF5D606D611953421D3503354C0D550DBAF2A48C756AA95829712DA1B1FA94
        6CB1C8FAD33ABB3EB94014C521CDCC817A4C5A04FA8C4069B23A5B64ECFB1B33
        896442756186B5C929F23BF762AD2A1BFFFE8CA960AA604131F52012E6AAC2FC
        C359D6AAFE56E29CB03253245DAEB063DF3B644BE3F8FAEAD643100D06A8EFD4
        F261569E5EE6D17CFA63E2324FA538CDB6AE6D74254263F63ED2A875923DE615
        63CB443011D2F52695D5C6E36BA3A5E9A4B1D1C29696E8D9F32ECDC509B2CA7C
        27B553814DB5700705354AF3752AA9BF05B86423F57FE2ABFB277F2F307967EB
        D304C5009400B370A006CEDBDCF8E2C608D0DA5CA657812EE0459BF9FC3219E0
        80E63747DF1680FF001724CEF504A838340000000049454E44AE426082}
      TabOrder = 2
      OnClick = btnAbrirClick
    end
  end
  object dsDetalheCsll: TDataSource
    Left = 964
    Top = 173
  end
  object dsDetalheIrpj: TDataSource
    Left = 964
    Top = 221
  end
  object StyleRepository: TcxStyleRepository
    Left = 528
    Top = 385
    PixelsPerInch = 96
    object EstiloComConta: TcxStyle
      AssignedValues = [svColor]
      Color = clInactiveCaption
    end
  end
  object dsGeralLanconCsll: TDataSource
    Left = 967
    Top = 276
  end
  object dsGeralLanconIrpj: TDataSource
    Left = 967
    Top = 332
  end
end
