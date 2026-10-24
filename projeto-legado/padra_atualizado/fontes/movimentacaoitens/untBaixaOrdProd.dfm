inherited frmBaixaOrdProd: TfrmBaixaOrdProd
  Width = 673
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Baixa de Ordem de Produ'#231#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 673
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 667
    TabOrder = 1
    ExplicitTop = 527
    ExplicitWidth = 667
    DesignSize = (
      667
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 663
      ExplicitWidth = 663
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Caption = '&Baixar'
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
      object btnCadRapLotWMS: TBitBtnLocked
        Left = 77
        Top = 0
        Width = 146
        Height = 22
        Caption = '[F8] Cad. R'#225'pido Lotes'
        TabOrder = 1
        OnClick = btnCadRapLotWMSClick
      end
      object btnLocFis: TBitBtnLocked
        Left = 223
        Top = 0
        Width = 117
        Height = 22
        Caption = '[F7] Cad. Loc. F'#237'sicas'
        TabOrder = 2
        OnClick = btnLocFisClick
      end
      object btnCorrecoes: TBitBtnLocked
        Left = 340
        Top = 0
        Width = 117
        Height = 22
        Caption = '[F9] Corre'#231#245'es'
        TabOrder = 3
        OnClick = btnCorrecoesClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 587
      ExplicitLeft = 587
    end
  end
  inherited pnlStatus: TPanel
    Top = 555
    Width = 667
    TabOrder = 0
    ExplicitTop = 555
    ExplicitWidth = 667
    inherited pnlNomeForm: TPanel
      Left = 496
      ExplicitLeft = 496
    end
    inherited pnlInfo: TPanel
      Width = 496
      ExplicitWidth = 496
    end
  end
  object pgcPagina: TPageControl [2]
    Left = 0
    Top = 0
    Width = 667
    Height = 527
    ActivePage = tbsBaixa
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    object tbsBaixa: TTabSheet
      Caption = 'Baixa'
      object pnlIteEst: TPanel
        Left = 0
        Top = 266
        Width = 659
        Height = 229
        Align = alClient
        TabOrder = 0
        object dbgIteEst: TcxGridCitel
          Left = 1
          Top = 24
          Width = 657
          Height = 204
          Align = alClient
          TabOrder = 1
          LookAndFeel.ScrollbarMode = sbmClassic
          object dbgIteEstTV: TcxGridDBTableViewCitel
            OnKeyPress = dbgIteEstTVKeyPress
            Navigator.Buttons.CustomButtons = <>
            OnEditKeyDown = dbgIteEstTVEditKeyDown
            OnEditKeyPress = dbgIteEstTVEditKeyPress
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object dbgIteEstTVITESUB: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'ITESUB'
              Options.Editing = False
              Options.Focusing = False
              Width = 65
            end
            object dbgIteEstTVDESITE: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'DESITE'
              Options.Editing = False
              Options.Focusing = False
              Width = 225
            end
            object dbgIteEstTVREFERE: TcxGridDBColumn
              Caption = 'Refer'#234'ncia'
              DataBinding.FieldName = 'REFERE'
              Options.Editing = False
              Options.Focusing = False
              Width = 110
            end
            object dbgIteEstTVUNIDAD: TcxGridDBColumn
              Caption = 'Unid.'
              DataBinding.FieldName = 'UNIDAD'
              Options.Editing = False
              Options.Focusing = False
              Width = 65
            end
            object dbgIteEstTVQTDPRO: TcxGridDBColumn
              Caption = 'Qtd. Utilizada'
              DataBinding.FieldName = 'QTDPRO'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.OnEditValueChanged = dbgIteEstTVQTDPROPropertiesEditValueChanged
              Width = 70
            end
            object dbgIteEstTVNUMLOT: TcxGridDBColumn
              Caption = 'Lote'
              DataBinding.FieldName = 'NUMLOT'
              PropertiesClassName = 'TcxTextEditProperties'
              Properties.CharCase = ecUpperCase
              Properties.OnEditValueChanged = dbgIteEstTVNUMLOTPropertiesEditValueChanged
              Options.Grouping = False
              Width = 110
            end
          end
          object dbgIteEstLvl: TcxGridLevel
            GridView = dbgIteEstTV
          end
        end
        object pnlConLot: TPanel
          Left = 1
          Top = 1
          Width = 657
          Height = 23
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object chkConLot: TCheckBox
            Left = 2
            Top = 3
            Width = 217
            Height = 17
            Caption = 'Exibir somente itens com lote controlado'
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = chkConLotClick
          end
        end
      end
      object pnlArmEnt: TPanel
        Left = 0
        Top = 34
        Width = 659
        Height = 46
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 1
        object lblArmEnt: TLabel
          Left = 10
          Top = 16
          Width = 203
          Height = 14
          Alignment = taRightJustify
          Caption = 'Armaz'#233'm p/ entrada do Produto Estrutura:'
          Enabled = False
        end
        object edtDesArm: TEditFocus
          Left = 350
          Top = 12
          Width = 306
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtArmEnt: TMaskEditFocus
          Tag = 99
          Left = 214
          Top = 12
          Width = 134
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = clWhite
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = ''
          OnKeyPress = edtArmEntKeyPress
          NormalColor = clWhite
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
      object pnlConferido: TPanel
        Left = 0
        Top = 206
        Width = 659
        Height = 60
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 2
        object Label6: TLabel
          Left = 28
          Top = 10
          Width = 51
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produzido:'
        end
        object Label7: TLabel
          Left = 9
          Top = 35
          Width = 69
          Height = 14
          Alignment = taRightJustify
          Caption = 'Conferido Por:'
        end
        object edtProduzido: TEditFocus
          Tag = 99
          Left = 84
          Top = 6
          Width = 67
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = clWhite
          TabOrder = 0
          NormalColor = clWhite
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtConfPor: TEditFocus
          Left = 84
          Top = 32
          Width = 572
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = clWhite
          MaxLength = 30
          TabOrder = 2
          NormalColor = clWhite
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnArmInd: TBitBtnLocked
          Left = 157
          Top = 5
          Width = 204
          Height = 25
          Caption = 'Armaz'#233'm individual por unidade [F3]'
          TabOrder = 1
          TabStop = False
          OnClick = btnArmIndClick
        end
      end
      object pnlDadCli: TPanel
        Left = 0
        Top = 80
        Width = 659
        Height = 126
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 3
        object Label1: TLabel
          Left = 44
          Top = 10
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cliente:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 39
          Top = 33
          Width = 40
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produto:'
        end
        object Label4: TLabel
          Left = 10
          Top = 56
          Width = 69
          Height = 14
          Alignment = taRightJustify
          Caption = 'Observa'#231#245'es:'
        end
        object Label5: TLabel
          Left = 36
          Top = 102
          Width = 43
          Height = 14
          Alignment = taRightJustify
          Caption = 'Produzir:'
        end
        object edtCodCli: TEditFocus
          Left = 84
          Top = 6
          Width = 67
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodIte: TEditFocus
          Left = 84
          Top = 29
          Width = 67
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
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
        object edtObs001: TEditFocus
          Left = 84
          Top = 52
          Width = 572
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          ReadOnly = True
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtObs002: TEditFocus
          Left = 84
          Top = 75
          Width = 572
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          ReadOnly = True
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtProduzir: TEditFocus
          Left = 84
          Top = 98
          Width = 67
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          CharCase = ecUpperCase
          Color = 16768952
          ReadOnly = True
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          EditFormat = '#,##0.00'
        end
        object edtDesCli: TEditFocus
          Left = 152
          Top = 6
          Width = 504
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
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
        object edtDesIte: TEditFocus
          Left = 152
          Top = 29
          Width = 504
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          ReadOnly = True
          TabOrder = 6
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object pnlOrdPro: TPanel
        Left = 0
        Top = 0
        Width = 659
        Height = 34
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 4
        object Label3: TLabel
          Left = 29
          Top = 10
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'N'#186' Ordem:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtOrdPro: TEditFocus
          Tag = 99
          Left = 84
          Top = 6
          Width = 115
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          MaxLength = 6
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtOrdProKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttInteiro
        end
      end
    end
    object tbsFases: TTabSheet
      Caption = 'Fases'
      ImageIndex = 1
      object cxgCadFas: TcxGridCitel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 653
        Height = 489
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgCadFasView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = '< Sem fases para ordenar>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgCadFasCODIGO: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'FAS_CODIGO'
            Options.Editing = False
            Width = 65
          end
          object cxgCadFasDESFAS: TcxGridDBColumn
            Caption = 'Descri'#231#227'o da Fase'
            DataBinding.FieldName = 'FAS_DESFAS'
            Options.Editing = False
            Width = 516
          end
          object cxgCadFasSEQUEN: TcxGridDBColumn
            Caption = 'Sequ'#234'ncia'
            DataBinding.FieldName = 'FAS_SEQUEN'
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 93
          end
          object cxgCadFasSTATUS: TcxGridDBColumn
            Caption = 'Status'
            DataBinding.FieldName = 'FAS_STATUS'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
          end
        end
        object cxgCadFasLevel1: TcxGridLevel
          GridView = cxgCadFasView
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 528
    Top = 3
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 496
    Top = 3
  end
end
