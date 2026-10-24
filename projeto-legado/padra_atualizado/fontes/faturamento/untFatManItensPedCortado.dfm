inherited frmFatManItensPedCortado: TfrmFatManItensPedCortado
  Width = 781
  Height = 424
  Caption = 'Itens do Pedido Cortado'
  OnDestroy = FormDestroy
  ExplicitWidth = 781
  ExplicitHeight = 424
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 351
    Width = 775
    ExplicitTop = 351
    ExplicitWidth = 775
    inherited FlwBotoes: TFlowPanel
      Width = 771
      ExplicitWidth = 771
      object btnDefinirLotes: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 143
        Height = 22
        Caption = '[F2] Definir Lotes'
        TabOrder = 0
        OnClick = btnDefinirLotesClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 692
      ExplicitLeft = 692
    end
  end
  inherited pnlStatus: TPanel
    Top = 379
    Width = 775
    ExplicitTop = 379
    ExplicitWidth = 775
    inherited pnlNomeForm: TPanel
      Left = 604
      ExplicitLeft = 604
    end
    inherited pnlInfo: TPanel
      Width = 604
      ExplicitWidth = 604
    end
  end
  object pnlTopo: TPanel [2]
    Left = 0
    Top = 0
    Width = 775
    Height = 81
    Align = alTop
    TabOrder = 2
    DesignSize = (
      775
      81)
    object lblCliFor: TLabel
      Left = 20
      Top = 46
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pedido:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 58
      Top = 17
      Width = 85
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 145
      Top = 17
      Width = 30
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 177
      Top = 17
      Width = 30
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 58
      Top = 43
      Width = 65
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 124
      Top = 43
      Width = 431
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object dbgGrid: TcxGrid [3]
    Left = 0
    Top = 81
    Width = 775
    Height = 270
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object dbgGridTBV: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsGrid
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibir>'
      OptionsView.ScrollBars = ssVertical
      OptionsView.GroupByBox = False
      object dbgMensagensCODITE: TcxGridDBColumn
        Caption = 'C'#243'd. Item'
        DataBinding.FieldName = 'CODITE'
        Width = 90
      end
      object dbgMensagensDESITE: TcxGridDBColumn
        Caption = 'Descr. Item'
        DataBinding.FieldName = 'DESITE'
        Width = 447
      end
      object dbgMensagensSIGUNI: TcxGridDBColumn
        Caption = 'UN'
        DataBinding.FieldName = 'SIGUNI'
        Width = 36
      end
      object dbgMensagensQTDITE: TcxGridDBColumn
        Caption = 'Qtde'
        DataBinding.FieldName = 'QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Width = 71
      end
      object dbgMensagensQTLDOR: TcxGridDBColumn
        Caption = 'Qtde Sep.'
        DataBinding.FieldName = 'QTLDOR'
        HeaderAlignmentHorz = taRightJustify
        Width = 89
      end
    end
    object dbgGridLevel1: TcxGridLevel
      GridView = dbgGridTBV
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 208
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 104
    Top = 104
  end
  object dtsGrid: TDataSource
    Left = 440
    Top = 104
  end
end
