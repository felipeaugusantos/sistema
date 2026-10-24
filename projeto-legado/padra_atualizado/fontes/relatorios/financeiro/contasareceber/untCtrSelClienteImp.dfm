inherited frmCtrSelClienteImp: TfrmCtrSelClienteImp
  Width = 606
  Height = 450
  Caption = 'Sele'#231#227'o de Clientes para Impress'#227'o'
  ExplicitWidth = 606
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 379
    Width = 600
    Height = 26
    ExplicitTop = 379
    ExplicitWidth = 600
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Left = 101
      Width = 398
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 596
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 499
      Top = 2
      Width = 99
      Align = alRight
      Caption = '[ESC] Cancela'
      TabOrder = 2
      ExplicitLeft = 497
      ExplicitWidth = 99
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 99
      Height = 22
      Align = alLeft
      Cancel = True
      Caption = '[F10] Confirma'
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
      ExplicitLeft = 4
      ExplicitTop = 3
    end
  end
  object pnl1: TPanel [2]
    Left = 0
    Top = 349
    Width = 600
    Height = 30
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 347
    object lbl1: TLabel
      Left = 7
      Top = 8
      Width = 169
      Height = 14
      Caption = '[ENTER] MARCAR / DESMARCAR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnMarcarTodos: TBitBtnLocked
      Left = 325
      Top = 2
      Width = 129
      Height = 25
      Caption = '[F7] Marcar todos'
      TabOrder = 0
      OnClick = btnMarcarTodosClick
    end
    object btnDesmarTodos: TBitBtnLocked
      Left = 460
      Top = 2
      Width = 129
      Height = 25
      Caption = '[F8] Desmarcar todos'
      TabOrder = 1
      OnClick = btnDesmarTodosClick
    end
  end
  object cxgSelCli: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 600
    Height = 349
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitHeight = 347
    object cxgSelCliDBTableView1: TcxGridDBTableView
      OnKeyDown = cxgSelCliDBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgSelCliDBTableView1CustomDrawCell
      DataController.DataSource = dtsSelCli
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.00'
          Position = spFooter
          Column = cxGridVALDUP
        end
        item
          Format = '#,##0.00'
          Column = cxGridVALDUP
        end
        item
          Format = '#,##0.00'
          Position = spFooter
          Column = cxGridVALCOR
        end
        item
          Format = '#,##0.00'
          Column = cxGridVALCOR
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Column = cxGridVALDUP
        end
        item
          Format = '#,##0.00'
          Column = cxGridVALCOR
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      object cxGridCODCLI: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CTR_CODCLI'
        Styles.Content = cxStyle1
      end
      object cxGridNOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        Styles.Content = cxStyle1
        Width = 310
      end
      object cxGridQTDTIT: TcxGridDBColumn
        Caption = 'Qtd.T'#237'tulos'
        DataBinding.FieldName = 'QTDTIT'
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 65
      end
      object cxGridVALDUP: TcxGridDBColumn
        Caption = 'Vlr.Pendente'
        DataBinding.FieldName = 'CTR_VALDUP'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 66
      end
      object cxGridVALCOR: TcxGridDBColumn
        Caption = 'Vlr.Corrigido'
        DataBinding.FieldName = 'CTR_CORRIGIDO'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Width = 79
      end
      object cxGridMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object cxgSelCliLevel1: TcxGridLevel
      GridView = cxgSelCliDBTableView1
    end
  end
  inherited pnlStatus: TPanel
    Top = 405
    Width = 600
    ExplicitTop = 405
    ExplicitWidth = 600
    inherited pnlNomeForm: TPanel
      Left = 429
      ExplicitLeft = 429
    end
    inherited pnlInfo: TPanel
      Width = 429
      ExplicitWidth = 429
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 80
  end
  object dtsSelCli: TDataSource
    DataSet = cdsSelCli
    Left = 232
    Top = 80
  end
  object cdsSelCli: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 200
    Top = 80
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 328
    Top = 80
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clWhite
    end
  end
end
