inherited frmClienteResumo: TfrmClienteResumo
  Left = 265
  Top = 216
  Width = 678
  Height = 268
  Caption = 'Cliente - Resumo de Benef'#237'cios/Descontos'
  Position = poMainFormCenter
  ExplicitWidth = 678
  ExplicitHeight = 268
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 195
    Width = 672
    ExplicitTop = 195
    ExplicitWidth = 672
    inherited FlwBotoes: TFlowPanel
      Width = 668
      ExplicitWidth = 668
    end
    inherited btnSair: TBitBtnLocked
      Left = 592
      Caption = '&Sair'
      ExplicitLeft = 592
    end
  end
  inherited pnlStatus: TPanel
    Top = 223
    Width = 672
    ExplicitTop = 223
    ExplicitWidth = 672
    inherited pnlNomeForm: TPanel
      Left = 501
      ExplicitLeft = 501
    end
    inherited pnlInfo: TPanel
      Width = 501
      ExplicitWidth = 501
    end
  end
  inline fraClienteResumo: TfraClienteResumo [2]
    Left = 0
    Top = 0
    Width = 671
    Height = 194
    TabOrder = 2
    ExplicitWidth = 671
    ExplicitHeight = 194
    inherited cxDBVerticalGrid: TcxDBVerticalGrid
      Width = 671
      Height = 194
      OptionsView.RowHeaderWidth = 297
      ExplicitWidth = 671
      ExplicitHeight = 194
      Version = 1
      inherited cxDBVerticalGridTipodeAbrevFiscaldeICMS: TcxDBEditorRow
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      inherited cxDBVerticalGridZonaFranca: TcxDBEditorRow
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      inherited cxDBVerticalGridSuframa: TcxDBEditorRow
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      inherited cxDBVerticalGridValidadeSuframa: TcxDBEditorRow
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      inherited cxDBVerticalGridIndstria: TcxDBEditorRow
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      inherited cxDBVerticalGridrgoPblico: TcxDBEditorRow
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      inherited cxDBVerticalGridUtilizardiferimentodeICMS: TcxDBEditorRow
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      inherited cxDBVerticalGridSujeitopassivoporSTatribuidaporregimeespecial: TcxDBEditorRow
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
      inherited cxDBVerticalGridIsenodeIPI: TcxDBEditorRow
        ID = 8
        ParentID = -1
        Index = 8
        Version = 1
      end
      inherited cxDBVerticalGridBenefcioREIDI: TcxDBEditorRow
        ID = 9
        ParentID = -1
        Index = 9
        Version = 1
      end
    end
    inherited DataSource: TDataSource
      Left = 336
      Top = 16
    end
  end
  inherited mnuAuxiliar: TPopupMenu [3]
  end
  inherited ApplicationEvents: TApplicationEvents [4]
    Left = 432
    Top = 104
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 168
  end
end
