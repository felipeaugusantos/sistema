inherited frmAvisoDocumentoCliente: TfrmAvisoDocumentoCliente
  Width = 964
  Height = 509
  Caption = 'Aviso de Documento do Mesmo Cliente'
  Position = poScreenCenter
  ExplicitWidth = 964
  ExplicitHeight = 509
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 436
    Width = 958
    ExplicitTop = 436
    ExplicitWidth = 958
    inherited FlwBotoes: TFlowPanel
      Width = 954
      AutoSize = True
      ExplicitWidth = 954
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 125
        Height = 22
        Caption = 'Marcar Todos'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 875
      ExplicitLeft = 875
    end
  end
  inherited pnlStatus: TPanel
    Top = 464
    Width = 958
    ExplicitTop = 464
    ExplicitWidth = 958
    inherited pnlNomeForm: TPanel
      Left = 787
      ExplicitLeft = 787
    end
    inherited pnlInfo: TPanel
      Width = 787
      ExplicitWidth = 787
    end
  end
  object grdDados: TcxGridCitel [2]
    Left = 0
    Top = 82
    Width = 958
    Height = 354
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = -2
    ExplicitTop = 79
    object grdDadosDBTableViewCitel1: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdDadosDTAEMI: TcxGridDBColumn
        Caption = 'Data Emiss'#227'o'
        DataBinding.FieldName = 'DTAEMI'
        Width = 71
      end
      object grdDadosDTAENT: TcxGridDBColumn
        Caption = 'Data Entrega'
        DataBinding.FieldName = 'DTAENT'
        Width = 68
      end
      object grdDadosDOCUME: TcxGridDBColumn
        Caption = 'Documento'
        DataBinding.FieldName = 'DOCUME'
        Width = 126
      end
      object grdDadosEMPFAT: TcxGridDBColumn
        Caption = 'Emp. Fat.'
        DataBinding.FieldName = 'EMPFAT'
        Width = 62
      end
      object grdDadosCODVEN: TcxGridDBColumn
        Caption = 'Cod. Vend.'
        DataBinding.FieldName = 'CODVEN'
        Width = 71
      end
      object grdDadosPESTOT: TcxGridDBColumn
        Caption = 'Peso Total'
        DataBinding.FieldName = 'PESTOT'
        Width = 104
      end
      object grdDadosENDENT: TcxGridDBColumn
        Caption = 'End. Entrega'
        DataBinding.FieldName = 'ENDENT'
        Width = 431
      end
    end
    object grdDadosLevel1: TcxGridLevel
      GridView = grdDadosDBTableViewCitel1
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 958
    Height = 47
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object Label1: TLabel
      AlignWithMargins = True
      Left = 15
      Top = 3
      Width = 928
      Height = 44
      Margins.Left = 15
      Margins.Right = 15
      Align = alClient
      Caption = 
        'Existe outro pedido/venda do mesmo cliente que precisa ser verif' +
        'icado para decidir se pode utilizar mesmo ve'#237'culo de transporte ' +
        'e aproveitar a entrega.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 732
      ExplicitHeight = 14
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 47
    Width = 958
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Label19: TLabel
      Left = 15
      Top = 7
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 55
      Top = 3
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 121
      Top = 3
      Width = 611
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  object dsDados: TDataSource
    Left = 304
    Top = 144
  end
end
