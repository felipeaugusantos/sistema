inherited frmGruposDadosEdicao: TfrmGruposDadosEdicao
  Width = 1049
  Height = 721
  Caption = 'Grupos de Dados'
  WindowState = wsMaximized
  ExplicitWidth = 1049
  ExplicitHeight = 721
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 649
    Width = 1043
    inherited btnSair: TBitBtnLocked
      Left = 960
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 3
      ExplicitLeft = 3
    end
  end
  inherited pnlStatus: TPanel
    Top = 677
    Width = 1043
    inherited pnlNomeForm: TPanel
      Left = 872
    end
    inherited pnlInfo: TPanel
      Width = 872
    end
  end
  object pgcGrupos: TPageControl [3]
    Left = 0
    Top = 0
    Width = 1043
    Height = 265
    ActivePage = tbsGrupo1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 3
    object tbsGrupo1: TTabSheet
      Caption = 'Grupo &1'
      ExplicitHeight = 550
      object pnlDados: TPanel
        Left = 0
        Top = 0
        Width = 1035
        Height = 44
        Align = alTop
        BevelOuter = bvLowered
        ParentColor = True
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 16
          Width = 107
          Height = 14
          Caption = 'Campo para a quebra:'
        end
        object EditFocus1: TEditFocus
          Left = 125
          Top = 13
          Width = 68
          Height = 22
          Alignment = taLeftJustify
          TabOrder = 0
          Text = 'EditFocus1'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object CheckBox1: TCheckBox
          Left = 220
          Top = 16
          Width = 97
          Height = 17
          Caption = 'Tem cabe'#231'alho'
          TabOrder = 1
        end
        object CheckBox2: TCheckBox
          Left = 343
          Top = 16
          Width = 97
          Height = 17
          Caption = 'Tem Rodap'#233
          TabOrder = 2
        end
      end
      object pnlInterGrafica: TPanel
        Left = 0
        Top = 44
        Width = 1035
        Height = 184
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 1
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 998
        object pnlTitGraf: TPanel
          Left = 1
          Top = 1
          Width = 1033
          Height = 35
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Campos do cabe'#231'alho'
          TabOrder = 0
        end
        object scrLinhas: TScrollBox
          Left = 1
          Top = 36
          Width = 1033
          Height = 143
          VertScrollBar.Visible = False
          Align = alTop
          BevelInner = bvNone
          BevelOuter = bvNone
          BevelKind = bkFlat
          BorderStyle = bsNone
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
          ExplicitLeft = 0
          ExplicitTop = 41
          ExplicitWidth = 1035
          object imgFundo: TImage
            Left = 0
            Top = 0
            Width = 2000
            Height = 125
          end
        end
      end
    end
    object tbsGrupo2: TTabSheet
      Caption = 'Grupo &2'
      ImageIndex = 1
      ExplicitHeight = 550
    end
    object tbsGrupo3: TTabSheet
      Caption = 'Grupo &3'
      ImageIndex = 2
      ExplicitHeight = 550
    end
  end
  object cxgTabCam: TcxGrid [4]
    Left = 53
    Top = 267
    Width = 185
    Height = 421
    TabOrder = 4
    object cxgTabCamView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsCustomize.DataRowSizing = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GridLines = glNone
      OptionsView.GroupByBox = False
      object cxgTabCamDESCAM: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'CAM_DESCAM'
        PropertiesClassName = 'TcxTextEditProperties'
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Width = 133
      end
      object cxgTabCamCODCAM: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CAM_CODCAM'
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        Width = 50
      end
      object cxgTabCamPOSDES: TcxGridDBColumn
        Caption = 'Cor'
        DataBinding.FieldName = 'CAM_POSDES'
        HeaderAlignmentHorz = taCenter
        Options.FilteringFilteredItemsList = False
        Options.FilteringMRUItemsList = False
        Options.FilteringPopup = False
        Options.FilteringPopupMultiSelect = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 25
      end
      object cxgTabCamPOSCAM: TcxGridDBColumn
        DataBinding.FieldName = 'CAM_POSCAM'
        Visible = False
      end
    end
    object cxgTabCamLevel1: TcxGridLevel
      GridView = cxgTabCamView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 600
    Top = 368
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 872
    Top = 416
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 864
    Top = 336
  end
end
