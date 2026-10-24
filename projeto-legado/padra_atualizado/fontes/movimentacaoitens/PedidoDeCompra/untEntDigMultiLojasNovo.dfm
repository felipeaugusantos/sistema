inherited frmEntDigMultiLojasNovo: TfrmEntDigMultiLojasNovo
  Width = 1307
  Height = 700
  BorderStyle = bsSizeable
  Caption = 'Digita'#231#227'o de Quantidades'
  Visible = True
  OnResize = FormResize
  ExplicitWidth = 1307
  ExplicitHeight = 700
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 617
    Width = 1291
    ExplicitTop = 617
    ExplicitWidth = 1291
    inherited FlwBotoes: TFlowPanel
      Width = 1210
      ExplicitWidth = 1210
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 108
        Height = 24
        Align = alLeft
        Caption = '[F10] &Confirma'
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
        ModalResult = 1
        TabOrder = 0
      end
      object btnGiroAna: TBitBtnLocked
        Left = 108
        Top = 0
        Width = 173
        Height = 24
        Caption = '[ F2 ] Giro de estoque anal'#237'tico'
        TabOrder = 1
        OnClick = btnGiroAnaClick
      end
      object btnPedVen: TBitBtnLocked
        Left = 281
        Top = 0
        Width = 200
        Height = 24
        Caption = '[F3] Pedidos de Vendas em Aberto'
        TabOrder = 2
        OnClick = btnPedVenClick
      end
      object btnPrepTE: TBitBtnLocked
        Left = 481
        Top = 0
        Width = 165
        Height = 24
        Caption = '[F5] Prepara'#231#227'o para TE'
        TabOrder = 3
        OnClick = btnPrepTEClick
      end
      object btnPreTEGrid: TBitBtnLocked
        Left = 646
        Top = 0
        Width = 211
        Height = 24
        Caption = '[F6] Prepara'#231#227'o para TE desse pedido'
        TabOrder = 4
        OnClick = btnPreTEGridClick
      end
      object btnPedidosPend: TBitBtnLocked
        Left = 857
        Top = 0
        Width = 119
        Height = 24
        Caption = '[F7] Pedidos Pendentes'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = btnPedidosPendClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1212
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 1212
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 645
    Width = 1291
    ExplicitTop = 645
    ExplicitWidth = 1291
    inherited pnlNomeForm: TPanel
      Left = 1120
      ExplicitLeft = 1120
    end
    inherited pnlInfo: TPanel
      Width = 1120
      ExplicitWidth = 1120
    end
  end
  object cxgGiro: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1291
    Height = 584
    Align = alClient
    TabOrder = 2
    OnExit = cxgGiroExit
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBBandedTableView
      OnDblClick = cxgItensViewDblClick
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      FilterBox.Visible = fvNever
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.DataSource = dtsPcdDet
      DataController.Summary.DefaultGroupSummaryItems.OnSummary = cxgItensViewDataControllerSummaryFooterSummaryItemsSummary
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensVENMES
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_01
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_02
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_03
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_04
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_05
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_06
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_07
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_08
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_09
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_10
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_11
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQ_V_12
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensMEDIA_
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensMEDIXX
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensSUGEST
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQTDITE
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensESTMAX
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensESTMIN
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensSALFIS
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensSALGAR
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensSALRES
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQTDPEN
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensFUTPRE
          DisplayText = '#,##0.00'
        end
        item
          Kind = skSum
          Position = spFooter
          OnGetText = cxgGiroDIAESTSummaryGetText
          Column = cxgItensDIAEST
        end
        item
          Kind = skSum
          Position = spFooter
          OnGetText = cxgGiroDIASUGSummaryGetText
          Column = cxgItensDIASUG
        end
        item
          Format = ' '
          Kind = skMax
          Position = spFooter
          Column = cxgItensDTAULT
          DisplayText = ' '
        end
        item
          Format = ' '
          Kind = skMax
          Position = spFooter
          Column = cxgItensDTAUVE
          DisplayText = ' '
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensPESOIT
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skMax
          Position = spFooter
          Column = cxgItensMAQTSA
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensMEDAJU
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensSALDIS
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensPONPED
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQTDREQ
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQTDTRA
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensQTDEXC
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensSALTRA
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensSALEND
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensORDPRO
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensFUTFAL
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensFUTAGU
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensSALBAS
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          OnGetText = cxgItensViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems42GetText
          Column = cxgItensQTDVEN
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensAJUSTA
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensSALEXT
          DisplayText = '#,##0.00'
        end
        item
          Kind = skSum
          Position = spFooter
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensITE_PONEXP
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensSALEXC
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensESTEXC
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Position = spFooter
          Column = cxgItensDIFSUG
          DisplayText = '#,##0.00'
        end>
      DataController.Summary.FooterSummaryItems.OnSummary = cxgItensViewDataControllerSummaryFooterSummaryItemsSummary
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_VENMES'
          Column = cxgItensVENMES
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_01'
          Column = cxgItensQ_V_01
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_02'
          Column = cxgItensQ_V_02
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_03'
          Column = cxgItensQ_V_03
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_04'
          Column = cxgItensQ_V_04
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_05'
          Column = cxgItensQ_V_05
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_06'
          Column = cxgItensQ_V_06
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_07'
          Column = cxgItensQ_V_07
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_08'
          Column = cxgItensQ_V_08
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_09'
          Column = cxgItensQ_V_09
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_10'
          Column = cxgItensQ_V_10
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_11'
          Column = cxgItensQ_V_11
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_Q_V_12'
          Column = cxgItensQ_V_12
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensMEDIA_
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_MEDIXX'
          Column = cxgItensMEDIXX
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_SUGEST'
          Column = cxgItensSUGEST
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_QTDITE'
          Column = cxgItensQTDITE
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_ESTMAX'
          Column = cxgItensESTMAX
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_ESTMIN'
          Column = cxgItensESTMIN
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_SALDOS'
          Column = cxgItensSALFIS
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_SALGAR'
          Column = cxgItensSALGAR
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_SALRES'
          Column = cxgItensSALRES
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_QTDPEN'
          Column = cxgItensQTDPEN
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_QTDFUT'
          Column = cxgItensFUTPRE
          DisplayText = '#,##0.00'
        end
        item
          Kind = skSum
          OnGetText = cxgGiroDIAESTSummaryGetText
          FieldName = 'ITE_DIAEST'
          Column = cxgItensDIAEST
        end
        item
          Kind = skSum
          OnGetText = cxgGiroDIASUGSummaryGetText
          FieldName = 'ITE_DIASUG'
          Column = cxgItensDIASUG
        end
        item
          Format = ' '
          Kind = skMax
          Column = cxgItensDTAULT
          DisplayText = ' '
        end
        item
          Format = ' '
          Kind = skMax
          Column = cxgItensDTAUVE
          DisplayText = ' '
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_PESOIT'
          Column = cxgItensPESOIT
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skMax
          Column = cxgItensMAQTSA
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_MEDAJU'
          Column = cxgItensMEDAJU
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensSALDIS
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensPONPED
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensQTDREQ
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensQTDTRA
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensQTDEXC
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensSALTRA
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensSALEND
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensFUTAGU
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensFUTFAL
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensORDPRO
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensSALBAS
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          OnGetText = cxgItensViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems42GetText
          Column = cxgItensQTDVEN
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensAJUSTA
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_REATRA'
          Column = cxgItensReaTra
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_SALEXT'
          Column = cxgItensSALEXT
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          FieldName = 'ITE_PONEXP'
          Column = cxgItensITE_PONEXP
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensSALEXC
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensESTEXC
          DisplayText = '#,##0.00'
        end
        item
          Format = '#,##0.00'
          Kind = skSum
          Column = cxgItensDIFSUG
          DisplayText = '#,##0.00'
        end>
      DataController.Summary.SummaryGroups = <>
      Filtering.MRUItemsList = False
      Filtering.ColumnAddValueItems = False
      Filtering.ColumnMRUItemsList = False
      OptionsCustomize.ColumnGrouping = False
      OptionsCustomize.NestedBands = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum item incluido>'
      OptionsView.GroupByBox = False
      OptionsView.GroupFooters = gfAlwaysVisible
      Styles.ContentEven = cxStyle1
      OnColumnSizeChanged = cxgItensViewColumnSizeChanged
      Bands = <
        item
          Caption = 'Empresa'
          FixedKind = fkLeft
          Width = 408
        end
        item
          Caption = 'Informa'#231#245'es do Item'
          HeaderAlignmentHorz = taLeftJustify
          Width = 5555
        end>
      object cxgItensCODEMP: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITE_CODEMP'
        OnCustomDrawCell = cxgItensCODEMPCustomDrawCell
        HeaderAlignmentHorz = taCenter
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 43
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensNOMEMP: TcxGridDBBandedColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'ITE_DESEMP'
        OnCustomDrawCell = cxgItensNOMEMPCustomDrawCell
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 140
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensFANEMP: TcxGridDBBandedColumn
        Caption = 'Nome Fantasia'
        DataBinding.FieldName = 'ITE_FANEMP'
        OnCustomDrawCell = cxgItensFANEMPCustomDrawCell
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 140
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensCPRCEN: TcxGridDBBandedColumn
        Caption = 'C / I'
        DataBinding.FieldName = 'ITE_CPRCEN'
        OnGetDisplayText = cxgItensCPRCENGetDisplayText
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 70
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensQ_V_01: TcxGridDBBandedColumn
        Caption = 'M'#234's 1'
        DataBinding.FieldName = 'ITE_Q_V_01'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_01CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensQ_V_02: TcxGridDBBandedColumn
        Caption = 'M'#234's 2'
        DataBinding.FieldName = 'ITE_Q_V_02'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_02CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensQ_V_03: TcxGridDBBandedColumn
        Caption = 'M'#234's 3'
        DataBinding.FieldName = 'ITE_Q_V_03'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_03CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensQ_V_04: TcxGridDBBandedColumn
        Caption = 'M'#234's 4'
        DataBinding.FieldName = 'ITE_Q_V_04'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_04CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensQ_V_05: TcxGridDBBandedColumn
        Caption = 'M'#234's 5'
        DataBinding.FieldName = 'ITE_Q_V_05'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_05CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensQ_V_06: TcxGridDBBandedColumn
        Caption = 'M'#234's 6'
        DataBinding.FieldName = 'ITE_Q_V_06'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_06CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensQ_V_07: TcxGridDBBandedColumn
        Caption = 'M'#234's 7'
        DataBinding.FieldName = 'ITE_Q_V_07'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_07CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgItensQ_V_08: TcxGridDBBandedColumn
        Caption = 'M'#234's 8'
        DataBinding.FieldName = 'ITE_Q_V_08'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_08CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgItensQ_V_09: TcxGridDBBandedColumn
        Caption = 'M'#234's 9'
        DataBinding.FieldName = 'ITE_Q_V_09'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_09CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgItensQ_V_10: TcxGridDBBandedColumn
        Caption = 'M'#234's 10'
        DataBinding.FieldName = 'ITE_Q_V_10'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_10CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxgItensQ_V_11: TcxGridDBBandedColumn
        Caption = 'M'#234's 11'
        DataBinding.FieldName = 'ITE_Q_V_11'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_11CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxgItensQ_V_12: TcxGridDBBandedColumn
        Caption = 'M'#234's 12'
        DataBinding.FieldName = 'ITE_Q_V_12'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensQ_V_12CustomDrawCell
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxgItensVENMES: TcxGridDBBandedColumn
        Caption = 'M'#234's Atual'
        DataBinding.FieldName = 'ITE_VENMES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensVENMESCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxgItensMEDIA_: TcxGridDBBandedColumn
        Caption = 'M'#233'dia Vendas'
        DataBinding.FieldName = 'ITE_MEDIA_'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxgItensAJUSTA: TcxGridDBBandedColumn
        Caption = 'M'#233'dia Ajustada'
        DataBinding.FieldName = 'ITE_AJUSTA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 90
        Position.BandIndex = 1
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxgItensSUGEST: TcxGridDBBandedColumn
        Caption = 'Sugest'#227'o Compra'
        DataBinding.FieldName = 'ITE_SUGEST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Styles.Content = cxsNegrito
        Styles.Footer = cxsNegrito
        Styles.Header = cxsNegrito
        Width = 107
        Position.BandIndex = 1
        Position.ColIndex = 18
        Position.RowIndex = 0
      end
      object cxgItensMEDIXX: TcxGridDBBandedColumn
        Caption = 'M'#233'dia XX'
        DataBinding.FieldName = 'ITE_MEDIXX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxgItensMEDAJU: TcxGridDBBandedColumn
        Caption = 'M'#233'dia XX Ajustada'
        DataBinding.FieldName = 'ITE_MEDAJU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 97
        Position.BandIndex = 1
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
      object cxgItensQTDITE: TcxGridDBBandedColumn
        Caption = 'Qtd. Comprar'
        DataBinding.FieldName = 'ITE_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.ValidationOptions = []
        OnCustomDrawCell = cxgItensQTDITECustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.AutoWidthSizable = False
        Styles.Content = cxsNegrito
        Styles.Footer = cxsNegrito
        Styles.Header = cxsNegrito
        Width = 82
        Position.BandIndex = 1
        Position.ColIndex = 20
        Position.RowIndex = 0
      end
      object cxgItensESTMIN: TcxGridDBBandedColumn
        Caption = 'Estoque M'#237'nimo'
        DataBinding.FieldName = 'ITE_ESTMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensESTMINCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.AutoWidthSizable = False
        Width = 82
        Position.BandIndex = 1
        Position.ColIndex = 26
        Position.RowIndex = 0
      end
      object cxgItensMLTCOM: TcxGridDBBandedColumn
        Caption = 'M'#250'lt. Compra'
        DataBinding.FieldName = 'ITE_MLTCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 31
        Position.RowIndex = 0
      end
      object cxgItensSALFIS: TcxGridDBBandedColumn
        Caption = 'Saldo F'#237'sico'
        DataBinding.FieldName = 'ITE_SALFIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 90
        Position.BandIndex = 1
        Position.ColIndex = 32
        Position.RowIndex = 0
      end
      object cxgItensSALBAS: TcxGridDBBandedColumn
        Caption = 'Saldo Base Compra'
        DataBinding.FieldName = 'ITE_SALBAS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Styles.Content = cxsNegrito
        Styles.Footer = cxsNegrito
        Styles.Header = cxsNegrito
        Width = 114
        Position.BandIndex = 1
        Position.ColIndex = 44
        Position.RowIndex = 0
      end
      object cxgItensQTDPEN: TcxGridDBBandedColumn
        Caption = 'PD Compra Pendente'
        DataBinding.FieldName = 'ITE_QTDPEN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 110
        Position.BandIndex = 1
        Position.ColIndex = 42
        Position.RowIndex = 0
      end
      object cxgItensVENPER: TcxGridDBBandedColumn
        Caption = 'Qtd. Ven. Perdida'
        DataBinding.FieldName = 'ITE_VENPER'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DecimalPlaces = 3
        Properties.DisplayFormat = '0.000'
        Width = 21
        Position.BandIndex = 1
        Position.ColIndex = 43
        Position.RowIndex = 0
      end
      object cxgItensSALGAR: TcxGridDBBandedColumn
        Caption = 'Reservado Garantia'
        DataBinding.FieldName = 'ITE_SALGAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 104
        Position.BandIndex = 1
        Position.ColIndex = 33
        Position.RowIndex = 0
      end
      object cxgItensSALRES: TcxGridDBBandedColumn
        Caption = 'Reservado Ped. Venda'
        DataBinding.FieldName = 'ITE_SALRES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 118
        Position.BandIndex = 1
        Position.ColIndex = 34
        Position.RowIndex = 0
      end
      object cxgItensSALEND: TcxGridDBBandedColumn
        Caption = 'Res. Endere'#231'amento'
        DataBinding.FieldName = 'ITE_SALEND'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 112
        Position.BandIndex = 1
        Position.ColIndex = 35
        Position.RowIndex = 0
      end
      object cxgItensORDPRO: TcxGridDBBandedColumn
        Caption = 'Ordem Produ'#231#227'o'
        DataBinding.FieldName = 'ITE_QTPD_P'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Position.BandIndex = 1
        Position.ColIndex = 39
        Position.RowIndex = 0
      end
      object cxgItensDIAEST: TcxGridDBBandedColumn
        Caption = 'Dias Estoque'
        DataBinding.FieldName = 'ITE_DIAEST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = '0;-0'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 72
        Position.BandIndex = 1
        Position.ColIndex = 46
        Position.RowIndex = 0
      end
      object cxgItensDIASUG: TcxGridDBBandedColumn
        Caption = 'Dias Est. Qtd. Comprada'
        DataBinding.FieldName = 'ITE_DIASUG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 0
        Properties.DisplayFormat = '0;-0'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 125
        Position.BandIndex = 1
        Position.ColIndex = 47
        Position.RowIndex = 0
      end
      object cxgItensLOCFIS: TcxGridDBBandedColumn
        Caption = 'Local. F'#237'sica'
        DataBinding.FieldName = 'ITE_LOCFIS'
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 123
        Position.BandIndex = 1
        Position.ColIndex = 50
        Position.RowIndex = 0
      end
      object cxgItensDTAULT: TcxGridDBBandedColumn
        Caption = 'Data '#218'lt. Compra'
        DataBinding.FieldName = 'ITE_DTAULT'
        HeaderAlignmentHorz = taCenter
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 90
        Position.BandIndex = 1
        Position.ColIndex = 51
        Position.RowIndex = 0
      end
      object cxgItensFORULT: TcxGridDBBandedColumn
        Caption = 'C'#243'digo do Fornecedor da '#218'ltima Compra'
        DataBinding.FieldName = 'ITE_FORULT'
        Visible = False
        MinWidth = 0
        Options.AutoWidthSizable = False
        Position.BandIndex = 1
        Position.ColIndex = 63
        Position.RowIndex = 0
      end
      object cxgItensNOMFOR: TcxGridDBBandedColumn
        Caption = 'Fornecedor da '#218'ltima Compra'
        DataBinding.FieldName = 'ITE_NOMFOR'
        OnGetDisplayText = cxgItensNOMFORGetDisplayText
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 274
        Position.BandIndex = 1
        Position.ColIndex = 52
        Position.RowIndex = 0
      end
      object cxgItensQTDUCO: TcxGridDBBandedColumn
        Caption = 'Quant. '#218'lt. Compra'
        DataBinding.FieldName = 'ITE_QTDUCO'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 95
        Position.BandIndex = 1
        Position.ColIndex = 53
        Position.RowIndex = 0
      end
      object cxgItensPREULT: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o '#218'lt. Compra'
        DataBinding.FieldName = 'ITE_PREULT'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 91
        Position.BandIndex = 1
        Position.ColIndex = 54
        Position.RowIndex = 0
      end
      object cxgItensDTAUVE: TcxGridDBBandedColumn
        Caption = 'Data '#218'lt. Venda'
        DataBinding.FieldName = 'ITE_DTAUVE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 80
        Position.BandIndex = 1
        Position.ColIndex = 56
        Position.RowIndex = 0
      end
      object cxgItensDIAUCO: TcxGridDBBandedColumn
        Caption = #218'ltima Compra (Dias)'
        DataBinding.FieldName = 'ITE_DIAUCO'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 108
        Position.BandIndex = 1
        Position.ColIndex = 57
        Position.RowIndex = 0
      end
      object cxgItensDIAUVE: TcxGridDBBandedColumn
        Caption = #218'ltima Venda (Dias)'
        DataBinding.FieldName = 'ITE_DIAUVE'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 58
        Position.RowIndex = 0
      end
      object cxgItensNIVGIR: TcxGridDBBandedColumn
        Caption = 'N'#237'v.Giro'
        DataBinding.FieldName = 'ITE_NVLGIR'
        HeaderAlignmentHorz = taCenter
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 50
        Position.BandIndex = 1
        Position.ColIndex = 48
        Position.RowIndex = 0
      end
      object cxgItensNIVCRI: TcxGridDBBandedColumn
        Caption = 'N'#237'v.Crit'
        DataBinding.FieldName = 'ITE_NVLCRI'
        HeaderAlignmentHorz = taCenter
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 50
        Position.BandIndex = 1
        Position.ColIndex = 49
        Position.RowIndex = 0
      end
      object cxgItensMAXDIG: TcxGridDBBandedColumn
        Caption = 'Est.M'#225'x.Dig.'
        DataBinding.FieldName = 'ITE_MAXDIG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensESTMINCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.AutoWidthSizable = False
        Width = 68
        Position.BandIndex = 1
        Position.ColIndex = 28
        Position.RowIndex = 0
      end
      object cxgItensMINDIG: TcxGridDBBandedColumn
        Caption = 'Est.M'#237'n.Dig.'
        DataBinding.FieldName = 'ITE_MINDIG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensESTMINCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.AutoWidthSizable = False
        Width = 65
        Position.BandIndex = 1
        Position.ColIndex = 29
        Position.RowIndex = 0
      end
      object cxgItensESTMAX: TcxGridDBBandedColumn
        Caption = 'Estoque M'#225'ximo'
        DataBinding.FieldName = 'ITE_ESTMAX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DecimalPlaces = 2
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        OnCustomDrawCell = cxgItensESTMINCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.AutoWidthSizable = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 25
        Position.RowIndex = 0
      end
      object cxgItensFUTPRE: TcxGridDBBandedColumn
        Caption = 'Ent.Fut. Prev.'
        DataBinding.FieldName = 'ITE_QTEF_P'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 38
        Position.RowIndex = 0
      end
      object cxgItensFUTFAL: TcxGridDBBandedColumn
        Caption = 'Ent.Fut. Falta'
        DataBinding.FieldName = 'ITE_QTEF_F'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 71
        Position.BandIndex = 1
        Position.ColIndex = 36
        Position.RowIndex = 0
      end
      object cxgItensFUTAGU: TcxGridDBBandedColumn
        Caption = 'Ent.Fut. Ag.'
        DataBinding.FieldName = 'ITE_QTEF_A'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Position.BandIndex = 1
        Position.ColIndex = 37
        Position.RowIndex = 0
      end
      object cxgItensCODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'digo do Item'
        DataBinding.FieldName = 'ITE_CODITE'
        Visible = False
        OnGetDisplayText = cxgItensCODITEGetDisplayText
        GroupIndex = 0
        MinWidth = 0
        Options.Editing = False
        Options.FilteringWithFindPanel = False
        Options.FilteringAddValueItems = False
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Options.AutoWidthSizable = False
        Options.ShowCaption = False
        VisibleForCustomization = False
        Position.BandIndex = 1
        Position.ColIndex = 64
        Position.RowIndex = 0
      end
      object cxgItensMAQTSA: TcxGridDBBandedColumn
        Caption = 'Quant. Maior Venda'
        DataBinding.FieldName = 'ITE_MAQTSA'
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 102
        Position.BandIndex = 1
        Position.ColIndex = 59
        Position.RowIndex = 0
      end
      object cxgItensMADTSA: TcxGridDBBandedColumn
        Caption = 'Data Maior Venda'
        DataBinding.FieldName = 'ITE_MADTSA'
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 53
        Position.BandIndex = 1
        Position.ColIndex = 60
        Position.RowIndex = 0
      end
      object cxgItensPMED_V: TcxGridDBBandedColumn
        Caption = 'Pre'#231'o M'#233'dio Venda'
        DataBinding.FieldName = 'ITE_PMED_V'
        Options.Editing = False
        Width = 20
        Position.BandIndex = 1
        Position.ColIndex = 61
        Position.RowIndex = 0
      end
      object cxgItensPESOIT: TcxGridDBBandedColumn
        Caption = 'Peso Total'
        DataBinding.FieldName = 'ITE_PESOIT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 62
        Position.RowIndex = 0
      end
      object cxgItensSALDIS: TcxGridDBBandedColumn
        Caption = 'Saldo Dispon'#237'vel'
        DataBinding.FieldName = 'ITE_SALDIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Styles.Content = cxsNegrito
        Styles.Footer = cxsNegrito
        Styles.Header = cxsNegrito
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 41
        Position.RowIndex = 0
      end
      object cxgItensSALEXT: TcxGridDBBandedColumn
        Caption = 'Saldo Externo'
        DataBinding.FieldName = 'ITE_SALEXT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Options.Editing = False
        Width = 20
        Position.BandIndex = 1
        Position.ColIndex = 40
        Position.RowIndex = 0
      end
      object cxgItensPONPED: TcxGridDBBandedColumn
        Caption = 'Ponto Pedido'
        DataBinding.FieldName = 'ITE_PONPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 30
        Position.RowIndex = 0
      end
      object cxgItensQTDREQ: TcxGridDBBandedColumn
        Caption = 'Qtd. Requis.'
        DataBinding.FieldName = 'ITE_QTDREQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Styles.Content = cxsNegrito
        Styles.Footer = cxsNegrito
        Styles.Header = cxsNegrito
        Width = 75
        Position.BandIndex = 1
        Position.ColIndex = 19
        Position.RowIndex = 0
      end
      object cxgItensQTDTRA: TcxGridDBBandedColumn
        Caption = 'Qtd. a Transferir para Rec. de Transferencia'
        DataBinding.FieldName = 'ITE_QTDTRA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Styles.Content = cxsNegrito
        Styles.Footer = cxsNegrito
        Styles.Header = cxsNegrito
        Width = 252
        Position.BandIndex = 1
        Position.ColIndex = 22
        Position.RowIndex = 0
      end
      object cxgItensQTDEXC: TcxGridDBBandedColumn
        Caption = 'Excedente'
        DataBinding.FieldName = 'ITE_QTDEXC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Styles.Content = cxsNegrito
        Styles.Footer = cxsNegrito
        Styles.Header = cxsNegrito
        Width = 67
        Position.BandIndex = 1
        Position.ColIndex = 23
        Position.RowIndex = 0
      end
      object cxgItensSALTRA: TcxGridDBBandedColumn
        Caption = 'Saldo Transfer.'
        DataBinding.FieldName = 'ITE_SALTRA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Position.BandIndex = 1
        Position.ColIndex = 45
        Position.RowIndex = 0
      end
      object cxgItensVARCOM: TcxGridDBBandedColumn
        Caption = '%Var. (Pr.Pedido x Pr.'#218'lt.Compra)'
        DataBinding.FieldName = 'ITE_VARCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 168
        Position.BandIndex = 1
        Position.ColIndex = 55
        Position.RowIndex = 0
      end
      object cxgItensDIASAI: TcxGridDBBandedColumn
        Caption = 'Dias com Est.'
        DataBinding.FieldName = 'ITE_DIASAI'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 70
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 17
        Position.RowIndex = 0
      end
      object cxgItensSIGUNI: TcxGridDBBandedColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'ITE_SIGUNI'
        OnGetDisplayText = cxgItensSIGUNIGetDisplayText
        HeaderAlignmentHorz = taCenter
        MinWidth = 45
        Options.Editing = False
        Width = 45
        Position.BandIndex = 1
        Position.ColIndex = 65
        Position.RowIndex = 0
      end
      object cxgItensQTDEMB: TcxGridDBBandedColumn
        Caption = 'Embalagem'
        DataBinding.FieldName = 'ITE_QTDEMB'
        OnGetDisplayText = cxgItensQTDEMBGetDisplayText
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 85
        Options.Editing = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 66
        Position.RowIndex = 0
      end
      object cxgItensQTDVEN: TcxGridDBBandedColumn
        Caption = 'Qtd. Uni. Venda'
        DataBinding.FieldName = 'ITE_QTDVEN'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taRightJustify
        OnGetDisplayText = cxgItensQTDVENGetDisplayText
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 85
        Options.Editing = False
        Width = 85
        Position.BandIndex = 1
        Position.ColIndex = 67
        Position.RowIndex = 0
      end
      object cxgItensReaTra: TcxGridDBBandedColumn
        Caption = 'Qtd. A Transferir'
        DataBinding.FieldName = 'ITE_REATRA'
        OnGetDisplayText = cxgItensReaTraGetDisplayText
        Options.Editing = False
        Styles.Content = cxsNegrito
        Styles.Footer = cxsNegrito
        Styles.Header = cxsNegrito
        Width = 20
        Position.BandIndex = 1
        Position.ColIndex = 24
        Position.RowIndex = 0
      end
      object cxgItensIMPULT: TcxGridDBBandedColumn
        Caption = 'Prc Ult Compra + Imp.'
        DataBinding.FieldName = 'ITE_IMPULT'
        FooterAlignmentHorz = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 20
        Position.BandIndex = 1
        Position.ColIndex = 68
        Position.RowIndex = 0
      end
      object cxgItensESMIDG: TcxGridDBBandedColumn
        Caption = 'Op'#231#227'o Est. M'#237'nimo'
        DataBinding.FieldName = 'ITE_ESMIDG'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'D'
          'G')
        HeaderAlignmentHorz = taCenter
        Width = 42
        Position.BandIndex = 1
        Position.ColIndex = 27
        Position.RowIndex = 0
      end
      object cxgItensREFERE: TcxGridDBBandedColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'ITE_REFERE'
        FooterAlignmentHorz = taRightJustify
        GroupSummaryAlignment = taRightJustify
        Options.Editing = False
        Width = 20
        Position.BandIndex = 1
        Position.ColIndex = 69
        Position.RowIndex = 0
      end
      object cxgItensSALEXC: TcxGridDBBandedColumn
        Caption = 'Saldo excesso'
        DataBinding.FieldName = 'ITE_SALEXC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.MinValue = True
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        Properties.ValidationOptions = []
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Styles.Content = cxsNegrito
        Styles.Footer = cxsNegrito
        Styles.Header = cxsNegrito
        Width = 86
        Position.BandIndex = 1
        Position.ColIndex = 21
        Position.RowIndex = 0
      end
      object cxgItensITE_PONEXP: TcxGridDBBandedColumn
        Caption = 'Ponto de Exposi'#231#227'o'
        DataBinding.FieldName = 'ITE_PONEXP'
        PropertiesClassName = 'TcxTextEditProperties'
        FooterAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 70
        Position.RowIndex = 0
      end
      object cxgItensITE_QTEP_S: TcxGridDBBandedColumn
        Caption = 'Qtde. Emprestimo (Sa'#237'da)'
        DataBinding.FieldName = 'ITE_QTEP_S'
        Visible = False
        MinWidth = 140
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 71
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP01: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP01'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP02: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP02'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP03: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP03'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP04: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP04'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP05: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP05'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP06: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP06'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP07: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP07'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP08: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP08'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP09: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP09'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP10: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP10'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP11: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP11'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VP12: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VP12'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxgItensITE_Q_VPME: TcxGridDBBandedColumn
        DataBinding.FieldName = 'ITE_Q_VPME'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
      object cxgItensESTEXC: TcxGridDBBandedColumn
        Caption = 'Saldo Excedente'
        DataBinding.FieldName = 'ITE_ESTEXC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Styles.Content = cxsNegrito
        Styles.Footer = cxsNegrito
        Styles.Header = cxsNegrito
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 72
        Position.RowIndex = 0
      end
      object cxgItensDIFSUG: TcxGridDBBandedColumn
        Caption = 'Quantidade Adicional'
        DataBinding.FieldName = 'ITE_DIFSUG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '#,##0.00;-#,##0.00'
        HeaderAlignmentHorz = taRightJustify
        MinWidth = 0
        Options.Editing = False
        Options.AutoWidthSizable = False
        Styles.Content = cxsNegrito
        Styles.Footer = cxsNegrito
        Styles.Header = cxsNegrito
        Width = 100
        Position.BandIndex = 1
        Position.ColIndex = 68
        Position.RowIndex = 0
      end
      object cxgItensTIPABS: TcxGridDBBandedColumn
        Caption = 'Tipo Abastecimento'
        DataBinding.FieldName = 'ITE_TIPABS'
        OnGetDisplayText = cxgItensTIPABSGetDisplayText
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 110
        Position.RowIndex = 0
      end
      object cxgItensVNOLCD: TcxGridDBBandedColumn
        Caption = 'Venda Saldo Outra Loja/CD'
        DataBinding.FieldName = 'ITE_VNOLCD'
        OnGetDisplayText = cxgItensVNOLCDGetDisplayText
        Options.Editing = False
        Position.BandIndex = 1
        Position.ColIndex = 109
        Position.RowIndex = 0
      end
    end
    object cxgGiroLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlLegendas: TPanel [3]
    Left = 0
    Top = 584
    Width = 1291
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 3
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 1291
      Height = 33
      Align = alClient
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object FlowPanel1: TFlowPanel
        Left = 0
        Top = 0
        Width = 1291
        Height = 33
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object pnlLeg1: TPanel
          Left = 0
          Top = 0
          Width = 260
          Height = 15
          BevelOuter = bvNone
          Padding.Left = 5
          Padding.Right = 5
          ParentColor = True
          TabOrder = 0
          object Label5: TLabel
            Left = 5
            Top = 0
            Width = 250
            Height = 15
            Align = alClient
            Caption = '(C) Compra Centralizada (I) Compra Individual'
            Color = clMedGray
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            ExplicitHeight = 14
          end
        end
        object Panel2: TPanel
          Left = 260
          Top = 0
          Width = 220
          Height = 15
          BevelOuter = bvNone
          Padding.Left = 5
          Padding.Right = 5
          ParentColor = True
          TabOrder = 1
          object shpMesMed: TShape
            Left = 5
            Top = 0
            Width = 14
            Height = 15
            Align = alLeft
            Brush.Color = clRed
            ExplicitLeft = 250
            ExplicitTop = 1
            ExplicitHeight = 14
          end
          object lblMesMed: TLabel
            Left = 19
            Top = 0
            Width = 196
            Height = 15
            Align = alClient
            Caption = ' Meses utilizados para m'#233'dia e sugest'#227'o'
            ExplicitHeight = 14
          end
        end
        object Panel3: TPanel
          Left = 480
          Top = 0
          Width = 104
          Height = 15
          BevelOuter = bvNone
          Padding.Left = 5
          Padding.Right = 5
          ParentColor = True
          TabOrder = 2
          object Shape2: TShape
            Left = 5
            Top = 0
            Width = 14
            Height = 15
            Align = alLeft
            Brush.Color = clMoneyGreen
            ExplicitLeft = 214
            ExplicitTop = 1
            ExplicitHeight = 14
          end
          object Label2: TLabel
            Left = 19
            Top = 0
            Width = 80
            Height = 15
            Align = alClient
            Caption = ' Empresa logada'
            ExplicitHeight = 14
          end
        end
        object pnlAltera: TPanel
          Left = 584
          Top = 0
          Width = 189
          Height = 15
          BevelOuter = bvNone
          Padding.Left = 5
          Padding.Right = 5
          ParentColor = True
          TabOrder = 3
          object shpAltera: TShape
            Left = 5
            Top = 0
            Width = 14
            Height = 15
            Align = alLeft
            Brush.Color = clYellow
            ExplicitLeft = 214
            ExplicitTop = 1
            ExplicitHeight = 14
          end
          object lblAltera: TLabel
            Left = 19
            Top = 0
            Width = 165
            Height = 15
            Align = alClient
            Caption = ' Campos que podem ser alterados'
            ExplicitHeight = 14
          end
        end
        object pnlEmpVis: TPanel
          Left = 773
          Top = 0
          Width = 199
          Height = 15
          BevelOuter = bvNone
          Padding.Left = 5
          Padding.Right = 5
          ParentColor = True
          TabOrder = 4
          object shpEmpVis: TShape
            Left = 5
            Top = 0
            Width = 14
            Height = 15
            Align = alLeft
            Brush.Color = clFuchsia
            ExplicitLeft = 178
            ExplicitTop = 1
            ExplicitHeight = 14
          end
          object lblEmpVis: TLabel
            Left = 19
            Top = 0
            Width = 175
            Height = 15
            Align = alClient
            Caption = ' Empresa apenas para visualiza'#231#227'o'
            ExplicitWidth = 172
            ExplicitHeight = 14
          end
        end
        object Panel6: TPanel
          Left = 972
          Top = 0
          Width = 136
          Height = 15
          BevelOuter = bvNone
          Padding.Left = 5
          Padding.Right = 5
          ParentColor = True
          TabOrder = 5
          object Shape1: TShape
            Left = 5
            Top = 0
            Width = 14
            Height = 15
            Align = alLeft
            Brush.Color = clBlue
            ExplicitLeft = 183
            ExplicitTop = 1
            ExplicitHeight = 14
          end
          object Label3: TLabel
            Left = 19
            Top = 0
            Width = 112
            Height = 15
            Align = alClient
            Caption = ' Vendas em promo'#231#227'o'
            ExplicitWidth = 108
            ExplicitHeight = 14
          end
        end
        object Panel7: TPanel
          Left = 0
          Top = 15
          Width = 1329
          Height = 34
          BevelOuter = bvNone
          Padding.Left = 5
          Padding.Right = 5
          ParentColor = True
          TabOrder = 6
          object lblListaMesesGiro: TLabel
            Left = 5
            Top = 2
            Width = 159
            Height = 14
            Cursor = crHandPoint
            Caption = 'An'#225'lise de promo'#231#227'o do giro'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            OnClick = lblListaMesesGiroClick
          end
          object lblLegMesPromo: TLabel
            Left = 171
            Top = 2
            Width = 173
            Height = 14
            Caption = '(*) M'#234's com venda(s) em Promo'#231#227'o'
          end
          object lblExiApli: TLabel
            Left = 350
            Top = 2
            Width = 113
            Height = 14
            Cursor = crHandPoint
            Caption = 'Auto ajustar colunas'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
          end
          object lblResPad: TLabel
            Left = 478
            Top = 2
            Width = 95
            Height = 14
            Cursor = crHandPoint
            Caption = 'Restaurar padr'#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            OnClick = lblResPadClick
          end
          object lblSalbas: TLabel
            Left = 590
            Top = 2
            Width = 191
            Height = 14
            Cursor = crHandPoint
            Caption = 'Demonstrativo Saldo Base Compra'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            OnClick = lblSalbasClick
          end
          object lblConfiguraColunas: TLabel
            Left = 800
            Top = 2
            Width = 102
            Height = 14
            Cursor = crHandPoint
            Caption = 'Confi&gura Colunas'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold, fsUnderline]
            ParentFont = False
            OnClick = lblConfiguraColunasClick
          end
          object lblTestTamanho: TLabel
            Left = 917
            Top = 2
            Width = 73
            Height = 14
            Caption = 'lblTestTamanho'
            Visible = False
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 384
    Top = 312
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 568
    Top = 304
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 304
  end
  object dtsPcdDet: TDataSource
    Left = 56
    Top = 96
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 56
    Top = 176
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 16771797
    end
    object cxsNegrito: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
end
