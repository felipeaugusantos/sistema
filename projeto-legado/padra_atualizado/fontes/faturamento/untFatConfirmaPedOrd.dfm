inherited frmFatConfirmaPedOrc: TfrmFatConfirmaPedOrc
  Width = 664
  Height = 459
  Caption = 'Confirma'#231#227'o'
  ExplicitWidth = 664
  ExplicitHeight = 459
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 388
    Width = 658
    ExplicitTop = 388
    ExplicitWidth = 658
    inherited FlwBotoes: TFlowPanel
      Width = 654
      ExplicitWidth = 654
      inherited btnConfirma: TBitBtnLocked
        Width = 81
        Caption = '&Desmarca'
        ExplicitWidth = 81
      end
      object btnLibera: TBitBtnLocked
        Left = 81
        Top = 0
        Width = 81
        Height = 22
        Caption = '&Libera'
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
        ModalResult = 6
        NumGlyphs = 2
        TabOrder = 1
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 578
      ExplicitLeft = 578
    end
  end
  inherited pnlStatus: TPanel
    Top = 414
    Width = 658
    ExplicitTop = 414
    ExplicitWidth = 658
    inherited pnlNomeForm: TPanel
      Left = 487
      ExplicitLeft = 487
    end
    inherited pnlInfo: TPanel
      Width = 487
      ExplicitWidth = 487
    end
  end
  object cxgDados: TcxGridCitel [2]
    Left = 0
    Top = 44
    Width = 658
    Height = 300
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDadostv: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDadosNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'NUMDOC'
        Options.Editing = False
        Width = 60
      end
      object cxgDadosESPDOC: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'ESPDOC'
        Options.Editing = False
        Width = 44
      end
      object cxgDadosCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        Options.Editing = False
        Width = 60
      end
      object cxgDadosCODVEN: TcxGridDBColumn
        Caption = 'C'#243'd. Vendedor'
        DataBinding.FieldName = 'CODVEN'
        Options.Editing = False
        Width = 78
      end
      object cxgDadosNOMVEN: TcxGridDBColumn
        Caption = 'Nome Vendedor'
        DataBinding.FieldName = 'NOMVEN'
        Options.Editing = False
        Width = 83
      end
      object cxgDadosCODCLI: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente'
        DataBinding.FieldName = 'CODCLI'
        Options.Editing = False
        Width = 63
      end
      object cxgDadosNOMCLI: TcxGridDBColumn
        Caption = 'Nome Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Options.Editing = False
        Width = 68
      end
      object cxgDadosOBSERV: TcxGridDBColumn
        DataBinding.FieldName = 'OBSERV'
        Visible = False
        Options.Editing = False
      end
      object cxgDadosCCLNOV: TcxGridDBColumn
        Caption = 'C'#243'd. Cliente Novo'
        DataBinding.FieldName = 'CCLNOV'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Caption = 'Definir'
            Default = True
            Glyph.SourceDPI = 96
            Glyph.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000001974455874536F6674776172650041646F626520496D616765526561
              647971C9653C0000001B744558745469746C65004D6172717565655A6F6F6D2E
              706E673B5A6F6F6D3BBEE84AB30000031749444154785E758F0F489C7518C73F
              BFF73DBB9BA703E9285B4B0B65C5C61C66DDAE5C4D716A393D3643705B44B9A2
              5C232830B70ABDD3EC2ED436DC2AD6BFB1482B4846B73F76CD313DFB33A846F9
              A74C1B5B0CA5B5824B37CF73F7BE4F677981511FF8F2C003DF0FCFA38ADC3B05
              008472F7561508740A2220B0D1BD451D0D74491C44A0AC628B4284FADA021250
              E8DE21ED6F7D46FB9B03B4C50328400792166201B475F76D97967DBD34ED0DB2
              8882F227A4F5403F89E2F3FEEE92173B82C77DFB4F4EC60B93DE3D3DC7EBBC5D
              A5F9C50FEF069461088B78F9F53EFCAFF501E8DE578E7AF71D1C9091B15F646A
              7A56FE988AC8D0E8A4B41D3825CF347679172E528B04F92535026875DECED28E
              7742129E8EC8079F8C49ADAF5F76F8FBE5FD4FC7E5B7F08CF8F7F7C41EAA6D2F
              05F4238FAD2510CFE11A279A6918009AD596EA59EFCAE658E867CEFC18C65DB4
              9AD9F4150447C204BF9A60FD5D2B748B35C50358CADF388DC56A23C966C36298
              7F0B62315999B93C8D57BB47D9B6D945AAFD1AEC6973581C76BE181DA4A87A0D
              91487415A033F212A669621A825650F4800254341A5531C304A5F1EEB7110E7E
              37872D19AC5641E98A98294466223AA0989BC330647E8776A2A74B009999B9F2
              C3E84F17B93B371DE3F7F32459AEA2AB18E10BE7B83DDBC1E0F0F9B8E0F23060
              2604460CB4F95300E3D78B179A8F04BF31D6E55C4F7ED612A2E786B83C3644DE
              321BCEAC343EFA38C42AE3CCF78045B97CEA2F8161A2563B3789009A92BA9BB3
              5DD73A1C8E5D9B2A9CDC92998E98C2F8D9093EEC3E4565EE14595706E90B8D37
              D61D1B6903663B1F5C6B5255D341E5237B011460BBA7F429F786CD0D278A2B1B
              2FC5E7A5C28AFA938F9714BF17F26C14F9FC69F9B2E97E69D9706B136007342A
              B6B65256EDE3ECC4544262019600290B490696D6BB329A7AEB0B457A1F9581E7
              0AC55F96E301AC8808FF464490E116E4EB46E4F42E000DB0EF5C734373E04997
              440F57C9DB55774C03A9FF2900E8DC7627BE7B3369CECFC0E3CA484852B6DF76
              5DC39E929573AD65398780E4FF151CAACE8B176FE205E77276E7DDC8B3B9CB12
              121BB074E135FD4F36D067FE1DB456560000000049454E44AE426082}
            Kind = bkGlyph
            Visible = False
          end>
        Properties.ReadOnly = True
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = cxgDadosCCLNOVPropertiesButtonClick
        Visible = False
        Options.ShowEditButtons = isebAlways
        Width = 95
      end
      object cxgDadosNCLNOV: TcxGridDBColumn
        Caption = 'Nome Cliente Novo'
        DataBinding.FieldName = 'NCLNOV'
        Visible = False
        Options.Editing = False
        Width = 98
      end
    end
    object cxgDadosLevel1: TcxGridLevel
      GridView = cxgDadostv
    end
  end
  object pnlTitulo: TPanel [3]
    Left = 0
    Top = 0
    Width = 658
    Height = 44
    Align = alTop
    TabOrder = 4
    object lblTitulo: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 650
      Height = 39
      Align = alClient
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 3
      ExplicitHeight = 14
    end
  end
  object pnlRodape: TPanel [4]
    Left = 0
    Top = 344
    Width = 658
    Height = 44
    Align = alBottom
    TabOrder = 3
    object lblRodape: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 650
      Height = 39
      Align = alClient
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 3
      ExplicitHeight = 14
    end
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'NUMDOC'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'CODEMP'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'CODCLI'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'NOMCLI'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'ESPDOC'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CODVEN'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'NOMVEN'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'OBSERV'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'CCLNOV'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'NCLNOV'
        DataType = ftString
        Size = 60
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 320
    Top = 216
  end
  object dsDados: TDataSource
    DataSet = cdsDados
    Left = 416
    Top = 216
  end
end
