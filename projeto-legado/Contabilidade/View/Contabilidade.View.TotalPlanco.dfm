inherited frmTotalPlanco: TfrmTotalPlanco
  Width = 589
  Height = 421
  Caption = 'Informe o Saldo Inicial'
  Position = poMainFormCenter
  ExplicitWidth = 589
  ExplicitHeight = 421
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 348
    Width = 583
    inherited FlwBotoes: TFlowPanel
      Width = 579
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 89
        Height = 22
        Caption = '&Confirmar'
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
    end
    inherited btnSair: TBitBtnLocked
      Left = 503
    end
  end
  inherited pnlStatus: TPanel
    Top = 376
    Width = 583
    inherited pnlNomeForm: TPanel
      Left = 412
    end
    inherited pnlInfo: TPanel
      Width = 412
    end
  end
  object cxGrid: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 583
    Height = 348
    Align = alClient
    TabOrder = 2
    LookAndFeel.NativeStyle = False
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitLeft = -531
    ExplicitTop = 1
    ExplicitWidth = 1014
    ExplicitHeight = 169
    object cxGridView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnEditing = cxGridViewEditing
      DataController.DataSource = src
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      Filtering.ColumnFilteredItemsList = True
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clWhite
      object cxGridViewCODEMP: TcxGridDBColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'CODEMP'
        Width = 110
      end
      object cxGridViewEXERCI: TcxGridDBColumn
        Caption = 'Exerc'#237'cio'
        DataBinding.FieldName = 'EXERCI'
        PropertiesClassName = 'TcxMaskEditProperties'
        Properties.EditMask = '9999;0'
        Properties.OnEditValueChanged = cxGridViewEXERCIPropertiesEditValueChanged
        Width = 79
      end
      object cxGridViewCODCON: TcxGridDBColumn
        Caption = 'Conta'
        DataBinding.FieldName = 'CODCON'
        Width = 159
      end
      object cxGridViewSALINI: TcxGridDBColumn
        Caption = 'Saldo Inicial'
        DataBinding.FieldName = 'SALINI'
        PropertiesClassName = 'TcxCalcEditProperties'
        Properties.DisplayFormat = '#,##0.00'
        Properties.OnEditValueChanged = cxGridViewSALINIPropertiesEditValueChanged
        Width = 151
      end
      object cxGridViewDEBCRE: TcxGridDBColumn
        Caption = 'D/C'
        DataBinding.FieldName = 'DEBCRE'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.Items.Strings = (
          'D'
          'C')
        Width = 70
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridView
    end
  end
  object src: TDataSource
    Left = 216
    Top = 128
  end
end
