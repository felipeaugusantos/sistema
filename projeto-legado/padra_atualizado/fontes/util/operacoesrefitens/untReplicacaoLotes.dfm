inherited frmReplicacaoLotes: TfrmReplicacaoLotes
  Width = 800
  Height = 674
  BorderIcons = [biSystemMenu]
  Caption = 'Replica'#231#227'o de Armaz'#233'ns - Produtos'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 674
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 603
    Width = 794
    Height = 27
    Enabled = True
    Visible = True
    ExplicitTop = 603
    ExplicitWidth = 794
    ExplicitHeight = 27
    inherited btnSair: TBitBtnLocked
      Left = 708
      Top = 2
      ExplicitLeft = 708
      ExplicitTop = 2
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 2
      Width = 110
      Height = 22
      Caption = '[F10] Confirmar'
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
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  inherited pgcDados: TPageControl
    Top = 603
    Width = 794
    Height = 0
    Align = alBottom
    Visible = False
    ExplicitTop = 603
    ExplicitWidth = 794
    ExplicitHeight = 0
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 786
      ExplicitHeight = 429
    end
  end
  object grbArmRep: TGroupBox [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 603
    Align = alClient
    Caption = '   Armaz'#233'ns   '
    TabOrder = 3
    object grdAmzRep: TcxGridCitel
      Left = 2
      Top = 16
      Width = 790
      Height = 461
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdAmzRepDados: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsAmzRep
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = True
        Destaque = False
        CorZebra = clMoneyGreen
        object grdAmzRepDadosSELECT: TcxGridDBColumn
          DataBinding.FieldName = 'SELECT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 'S'
          Properties.ValueUnchecked = 'N'
          HeaderGlyph.SourceDPI = 96
          HeaderGlyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E0000000000000000000000000000000000020000
            00090000000E0000000F0000000F0000000F0000001000000010000000100000
            001100000011000000100000000B00000003000000000000000000000008285B
            8FC0357DC6FF327AC4FF3077C2FF2D75C1FF2B73C0FF2870BEFF266EBDFF256D
            BCFF226BBBFF216AB9FF154B84C20000000A00000000000000000000000C3C82
            CAFF77C2EEFF64B7EAFF61B5EAFF5DB4E9FF5AB2E8FF58B0E7FF54AFE7FF51AC
            E7FF50ABE6FF4DAAE6FF216ABAFF0000000F00000000000000000000000C3F85
            CBFF80C7EFFF3F8BCBFF3C88CBFF3986C8FF3583C7FF3381C6FF307FC4FF2F7F
            C4FF2D7DC3FF50ACE7FF246CBBFF0000000F00000000000000000000000B4288
            CDFF88CBF0FF4490CEFFF3ECEAFFEDE6E4FFEFEAE7FFE6E1DEFFE9E4E1FFECE5
            E1FF3181C5FF55AFE7FF256EBDFF0000000F00000000000000000000000B458B
            D0FF91D0F1FF4A95D1FFF5F1EFFFEFECE9FFA8B7AFFF125838FF668877FFE7E2
            DFFF4D91CDFF59B1E8FF2971BEFF0000000E00000000000000000000000A498E
            D2FF99D4F3FF65A5D8FFF5F3F2FFAEBFB5FF1E825BFF2EE1AAFF15744FFFA2B0
            A7FF8BB5DAFF63B6E9FF2B73C0FF0000000D0000000000000000000000094C92
            D3FFADDDF5FFA3C8E6FFB6C9C0FF258863FF40ECB9FF38ECB7FF2BD19CFF2367
            49FF87ACC6FF95CCEDFF2F76C2FF0000000D0000000000000000000000094E95
            D5FFB8E1F7FF84B2BEFF34906CFF5EF2C9FF71F9D7FF77F7D7FF41EBB9FF23B0
            81FF326D5FFFA7CDE3FF6499D1FF0000000C0000000000000000000000085397
            D7FFBEE4F7FF78AFB3FF4AAA89FF77DBBEFF419E7EFF237956FF6ADFC1FF41E9
            B8FF1D9A6FFF52867FFF92B4D6FF0000000D000000000000000000000007559A
            D9FFC5E8F9FFAFD2ECFFA3C5B7FF52967BFF98B8A9FFC5D1CBFF408D6FFF6DE1
            C3FF48ECBDFF18855CFF5B8891FF00000015000000010000000000000007589D
            DAFFBDE6F9FF84BCE4FFF8F8F8FFF0F0EEFFEEEEECFFEDEBEAFFD1D9D4FF3D89
            6BFF62D0B3FF66EFCCFF1C6F4DFF0000001B0000000200000000000000065B9F
            DCFFC2E7F7FF6AA6D2FFA5A3A1FF7D7976FF645E5DFF696462FFABA8A8FFB2B7
            B3FF3B826DFF359170FF6D95A5FF000000130000000000000000000000055DA1
            DEFFC5E6F5FF767C80FFB3AEACFFD2CDCAFFE5E0DDFFCFC6C1FFB8AFAAFFC1BE
            BDFFA6ABAFFFC3D9E6FF9BBDDEFF0000000A0000000000000000000000034778
            A6C05DA0DBFF918987FF8D8682FF88817FFFD0CCCAFFC8C3C1FF6C6664FF7672
            6FFF837F7DFF5C95CBFF4E7BA6CA000000050000000000000000000000010000
            000300000004000000050000000525232243716C6ACA605B59CA1D1B1B440000
            00060000000600000006000000040000000100000000}
          HeaderGlyphAlignmentHorz = taCenter
          MinWidth = 64
          IsCaptionAssigned = True
        end
        object grdAmzRepDadosCODAMZ: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODAMZ'
          MinWidth = 64
          Options.Editing = False
        end
        object grdAmzRepDadosDESCRI: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRI'
          MinWidth = 300
          Options.Editing = False
          Width = 300
        end
        object grdAmzRepDadosQTDREP: TcxGridDBColumn
          Caption = 'Qtd. Itens'
          DataBinding.FieldName = 'QTDREP'
          HeaderAlignmentHorz = taRightJustify
          MinWidth = 64
          Options.Editing = False
        end
      end
      object grdAmzRepLvl1: TcxGridLevel
        GridView = grdAmzRepDados
      end
    end
    object grbPrgRep: TGroupBox
      Left = 2
      Top = 477
      Width = 790
      Height = 124
      Align = alBottom
      Caption = '   Progresso Replica'#231#227'o   '
      TabOrder = 1
      object lblGeral: TLabel
        Left = 2
        Top = 16
        Width = 786
        Height = 14
        Align = alTop
        Caption = '   Armaz'#233'm: xxx'
        ExplicitWidth = 78
      end
      object lblDetalheEmp: TLabel
        Left = 2
        Top = 50
        Width = 786
        Height = 14
        Align = alTop
        Caption = '   Replicando armaz'#233'm na empresa: xxx'
        ExplicitWidth = 193
      end
      object lblDetalheItem: TLabel
        Left = 2
        Top = 84
        Width = 786
        Height = 14
        Align = alTop
        Caption = 
          '   Replicando armaz'#233'm nos produtos sem lote cadastrado, aguarde.' +
          '..'
        ExplicitWidth = 332
      end
      object pgrGeral: TProgressBar
        Left = 2
        Top = 30
        Width = 786
        Height = 20
        Align = alTop
        TabOrder = 0
      end
      object pgrDetalheEmp: TProgressBar
        Left = 2
        Top = 64
        Width = 786
        Height = 20
        Align = alTop
        TabOrder = 1
      end
      object pgrDetalheItem: TProgressBar
        Left = 2
        Top = 98
        Width = 786
        Height = 20
        Align = alTop
        TabOrder = 2
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 630
    Width = 794
    ExplicitTop = 630
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 392
    Top = 400
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 400
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 400
  end
  object dtsAmzRep: TDataSource
    Left = 448
    Top = 200
  end
end
