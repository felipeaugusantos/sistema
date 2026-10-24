inherited frmRelacaoNetpoints: TfrmRelacaoNetpoints
  Width = 965
  Height = 600
  Caption = 'Rela'#231#227'o dos Netpoints Cadastrados'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 965
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 528
    Width = 959
    TabOrder = 2
    ExplicitTop = 528
    ExplicitWidth = 959
    inherited btnSair: TBitBtnLocked
      Left = 876
      TabOrder = 1
      ExplicitLeft = 876
    end
    object btnReenviar: TBitBtnLocked
      Left = 6
      Top = 3
      Width = 147
      Height = 22
      Caption = '[F6] Reenviar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000000000001000000050000000D0000000F00000005000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000020000000A170F093B72472CC3A1643DFF00000010000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        00060604031955382594AB754CF9D5A670FFA56942FF00000022000000110000
        000D000000080000000300000000000000000000000000000000000000053525
        195F9A6A48E5CB9C6DFFE8C089FFE8C189FFA86F48FF88512EFC724125E4532E
        17B92F1A0D7B090502270000000700000001000000000000000000000008BD8D
        64FFECD4B3FFF1D8ACFFEBCA95FFEAC68FFFE7CBA4FFF2DBB9FFE1C39EFFC59D
        74FFA16F47FF512C16BE1B0E065200000008000000010000000000000004392C
        1F59A8815EE2DBBB97FFF3DFBDFFF0D4A6FFC69C74FFBB8B62FFC49870FFD3AE
        89FFE0C29BFFB78A60FF5C351CCB120A043E0000000400000000000000010000
        000407050415614B378CC39D76F9E7CEADFFC1936AFF060503242B21174E644A
        359AB48F6BECD7B891FFAB7E56FF3C2110970000000A00000000000000020000
        00080000000B0000000F1A140F328A6C4FBBC79A70FF0000000C000000040000
        000C56412F86D2AD87FFD8BD9DFF60351CD50000000F00000000000000062379
        49F9237B4AFF247A4AFF030A06220000000900000009000000060000000A0000
        000B100C0927C5996FFFC4986EFFAE7C57F90000000D0000000000000005246E
        49CE5BC49EFF308E62FF0D311C7E00000008000000030000000A247B4AFF0A37
        1ABF020B053900000015000000110000000D000000030000000000000003194B
        32885BB691FF6DC3A6FF2F7A54EA103B229107190F470104021C267F4DFF34A5
        78FF17633BF9092B169101030218000000060000000100000000000000010919
        112F2C7451C07AC8AAFF8BD7BFFF56A886FF33875DFF207345FF3A976AFF6ADA
        BBFF4BC89FFF30966AFF145530E5061D0F5F0000000600000000000000000000
        00020E251A41266C4BB263BB96FF8AD3BAFFA8E7D6FFBAF3E7FFA4E4D2FF89EA
        D5FF77E1C6FF75DDBDFF80D7BCFF278551FF0000000A00000000000000000000
        000000000002050D091A17412D6A276D4CAD338E64DF3AA06FFB3AA271FF9EF0
        E0FFB4F1E5FF6EC5A3FF348B60E1102E1F5A0000000500000000000000000000
        000000000000000000010000000200000004000000050000000C3EA977FF9AE0
        C9FF4CAC82F81E52398902060415000000040000000100000000000000000000
        000000000000000000000000000000000000000000000000000541AF7DFF2D79
        56B70816102B0000000500000001000000000000000000000000}
      TabOrder = 0
      OnClick = btnReenviarClick
    end
  end
  object pnlFiltros: TPanel [2]
    Left = 0
    Top = 484
    Width = 959
    Height = 44
    Align = alBottom
    Color = 16770261
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 6
      Top = 3
      Width = 35
      Height = 14
      Caption = 'Status'
    end
    object Label2: TLabel
      Left = 290
      Top = 3
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
    end
    object Label3: TLabel
      Left = 372
      Top = 3
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
    end
    object cmbStatus: TComboBox
      Left = 6
      Top = 17
      Width = 267
      Height = 22
      Style = csDropDownList
      TabOrder = 0
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 290
      Top = 17
      Width = 66
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 372
      Top = 17
      Width = 68
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object btnRefresh: TBitBtnLocked
      Left = 456
      Top = 6
      Width = 225
      Height = 34
      Caption = '[F5] Atualizar Filtros'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000030000000B00000013000000190000001A0000
        00140000000B0000000300000000000000000000000000000000000000000000
        000000000000000000060402011C4827118B7C431ED2A65927FFA55927FF7E44
        1ED442230F7B0100000F0000000E000000070000000000000000000000000000
        000000000005120A05348A4F26DDC58A53FFDCB37CFFEFD298FFEFD198FFB676
        43FF2E1A0C62100904398F5127E10E05013A0000000600000000000000000000
        0002040201198D552BDCD1A169FFF1D6A5FFCE9E6EFFC08656FFBD8251FF613A
        1DA6000000227D4B26CBE2B97BFF5F290FCF0101001900000003000000000000
        00074C2F1B82C99765FFECD2A3FFB98154FB5238238A120C07300F0A06270201
        01194C2F1B88CE9D66FFF6DC9BFFBA8657FF3F1C0C910000000D000000000000
        000A8C5B36D0E3C598FFCB9D75FF573B258C0000000C00000003000000062014
        0C43BD875AFBF8E5BCFFF8DFA5FFF7E4BAFFA16540FC1C0E074C000000080000
        0014B37A4BFAF5E6BDFFBC8356FF0D0704300000000C00000003000000079666
        3FD5B87D4DFFBB8153FFF2D9A1FFB87D4DFFB87C4DFF9C6941DE845331D3A263
        3BFFBB8557FFF6E7BFFFBF8B5EFFA06238FF87522FDC00000006000000020000
        000B0D08042FA1653CFFF4DEAEFFB68155FA000000180000000A1F170F34C79D
        75FBFBF5DCFFFCF3CCFFFAF4DAFFB3855FFB21150C4100000004000000020000
        0009492C1886BA8B5EFFE7CEA7FF926B48CB0000000900000000000000045540
        2D77DDC1A2FFFDF7D9FFD4B598FF5037227F0202010C0D08041F110A05274B2D
        1986A1683EFAF3E4C3FFD8B692FF533F2C780000000400000000000000000000
        00058F6F50BCEFE1CDFF886343C20202010D58382091A3693CFFA66F43FFBE94
        6DFFF4E9D1FFE3CAADFFA47E5BD60504030E0000000100000000000000000000
        0001130F0B1DAB8863DA18130E242C1E1248B78B63FDF8F3E2FFF9F3E4FFEDDE
        C7FFDCC1A1FFA3815ED215110C22000000020000000000000000000000000000
        000000000001000000010101000342301E629A7B5CC2C6A078F9C6A078F9997B
        5DC3564634710504030A00000001000000000000000000000000000000000000
        0000000000000000000000000000000000010000000200000002000000020000
        0002000000010000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 3
      OnClick = btnRefreshClick
    end
  end
  object cxDados: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 959
    Height = 484
    Align = alClient
    TabOrder = 0
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxDadosDBTableView: TcxGridDBTableView
      OnKeyDown = cxDadosDBTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<N'#227'o h'#225' documentos para exibir>'
      OptionsView.CellAutoHeight = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      object cxDadosDBTableViewCODEMP: TcxGridDBColumn
        Caption = 'C'#243'd.Emp.'
        DataBinding.FieldName = 'CODEMP'
        Width = 55
      end
      object cxDadosDBTableViewDTAENT: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'DTAENT'
        Width = 68
      end
      object cxDadosDBTableViewCODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CODCLI'
        Width = 70
      end
      object cxDadosDBTableViewNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Width = 120
      end
      object cxDadosDBTableViewCODOPE: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'CODOPE'
        Width = 58
      end
      object cxDadosDBTableViewCPFCLI: TcxGridDBColumn
        Caption = 'Cpf'
        DataBinding.FieldName = 'CPFCLI'
        Width = 60
      end
      object cxDadosDBTableViewFONCLI: TcxGridDBColumn
        Caption = 'Fone'
        DataBinding.FieldName = 'FONCLI'
      end
      object cxDadosDBTableViewNPSCAL: TcxGridDBColumn
        Caption = 'Pontos'
        DataBinding.FieldName = 'NPSCAL'
      end
      object cxDadosDBTableViewSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
        Width = 126
      end
      object cxDadosDBTableViewOBSERV: TcxGridDBColumn
        Caption = 'Observa'#231#245'es'
        DataBinding.FieldName = 'OBSERV'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.VisibleLineCount = 2
        Width = 218
      end
    end
    object cxDadosLevel1: TcxGridLevel
      GridView = cxDadosDBTableView
    end
  end
  inherited pnlStatus: TPanel
    Top = 556
    Width = 959
    TabOrder = 3
    ExplicitTop = 556
    ExplicitWidth = 959
    inherited pnlNomeForm: TPanel
      Left = 788
      ExplicitLeft = 788
    end
    inherited pnlInfo: TPanel
      Width = 788
      ExplicitWidth = 788
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 152
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 152
  end
  object UniQuery1: TUniQuery
    Constraints = <>
    Left = 448
    Top = 288
  end
end
