inherited frmSelEmpresas: TfrmSelEmpresas
  Width = 622
  Height = 474
  BorderIcons = [biSystemMenu]
  Caption = 'Selecione as Empresas'
  ExplicitWidth = 622
  ExplicitHeight = 474
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 403
    Width = 616
    ExplicitTop = 403
    ExplicitWidth = 598
    inherited FlwBotoes: TFlowPanel
      Width = 535
      ExplicitWidth = 517
      inherited btnConfirma: TBitBtnLocked
        Width = 126
        ModalResult = 0
        ExplicitWidth = 126
      end
      object btnMarcaDesmarca: TBitBtnLocked
        Left = 126
        Top = 0
        Width = 126
        Height = 22
        Caption = '[F5] Marca / Desmarca'
        TabOrder = 1
        OnClick = btnMarcaDesmarcaClick
      end
      object btnMarcaTodas: TBitBtnLocked
        Left = 252
        Top = 0
        Width = 126
        Height = 22
        Caption = '[F6] Marca Todas'
        TabOrder = 2
        OnClick = btnMarcaTodasClick
      end
      object btnDesmarcaTodas: TBitBtnLocked
        Left = 378
        Top = 0
        Width = 126
        Height = 22
        Caption = '[F7] Desmarca Todas'
        TabOrder = 3
        OnClick = btnDesmarcaTodasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 537
      Top = 2
      Align = alRight
      ExplicitLeft = 519
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 429
    Width = 616
    ExplicitTop = 429
    ExplicitWidth = 598
    inherited pnlNomeForm: TPanel
      Left = 445
      ExplicitLeft = 427
    end
    inherited pnlInfo: TPanel
      Width = 445
      ExplicitWidth = 427
    end
  end
  object cxGridEmpresas: TcxGridCitel [2]
    Left = 0
    Top = 0
    Width = 616
    Height = 403
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitWidth = 598
    object cxGridEmpresasTable: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxGridEmpresasTableCustomDrawCell
      DataController.DataSource = dsCadEmp
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxGridEmpresasTableCODEMP: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'EMP_CODEMP'
        Options.Editing = False
        Width = 73
      end
      object cxGridEmpresasTableNOMEMP: TcxGridDBColumn
        Caption = 'Nome Empresa'
        DataBinding.FieldName = 'EMP_NOMEMP'
        MinWidth = 100
        Options.Editing = False
        Width = 497
      end
      object cxGridEmpresasTablemMARDES: TcxGridDBColumn
        Caption = 'Sel.'
        DataBinding.FieldName = 'MARDES'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 'M'
        Properties.ValueUnchecked = 'D'
        Width = 26
      end
    end
    object cxGridEmpresasLevel: TcxGridLevel
      GridView = cxGridEmpresasTable
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 728
    Top = 280
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 680
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
    Top = 240
  end
  object dsCadEmp: TDataSource
    Left = 456
    Top = 208
  end
end
