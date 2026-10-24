inherited frmBaixaOrdProdIndCriarLotesAuto: TfrmBaixaOrdProdIndCriarLotesAuto
  Width = 721
  Height = 543
  Caption = 'Baixa de ordem de produ'#231#227'o industrial - Cria'#231#227'o de lotes'
  OnDestroy = FormDestroy
  ExplicitWidth = 721
  ExplicitHeight = 543
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 472
    Width = 715
    ExplicitTop = 472
    ExplicitWidth = 715
    inherited FlwBotoes: TFlowPanel
      Width = 711
      ExplicitWidth = 711
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 78
        Top = 3
        Width = 369
        Height = 14
        Alignment = taCenter
        Caption = 
          'Pressione '#39'/'#39' na coluna de Localiza'#231#227'o F'#237'sica para alterar a loc' +
          'aliza'#231#227'o f'#237'sica'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 632
      ExplicitLeft = 632
    end
  end
  inherited pnlStatus: TPanel
    Top = 498
    Width = 715
    ExplicitTop = 498
    ExplicitWidth = 715
    inherited pnlNomeForm: TPanel
      Left = 512
      Width = 203
      ExplicitLeft = 512
      ExplicitWidth = 203
    end
    inherited pnlInfo: TPanel
      Width = 512
      ExplicitWidth = 512
    end
  end
  object cxGridLotes: TcxGrid [2]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 709
    Height = 445
    Align = alClient
    TabOrder = 2
    object cxGridLotesDBTableView: TcxGridDBTableView
      OnKeyPress = cxGridLotesDBTableViewKeyPress
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsLotes
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      OnCustomDrawGroupCell = cxGridLotesDBTableViewCustomDrawGroupCell
      object cxGridLotesTITULO: TcxGridDBColumn
        DataBinding.FieldName = 'TITULO'
        Visible = False
        GroupIndex = 0
        IsCaptionAssigned = True
      end
      object cxGridLotesSUBTITULO: TcxGridDBColumn
        DataBinding.FieldName = 'SUBTITULO'
        Visible = False
        GroupIndex = 1
        IsCaptionAssigned = True
      end
      object cxGridLotesNUMLOT: TcxGridDBColumn
        Caption = 'N'#250'mero lote'
        DataBinding.FieldName = 'NUMLOT'
        Options.Editing = False
      end
      object cxGridLotesSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
        OnGetDisplayText = cxGridLotesSTATUSGetDisplayText
        Options.Editing = False
        Width = 48
      end
      object cxGridLotesDTAFAB: TcxGridDBColumn
        Caption = 'Data Fabrica'#231#227'o'
        DataBinding.FieldName = 'DTAFAB'
        Options.Editing = False
        Width = 97
      end
      object cxGridLotesDTAVAL: TcxGridDBColumn
        Caption = 'Data Validade'
        DataBinding.FieldName = 'DTAVAL'
        Width = 72
      end
      object cxGridLotesDBLOCFIS: TcxGridDBColumn
        Caption = 'Localiza'#231#227'o F'#237'sica'
        DataBinding.FieldName = 'LOCFIS'
        Options.Editing = False
      end
      object cxGridLotesDBQTDALO: TcxGridDBColumn
        Caption = 'Qtd. Alocada'
        DataBinding.FieldName = 'QTDALO'
        Options.Editing = False
        Width = 68
      end
    end
    object cxGridLotesLevel1: TcxGridLevel
      GridView = cxGridLotesDBTableView
    end
  end
  object pnlAcao: TPanel [3]
    Left = 0
    Top = 451
    Width = 715
    Height = 21
    Align = alBottom
    Caption = 
      'N'#227'o ser'#225' poss'#237'vel confirmar pois h'#225' itens sem mapeamento de loca' +
      'liza'#231#227'o f'#237'sica'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object pnlLegendaLotePrincipal: TPanel
      Left = 582
      Top = 1
      Width = 132
      Height = 19
      Align = alRight
      BevelOuter = bvNone
      Caption = 'pnlLegendaLotePrincipal'
      ShowCaption = False
      TabOrder = 0
      Visible = False
    end
  end
  object dtsLotes: TDataSource
    DataSet = cdsLotes
    Left = 176
    Top = 160
  end
  object cdsLotes: TUniClientDataSet
    PersistDataPacket.Data = {
      690200009619E0BD01000000180000001A000000000003000000690205434841
      56450100490000000100055749445448020002001400064C4F43464953010049
      00000001000557494454480200020014000644544156414C0400060000000000
      0651544449544508000400000000000651544456454E08000400000000000645
      4E44455245010049000000010005574944544802000200010006415554494E43
      01004900000001000557494454480200020014000642554656454E0100490000
      0001000557494454480200020001000646495350494301004900000001000557
      494454480200020064000645584345535302000300000000000653454C454345
      02000300000000000641425049434B0100490000000100055749445448020002
      000100065049434B4E4701004900000001000557494454480200020001000643
      4F4449544501004900000001000557494454480200020007000A41494C5F494D
      5052455301004900000001000557494454480200020001000644455349544501
      00490000000100055749445448020002004600074C4F435449504F0100490000
      00010005574944544802000200320006454D4252454308000400000000000653
      455155454E040001000000000006544954554C4F010049000000010005574944
      544802000200640009535542544954554C4F0100490000000100055749445448
      02000200FA00084944544954554C4F0400010000000000064E554D4C4F540100
      490000000100055749445448020002001E000653544154555301004900000001
      0005574944544802000200010006445441464142040006000000000006515444
      414C4F08000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CHAVE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LOCFIS'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DTAVAL'
        DataType = ftDate
      end
      item
        Name = 'QTDITE'
        DataType = ftFloat
      end
      item
        Name = 'QTDVEN'
        DataType = ftFloat
      end
      item
        Name = 'ENDERE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'AUTINC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BUFVEN'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'FISPIC'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'EXCESS'
        DataType = ftBoolean
      end
      item
        Name = 'SELECE'
        DataType = ftBoolean
      end
      item
        Name = 'ABPICK'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PICKNG'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'CODITE'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'AIL_IMPRES'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DESITE'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'LOCTIPO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'EMBREC'
        DataType = ftFloat
      end
      item
        Name = 'SEQUEN'
        DataType = ftInteger
      end
      item
        Name = 'TITULO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'SUBTITULO'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'IDTITULO'
        DataType = ftInteger
      end
      item
        Name = 'NUMLOT'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'STATUS'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DTAFAB'
        DataType = ftDate
      end
      item
        Name = 'QTDALO'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    IndexFieldNames = 'NUMLOT'
    Params = <>
    StoreDefs = True
    BeforePost = cdsLotesBeforePost
    Left = 176
    Top = 104
    object cdsLotesCHAVE: TStringField
      DisplayWidth = 18
      FieldName = 'CHAVE'
    end
    object cdsLotesLOCFIS: TStringField
      DisplayWidth = 24
      FieldName = 'LOCFIS'
    end
    object cdsLotesDTAVAL: TDateField
      DisplayWidth = 12
      FieldName = 'DTAVAL'
    end
    object cdsLotesQTDITE: TFloatField
      DisplayWidth = 12
      FieldName = 'QTDITE'
    end
    object cdsLotesQTDVEN: TFloatField
      FieldName = 'QTDVEN'
    end
    object cdsLotesENDERE: TStringField
      FieldName = 'ENDERE'
      Size = 1
    end
    object cdsLotesAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsLotesBUFVEN: TStringField
      FieldName = 'BUFVEN'
      Size = 1
    end
    object cdsLotesFISPIC: TStringField
      FieldName = 'FISPIC'
      Size = 100
    end
    object cdsLotesEXCESS: TBooleanField
      FieldName = 'EXCESS'
    end
    object cdsLotesSELECE: TBooleanField
      FieldName = 'SELECE'
    end
    object cdsLotesABPICK: TStringField
      FieldName = 'ABPICK'
      Size = 1
    end
    object cdsLotesPICKNG: TStringField
      FieldName = 'PICKNG'
      Size = 1
    end
    object cdsLotesCODITE: TStringField
      FieldName = 'CODITE'
      Size = 7
    end
    object cdsLotesAIL_IMPRES: TStringField
      FieldName = 'AIL_IMPRES'
      Size = 1
    end
    object cdsLotesQTDEMB: TFloatField
      FieldKind = fkCalculated
      FieldName = 'QTDEMB'
      Calculated = True
    end
    object cdsLotesDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsLotesLOCTIPO: TStringField
      FieldName = 'LOCTIPO'
      Size = 50
    end
    object cdsLotesEMBREC: TFloatField
      FieldName = 'EMBREC'
    end
    object cdsLotesSEQUEN: TIntegerField
      FieldName = 'SEQUEN'
    end
    object cdsLotesTITULO: TStringField
      FieldName = 'TITULO'
      Size = 100
    end
    object cdsLotesSUBTITULO: TStringField
      FieldName = 'SUBTITULO'
      Size = 250
    end
    object cdsLotesIDTITULO: TIntegerField
      FieldName = 'IDTITULO'
    end
    object cdsLotesNUMLOT: TStringField
      FieldName = 'NUMLOT'
      Size = 30
    end
    object cdsLotesSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object cdsLotesDTAFAB: TDateField
      FieldName = 'DTAFAB'
    end
    object cdsLotesQTDALO: TFloatField
      FieldName = 'QTDALO'
    end
  end
end
