inherited frmFatMotEntregas: TfrmFatMotEntregas
  Width = 1107
  Height = 689
  Caption = 'Entregas'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitTop = -273
  ExplicitWidth = 1107
  ExplicitHeight = 689
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 644
    Width = 1101
    ExplicitTop = 644
    ExplicitWidth = 1101
    inherited FlwBotoes: TFlowPanel
      Width = 1097
      ExplicitWidth = 1097
    end
  end
  inherited pnlStatus: TPanel
    Top = 644
    Width = 1101
    ExplicitTop = 644
    ExplicitWidth = 1101
    inherited pnlNomeForm: TPanel
      Left = 930
      ExplicitLeft = 930
    end
    inherited pnlInfo: TPanel
      Width = 930
      ExplicitWidth = 930
    end
  end
  inherited pgcDados: TPageControl
    Width = 1101
    Height = 644
    ExplicitWidth = 1101
    ExplicitHeight = 644
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1093
      ExplicitHeight = 612
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 1101
    Height = 644
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlEntregadores: TPanel
      Left = 870
      Top = 1
      Width = 230
      Height = 642
      Align = alRight
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object pnlLegenda: TPanel
        Left = 1
        Top = 472
        Width = 228
        Height = 169
        Align = alBottom
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object btnEntrada: TBitBtnLocked
          Left = 5
          Top = 15
          Width = 98
          Height = 37
          Caption = '&Entrada'
          Enabled = False
          TabOrder = 0
          OnClick = btnEntradaClick
        end
        object btnSaidaAlmoco: TBitBtnLocked
          Left = 5
          Top = 51
          Width = 98
          Height = 37
          Caption = 'Sa'#237'da/&Almo'#231'o'
          Enabled = False
          TabOrder = 1
          OnClick = btnSaidaAlmocoClick
        end
        object btnRetornoAlmoco: TBitBtnLocked
          Left = 5
          Top = 87
          Width = 98
          Height = 37
          Caption = '&Retorno/Almo'#231'o'
          Enabled = False
          TabOrder = 2
          OnClick = btnRetornoAlmocoClick
        end
        object btnSaida: TBitBtnLocked
          Left = 5
          Top = 123
          Width = 98
          Height = 37
          Caption = '&Sa'#237'da'
          Enabled = False
          TabOrder = 3
          OnClick = btnSaidaClick
        end
        object grbLegenda: TGroupBox
          Left = 114
          Top = 7
          Width = 111
          Height = 153
          Caption = 'Legenda'
          TabOrder = 4
          object shpIndisponivel: TShape
            Left = -5
            Top = 16
            Width = 54
            Height = 33
            Brush.Color = clRed
            Shape = stRoundSquare
          end
          object shpAlmoco: TShape
            Left = -5
            Top = 48
            Width = 54
            Height = 33
            Brush.Color = clYellow
            Shape = stRoundSquare
          end
          object shpEntregando: TShape
            Left = -5
            Top = 80
            Width = 54
            Height = 33
            Brush.Color = clBlue
            Shape = stRoundSquare
          end
          object shpDisponivel: TShape
            Left = -5
            Top = 112
            Width = 54
            Height = 33
            Brush.Color = clGreen
            Shape = stRoundSquare
          end
          object lblIndisponível: TLabel
            Left = 43
            Top = 24
            Width = 56
            Height = 14
            Caption = 'Indispon'#237'vel'
          end
          object lblAlmoco: TLabel
            Left = 43
            Top = 57
            Width = 36
            Height = 14
            Caption = 'Almo'#231'o'
          end
          object lblEntregando: TLabel
            Left = 43
            Top = 88
            Width = 55
            Height = 14
            Caption = 'Entregando'
          end
          object lblDisponivel: TLabel
            Left = 43
            Top = 119
            Width = 49
            Height = 14
            Caption = 'Dispon'#237'vel'
          end
        end
      end
      object cxgMotoristas: TcxGridCitel
        Left = 1
        Top = 1
        Width = 228
        Height = 471
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgMotoristasDBTableViewCitel: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxgMotoristasDBTableViewCitelCustomDrawCell
          DataController.DataSource = dtsMotoristas
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgMotoristasMARDES: TcxGridDBColumn
            DataBinding.FieldName = 'MARDES'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.DisplayChecked = '1'
            Properties.DisplayUnchecked = '0'
            Properties.ImmediatePost = True
            Properties.ValueChecked = '1'
            Properties.ValueUnchecked = '0'
            Properties.OnChange = cxgMotoristasMARDESPropertiesChange
            Width = 25
            IsCaptionAssigned = True
          end
          object cxgMotoristasMOTORISTA: TcxGridDBColumn
            Caption = 'Entregadores'
            DataBinding.FieldName = 'MOTORISTA'
            Options.Editing = False
            Width = 185
          end
          object cxgMotoristasSITUAC: TcxGridDBColumn
            DataBinding.FieldName = 'MOT_SITUAC'
            Visible = False
            Options.Editing = False
            IsCaptionAssigned = True
          end
        end
        object cxgMotoristasLevel1: TcxGridLevel
          GridView = cxgMotoristasDBTableViewCitel
        end
      end
    end
    object pnlFundo: TPanel
      Left = 1
      Top = 1
      Width = 869
      Height = 642
      Align = alClient
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object pnlAcoes: TPanel
        Left = 1
        Top = 451
        Width = 867
        Height = 190
        Align = alBottom
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        DesignSize = (
          867
          190)
        object btnRegPartida: TBitBtnLocked
          Left = 7
          Top = 137
          Width = 153
          Height = 25
          Caption = '[F2] Registrar Partida'
          Enabled = False
          TabOrder = 1
          OnClick = btnRegPartidaClick
        end
        object btnRegChegada: TBitBtnLocked
          Left = 161
          Top = 137
          Width = 153
          Height = 25
          Caption = '[F3] Registrar Chegada'
          Enabled = False
          TabOrder = 2
          OnClick = btnRegChegadaClick
        end
        object btnRemoveDocs: TBitBtnLocked
          Left = 315
          Top = 137
          Width = 153
          Height = 25
          Caption = '[F4] Remover Documentos'
          Enabled = False
          TabOrder = 3
          OnClick = btnRemoveDocsClick
        end
        object btnDetEntrega: TBitBtnLocked
          Left = 7
          Top = 163
          Width = 153
          Height = 25
          Caption = '[F6] Detalhes da Entrega'
          TabOrder = 6
          OnClick = btnDetEntregaClick
        end
        object btnConEntrega: TBitBtnLocked
          Left = 161
          Top = 163
          Width = 153
          Height = 25
          Caption = '[F7] Consulta Entrega'
          TabOrder = 7
          OnClick = btnConEntregaClick
        end
        object btnAltEntrega: TBitBtnLocked
          Left = 315
          Top = 163
          Width = 153
          Height = 25
          Caption = '[F8] Alterar Tipo da Entrega'
          TabOrder = 8
          OnClick = btnAltEntregaClick
        end
        object btnAtualizar: TBitBtnLocked
          Left = 468
          Top = 137
          Width = 153
          Height = 25
          Caption = '[F5] Atualiza Documentos'
          TabOrder = 4
          OnClick = btnAtualizarClick
        end
        object btnAdicionarDocMotorista: TBitBtnLocked
          Left = 621
          Top = 137
          Width = 153
          Height = 25
          Anchors = [akLeft]
          Caption = '[F10] Adicionar Doc. Motorista'
          Enabled = False
          TabOrder = 5
          OnClick = btnAdicionarDocMotoristaClick
        end
        object pnlDadosDoc: TPanel
          Left = 1
          Top = 1
          Width = 865
          Height = 135
          Align = alTop
          Caption = 'pnlDadosDoc'
          TabOrder = 0
          object pgcDadosDoc: TPageControl
            Left = 1
            Top = 1
            Width = 863
            Height = 133
            ActivePage = tsObservacao
            Align = alClient
            TabOrder = 0
            object tsObservacao: TTabSheet
              Caption = 'Observa'#231#245'es'
              object grbObsEnt: TGroupBox
                Left = 381
                Top = -1
                Width = 526
                Height = 105
                Caption = 'Observa'#231#227'o Entrega'
                TabOrder = 0
                object memObsEnt: TMemo
                  Left = 2
                  Top = 16
                  Width = 522
                  Height = 87
                  TabStop = False
                  Align = alClient
                  ReadOnly = True
                  TabOrder = 0
                end
              end
              object grbObs: TGroupBox
                Left = 5
                Top = -1
                Width = 372
                Height = 105
                Caption = 'Observa'#231#227'o'
                TabOrder = 1
                object memObs: TMemo
                  Left = 2
                  Top = 16
                  Width = 368
                  Height = 87
                  TabStop = False
                  Align = alClient
                  ReadOnly = True
                  TabOrder = 0
                end
              end
            end
            object tsProdutos: TTabSheet
              Caption = 'Produtos'
              ImageIndex = 1
              ExplicitLeft = 0
              ExplicitTop = 0
              ExplicitWidth = 0
              ExplicitHeight = 0
              object cxgItens: TcxGrid
                Left = 0
                Top = 0
                Width = 855
                Height = 104
                Align = alClient
                TabOrder = 0
                object cxgItensDBTableView: TcxGridDBTableView
                  Navigator.Buttons.CustomButtons = <>
                  DataController.DataSource = dtsItensDoc
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsData.CancelOnExit = False
                  OptionsData.Deleting = False
                  OptionsData.DeletingConfirmation = False
                  OptionsData.Editing = False
                  OptionsData.Inserting = False
                  OptionsView.GroupByBox = False
                  object cxgItensCODITE: TcxGridDBColumn
                    Caption = 'C'#243'digo'
                    DataBinding.FieldName = 'CODITE'
                    Width = 66
                  end
                  object cxgItensDESCRI: TcxGridDBColumn
                    Caption = 'Descri'#231#227'o'
                    DataBinding.FieldName = 'DESCRI'
                  end
                  object cxgItensUNIDAD: TcxGridDBColumn
                    Caption = 'Un'
                    DataBinding.FieldName = 'UNIDAD'
                    Width = 25
                  end
                  object cxgItensQTDITE: TcxGridDBColumn
                    Caption = 'Quantidade'
                    DataBinding.FieldName = 'QTDITE'
                    Width = 98
                  end
                  object cxgItensUNITAR: TcxGridDBColumn
                    Caption = 'Valor Unit'#225'rio'
                    DataBinding.FieldName = 'UNITAR'
                    Width = 80
                  end
                  object cxgItensTOTITE: TcxGridDBColumn
                    Caption = 'Valor Total'
                    DataBinding.FieldName = 'TOTITE'
                    Width = 89
                  end
                end
                object cxgItensLevel: TcxGridLevel
                  GridView = cxgItensDBTableView
                end
              end
            end
          end
        end
      end
      object pnlDocumentos: TPanel
        Left = 1
        Top = 1
        Width = 867
        Height = 450
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object cxgDocumentos: TcxGridCitel
          Left = 1
          Top = 1
          Width = 865
          Height = 448
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxgDocumentosDBTableViewCitel: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            OnFocusedRecordChanged = cxgDocumentosDBTableViewCitelFocusedRecordChanged
            DataController.DataSource = dtsDocumentos
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxgDocumentosMARDES: TcxGridDBColumn
              DataBinding.FieldName = 'MARDES'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.DisplayChecked = '1'
              Properties.DisplayUnchecked = '0'
              Properties.ImmediatePost = True
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              Properties.OnChange = cxgDocumentosMARDESPropertiesChange
              Width = 25
              IsCaptionAssigned = True
            end
            object cxgDocumentosDOCUMENTO: TcxGridDBColumn
              Caption = 'Documento'
              DataBinding.FieldName = 'DOCUMENTO'
              Options.Editing = False
              Width = 120
            end
            object cxgDocumentosFANSOB: TcxGridDBColumn
              Caption = 'Nome Fantasia'
              DataBinding.FieldName = 'FANSOB'
              Options.Editing = False
              Width = 190
            end
            object cxgDocumentosCLIENTE: TcxGridDBColumn
              Caption = 'Cliente'
              DataBinding.FieldName = 'CLIENTE'
              Options.Editing = False
              Width = 299
            end
            object cxgDocumentosTELEFONES: TcxGridDBColumn
              Caption = 'Telefones'
              DataBinding.FieldName = 'TELEFONES'
              Options.Editing = False
              Width = 160
            end
            object cxgDocumentosVENDEDOR: TcxGridDBColumn
              Caption = 'Vendedor'
              DataBinding.FieldName = 'VENDEDOR'
              Options.Editing = False
              Width = 162
            end
            object cxgDocumentosVLRCON: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'GER_VLRCON'
              Options.Editing = False
              Width = 74
            end
            object cxgDocumentosCONPAG: TcxGridDBColumn
              Caption = 'Condi'#231#227'o de Pagamento'
              DataBinding.FieldName = 'CONPAG'
              Options.Editing = False
              Width = 157
            end
            object cxgDocumentosDATAHORADOC: TcxGridDBColumn
              Caption = 'Data / Hora Doc.'
              DataBinding.FieldName = 'DATAHORADOC'
              Options.Editing = False
              Width = 114
            end
            object cxgDocumentosENDCON: TcxGridDBColumn
              Caption = 'End. Entrega'
              DataBinding.FieldName = 'GER_ENDCON'
              Options.Editing = False
              Width = 235
            end
            object cxgDocumentosBAICON: TcxGridDBColumn
              Caption = 'Bairro'
              DataBinding.FieldName = 'GER_BAICON'
              Options.Editing = False
            end
            object cxgDocumentosDESREG: TcxGridDBColumn
              Caption = 'Regi'#227'o'
              DataBinding.FieldName = 'REG_DESREG'
              Options.Editing = False
              Width = 111
            end
            object cxgDocumentosSEPARACAO: TcxGridDBColumn
              Caption = 'Separa'#231#227'o'
              DataBinding.FieldName = 'SEPARACAO'
              Options.Editing = False
              Width = 114
            end
            object cxgDocumentosENTREGADOR: TcxGridDBColumn
              Caption = 'Entregador'
              DataBinding.FieldName = 'ENTREGADOR'
              Options.Editing = False
              Width = 135
            end
            object cxgDocumentosSAIDA: TcxGridDBColumn
              Caption = 'Sa'#237'da'
              DataBinding.FieldName = 'SAIDA'
              Options.Editing = False
              Width = 114
            end
          end
          object cxgDocumentosLevel: TcxGridLevel
            GridView = cxgDocumentosDBTableViewCitel
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 624
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 592
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 520
    Top = 224
  end
  object dtsDocumentos: TDataSource
    Left = 50
    Top = 42
  end
  object dtsMotoristas: TDataSource
    Left = 995
    Top = 121
  end
  object dtsItensDoc: TDataSource
    Left = 296
    Top = 504
  end
end
