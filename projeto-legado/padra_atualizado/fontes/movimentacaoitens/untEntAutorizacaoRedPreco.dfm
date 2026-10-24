inherited frmEntAutorizacaoRedPreco: TfrmEntAutorizacaoRedPreco
  Width = 841
  Height = 498
  BorderStyle = bsSizeable
  Caption = 'Itens que ter'#227'o oscila'#231#227'o de pre'#231'o'
  Position = poScreenCenter
  ExplicitWidth = 841
  ExplicitHeight = 498
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 415
    Width = 825
    ExplicitTop = 415
    ExplicitWidth = 825
    DesignSize = (
      825
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 821
      ExplicitWidth = 821
    end
    inherited btnSair: TBitBtnLocked
      Left = 742
      Caption = 'Cancelar'
      TabOrder = 2
      ExplicitLeft = 742
    end
    object btnAutoriz: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 164
      Height = 22
      Caption = '[F10] AUTORIZAR'
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
      TabOrder = 1
      OnClick = btnAutorizClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 443
    Width = 825
    ExplicitTop = 443
    ExplicitWidth = 825
    inherited pnlNomeForm: TPanel
      Left = 654
      ExplicitLeft = 654
    end
    inherited pnlInfo: TPanel
      Width = 654
      ExplicitWidth = 654
    end
  end
  object dbgItens: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 825
    Height = 415
    Align = alClient
    DataSource = dtsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        Title.Caption = 'Descri'#231#227'o'
        Width = 438
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'MEDATU'
        Title.Alignment = taRightJustify
        Title.Caption = 'Pre'#231'o M'#233'dio Atual'
        Width = 106
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'MEDNOV'
        Title.Alignment = taRightJustify
        Title.Caption = 'Novo Pre'#231'o M'#233'dio'
        Width = 106
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'OSCILA'
        Title.Alignment = taRightJustify
        Title.Caption = '% Oscila'#231#227'o'
        Width = 78
        Visible = True
      end>
  end
  object dtsItens: TDataSource
    Left = 488
    Top = 40
  end
end
