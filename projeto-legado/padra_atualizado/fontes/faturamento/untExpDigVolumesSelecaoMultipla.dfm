inherited frmExpDigVolumesSelecaoMultipla: TfrmExpDigVolumesSelecaoMultipla
  Width = 1046
  Caption = 'Informe peso e volume para impress'#227'o de despacho'
  Position = poMainFormCenter
  ExplicitWidth = 1046
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 434
    Width = 1040
    Height = 26
    Enabled = True
    Visible = True
    ExplicitTop = 434
    ExplicitWidth = 859
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 1036
      Height = 22
      Visible = True
      ExplicitWidth = 855
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 121
        Height = 22
        Caption = '[F10] Confirma'
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
        OnClick = btnConfirmaClick
      end
      object btnMarca: TBitBtnLocked
        Left = 121
        Top = 0
        Width = 121
        Height = 22
        Caption = '[F2] Marca Todos'
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarcaClick
      end
      object btnDesmarca: TBitBtnLocked
        Left = 242
        Top = 0
        Width = 121
        Height = 22
        Caption = '[F3] Desmarca Todos'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnDesmarcaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 958
      Top = 1
      ExplicitLeft = 777
      ExplicitTop = 1
    end
  end
  inherited pnlStatus: TPanel
    Width = 1040
    ExplicitTop = 460
    ExplicitWidth = 859
    inherited pnlNomeForm: TPanel
      Left = 869
      ExplicitLeft = 688
    end
    inherited pnlInfo: TPanel
      Width = 869
      ExplicitWidth = 688
    end
  end
  inherited pgcDados: TPageControl
    Width = 1040
    Height = 434
    ExplicitWidth = 859
    ExplicitHeight = 434
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 851
      ExplicitHeight = 402
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 1040
    Height = 434
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitWidth = 859
    object grdEtiDespacho: TcxGrid
      Left = 1
      Top = 1
      Width = 1038
      Height = 432
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 857
      object grdEtiDespachoDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtaEtiquetas
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.GroupByBox = False
        object grdEtiDespachoIMPETI: TcxGridDBColumn
          Caption = 'IMP'
          DataBinding.FieldName = 'IMPETI'
          PropertiesClassName = 'TcxCheckBoxProperties'
        end
        object grdEtiDespachoDOCESP: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'DOCESP'
          Options.Editing = False
          Width = 109
        end
        object grdEtiDespachoCODEMP: TcxGridDBColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'CODEMP'
          Options.Editing = False
          Width = 58
        end
        object grdEtiDespachoCODNOM: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CODNOM'
          Options.Editing = False
        end
        object grdEtiDespachoPESBRU: TcxGridDBColumn
          Caption = 'Peso Bru.'
          DataBinding.FieldName = 'PESBRU'
        end
        object grdEtiDespachoPESLIQ: TcxGridDBColumn
          Caption = 'Peso Liq.'
          DataBinding.FieldName = 'PESLIQ'
        end
        object grdEtiDespachoVOLUME: TcxGridDBColumn
          Caption = 'Volumes'
          DataBinding.FieldName = 'VOLUME'
        end
        object grdEtiDespachoVOLEXS: TcxGridDBColumn
          Caption = 'Vol. Sep. Exclusiva'
          DataBinding.FieldName = 'VOLEXS'
          Options.Editing = False
          Width = 100
        end
        object grdEtiDespachoVOLEXN: TcxGridDBColumn
          Caption = 'Vol. Sep. N'#227'o Exclu'
          DataBinding.FieldName = 'VOLEXN'
          Options.Editing = False
          Width = 100
        end
      end
      object grdEtiDespachoLevel1: TcxGridLevel
        GridView = grdEtiDespachoDBTableView
      end
    end
  end
  object cdsEtiquetas: TUniClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = cdsEtiquetasBeforePost
    Left = 40
    Top = 208
    object cdsEtiquetasIMPETI: TBooleanField
      FieldName = 'IMPETI'
    end
    object cdsEtiquetasNUMDOC: TStringField
      FieldName = 'NUMDOC'
      Size = 12
    end
    object cdsEtiquetasESPDOC: TStringField
      FieldName = 'ESPDOC'
      Size = 2
    end
    object cdsEtiquetasDOCESP: TStringField
      FieldName = 'DOCESP'
      Size = 15
    end
    object cdsEtiquetasCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsEtiquetasCODCLI: TStringField
      FieldName = 'CODCLI'
      Size = 8
    end
    object cdsEtiquetasNOMCLI: TStringField
      FieldName = 'NOMCLI'
      Size = 60
    end
    object cdsEtiquetasCODNOM: TStringField
      FieldName = 'CODNOM'
      Size = 70
    end
    object cdsEtiquetasPESBRU: TFloatField
      FieldName = 'PESBRU'
      DisplayFormat = '#0.000'
      EditFormat = '#0.000'
    end
    object cdsEtiquetasPESLIQ: TFloatField
      FieldName = 'PESLIQ'
      DisplayFormat = '#0.000'
      EditFormat = '#0.000'
    end
    object cdsEtiquetasVOLUME: TIntegerField
      FieldName = 'VOLUME'
    end
    object cdsEtiquetasVOLEXS: TIntegerField
      FieldName = 'VOLEXS'
    end
    object cdsEtiquetasVOLEXN: TIntegerField
      FieldName = 'VOLEXN'
    end
  end
  object dtaEtiquetas: TDataSource
    DataSet = cdsEtiquetas
    Left = 120
    Top = 208
  end
end
