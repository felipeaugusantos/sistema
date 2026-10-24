inherited frmFatLibProgredirTabPreco: TfrmFatLibProgredirTabPreco
  Left = 345
  Top = 212
  Width = 703
  Height = 396
  BorderIcons = [biSystemMenu]
  Caption = 'Libera'#231#227'o para Progredir Tabela de Pre'#231'o'
  Position = poMainFormCenter
  ExplicitWidth = 703
  ExplicitHeight = 396
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 322
    Width = 697
    Height = 30
    Enabled = True
    Visible = True
    ExplicitTop = 322
    ExplicitWidth = 697
    ExplicitHeight = 30
    DesignSize = (
      697
      30)
    inherited btnSair: TBitBtnLocked
      Left = 611
      Top = 3
      Height = 25
      Caption = '&Cancelar'
      ParentFont = False
      ExplicitLeft = 611
      ExplicitTop = 3
      ExplicitHeight = 25
    end
    object btnLiberar: TBitBtnLocked
      Left = 3
      Top = 4
      Width = 118
      Height = 24
      Caption = '[F10] &Libera'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnLiberarClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
  end
  inherited pnlStatus: TPanel
    Top = 352
    Width = 697
    TabOrder = 3
    ExplicitTop = 352
    ExplicitWidth = 697
    inherited pnlNomeForm: TPanel
      Left = 515
      Width = 182
      ExplicitLeft = 515
      ExplicitWidth = 182
    end
    inherited pnlInfo: TPanel
      Width = 515
      ExplicitWidth = 515
    end
  end
  inherited pgcDados: TPageControl
    Width = 697
    Height = 322
    TabOrder = 1
    Visible = False
    ExplicitWidth = 697
    ExplicitHeight = 322
  end
  object dbgItens: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 697
    Height = 322
    Align = alClient
    DataSource = dtsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    OnKeyDown = dbgItensKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 304
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ITE_TABPRE'
        Title.Alignment = taCenter
        Title.Caption = 'TP'
        Width = 22
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ITE_SIGUNI'
        Title.Alignment = taCenter
        Title.Caption = 'UN'
        Width = 26
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_QTDITE'
        Title.Alignment = taCenter
        Title.Caption = 'Quantidade'
        Width = 70
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_UNITAR'
        Title.Alignment = taCenter
        Title.Caption = 'Vr. Unit'#225'rio'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'ITE_TOTITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vr. Total'
        Width = 73
        Visible = True
      end>
  end
  object dtsItens: TDataSource
    Left = 144
    Top = 96
  end
end
