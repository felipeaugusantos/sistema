inherited frmLiberacaoAcessoEndPointsWS: TfrmLiberacaoAcessoEndPointsWS
  Width = 990
  Height = 598
  BorderStyle = bsSingle
  Caption = 'Libera'#231#227'o de Acesso EndPoints WebService'
  Position = poScreenCenter
  ExplicitWidth = 990
  ExplicitHeight = 598
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 984
    ExplicitTop = 527
    ExplicitWidth = 984
    inherited FlwBotoes: TFlowPanel
      Width = 980
      ExplicitWidth = 980
      inherited btnConfirma: TBitBtnLocked
        Enabled = False
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 904
      ModalResult = 0
      ExplicitLeft = 904
    end
  end
  inherited pnlStatus: TPanel
    Top = 553
    Width = 984
    ExplicitTop = 553
    ExplicitWidth = 984
    inherited pnlNomeForm: TPanel
      Left = 800
      Width = 184
      ExplicitLeft = 800
      ExplicitWidth = 184
    end
    inherited pnlInfo: TPanel
      Width = 800
      ExplicitWidth = 800
    end
  end
  object pnlCodDiv: TPanel [2]
    Left = 0
    Top = 0
    Width = 984
    Height = 49
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    DesignSize = (
      984
      49)
    object Label224: TLabel
      Left = 27
      Top = 19
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Autorizado:'
    end
    object edtCodAut: TEditFocus
      Tag = 99
      Left = 88
      Top = 15
      Width = 66
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 7
      TabOrder = 0
      OnKeyPress = edtCodAutKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 7
      TipoTexto = ttNumerico
    end
    object edtDesAut: TEditFocus
      Left = 155
      Top = 15
      Width = 380
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
    object cbxMarcarTodos: TcxCheckBox
      Left = 888
      Top = 24
      Anchors = [akTop, akRight]
      Caption = 'Marcar Todos'
      TabOrder = 2
      Visible = False
      OnClick = cbxMarcarTodosClick
    end
  end
  object cxgEndPoints: TcxGrid [3]
    Left = 0
    Top = 49
    Width = 984
    Height = 478
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgEndPointsDBTv: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Buttons.Filter.Visible = True
      DataController.DataSource = dtsEndPoints
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <
        item
          Links = <
            item
              Column = cxgEndPointsDBTvGRPEND
            end>
          SummaryItems = <
            item
              FieldName = 'END_GRPEND'
              Column = cxgEndPointsDBTvGRPEND
              DisplayText = 'GRUPO'
            end>
        end>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = '<Sem dados para exibi'#231#227'o>'
      OptionsView.CellAutoHeight = True
      OptionsView.DataRowHeight = 32
      OptionsView.Header = False
      object cxgEndPointsDBTvGRPEND: TcxGridDBColumn
        Caption = 'GRUPO'
        DataBinding.FieldName = 'END_GRPEND'
        Visible = False
        GroupIndex = 0
        HeaderAlignmentHorz = taCenter
        MinWidth = 80
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 80
      end
      object cxgEndPointsDBTvMARCADO: TcxGridDBColumn
        DataBinding.FieldName = 'END_MARCADO'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.Alignment = taRightJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        IsCaptionAssigned = True
      end
      object cxgEndPointsDBTvMETHOD: TcxGridDBColumn
        Caption = 'M'#201'TODO'
        DataBinding.FieldName = 'END_METHOD'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Styles.OnGetContentStyle = cxgEndPointsDBTvMETHODStylesGetContentStyle
        Width = 70
      end
      object cxgEndPointsDBTvENDPOI: TcxGridDBColumn
        Caption = 'ENDPOINT'
        DataBinding.FieldName = 'END_ENDPOI'
        Options.Editing = False
        Width = 300
      end
      object cxgEndPointsDBTvDESEND: TcxGridDBColumn
        Caption = 'COMENT'#193'RIOS'
        DataBinding.FieldName = 'END_DESEND'
        Options.Editing = False
        Width = 480
      end
    end
    object cxgEndPointsLevel1: TcxGridLevel
      GridView = cxgEndPointsDBTv
    end
  end
  object dtsEndPoints: TDataSource
    DataSet = cdsEndPoints
    Left = 416
    Top = 184
  end
  object cdsEndPoints: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 384
    Top = 184
    object cdsEndPointsEND_END_ID: TStringField
      FieldName = 'END_END_ID'
      Size = 255
    end
    object cdsEndPointsEND_DESEND: TStringField
      FieldName = 'END_DESEND'
      Size = 1023
    end
    object cdsEndPointsEND_GRPEND: TStringField
      FieldName = 'END_GRPEND'
      Size = 100
    end
    object cdsEndPointsEND_METHOD: TStringField
      FieldName = 'END_METHOD'
      Size = 10
    end
    object cdsEndPointsEND_ENDPOI: TStringField
      FieldName = 'END_ENDPOI'
      Size = 255
    end
    object cdsEndPointsEND_MARCADO: TLargeintField
      FieldName = 'END_MARCADO'
    end
    object cdsEndPointsACS_ID_INT: TStringField
      FieldName = 'ACS_ID_INT'
      Size = 7
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 80
    Top = 136
    PixelsPerInch = 96
    object cxsPOST: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 7058209
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxsGET: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 12736256
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxsPUT: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 1211135
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxsDELETE: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxsPATCH: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 12772176
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxsOPTIONS: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 10967565
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
    object cxsHEAD: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16650896
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      TextColor = clWhite
    end
  end
end
