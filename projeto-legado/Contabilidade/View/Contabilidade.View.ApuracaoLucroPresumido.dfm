inherited frmApuracaoLucroPresumido: TfrmApuracaoLucroPresumido
  Width = 1043
  Height = 454
  Caption = 'Apura'#231#227'o Lucro Presumido'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 1043
  ExplicitHeight = 454
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 381
    Width = 1037
    ExplicitTop = 381
    ExplicitWidth = 1037
    inherited FlwBotoes: TFlowPanel
      Width = 1033
      ExplicitWidth = 1033
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
    end
    inherited btnSair: TBitBtnLocked
      Left = 957
      ExplicitLeft = 957
    end
  end
  inherited pnlStatus: TPanel
    Top = 409
    Width = 1037
    ExplicitTop = 409
    ExplicitWidth = 1037
    inherited pnlNomeForm: TPanel
      Left = 866
      ExplicitLeft = 866
    end
    inherited pnlInfo: TPanel
      Width = 866
      ExplicitWidth = 866
    end
  end
  object pnlAbrirExercicio: TPanel [2]
    Left = 0
    Top = 0
    Width = 1037
    Height = 57
    Align = alTop
    TabOrder = 2
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
      Caption = 'Carregar Apura'#231#227'o'
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
  object pgcApuracao: TPageControl [3]
    Left = 0
    Top = 57
    Width = 1037
    Height = 324
    ActivePage = tsBaseCalculo
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    object tsBaseCalculo: TTabSheet
      Caption = 'tsBaseCalculo'
      object GridBaseCalculo: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1029
        Height = 292
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object GridBaseCalculoView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditing = GridBaseCalculoViewEditing
          DataController.DataSource = dsBaseCalculo
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsCustomize.DataRowSizing = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.CellAutoHeight = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object GridBaseCalculoViewAUTOINCREM: TcxGridDBColumn
            DataBinding.FieldName = 'AUTOINCREM'
            Visible = False
            VisibleForCustomization = False
          end
          object GridBaseCalculoViewCODIGO: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODIGO'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Width = 75
          end
          object GridBaseCalculoViewDESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESCRI'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Width = 487
          end
          object GridBaseCalculoViewPERIOD_01: TcxGridDBColumn
            Caption = '1'#186' Trimestre'
            DataBinding.FieldName = 'PERIOD_01'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 121
          end
          object GridBaseCalculoViewPERIOD_02: TcxGridDBColumn
            Caption = '2'#186' Trimestre'
            DataBinding.FieldName = 'PERIOD_02'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 121
          end
          object GridBaseCalculoViewPERIOD_03: TcxGridDBColumn
            Caption = '3'#186' Trimestre'
            DataBinding.FieldName = 'PERIOD_03'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 121
          end
          object GridBaseCalculoViewPERIOD_04: TcxGridDBColumn
            Caption = '4'#186' Trimestre'
            DataBinding.FieldName = 'PERIOD_04'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 121
          end
          object GridBaseCalculoViewPERIOD_TOT: TcxGridDBColumn
            Caption = 'Totais'
            DataBinding.FieldName = 'PERIOD_TOT'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Properties.ReadOnly = True
            Width = 121
          end
          object GridBaseCalculoViewBLOQUE: TcxGridDBColumn
            DataBinding.FieldName = 'BLOQUE'
            Visible = False
            VisibleForCustomization = False
          end
        end
        object GridBaseCalculoLevel: TcxGridLevel
          GridView = GridBaseCalculoView
        end
      end
    end
    object tsApuracao: TTabSheet
      Caption = 'tsApuracao'
      ImageIndex = 1
      object GridApuracao: TcxGridCitel
        Left = 0
        Top = 0
        Width = 1029
        Height = 292
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object GridApuracaoView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditing = GridApuracaoViewEditing
          DataController.DataSource = dsApuracao
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsCustomize.DataRowSizing = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.CellAutoHeight = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object GridApuracaoViewAUTOINCREM: TcxGridDBColumn
            DataBinding.FieldName = 'AUTOINCREM'
            Visible = False
            VisibleForCustomization = False
          end
          object GridApuracaoViewCODIGO: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODIGO'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Width = 75
          end
          object GridApuracaoViewDESCRI: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESCRI'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Width = 487
          end
          object GridApuracaoViewPERIOD_01: TcxGridDBColumn
            Caption = '1'#186' Trimestre'
            DataBinding.FieldName = 'PERIOD_01'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 121
          end
          object GridApuracaoViewPERIOD_02: TcxGridDBColumn
            Caption = '2'#186' Trimestre'
            DataBinding.FieldName = 'PERIOD_02'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 121
          end
          object GridApuracaoViewPERIOD_03: TcxGridDBColumn
            Caption = '3'#186' Trimestre'
            DataBinding.FieldName = 'PERIOD_03'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 121
          end
          object GridApuracaoViewPERIOD_04: TcxGridDBColumn
            Caption = '4'#186' Trimestre'
            DataBinding.FieldName = 'PERIOD_04'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Width = 121
          end
          object GridApuracaoViewPERIOD_TOT: TcxGridDBColumn
            Caption = 'Totais'
            DataBinding.FieldName = 'PERIOD_TOT'
            PropertiesClassName = 'TcxCalcEditProperties'
            Properties.DisplayFormat = '#,##0.00'
            Properties.ReadOnly = True
            Width = 121
          end
          object GridApuracaoViewBLOQUE: TcxGridDBColumn
            DataBinding.FieldName = 'BLOQUE'
            Visible = False
            VisibleForCustomization = False
          end
        end
        object GridApuracaoLevel: TcxGridLevel
          GridView = GridApuracaoView
        end
      end
    end
  end
  object dsBaseCalculo: TDataSource
    Left = 716
    Top = 85
  end
  object dsApuracao: TDataSource
    Left = 716
    Top = 133
  end
end
