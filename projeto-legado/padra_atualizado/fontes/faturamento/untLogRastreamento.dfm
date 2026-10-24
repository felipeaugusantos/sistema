inherited frmLogRastreamento: TfrmLogRastreamento
  Width = 807
  Height = 608
  Caption = 'Log de Rastreamento'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 807
  ExplicitHeight = 608
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 535
    Width = 801
    ExplicitTop = 535
    ExplicitWidth = 801
    inherited FlwBotoes: TFlowPanel
      Width = 797
      ExplicitWidth = 797
    end
    inherited btnSair: TBitBtnLocked
      Left = 718
      ExplicitLeft = 718
    end
  end
  inherited pnlStatus: TPanel
    Top = 563
    Width = 801
    ExplicitTop = 563
    ExplicitWidth = 801
    inherited pnlNomeForm: TPanel
      Left = 630
      ExplicitLeft = 630
    end
    inherited pnlInfo: TPanel
      Width = 630
      ExplicitWidth = 630
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 801
    Height = 73
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Dt.Emiss'#227'o:'
    end
    object Label2: TLabel
      Left = 200
      Top = 16
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Doc.Venda:'
    end
    object Label3: TLabel
      Left = 392
      Top = 16
      Width = 27
      Height = 14
      Alignment = taRightJustify
      Caption = 'Peso:'
    end
    object Label4: TLabel
      Left = 522
      Top = 16
      Width = 71
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vr.Documento:'
    end
    object Label5: TLabel
      Left = 29
      Top = 39
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label6: TLabel
      Left = 504
      Top = 39
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object edtDtaEnt: TEditFocus
      Left = 70
      Top = 13
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDocVen: TEditFocus
      Left = 262
      Top = 13
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPesBru: TEditFocus
      Left = 424
      Top = 13
      Width = 89
      Height = 22
      Alignment = taLeftJustify
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtVrDoc: TEditFocus
      Left = 598
      Top = 13
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Left = 70
      Top = 36
      Width = 59
      Height = 22
      Alignment = taLeftJustify
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCidade: TEditFocus
      Left = 550
      Top = 36
      Width = 169
      Height = 22
      Alignment = taLeftJustify
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomCli: TEditFocus
      Left = 131
      Top = 36
      Width = 367
      Height = 22
      Alignment = taLeftJustify
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object grdDados: TcxGridCitel [3]
    Left = 0
    Top = 73
    Width = 801
    Height = 462
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdDadosTv: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsDados
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
      object grdDadosTvDTHREN: TcxGridDBColumn
        Caption = 'Data Envio Transbordo'
        DataBinding.FieldName = 'TRA_DTHREN'
      end
      object grdDadosTvNUMROM: TcxGridDBColumn
        Caption = 'Romaneio'
        DataBinding.FieldName = 'GER_NUMROM'
      end
      object grdDadosTvEMPORI: TcxGridDBColumn
        Caption = 'Emp. Envio'
        DataBinding.FieldName = 'TRA_EMPORI'
      end
      object grdDadosTvDTHRRE: TcxGridDBColumn
        Caption = 'Data Rec. Destino'
        DataBinding.FieldName = 'TRA_DTHRRE'
      end
      object grdDadosTvEMPDES: TcxGridDBColumn
        Caption = 'Emp. Destino'
        DataBinding.FieldName = 'TRA_EMPDES'
      end
      object grdDadosTvOPEREC: TcxGridDBColumn
        Caption = 'Operador'
        DataBinding.FieldName = 'OPEREC'
      end
    end
    object grdDadosLvl: TcxGridLevel
      GridView = grdDadosTv
    end
  end
  object dtsDados: TDataSource
    Left = 456
    Top = 176
  end
end
