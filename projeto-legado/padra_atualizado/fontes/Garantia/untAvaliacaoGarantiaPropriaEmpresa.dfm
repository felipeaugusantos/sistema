inherited frmAvaliacaoGarantiaPropriaEmpresa: TfrmAvaliacaoGarantiaPropriaEmpresa
  Width = 1240
  Height = 502
  Caption = 'Avalia'#231#227'o de Garantia da Pr'#243'pria Empresa'
  Position = poScreenCenter
  ExplicitWidth = 1240
  ExplicitHeight = 502
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 429
    Width = 1234
    TabOrder = 2
    ExplicitTop = 429
    ExplicitWidth = 1234
    inherited FlwBotoes: TFlowPanel
      Width = 1230
      ExplicitWidth = 1230
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 185
        Height = 22
        Caption = '[F10] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object Panel1: TPanel
        Left = 185
        Top = 0
        Width = 432
        Height = 20
        BevelOuter = bvNone
        Color = clRed
        ParentBackground = False
        TabOrder = 1
        object Label1: TLabel
          AlignWithMargins = True
          Left = 5
          Top = 0
          Width = 424
          Height = 20
          Margins.Left = 5
          Margins.Top = 0
          Align = alClient
          AutoSize = False
          Caption = 
            'A quantidade reprovada estar'#225' no pedido de venda gerado para a E' +
            'xpedi'#231#227'o'
          Color = clRed
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
          ExplicitLeft = 6
          ExplicitTop = 1
          ExplicitWidth = 427
          ExplicitHeight = 25
        end
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1151
      ExplicitLeft = 1151
    end
  end
  inherited pnlStatus: TPanel
    Top = 457
    Width = 1234
    TabOrder = 3
    ExplicitTop = 457
    ExplicitWidth = 1234
    inherited pnlNomeForm: TPanel
      Left = 894
      Width = 340
      ExplicitLeft = 894
      ExplicitWidth = 340
    end
    inherited pnlInfo: TPanel
      Width = 894
      ExplicitWidth = 894
    end
  end
  object cxGrid: TcxGridCitel [2]
    Left = 0
    Top = 41
    Width = 1234
    Height = 388
    Align = alClient
    TabOrder = 1
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxGridDBTableViewCitel1: TcxGridDBTableViewCitel
      OnDblClick = cxGridDBTableViewCitel1DblClick
      OnKeyDown = cxGridDBTableViewCitel1KeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridDBTableViewCitel1CustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
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
      object cxGridDBTableViewCitel1Selecionado: TcxGridDBColumn
        DataBinding.FieldName = 'SELECIONADO'
        Visible = False
      end
      object cxGridDBTableViewCitel1AUTINC: TcxGridDBColumn
        DataBinding.FieldName = 'AUTINC'
        Visible = False
        Options.Editing = False
      end
      object cxGridDBTableViewCitel1NUMENT: TcxGridDBColumn
        Caption = 'Garantia'
        DataBinding.FieldName = 'NUMENT'
        Options.Editing = False
        Width = 80
      end
      object cxGridDBTableViewCitel1CODCLI: TcxGridDBColumn
        Caption = 'Cliente'
        DataBinding.FieldName = 'CODCLI'
        Options.Editing = False
        Width = 80
      end
      object cxGridDBTableViewCitel1NOMCLI: TcxGridDBColumn
        Caption = 'Nome Cliente'
        DataBinding.FieldName = 'NOMCLI'
        Options.Editing = False
      end
      object cxGridDBTableViewCitel1CODITE: TcxGridDBColumn
        Caption = 'Item'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 80
      end
      object cxGridDBTableViewCitel1CODFAB: TcxGridDBColumn
        Caption = 'C'#243'd. F'#225'brica'
        DataBinding.FieldName = 'CODFAB'
        Options.Editing = False
        Width = 100
      end
      object cxGridDBTableViewCitel1DESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o Item'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 300
      end
      object cxGridDBTableViewCitel1QTDREQ: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDREQ'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
      end
      object cxGridDBTableViewCitel1QTDAPR: TcxGridDBColumn
        Caption = 'Aprovado'
        DataBinding.FieldName = 'QTDAPR'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxGridDBTableViewCitel1QTDREF: TcxGridDBColumn
        Caption = 'Reprovado'
        DataBinding.FieldName = 'QTDREF'
        HeaderAlignmentHorz = taRightJustify
        Width = 70
      end
      object cxGridDBTableViewCitel1Finalidade: TcxGridDBColumn
        Caption = 'Finalidade Item Aprovado'
        DataBinding.FieldName = 'FINALIDADE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 138
      end
    end
    object cxGridLevel1: TcxGridLevel
      GridView = cxGridDBTableViewCitel1
    end
  end
  object pnlCliente: TPanel [3]
    Left = 0
    Top = 0
    Width = 1234
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlCliente'
    ShowCaption = False
    TabOrder = 0
    object lblCliente: TLabel
      Left = 7
      Top = 13
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 46
      Top = 10
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 169
      Top = 10
      Width = 1061
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = 16768952
      Requerido = False
      CompZeros = True
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforeDelete = cdsDadosBeforeDelete
    Left = 944
    Top = 88
    object cdsDadosSELECIONADO: TStringField
      FieldName = 'SELECIONADO'
      Size = 1
    end
    object cdsDadosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsDadosNUMENT: TStringField
      FieldName = 'NUMENT'
      Size = 12
    end
    object cdsDadosCODITE: TStringField
      FieldName = 'CODITE'
    end
    object cdsDadosDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsDadosQTDREQ: TFloatField
      FieldName = 'QTDREQ'
      DisplayFormat = '#0'
      EditFormat = '#0'
    end
    object cdsDadosQTDREF: TFloatField
      FieldName = 'QTDREF'
      OnValidate = cdsDadosQTDREFValidate
      DisplayFormat = '#0'
      EditFormat = '#0'
    end
    object cdsDadosQTDAPR: TFloatField
      FieldName = 'QTDAPR'
      OnValidate = cdsDadosQTDAPRValidate
      DisplayFormat = '#0'
      EditFormat = '#0'
    end
    object cdsDadosCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsDadosNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 40
    end
    object cdsDadosFINALIDADE: TStringField
      Alignment = taCenter
      FieldName = 'FINALIDADE'
      OnGetText = cdsDadosFINALIDADEGetText
      Size = 1
    end
    object cdsDadosSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsDadosGPE_SEQBAI: TStringField
      FieldName = 'GPE_SEQBAI'
    end
    object cdsDadosGPE_SEQAJE: TStringField
      FieldName = 'GPE_SEQAJE'
    end
    object cdsDadosAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsDadosTEM_ESTRUTURA: TStringField
      FieldName = 'TEM_ESTRUTURA'
      Size = 1
    end
    object cdsDadosCODFAB: TStringField
      FieldName = 'CODFAB'
      Size = 50
    end
    object cdsDadosITE_REFERE: TStringField
      FieldName = 'ITE_REFERE'
      Size = 16
    end
    object cdsDadosITE_CODMAR: TStringField
      FieldName = 'ITE_CODMAR'
      Size = 6
    end
    object cdsDadosGAD_VALITE: TFloatField
      FieldName = 'GAD_VALITE'
    end
    object cdsDadosVALENT: TFloatField
      FieldName = 'VALENT'
    end
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 944
    Top = 136
  end
  object cdsComponentes: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 1032
    Top = 96
    object cdsComponentesINCGAD: TStringField
      FieldName = 'INCGAD'
    end
    object cdsComponentesCOMPONENTE: TStringField
      FieldName = 'COMPONENTE'
      Size = 5
    end
    object cdsComponentesAPROVEITAR: TFloatField
      FieldName = 'APROVEITAR'
    end
    object cdsComponentesREFUGAR: TFloatField
      FieldName = 'REFUGAR'
    end
    object cdsComponentesCUSTO: TFloatField
      FieldName = 'CUSTO'
    end
    object cdsComponentesORIGEM: TStringField
      FieldName = 'ORIGEM'
      Size = 10
    end
    object cdsComponentesMOTIVO: TStringField
      FieldName = 'MOTIVO'
      Size = 10
    end
    object cdsComponentesDESTINO: TStringField
      FieldName = 'DESTINO'
      Size = 10
    end
    object cdsComponentesINCAJU: TStringField
      FieldName = 'INCAJU'
    end
    object cdsComponentesTOTALCUSTOREFUGAR: TAggregateField
      FieldName = 'TOTALCUSTOREFUGAR'
      Active = True
      DisplayName = ''
      Expression = 'SUM(CUSTO*REFUGAR)'
    end
    object cdsComponentesTOTALCUSTOAPROVEITAR: TAggregateField
      FieldName = 'TOTALCUSTOAPROVEITAR'
      Active = True
      DisplayName = ''
      Expression = 'SUM(CUSTO*APROVEITAR)'
    end
  end
end
