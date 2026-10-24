inherited frmGNREGuiasPorApuracaoDatas: TfrmGNREGuiasPorApuracaoDatas
  Width = 295
  Height = 182
  BorderStyle = bsDialog
  Caption = 'Dados de Apura'#231#227'o'
  Position = poOwnerFormCenter
  ExplicitWidth = 295
  ExplicitHeight = 182
  PixelsPerInch = 96
  TextHeight = 14
  object Label2: TLabel [0]
    Left = 31
    Top = 48
    Width = 84
    Height = 14
    Caption = 'Data Vencimento:'
  end
  object Label3: TLabel [1]
    Left = 35
    Top = 76
    Width = 81
    Height = 14
    Caption = 'Data Pagamento:'
  end
  object Label1: TLabel [2]
    Left = 12
    Top = 21
    Width = 104
    Height = 14
    Caption = 'Per'#237'odo de Apura'#231#227'o:'
  end
  inherited pnlBotoes: TPanel
    Top = 109
    Width = 289
    TabOrder = 4
    ExplicitTop = 109
    ExplicitWidth = 289
    inherited FlwBotoes: TFlowPanel
      Width = 285
      ExplicitWidth = 285
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 110
        Height = 22
        Caption = '[F10] Confirma'
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
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 175
      Top = 2
      Width = 110
      Caption = '[ESC] Cancela'
      ExplicitLeft = 175
      ExplicitTop = 2
      ExplicitWidth = 110
    end
  end
  inherited pnlStatus: TPanel
    Top = 137
    Width = 289
    TabOrder = 5
    ExplicitTop = 137
    ExplicitWidth = 289
    inherited pnlNomeForm: TPanel
      Left = 118
      ExplicitLeft = 118
    end
    inherited pnlInfo: TPanel
      Width = 118
      ExplicitWidth = 118
    end
  end
  object mskDtaVen: TMaskEditFocus [5]
    Tag = 99
    Left = 122
    Top = 45
    Width = 63
    Height = 22
    EditMask = '99/99/9999;1;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object mskDtaPag: TMaskEditFocus [6]
    Tag = 99
    Left = 122
    Top = 73
    Width = 63
    Height = 22
    EditMask = '99/99/9999;1;_'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 3
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object icbMes: TcxImageComboBox [7]
    Left = 122
    Top = 17
    EditValue = '1'
    ParentColor = True
    Properties.DropDownRows = 12
    Properties.ImmediatePost = True
    Properties.Items = <
      item
        Description = 'Janeiro'
        ImageIndex = 0
        Value = '1'
      end
      item
        Description = 'Fevereiro'
        Value = '2'
      end
      item
        Description = 'Mar'#231'o'
        Value = '3'
      end
      item
        Description = 'Abril'
        Value = '4'
      end
      item
        Description = 'Maio'
        Value = '5'
      end
      item
        Description = 'Junho'
        Value = '6'
      end
      item
        Description = 'Julho'
        Value = '7'
      end
      item
        Description = 'Agosto'
        Value = '8'
      end
      item
        Description = 'Setembro'
        Value = '9'
      end
      item
        Description = 'Outubro'
        Value = '10'
      end
      item
        Description = 'Novembro'
        Value = '11'
      end
      item
        Description = 'Dezembro'
        Value = '12'
      end>
    Properties.ReadOnly = False
    StyleDisabled.Color = clScrollBar
    StyleFocused.Color = clScrollBar
    StyleHot.Color = clScrollBar
    TabOrder = 0
    OnKeyUp = icbMesKeyUp
    Width = 100
  end
  object cbxAno: TcxComboBox [8]
    Left = 225
    Top = 17
    ParentColor = True
    Properties.Items.Strings = (
      '2024'
      '2025'
      '2026'
      '2027'
      '2028'
      '2029'
      '2030'
      '2031'
      '2032'
      '2033'
      '2034'
      '2035'
      '2036'
      '2037'
      '2038'
      '2039'
      '2040')
    Properties.Nullstring = '2024'
    Properties.ReadOnly = False
    Properties.OnValidate = cbxAnoPropertiesValidate
    Style.TransparentBorder = True
    StyleDisabled.Color = 16770261
    StyleFocused.Color = 16770261
    StyleHot.BorderColor = clWindowFrame
    StyleHot.Color = 16770261
    TabOrder = 1
    Text = '2024'
    Width = 50
  end
end
