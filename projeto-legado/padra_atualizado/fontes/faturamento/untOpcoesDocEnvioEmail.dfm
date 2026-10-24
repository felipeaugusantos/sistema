inherited frmOpcoesDocEnvioEmail: TfrmOpcoesDocEnvioEmail
  Width = 314
  Height = 192
  BorderIcons = [biSystemMenu]
  Caption = 'Op'#231#245'es'
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 314
  ExplicitHeight = 192
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 119
    Width = 308
    ExplicitTop = 119
    ExplicitWidth = 243
    inherited FlwBotoes: TFlowPanel
      Width = 304
      ExplicitWidth = 239
      object btnConfirmaDados: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Caption = '&Confirma'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
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
        ParentFont = False
        TabOrder = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 229
      Top = 2
      ModalResult = 2
      ExplicitLeft = 164
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 147
    Width = 308
    ExplicitTop = 147
    ExplicitWidth = 243
    inherited pnlNomeForm: TPanel
      Left = 137
      ExplicitLeft = 72
    end
    inherited pnlInfo: TPanel
      Width = 137
      ExplicitWidth = 72
    end
  end
  object gbOpcoes: TGroupBox [2]
    Left = 0
    Top = 0
    Width = 308
    Height = 119
    Align = alClient
    Caption = 'Op'#231#245'es de Envio de E-mail:'
    TabOrder = 2
    ExplicitWidth = 243
    object chkDocSel: TCheckBox
      Left = 11
      Top = 21
      Width = 161
      Height = 17
      Caption = 'Documento Selecionado'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkDocSelClick
    end
    object chkBoletos: TCheckBox
      Left = 11
      Top = 46
      Width = 97
      Height = 17
      Caption = 'Boletos'
      TabOrder = 1
      OnClick = chkBoletosClick
    end
    object chkDocDigConf: TCheckBox
      Left = 11
      Top = 69
      Width = 233
      Height = 17
      Caption = 'Documentos Digitalizados (Confirma'#231#245'es)'
      TabOrder = 2
      OnClick = chkDocDigConfClick
    end
    object chkTodos: TCheckBox
      Left = 11
      Top = 94
      Width = 97
      Height = 17
      Caption = 'Todos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = chkTodosClick
    end
    object chkXML: TCheckBox
      Left = 243
      Top = 21
      Width = 60
      Height = 17
      Caption = 'XML'
      TabOrder = 4
      OnClick = chkXMLClick
    end
    object chkDANFe: TCheckBox
      Left = 243
      Top = 46
      Width = 60
      Height = 17
      Caption = 'DANFe'
      TabOrder = 5
      OnClick = chkDANFeClick
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 244
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 172
    Top = 80
  end
end
