inherited frmExportacaoModeloContabil: TfrmExportacaoModeloContabil
  Width = 485
  Height = 202
  Caption = 'Exporta'#231#227'o de Modelo Cont'#225'bil'
  ExplicitWidth = 485
  ExplicitHeight = 202
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 131
    Width = 479
    TabOrder = 2
    ExplicitTop = 131
    ExplicitWidth = 479
    inherited FlwBotoes: TFlowPanel
      Width = 475
      ExplicitWidth = 475
      inherited btnConfirma: TBitBtnLocked
        Caption = '&Exportar'
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 399
      ExplicitLeft = 399
    end
  end
  inherited pnlStatus: TPanel
    Top = 157
    Width = 479
    ExplicitTop = 157
    ExplicitWidth = 479
    inherited pnlNomeForm: TPanel
      Left = 308
      ExplicitLeft = 308
    end
    inherited pnlInfo: TPanel
      Width = 308
      ExplicitWidth = 308
    end
  end
  object pnlCorpo: TPanel [2]
    Left = 0
    Top = 0
    Width = 479
    Height = 131
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnlDetalhes: TPanel
      Left = 0
      Top = 0
      Width = 479
      Height = 131
      Align = alClient
      BevelOuter = bvNone
      Padding.Left = 8
      Padding.Top = 8
      Padding.Right = 8
      Padding.Bottom = 8
      TabOrder = 0
      DesignSize = (
        479
        131)
      object lblVersao: TLabel
        Left = 8
        Top = 8
        Width = 106
        Height = 14
        Caption = 'Layout do modelo: 1.0'
      end
      object lblTabelasLabel: TLabel
        Left = 8
        Top = 30
        Width = 98
        Height = 14
        Caption = 'Tabelas exportadas:'
      end
      object mmoTabelas: TMemo
        Left = 8
        Top = 48
        Width = 464
        Height = 75
        Anchors = [akLeft, akTop, akRight, akBottom]
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
end
