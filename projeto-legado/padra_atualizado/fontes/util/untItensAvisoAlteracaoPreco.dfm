inherited frmItensAvisoAlteracaoPreco: TfrmItensAvisoAlteracaoPreco
  Width = 1017
  Height = 449
  Caption = 'Itens com altera'#231#227'o de pre'#231'o acima do permitido'
  Position = poMainFormCenter
  ExplicitWidth = 1017
  ExplicitHeight = 449
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 376
    Width = 1011
    ExplicitTop = 376
    ExplicitWidth = 1011
    inherited FlwBotoes: TFlowPanel
      Width = 1007
      Color = clGray
      ParentBackground = False
      ExplicitWidth = 1007
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 121
        Height = 22
        Caption = '[ F10 ] Confirmar'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 928
      ExplicitLeft = 928
    end
  end
  inherited pnlStatus: TPanel
    Top = 404
    Width = 1011
    ExplicitTop = 404
    ExplicitWidth = 1011
    inherited pnlNomeForm: TPanel
      Left = 840
      ExplicitLeft = 840
    end
    inherited pnlInfo: TPanel
      Width = 840
      ExplicitWidth = 840
    end
  end
  object cxgItens: TcxGrid [2]
    Left = 0
    Top = 0
    Width = 1011
    Height = 348
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBBandedTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dtsItens
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.HeaderAutoHeight = True
      Bands = <
        item
          FixedKind = fkLeft
          Width = 290
        end
        item
          Caption = 'Pre'#231'os'
          HeaderAlignmentHorz = taLeftJustify
        end>
      object cxgItensCODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 61
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensDESITE: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o do Item'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 140
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensPRECUS_ANT: TcxGridDBBandedColumn
        Caption = 'Custo ( Ant. )'
        DataBinding.FieldName = 'CUSANT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxgItensPRECUS_NOV: TcxGridDBBandedColumn
        Caption = 'Custo ( Nov. )'
        DataBinding.FieldName = 'CUSNOV'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 72
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxgItensPRECUS_VAR: TcxGridDBBandedColumn
        Caption = 'Custo  ( % Var. )'
        DataBinding.FieldName = 'CUSVAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensPRECUS_VARStylesGetContentStyle
        Width = 89
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxgItensPREVE1_ANT: TcxGridDBBandedColumn
        Caption = 'Venda 1 ( Ant. )'
        DataBinding.FieldName = 'VENANT1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxgItensPREVE1_NOV: TcxGridDBBandedColumn
        Caption = 'Venda 1 ( Nov. )'
        DataBinding.FieldName = 'VENNOV1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxgItensPREVE1_VAR: TcxGridDBBandedColumn
        Caption = 'Venda 1 ( % Var.)'
        DataBinding.FieldName = 'VENVAR1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensPRECUS_VARStylesGetContentStyle
        Width = 94
        Position.BandIndex = 1
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxgItensPREVE2_ANT: TcxGridDBBandedColumn
        Caption = 'Venda 2 ( Ant. )'
        DataBinding.FieldName = 'VENANT2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxgItensPREVE2_NOV: TcxGridDBBandedColumn
        Caption = 'Venda 2 ( Nov. )'
        DataBinding.FieldName = 'VENNOV2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxgItensPREVE2_VAR: TcxGridDBBandedColumn
        Caption = 'Venda 2 ( % Var.)'
        DataBinding.FieldName = 'VENVAR2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensPRECUS_VARStylesGetContentStyle
        Width = 94
        Position.BandIndex = 1
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxgItensPREVE3_ANT: TcxGridDBBandedColumn
        Caption = 'Venda 3 ( Ant. )'
        DataBinding.FieldName = 'VENANT3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxgItensPREVE3_NOV: TcxGridDBBandedColumn
        Caption = 'Venda 3 ( Nov. )'
        DataBinding.FieldName = 'VENNOV3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxgItensPREVE3_VAR: TcxGridDBBandedColumn
        Caption = 'Venda 3 ( % Var.)'
        DataBinding.FieldName = 'VENVAR3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensPRECUS_VARStylesGetContentStyle
        Width = 94
        Position.BandIndex = 1
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxgItensPREVE4_ANT: TcxGridDBBandedColumn
        Caption = 'Venda 4 ( Ant. )'
        DataBinding.FieldName = 'VENANT4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxgItensPREVE4_NOV: TcxGridDBBandedColumn
        Caption = 'Venda 4 ( Nov. )'
        DataBinding.FieldName = 'VENNOV4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxgItensPREVE4_VAR: TcxGridDBBandedColumn
        Caption = 'Venda 4 ( % Var.)'
        DataBinding.FieldName = 'VENVAR4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensPRECUS_VARStylesGetContentStyle
        Width = 94
        Position.BandIndex = 1
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxgItensPREVE5_ANT: TcxGridDBBandedColumn
        Caption = 'Venda 5 ( Ant. )'
        DataBinding.FieldName = 'VENANT5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxgItensPREVE5_NOV: TcxGridDBBandedColumn
        Caption = 'Venda 2 ( Nov. )'
        DataBinding.FieldName = 'VENNOV5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
      object cxgItensPREVE5_VAR: TcxGridDBBandedColumn
        Caption = 'Venda 5 ( % Var.)'
        DataBinding.FieldName = 'VENVAR5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensPRECUS_VARStylesGetContentStyle
        Width = 94
        Position.BandIndex = 1
        Position.ColIndex = 17
        Position.RowIndex = 0
      end
      object cxgItensPREVE6_ANT: TcxGridDBBandedColumn
        Caption = 'Venda 6 ( Ant. )'
        DataBinding.FieldName = 'VENANT6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 18
        Position.RowIndex = 0
      end
      object cxgItensPREVE6_NOV: TcxGridDBBandedColumn
        Caption = 'Venda 6 ( Nov. )'
        DataBinding.FieldName = 'VENNOV6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 19
        Position.RowIndex = 0
      end
      object cxgItensPREVE6_VAR: TcxGridDBBandedColumn
        Caption = 'Venda 6 ( % Var.)'
        DataBinding.FieldName = 'VENVAR6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensPRECUS_VARStylesGetContentStyle
        Width = 94
        Position.BandIndex = 1
        Position.ColIndex = 20
        Position.RowIndex = 0
      end
      object cxgItensPREVE7_ANT: TcxGridDBBandedColumn
        Caption = 'Venda 7 ( Ant. )'
        DataBinding.FieldName = 'VENANT7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 21
        Position.RowIndex = 0
      end
      object cxgItensPREVE7_NOV: TcxGridDBBandedColumn
        Caption = 'Venda 7 ( Nov. )'
        DataBinding.FieldName = 'VENNOV7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 84
        Position.BandIndex = 1
        Position.ColIndex = 22
        Position.RowIndex = 0
      end
      object cxgItensPREVE7_VAR: TcxGridDBBandedColumn
        Caption = 'Venda 7 ( % Var.)'
        DataBinding.FieldName = 'VENVAR7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;-0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.OnGetContentStyle = cxgItensPRECUS_VARStylesGetContentStyle
        Width = 94
        Position.BandIndex = 1
        Position.ColIndex = 23
        Position.RowIndex = 0
      end
      object cxgItensCODUNI: TcxGridDBBandedColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'CODUNI'
        Options.Editing = False
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 348
    Width = 1011
    Height = 28
    Margins.Top = 8
    Margins.Bottom = 0
    Align = alBottom
    TabOrder = 3
    object lblIteCcr: TLabel
      Left = 17
      Top = 6
      Width = 381
      Height = 14
      Alignment = taRightJustify
      Caption = 
        'Confirma a manuten'#231#227'o dos pre'#231'os mesmo com as oscila'#231#245'es apresen' +
        'tadas ?'
    end
    object clbIteCcr: TColorLabel
      Left = 438
      Top = 6
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      CorDestaque = clRed
    end
    object Shape2: TShape
      AlignWithMargins = True
      Left = 862
      Top = 7
      Width = 15
      Height = 16
      Margins.Top = 6
      Margins.Bottom = 4
      Align = alRight
      Brush.Color = 16744448
      Pen.Style = psClear
      ExplicitLeft = 883
      ExplicitTop = 11
      ExplicitHeight = 13
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 883
      Top = 7
      Width = 124
      Height = 20
      Margins.Top = 6
      Align = alRight
      Caption = 'Abaixo ou igual a margem'
      ExplicitHeight = 14
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 770
      Top = 7
      Width = 86
      Height = 20
      Margins.Top = 6
      Align = alRight
      Caption = 'Acima da margem'
      ExplicitHeight = 14
    end
    object Shape1: TShape
      AlignWithMargins = True
      Left = 749
      Top = 7
      Width = 15
      Height = 16
      Margins.Top = 6
      Margins.Bottom = 4
      Align = alRight
      Brush.Color = 8421631
      Pen.Style = psClear
      ExplicitLeft = 860
      ExplicitTop = 11
      ExplicitHeight = 13
    end
    object edtConfirma: TEditFocus
      Tag = 99
      Left = 401
      Top = 3
      Width = 34
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 136
  end
  object dtsItens: TDataSource
    Left = 360
    Top = 232
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 184
    Top = 216
    PixelsPerInch = 96
    object styDentro: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 16744448
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object styFora: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 8421631
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
  end
end
