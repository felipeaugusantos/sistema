inherited frmFatMostraPedSalRes: TfrmFatMostraPedSalRes
  Left = 159
  Top = 100
  Width = 1024
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Documentos que comp'#245'em o saldo de reserva'
  Position = poMainFormCenter
  ExplicitWidth = 1024
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 468
    Width = 1008
    ExplicitTop = 468
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
    end
    inherited btnSair: TBitBtnLocked
      Left = 473
      ExplicitLeft = 473
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 1008
    ExplicitTop = 545
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  inherited pgcDados: TPageControl
    Top = 37
    Width = 1008
    Height = 431
    Visible = False
    ExplicitTop = 37
    ExplicitWidth = 1008
    ExplicitHeight = 431
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1000
      ExplicitHeight = 399
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1008
    Height = 37
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 28
      Top = 14
      Width = 22
      Height = 14
      Caption = 'Item:'
    end
    object edtItem: TEditFocus
      Left = 53
      Top = 7
      Width = 541
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object chkSemReq: TCheckBox
      Left = 640
      Top = 11
      Width = 241
      Height = 17
      Caption = 'Mostrar apenas pedidos sem requisi'#231#227'o'
      TabOrder = 1
      OnClick = chkSemReqClick
    end
  end
  object pnlBotoesMostra: TPanel [4]
    Left = 0
    Top = 521
    Width = 1008
    Height = 24
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 4
    object btnFechar: TBitBtnLocked
      Left = 929
      Top = 2
      Width = 77
      Height = 20
      Align = alRight
      Caption = '&Fechar'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
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
      TabOrder = 0
      OnClick = btnFecharClick
    end
    object btnPedVen: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 240
      Height = 20
      Hint = 'Visualizar o documentos que reservam este item'
      Align = alLeft
      Caption = '[ F5 ] Visualizar Pedido de Venda Completo'
      TabOrder = 1
      Visible = False
      OnClick = btnPedVenClick
    end
  end
  object pnlTotais: TPanel [5]
    Left = 0
    Top = 468
    Width = 1008
    Height = 53
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 5
    object lbl1: TLabel
      Left = 8
      Top = 31
      Width = 155
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Quantidade Reservada:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 23
      Top = 12
      Width = 140
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total Quantidade Cortada:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtTotCor: TEditFocus
      Left = 166
      Top = 4
      Width = 92
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      ParentFont = False
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
    object edtTotRes: TEditFocus
      Left = 166
      Top = 27
      Width = 92
      Height = 22
      TabStop = False
      Alignment = taRightJustify
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      ParentFont = False
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
  end
  object cxgItens: TcxGridCitel [6]
    Left = 0
    Top = 37
    Width = 1008
    Height = 431
    Align = alClient
    TabOrder = 6
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensTableView: TcxGridDBTableViewCitel
      OnKeyDown = cxgItensTableViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensTableViewCustomDrawCell
      DataController.DataSource = dtsSalRes
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#0.000'
          Kind = skSum
          Column = FDO_QTDPED
        end
        item
          Format = '#0.000'
          Kind = skSum
          Column = FDO_QTDGAR
        end
        item
          Format = '#0.000'
          Kind = skSum
          Column = FDO_QTDORP
        end
        item
          Format = '#0.000'
          Kind = skSum
          Column = FDO_QTDEND
        end
        item
          Format = '#0.000'
          Kind = skSum
          Column = LDO_QTDSEP
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object Se_adicionar_uma_coluna_modifique_o_FormCreate: TcxGridDBColumn
        Visible = False
        Width = 66
      end
      object FDO_NUMDOC: TcxGridDBColumn
        Caption = 'Nro. Pedido'
        DataBinding.FieldName = 'FDO_NUMDOC'
        Width = 105
      end
      object FDO_ESPDOC: TcxGridDBColumn
        Caption = 'Esp.'
        DataBinding.FieldName = 'FDO_ESPDOC'
        Width = 27
      end
      object FDO_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'FDO_CODEMP'
        Width = 27
      end
      object FDO_CODVEN: TcxGridDBColumn
        Caption = 'Cod Ven'
        DataBinding.FieldName = 'FDO_CODVEN'
        Width = 53
      end
      object NOMVEN: TcxGridDBColumn
        Caption = 'Nome Vendedor'
        DataBinding.FieldName = 'OPE_NOMOPE'
        Width = 153
      end
      object FDO_DTAENT: TcxGridDBColumn
        Caption = 'Data'
        DataBinding.FieldName = 'FDO_DTAENT'
        Width = 75
      end
      object FGO_PREVIS: TcxGridDBColumn
        Caption = 'Prev. Entrega'
        DataBinding.FieldName = 'FGO_PREVIS'
        Options.Editing = False
        Width = 75
      end
      object FDO_DTENTR: TcxGridDBColumn
        Caption = 'Data Entrega'
        DataBinding.FieldName = 'FDO_DTENTR'
        Options.Editing = False
        Width = 75
      end
      object CLI_CODCLI: TcxGridDBColumn
        Caption = 'Cod Cliente'
        DataBinding.FieldName = 'CLI_CODCLI'
        Width = 70
      end
      object CLI_NOMCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLI_NOMCLI'
        Width = 243
      end
      object CID_NOMCID: TcxGridDBColumn
        Caption = 'Cidade'
        DataBinding.FieldName = 'CID_NOMCID'
        Width = 200
      end
      object CID_ESTADO: TcxGridDBColumn
        Caption = 'UF'
        DataBinding.FieldName = 'CID_ESTADO'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 27
      end
      object FDO_QTDPED: TcxGridDBColumn
        Caption = 'Ped. Venda'
        DataBinding.FieldName = 'FDO_QTDPED'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.000'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object FDO_QTPD_F: TcxGridDBColumn
        Caption = 'Ped. Venda (Filial)'
        DataBinding.FieldName = 'FDO_QTPD_F'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.000'
        Visible = False
        Width = 94
      end
      object FDO_QTDGAR: TcxGridDBColumn
        Caption = 'Garantia'
        DataBinding.FieldName = 'FDO_QTDGAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.000'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object FDO_QTDEND: TcxGridDBColumn
        Caption = 'Endere'#231'amento'
        DataBinding.FieldName = 'FDO_QTDEND'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.000'
        HeaderAlignmentHorz = taRightJustify
        Width = 102
      end
      object FDO_QTDDEV: TcxGridDBColumn
        Caption = 'Pend. Dev.'
        DataBinding.FieldName = 'FDO_QTDDEV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        Width = 79
      end
      object FDO_QTDORP: TcxGridDBColumn
        Caption = 'Ord. Prod.'
        DataBinding.FieldName = 'FDO_QTDORP'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.000'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object FDO_UNITAR: TcxGridDBColumn
        Caption = 'Vr. Unit'#225'rio'
        DataBinding.FieldName = 'FDO_UNITAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.AutoWidthSizable = False
        Width = 80
      end
      object EQU_NUMOSE: TcxGridDBColumn
        Caption = 'N'#186' O.S.'
        DataBinding.FieldName = 'EQU_NUMOSE'
        HeaderAlignmentHorz = taRightJustify
        Width = 60
      end
      object EQU_STATUS: TcxGridDBColumn
        Caption = 'Status O.S.'
        DataBinding.FieldName = 'EQU_STATUS'
        Width = 142
      end
      object FGO_CORTE_: TcxGridDBColumn
        DataBinding.FieldName = 'FGO_CORTE_'
        Visible = False
      end
      object TABELA: TcxGridDBColumn
        AlternateCaption = 'TABELA'
        Caption = 'Tipo de Doc.'
        DataBinding.FieldName = 'TABELA'
        Width = 148
      end
      object DOCENT: TcxGridDBColumn
        Caption = 'Documento de Entrada / Endere'#231'amento'
        DataBinding.FieldName = 'DOCENT'
        Width = 400
      end
      object SEPIMP: TcxGridDBColumn
        Caption = 'Separa'#231#227'o Impressa'
        DataBinding.FieldName = 'SEPIMP'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 110
      end
      object LDO_QTDSEP: TcxGridDBColumn
        Caption = 'Qtd. Separada'
        DataBinding.FieldName = 'LDO_QTDSEP'
        Visible = False
        FooterAlignmentHorz = taRightJustify
        GroupSummaryAlignment = taRightJustify
        HeaderAlignmentHorz = taRightJustify
        HeaderGlyphAlignmentHorz = taRightJustify
        Width = 100
      end
      object CODREQ: TcxGridDBColumn
        Caption = 'Requisi'#231#227'o'
        DataBinding.FieldName = 'CODREQ'
        Options.Editing = False
        Width = 90
      end
      object LDO_NUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'NUMLOT'
        Width = 300
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensTableView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 336
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 272
    Top = 256
  end
  object dtsSalRes: TDataSource
    Left = 384
    Top = 80
  end
end
