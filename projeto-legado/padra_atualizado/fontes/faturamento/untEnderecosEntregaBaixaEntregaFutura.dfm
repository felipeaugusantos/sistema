inherited frmEnderecosEntregaBaixaEntregaFutura: TfrmEnderecosEntregaBaixaEntregaFutura
  Width = 737
  Height = 390
  Caption = 'Endere'#231'os de Entrega'
  ExplicitWidth = 737
  ExplicitHeight = 390
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 317
    Width = 731
    ExplicitTop = 277
    ExplicitWidth = 650
    inherited FlwBotoes: TFlowPanel
      Width = 727
      ExplicitWidth = 646
    end
    inherited btnSair: TBitBtnLocked
      Left = 648
      ExplicitLeft = 567
    end
  end
  inherited pnlStatus: TPanel
    Top = 345
    Width = 731
    ExplicitTop = 305
    ExplicitWidth = 650
    inherited pnlNomeForm: TPanel
      Left = 560
      ExplicitLeft = 479
    end
    inherited pnlInfo: TPanel
      Width = 560
      ExplicitWidth = 479
    end
  end
  object dbgConsulta: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 731
    Height = 317
    Align = alClient
    DataSource = dtsConsulta
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'DET_DTAFUT'
        Title.Caption = 'Data'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NUMDOC'
        Title.Caption = 'Documento'
        Width = 104
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_ESPDOC'
        Title.Caption = 'Esp.'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODEMP'
        Title.Caption = 'Emp.'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENDERECO'
        Title.Caption = 'Endere'#231'o'
        Width = 440
        Visible = True
      end>
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 152
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 216
    Top = 104
  end
end
