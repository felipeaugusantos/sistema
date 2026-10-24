inherited frmRelacaoPixParaGerarCC: TfrmRelacaoPixParaGerarCC
  Width = 1120
  Height = 523
  Caption = 'Gera'#231#227'o de CC dos Pix Recebidos'
  Position = poScreenCenter
  WindowState = wsMaximized
  ExplicitWidth = 1120
  ExplicitHeight = 523
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 450
    Width = 1114
    ExplicitTop = 450
    ExplicitWidth = 1114
    inherited FlwBotoes: TFlowPanel
      Width = 1110
      ExplicitWidth = 1110
      object btnGerarCC: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 129
        Height = 24
        Caption = '[F10] Confirmar'
        TabOrder = 0
        OnClick = btnGerarCCClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1034
      ExplicitLeft = 1034
    end
  end
  inherited pnlStatus: TPanel
    Top = 478
    Width = 1114
    ExplicitTop = 478
    ExplicitWidth = 1114
    inherited pnlNomeForm: TPanel
      Left = 905
      Width = 209
      ExplicitLeft = 905
      ExplicitWidth = 209
    end
    inherited pnlInfo: TPanel
      Width = 905
      ExplicitWidth = 905
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 1114
    Height = 450
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object grdLancamentos: TcxGridCitel
      Left = 1
      Top = 1
      Width = 1112
      Height = 448
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object grdLancamentosDados: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.FocusRect = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = False
        Destaque = False
        CorZebra = clMoneyGreen
        object grdLancamentosDadosMPX_DTAHOR: TcxGridDBColumn
          Caption = 'Data do Pix'
          DataBinding.FieldName = 'MPX_DTAHOR'
          Width = 147
        end
        object grdLancamentosDadosMPX_CODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'MPX_CODEMP'
          Width = 55
        end
        object grdLancamentosDadosMPX_VALREC: TcxGridDBColumn
          Caption = 'Valor Recebido'
          DataBinding.FieldName = 'MPX_VALREC'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;,0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 93
        end
        object grdLancamentosDadosDATARECEBIMENTO: TcxGridDBColumn
          Caption = 'Data Recebimento'
          DataBinding.FieldName = 'DATARECEBIMENTO'
          Width = 129
        end
        object grdLancamentosDadosBANCO: TcxGridDBColumn
          Caption = 'Banco'
          DataBinding.FieldName = 'BANCO'
          Width = 52
        end
        object grdLancamentosDadosPORTADOR: TcxGridDBColumn
          Caption = 'Portador'
          DataBinding.FieldName = 'PORTADOR'
          Width = 180
        end
        object grdLancamentosDadosMPX_SOLPAG: TcxGridDBColumn
          Caption = 'Solicita'#231#227'o Pagador'
          DataBinding.FieldName = 'MPX_SOLPAG'
          Width = 270
        end
        object grdLancamentosDadosLOG_CODCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'LOG_CODCLI'
          OnGetDisplayText = grdLancamentosDadosLOG_CODCLIGetDisplayText
          Width = 213
        end
        object grdLancamentosDadosVENDEDOR: TcxGridDBColumn
          Caption = 'Vendedor'
          DataBinding.FieldName = 'VENDEDOR'
          Width = 157
        end
        object grdLancamentosDadosMPX_CHADOC: TcxGridDBColumn
          Caption = 'Documento Refer'#234'ncia'
          DataBinding.FieldName = 'LOG_CHADOC'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          Width = 201
        end
        object grdLancamentosDadosMPX_VALDOC: TcxGridDBColumn
          Caption = 'Valor Total Documento'
          DataBinding.FieldName = 'LOG_VALDOC'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = ',0.00;-,0.00'
          Properties.HideSelection = False
          Properties.ReadOnly = True
          Width = 125
        end
        object grdLancamentosDadosLOG_QTDITE: TcxGridDBColumn
          Caption = 'Quantidade'
          DataBinding.FieldName = 'LOG_QTDITE'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
        end
        object grdLancamentosDadosMPX_TX_ID_: TcxGridDBColumn
          Caption = 'TxId Pix'
          DataBinding.FieldName = 'MPX_TX_ID_'
          Width = 188
        end
        object grdLancamentosDadosMPX_QRCODE: TcxGridDBColumn
          Caption = 'C'#243'digo QRCode'
          DataBinding.FieldName = 'MPX_QRCODE'
          Width = 256
        end
        object grdLancamentosDadosLOG_NOMTEL: TcxGridDBColumn
          Caption = 'Tela de cria'#231#227'o da cobran'#231'a'
          DataBinding.FieldName = 'LOG_NOMTEL'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          Width = 401
        end
      end
      object grdLancamentosNivel: TcxGridLevel
        GridView = grdLancamentosDados
      end
    end
  end
end
