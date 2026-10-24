inherited frmFormulacaoIndustrialNova: TfrmFormulacaoIndustrialNova
  Left = 112
  Top = 248
  Width = 463
  Height = 397
  BorderIcons = [biSystemMenu]
  Caption = 'Formula'#231#227'o - '
  Position = poOwnerFormCenter
  ExplicitWidth = 463
  ExplicitHeight = 397
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 325
    Width = 457
    ExplicitTop = 325
    ExplicitWidth = 457
    DesignSize = (
      457
      28)
    inherited btnSair: TBitBtnLocked
      Left = 374
      ExplicitLeft = 374
    end
  end
  inherited pnlStatus: TPanel
    Top = 353
    Width = 457
    ExplicitTop = 353
    ExplicitWidth = 457
    inherited pnlNomeForm: TPanel
      Left = 286
      ExplicitLeft = 286
    end
    inherited pnlInfo: TPanel
      Width = 286
      ExplicitWidth = 286
    end
  end
  object lsvFormulacao: TListView [2]
    Left = 0
    Top = 0
    Width = 457
    Height = 204
    Align = alTop
    Columns = <
      item
        AutoSize = True
        Caption = 'Colorante'
      end
      item
        Alignment = taRightJustify
        AutoSize = True
        Caption = 'Quantidade (GR)'
      end
      item
        Alignment = taRightJustify
        AutoSize = True
        Caption = 'Quantidade (ML)'
      end
      item
        Alignment = taRightJustify
        AutoSize = True
        Caption = 'Pre'#231'o'
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
    Width = 457
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
      Width = 455
      Height = 105
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
