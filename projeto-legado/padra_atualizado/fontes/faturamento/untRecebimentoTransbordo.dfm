inherited frmRecebimentoTransbordo: TfrmRecebimentoTransbordo
  Width = 1121
  Height = 698
  Caption = 'Recebimento de Transbordo'
  ExplicitWidth = 1121
  ExplicitHeight = 698
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 627
    Width = 1115
    ExplicitTop = 627
    ExplicitWidth = 1115
    inherited FlwBotoes: TFlowPanel
      Width = 1111
      ExplicitWidth = 1111
      inherited btnConfirma: TBitBtnLocked
        Width = 161
        Caption = '[F10] Receber Transbordo'
        ModalResult = 0
        ExplicitWidth = 161
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 161
        Top = 0
        Width = 118
        Height = 22
        Caption = '[F7] Marcar Todos'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 279
        Top = 0
        Width = 118
        Height = 22
        Caption = '[F8] Desmarcar Todos'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
      object btnItensDocumento: TBitBtnLocked
        Left = 397
        Top = 0
        Width = 188
        Height = 22
        Caption = '[F5] Visualizar itens do documento'
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnItensDocumentoClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1032
      Caption = 'Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      ExplicitLeft = 1032
    end
  end
  inherited pnlStatus: TPanel
    Top = 653
    Width = 1115
    ExplicitTop = 653
    ExplicitWidth = 1115
    inherited pnlNomeForm: TPanel
      Left = 944
      ExplicitLeft = 944
    end
    inherited pnlInfo: TPanel
      Width = 944
      ExplicitWidth = 944
    end
  end
  object grdTransbordo: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 1115
    Height = 627
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdTransbordoTv: TcxGridDBTableViewCitel
      OnKeyDown = grdTransbordoTvKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdTransbordoTvCustomDrawCell
      DataController.DataSource = dtsTransbordo
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
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object grdTransbordoTvDTHREN: TcxGridDBColumn
        Caption = 'Data Envio Transbordo'
        DataBinding.FieldName = 'TRA_DTHREN'
        Width = 128
      end
      object grdTransbordoTvNUMROM: TcxGridDBColumn
        Caption = 'Romaneio'
        DataBinding.FieldName = 'GER_NUMROM'
      end
      object grdTransbordoTvEMPORI: TcxGridDBColumn
        AlternateCaption = 'TRA_EMPROM'
        Caption = 'Emp. Envio'
        DataBinding.FieldName = 'TRA_EMPORI'
      end
      object grdTransbordoTvMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
        VisibleForCustomization = False
      end
      object grdTransbordoTvNUMDOC: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'GER_NUMDOC'
      end
      object grdTransbordoTvESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'GER_ESPDOC'
      end
      object grdTransbordoTvCODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'GER_CODEMP'
      end
      object grdTransbordoTvCLIENTE: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLIENTE'
      end
      object grdTransbordoTvNOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'CID_NOMCID'
      end
      object grdTransbordoTvESTCON: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'GER_ESTCON'
      end
      object grdTransbordoTvPESBRU: TcxGridDBColumn
        Caption = 'Peso Bruto'
        DataBinding.FieldName = 'GER_PESBRU'
      end
      object grdTransbordoTvPESLIQ: TcxGridDBColumn
        Caption = 'Peso Liquido'
        DataBinding.FieldName = 'GER_PESLIQ'
      end
      object grdTransbordoTvVOLUME: TcxGridDBColumn
        Caption = 'Volume'
        DataBinding.FieldName = 'GER_VOLUME'
      end
      object grdTransbordoTvVLRCON: TcxGridDBColumn
        Caption = 'Vr. Documento'
        DataBinding.FieldName = 'GER_VLRCON'
      end
    end
    object grdTransbordoLvl: TcxGridLevel
      GridView = grdTransbordoTv
    end
  end
  object dtsTransbordo: TDataSource
    Left = 440
    Top = 224
  end
end
