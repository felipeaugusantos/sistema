inherited frmFormulacaoImobiliaria: TfrmFormulacaoImobiliaria
  Left = 112
  Top = 248
  Width = 491
  Height = 397
  BorderIcons = [biSystemMenu]
  Caption = 'Formula'#231#227'o - '
  Position = poOwnerFormCenter
  ExplicitWidth = 491
  ExplicitHeight = 397
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 325
    Width = 485
    ExplicitTop = 325
    ExplicitWidth = 485
    DesignSize = (
      485
      28)
    inherited btnSair: TBitBtnLocked
      Left = 402
      ExplicitLeft = 402
    end
  end
  inherited pnlStatus: TPanel
    Top = 353
    Width = 485
    ExplicitTop = 353
    ExplicitWidth = 485
    inherited pnlNomeForm: TPanel
      Left = 314
      ExplicitLeft = 314
    end
    inherited pnlInfo: TPanel
      Width = 314
      ExplicitWidth = 314
    end
  end
  object lsvFormulacao: TListView [2]
    Left = 0
    Top = 0
    Width = 485
    Height = 204
    Align = alTop
    Columns = <
      item
        Caption = 'Colorante'
        Width = 130
      end
      item
        Alignment = taRightJustify
        Caption = 'Quantidade'
        Width = 120
      end
      item
        Alignment = taRightJustify
        Caption = 'Quantidade(On'#231'a)'
        Width = 110
      end
      item
        Alignment = taRightJustify
        Caption = 'Pre'#231'o'
        Width = 120
      end>
    ColumnClick = False
    FlatScrollBars = True
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
  end
  object pnlRodape: TPanel [3]
    Left = 0
    Top = 204
    Width = 485
    Height = 121
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 91
      Height = 14
      Align = alTop
      Caption = 'Calculo da F'#243'rmula'
    end
    object memCalculo: TMemo
      Left = 1
      Top = 15
      Width = 483
      Height = 105
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 216
    Top = 256
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 368
    Top = 264
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 136
    Top = 264
  end
end
