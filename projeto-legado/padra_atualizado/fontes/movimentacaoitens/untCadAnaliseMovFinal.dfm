inherited frmCadAnaliseMovFinal: TfrmCadAnaliseMovFinal
  Width = 530
  Height = 337
  Caption = 'Fechamento da An'#225'lise'
  OnClose = FormClose
  ExplicitWidth = 530
  ExplicitHeight = 337
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 264
    Width = 524
    TabOrder = 1
    ExplicitTop = 264
    ExplicitWidth = 524
    inherited FlwBotoes: TFlowPanel
      Width = 520
      TabOrder = 2
      ExplicitWidth = 520
    end
    inherited btnSair: TBitBtnLocked
      Left = 441
      ExplicitLeft = 441
    end
    object btnGravar: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 72
      Height = 20
      Caption = '&Gravar'
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
      ModalResult = 1
      TabOrder = 0
    end
  end
  inherited pnlStatus: TPanel
    Top = 292
    Width = 524
    TabOrder = 2
    ExplicitTop = 292
    ExplicitWidth = 524
    inherited pnlNomeForm: TPanel
      Left = 353
      ExplicitLeft = 353
    end
    inherited pnlInfo: TPanel
      Width = 353
      ExplicitWidth = 353
    end
  end
  object Panel1: TPanel [2]
    Left = 0
    Top = 0
    Width = 524
    Height = 264
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object gpbLiberacao: TGroupBox
      Left = 13
      Top = 11
      Width = 499
      Height = 121
      Caption = 'Libera'#231#227'o do Lote'
      TabOrder = 0
      object chkFinAna: TCheckBox
        Left = 14
        Top = 20
        Width = 195
        Height = 17
        Caption = 'Finalizar a An'#225'lise'
        TabOrder = 0
        OnClick = chkFinAnaClick
      end
      object rdgStatus: TGroupBox
        Left = 14
        Top = 43
        Width = 467
        Height = 62
        Caption = 'Situa'#231#227'o'
        Enabled = False
        TabOrder = 1
        object rdbAprovado: TRadioButton
          Left = 2
          Top = 16
          Width = 77
          Height = 44
          Align = alLeft
          Caption = 'Aprovado'
          TabOrder = 0
        end
        object rdbReprovado: TRadioButton
          Left = 79
          Top = 16
          Width = 85
          Height = 44
          Align = alLeft
          Caption = 'Reprovado'
          TabOrder = 1
        end
        object rdbCorrecao: TRadioButton
          Left = 164
          Top = 16
          Width = 137
          Height = 44
          Align = alLeft
          Caption = 'Aprovado com Corre'#231#227'o'
          TabOrder = 2
        end
        object rdbAprCorrecao: TRadioButton
          Left = 301
          Top = 16
          Width = 137
          Height = 44
          Align = alLeft
          Caption = 'Aprovado para Corre'#231#227'o'
          TabOrder = 3
        end
      end
    end
    object gpbAcompanhamento: TGroupBox
      Left = 13
      Top = 137
      Width = 499
      Height = 120
      Caption = 'Acompanhamento do Lote'
      Enabled = False
      TabOrder = 1
      object rdgStaAco: TGroupBox
        Left = 14
        Top = 44
        Width = 467
        Height = 62
        Caption = 'Situa'#231#227'o'
        Enabled = False
        TabOrder = 1
        object rdbAcoAprovado: TRadioButton
          Left = 2
          Top = 16
          Width = 77
          Height = 44
          Align = alLeft
          Caption = 'Aprovado'
          TabOrder = 0
        end
        object rdbAcoReprovado: TRadioButton
          Left = 79
          Top = 16
          Width = 85
          Height = 44
          Align = alLeft
          Caption = 'Reprovado'
          TabOrder = 1
        end
        object rdbAcoCorrecao: TRadioButton
          Left = 164
          Top = 16
          Width = 137
          Height = 44
          Align = alLeft
          Caption = 'Aprovado com Corre'#231#227'o'
          TabOrder = 2
        end
        object rdbAcoAprCorrecao: TRadioButton
          Left = 301
          Top = 16
          Width = 137
          Height = 44
          Align = alLeft
          Caption = 'Aprovado para Corre'#231#227'o'
          TabOrder = 3
        end
      end
      object chkFinAco: TCheckBox
        Left = 14
        Top = 23
        Width = 195
        Height = 17
        Caption = 'Finalizar o acompanhamento'
        TabOrder = 0
        OnClick = chkFinAcoClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 408
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 552
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 328
    Top = 8
  end
end
