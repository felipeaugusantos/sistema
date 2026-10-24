inherited frmRemessaMercadoriaFaltante: TfrmRemessaMercadoriaFaltante
  Width = 818
  Height = 692
  Caption = 'Itens Faltantes'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 818
  ExplicitHeight = 692
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 619
    Width = 812
    ExplicitTop = 619
    ExplicitWidth = 812
    inherited FlwBotoes: TFlowPanel
      Width = 808
      ExplicitTop = 2
      ExplicitWidth = 808
      ExplicitHeight = 24
      object btnMarcarItem: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 164
        Height = 24
        Align = alLeft
        Caption = '[ENTER] Marcar Item'
        TabOrder = 0
        OnClick = btnMarcarItemClick
      end
      object btnMarcarTodos: TBitBtnLocked
        Left = 164
        Top = 0
        Width = 164
        Height = 24
        Align = alLeft
        Caption = '[F2] Marcar Todos'
        TabOrder = 1
        OnClick = btnMarcarTodosClick
      end
      object btnDesmarcarTodos: TBitBtnLocked
        Left = 328
        Top = 0
        Width = 164
        Height = 24
        Align = alLeft
        Caption = '[F3] Desmarcar Todos'
        TabOrder = 2
        OnClick = btnDesmarcarTodosClick
      end
      object btnConfirmar: TBitBtnLocked
        Left = 492
        Top = 0
        Width = 164
        Height = 24
        Align = alLeft
        Caption = '[F10] Confirma'
        TabOrder = 3
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 732
      ExplicitLeft = 732
    end
  end
  inherited pnlStatus: TPanel
    Top = 647
    Width = 812
    ExplicitTop = 647
    ExplicitWidth = 812
    inherited pnlNomeForm: TPanel
      Left = 641
      ExplicitLeft = 641
    end
    inherited pnlInfo: TPanel
      Width = 641
      ExplicitWidth = 641
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 812
    Height = 79
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object lblDocumento: TLabel
      Left = 7
      Top = 6
      Width = 57
      Height = 14
      Caption = 'Documento:'
    end
    object lblEspecie: TLabel
      Left = 351
      Top = 6
      Width = 41
      Height = 14
      Caption = 'Esp'#233'cie:'
    end
    object lblEmpresa: TLabel
      Left = 19
      Top = 29
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object lblCliente: TLabel
      Left = 29
      Top = 52
      Width = 35
      Height = 14
      Caption = 'Cliente:'
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 68
      Top = 26
      Width = 50
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 68
      Top = 49
      Width = 77
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 119
      Top = 26
      Width = 318
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtNomCli: TEditFocus
      Left = 146
      Top = 49
      Width = 291
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtDocumento: TEditFocus
      Tag = 99
      Left = 68
      Top = 3
      Width = 237
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtEspecie: TEditFocus
      Tag = 99
      Left = 398
      Top = 3
      Width = 39
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
  end
  object grdItens: TcxGridCitel [4]
    Left = 0
    Top = 79
    Width = 812
    Height = 540
    Align = alClient
    TabOrder = 4
    object grdItensDBTableViewItens: TcxGridDBTableViewCitel
      OnKeyDown = grdItensDBTableViewItensKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = grdItensDBTableViewItensCustomDrawCell
      DataController.DataSource = dtsItens
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object grdItensCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Width = 75
      end
      object grdItensDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o dos Produtos'
        DataBinding.FieldName = 'DESITE'
        Width = 700
      end
      object grdItensMARDES: TcxGridDBColumn
        DataBinding.FieldName = 'MARDES'
        Visible = False
      end
    end
    object grdItensLevel1: TcxGridLevel
      GridView = grdItensDBTableViewItens
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 224
    Top = 576
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 144
    Top = 576
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 80
    Top = 576
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 184
    Top = 200
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 208
    object cdsItensAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensMARDES: TStringField
      FieldName = 'MARDES'
      Size = 1
    end
    object cdsItensCODITE: TStringField
      FieldName = 'CODITE'
      Size = 5
    end
  end
end
