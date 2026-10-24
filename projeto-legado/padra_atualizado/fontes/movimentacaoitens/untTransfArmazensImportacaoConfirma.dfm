inherited frmTransfArmazensImportacaoConfirma: TfrmTransfArmazensImportacaoConfirma
  Width = 972
  Height = 512
  Caption = 'Importa'#231#227'o Transfer'#234'ncia entre Armaz'#233'ns - Confirma'#231#227'o'
  ExplicitWidth = 972
  ExplicitHeight = 512
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 441
    Width = 966
    ExplicitTop = 441
    ExplicitWidth = 966
    inherited FlwBotoes: TFlowPanel
      Width = 962
      ExplicitTop = 2
      ExplicitWidth = 962
    end
    inherited btnSair: TBitBtnLocked
      Left = 886
      ExplicitLeft = 886
    end
  end
  inherited pnlStatus: TPanel
    Top = 467
    Width = 966
    ExplicitTop = 467
    ExplicitWidth = 966
    inherited pnlNomeForm: TPanel
      Left = 795
      ExplicitLeft = 795
    end
    inherited pnlInfo: TPanel
      Width = 795
      ExplicitWidth = 795
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 0
    Width = 966
    Height = 400
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    ExplicitTop = 2
    object cxgItensView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgItensViewCustomDrawCell
      DataController.DataSource = dsItens
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir o filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      object cxgItensViewCodIte: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'ITECOD'
        BestFitMaxWidth = 20
        Options.Editing = False
        Options.AutoWidthSizable = False
        Width = 37
      end
      object cxgItensViewDesIte: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Width = 228
      end
      object cxgItensViewLOTORI: TcxGridDBColumn
        Caption = 'Lote origem'
        DataBinding.FieldName = 'LOTORI'
        Width = 90
      end
      object cxgItensViewLOTDES: TcxGridDBColumn
        Caption = 'Lote destino'
        DataBinding.FieldName = 'LOTDES'
        Width = 90
      end
      object cxgItensViewITEQTD: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'ITEQTD'
        Width = 61
      end
      object cxgItensViewSTATUS: TcxGridDBColumn
        Caption = 'Status'
        DataBinding.FieldName = 'STATUS'
        Visible = False
        GroupIndex = 0
      end
      object cxgItensViewERRO: TcxGridDBColumn
        Caption = 'Inconsist'#234'ncia'
        DataBinding.FieldName = 'ERRO'
        Width = 419
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 400
    Width = 966
    Height = 41
    Align = alBottom
    Color = 8454016
    TabOrder = 4
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 170
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produtos importados com sucesso:'
    end
    object Label2: TLabel
      Left = 32
      Top = 24
      Width = 154
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produtos importados com erros:'
    end
    object lblSucesso: TLabel
      Left = 192
      Top = 8
      Width = 6
      Height = 14
      Caption = '0'
    end
    object lblErro: TLabel
      Left = 192
      Top = 24
      Width = 6
      Height = 14
      Caption = '0'
    end
  end
  object dsItens: TDataSource
    Left = 368
    Top = 240
  end
end
